"""単語辞書・構文テーブル (ZILCH が作る表) と入力の解析 (READ)、語彙の宣言 (SYNTAX など)。

refactor-plan.md Phase 5 で ZilRuntime.py から分けた。
"""


from __future__ import annotations


# ruff: noqa: F401


import contextlib as _contextlib
import contextvars as _contextvars
import dataclasses as _dataclasses
import io as _io
import keyword as _keyword
import os as _os
import pickle as _pickle
import re as _re
import tempfile as _tempfile
import types as _types
from pathlib import Path as _Path
import random as _random
import sys as _sys
from collections.abc import Callable, Iterator, Sequence
from typing import Any


# 品詞のビット (辞書エントリの 4 バイト目)。ZILCH の値に合わせている
PS_OBJECT = 128
PS_VERB = 64
PS_ADJECTIVE = 32
PS_DIRECTION = 16
PS_PREPOSITION = 8
PS_BUZZ_WORD = 4
# 最初の品詞の種別 (4 バイト目の下位 2 ビット)。P1_OBJECT は 4 より大きいので、
# WT? は値を読まずに真偽だけを返す
P1_OBJECT = 128
P1_VERB = 3
P1_ADJECTIVE = 2
P1_DIRECTION = 1
P1_PREPOSITION = 0
P1_BUZZ_WORD = 0
# 値 (動詞番号など) を持つ品詞。辞書エントリには最初の 2 つの値だけを格納する
_VALUE_PARTS = (PS_VERB, PS_DIRECTION, PS_ADJECTIVE, PS_PREPOSITION)
_FIRST_PART_CODE = {
    PS_VERB: P1_VERB,
    PS_DIRECTION: P1_DIRECTION,
    PS_ADJECTIVE: P1_ADJECTIVE,
    PS_PREPOSITION: P1_PREPOSITION,
}
# 辞書エントリのバイト位置の既定値 (4: 品詞、5: 最初の値、6: 次の値)。
# Trinity のようにバージョン 4 以降の辞書を想定するゲームは、parser で
# P-PSOFF (品詞のバイト位置) と P-P1OFF (最初の値) を定義する
_WORD_PS_BYTE = 4
_WORD_VALUE1_BYTE = 5


def _significant_chars() -> int:
    """辞書が区別する単語の文字数を返す。

    ゲームの P-PSOFF (品詞のバイト位置) が 4 なら 6 文字 (バージョン 3)、
    それより大きければ 9 文字 (バージョン 4 以降) を区別する。P-PSOFF がまだ
    定義されていないうちは、結果を覚えずに 6 文字を返す。

    Returns:
        区別する文字数。
    """
    d = get_context().dictionary
    if d.significant_cache is None:
        try:
            offset = int(ZG.P_PSOFF)
        except (ZilError, AttributeError, TypeError):
            return WORD_SIGNIFICANT_CHARS
        d.significant_cache = (
            WORD_SIGNIFICANT_CHARS_V4 if offset > _WORD_PS_BYTE else WORD_SIGNIFICANT_CHARS
        )
    return d.significant_cache


def _word_layout() -> tuple[int, int]:
    """辞書エントリの、品詞のバイト位置と最初の値のバイト位置を返す。

    Returns:
        (品詞のバイト位置, 最初の値のバイト位置)。ゲームが P-PSOFF / P-P1OFF を
        定義していればその値、なければ既定値。
    """
    try:
        return int(ZG.P_PSOFF), int(ZG.P_P1OFF)
    except (ZilError, AttributeError, TypeError):
        return _WORD_PS_BYTE, _WORD_VALUE1_BYTE


class Word(str):
    """辞書の単語。文字列として扱え、品詞のバイトを GETB で読める。

    先頭 6 文字だけを区別する (Z-machine バージョン 3)。ZIL の
    <GETB 単語 4> は品詞ビット、5 と 6 は品詞ごとの値 (動詞番号、方向、
    形容詞番号、前置詞番号) を返す。

    Attributes:
        parts: 品詞ビットと、その値 (値を持たない品詞は 0)。
    """

    parts: dict[int, Any]

    def __new__(cls, text: str) -> "Word":
        """単語を作る。

        Args:
            text: 単語の文字列 (先頭 6 文字を使う)。

        Returns:
            品詞をまだ持たない単語。
        """
        word = super().__new__(cls, text[:_significant_chars()].lower())
        word.parts = {}
        return word

    def __eq__(self, other: object) -> bool:
        """先頭 6 文字が等しい文字列と等しいとみなす。

        区切り文字の単語 (. , ") は、ZIL の記号定数の名前 (W?PERIOD の
        'period' など) とも等しいとみなす。

        Args:
            other: 比較対象。

        Returns:
            等しければ True。
        """
        if isinstance(other, str):
            # 比較はどちら向きでも同じ結果にする (`x in (W1, W2)` はタプルの要素の側から
            # 比べるため、片側だけの変換では `,` と WORD('comma') が一致しなくなる)
            mine = str.__str__(self)
            key = str.__str__(other)[:_significant_chars()].lower()
            return SEPARATOR_WORD_NAMES.get(mine, mine) == SEPARATOR_WORD_NAMES.get(key, key)
        return False

    def __ne__(self, other: object) -> bool:
        """`__eq__` の否定。

        Args:
            other: 比較対象。

        Returns:
            等しくなければ True。
        """
        return not self.__eq__(other)

    __hash__ = str.__hash__

    def __reduce__(self) -> tuple[Any, ...]:
        """保存時に、辞書に登録済みの同じ単語として復元できるようにする。

        Returns:
            (単語を取り出す関数, 引数)。
        """
        return (_word, (str(self),))

    def getb(self, index: int) -> int:
        """辞書エントリの index バイト目を返す。

        Args:
            index: バイト位置 (4: 品詞、5・6: 品詞ごとの値)。

        Returns:
            バイトの値。未定義の位置は 0。
        """
        _finalize_vocabulary()
        ps_byte, value1_byte = _word_layout()
        valued = [bit for bit in _VALUE_PARTS if bit in self.parts]
        if index == ps_byte:
            bits = sum(self.parts)
            return bits | (_FIRST_PART_CODE[valued[0]] if valued else 0)
        slot = index - value1_byte
        if slot in (0, 1) and slot < len(valued):
            return self.parts[valued[slot]]
        return 0


def _word(text: str) -> Word:
    """辞書の単語を返す。なければ登録する。

    Args:
        text: 単語。

    Returns:
        辞書の単語。
    """
    words = get_context().dictionary.words
    key = text[:_significant_chars()].lower()
    word = words.get(key)
    if word is None:
        word = words[key] = Word(key)
    return word


def WORD(text: str) -> Word:
    """W?NAME に対応する辞書の単語を返す (生成コードから使う)。

    素の文字列ではなく Word を返すので、<GETB ,W?INTNUM 4> のように
    品詞を参照しても失敗しない。

    Args:
        text: 単語 (W? を除いた小文字の名前)。

    Returns:
        辞書の単語。
    """
    return _word(text)


def _lookup_word(text: str) -> Word | int:
    """入力された単語を辞書から探す。

    Args:
        text: 入力された単語。

    Returns:
        辞書の単語。見つからない場合は 0。
    """
    _finalize_vocabulary()
    word = get_context().dictionary.words.get(text[:_significant_chars()].lower())
    return word if word is not None and word.parts else 0


# SYNTAX の位置指定 (HELD など) と、parser で定義された定数の対応
_LOCATION_BITS = {
    "HELD": "SH",
    "CARRIED": "SC",
    "IN-ROOM": "SIR",
    "ON-GROUND": "SOG",
    "TAKE": "STAKE",
    "MANY": "SMANY",
    "HAVE": "SHAVE",
}
_SYNTAX_ENTRY_SIZE = 8


def _invalidate_vocabulary() -> None:
    """宣言が増えたので、番号の割り当てをやり直すように印を付ける。"""
    get_context().dictionary.invalidate()


def _action_id(name: str) -> int:
    """アクション (V-NAME) の番号を返す。なければ割り当てる。

    Args:
        name: アクションのルーチン名 (例: 'V-TAKE')。

    Returns:
        1 から始まるアクション番号。
    """
    return get_context().actions.action_id(name)


def _syntax_slots(parts: tuple[Any, ...]) -> tuple[Any, ...]:
    """SYNTAX の宣言を、動詞・前置詞・目的語の条件・アクションに分解する。

    Args:
        parts: SYNTAX の引数。

    Returns:
        (動詞, 目的語ごとの前置詞 2 つ, FIND フラグ 2 つ, 位置指定 2 つ,
        アクション, 事前アクション, 目的語の数)。
        前置詞・フラグ・位置指定がない目的語は 0。
    """
    eq = parts.index("=") if "=" in parts else len(parts)
    left, right = parts[:eq], parts[eq + 1 :]
    preps: list[Any] = [0, 0]
    finds: list[Any] = [0, 0]
    locs: list[Any] = [0, 0]
    pending_prep = 0
    count = 0
    for token in left[1:]:
        if token == "OBJECT":
            if count < 2:
                preps[count] = pending_prep
            pending_prep = 0
            count += 1
        elif isinstance(token, tuple):
            slot = count - 1
            if not 0 <= slot < 2 or not token:
                continue
            if token[0] == "FIND":
                finds[slot] = token[1]
            else:
                locs[slot] = token
        else:
            pending_prep = token
    if pending_prep and count < 2:
        preps[count] = pending_prep
    action = right[0] if right else ""
    preaction = right[1] if len(right) > 1 else ""
    return left[0], preps, finds, locs, action, preaction, count


def _finalize_vocabulary() -> None:
    """宣言された構文・同義語から、辞書の品詞と番号を割り当てる。

    動詞 (VERBS の添字から 255 - n)、前置詞、方向、アクションの番号を決め、
    各単語に品詞を設定する。宣言が増えない限り一度だけ実行する。
    """
    ctx = get_context()
    d = ctx.dictionary
    acts = ctx.actions
    if d.vocabulary_ready:
        return
    d.vocabulary_ready = True
    d.verb_names.clear()
    d.verb_index.clear()
    d.prep_words.clear()
    d.prep_numbers.clear()
    for syntax in d.syntaxes:
        verb = syntax[0]
        key = verb[:_significant_chars()].lower()
        if key not in d.verb_index:
            d.verb_index[key] = len(d.verb_names)
            d.verb_names.append(verb)
        for token in syntax[1 : syntax.index("=") if "=" in syntax else None]:
            if isinstance(token, str) and token != "OBJECT":
                pkey = token[:_significant_chars()].lower()
                if pkey not in d.prep_numbers:
                    d.prep_numbers[pkey] = len(d.prep_numbers) + 1
                    d.prep_words.append(pkey)
    directions = {name[:_significant_chars()].lower(): name for name in d.direction_names}
    for group in d.synonym_groups:
        first = group[0][:_significant_chars()].lower()
        for text in group[1:]:
            key = text[:_significant_chars()].lower()
            if first in d.verb_index:
                d.verb_index.setdefault(key, d.verb_index[first])
            if first in d.prep_numbers and key not in d.prep_numbers:
                d.prep_numbers[key] = d.prep_numbers[first]
                d.prep_words.append(key)
            if first in directions:
                directions.setdefault(key, directions[first])
    for key, index in d.verb_index.items():
        _word(key).parts[PS_VERB] = 255 - index
    for key, number in d.prep_numbers.items():
        _word(key).parts[PS_PREPOSITION] = number
    for key, name in directions.items():
        _word(key).parts[PS_DIRECTION] = Direction(name.upper())
    for text in d.buzz_words:
        _word(text).parts.setdefault(PS_BUZZ_WORD, 0)
    for syntax in d.syntaxes:
        _verb, _preps, _finds, _locs, action, preaction, _count = _syntax_slots(syntax)
        action_id = acts.action_id(action)
        if preaction:
            acts.preaction_names[action_id] = preaction


def _adjective_id(text: str) -> int:
    """形容詞の番号を返す。なければ割り当てる。

    Args:
        text: 形容詞の単語。

    Returns:
        1 から始まる形容詞番号。
    """
    adj_ids = get_context().dictionary.adjective_ids
    key = text[:_significant_chars()].lower()
    if key not in adj_ids:
        adj_ids[key] = len(adj_ids) + 1
    return adj_ids[key]


def _register_object_words(synonyms: Sequence[Any], adjectives: Sequence[Any]) -> tuple[Table, Table]:
    """オブジェクトの名詞・形容詞を辞書に登録し、プロパティのテーブルを作る。

    Args:
        synonyms: SYNONYM プロパティの単語 (名詞)。
        adjectives: ADJECTIVE プロパティの単語。

    Returns:
        (単語のワードのテーブル, 形容詞のテーブル)。形容詞のテーブルは、
        V3 (部屋をバイトで持つ配置) なら形容詞番号のバイトの並び、
        V4 以降 (Trinity・AMFV など、部屋をワードで持つ配置) なら単語のワードの並び。
        V4 のパーサーは <INTBL? ,P-ADJ .SYNS </ <PTSIZE .SYNS> 2>> で単語として照合する。
    """
    nouns = []
    for text in synonyms:
        word = _word(str(text))
        word.parts.setdefault(PS_OBJECT, 0)
        nouns.append(word)
    numbers = []
    words = []
    for text in adjectives:
        number = _adjective_id(str(text))
        word = _word(str(text))
        word.parts[PS_ADJECTIVE] = number
        numbers.append(number)
        words.append(word)
    if _wide_exits():
        return Table.of(nouns), Table.of(words)
    return Table.of(nouns), Table.of(numbers, byte=True)


def VOC(text: Any, part: Any = None) -> Word:
    """単語を辞書に登録して、その単語を返す (<VOC "AZ" ADJ>)。

    元はコンパイル時の MDL 関数。Spellbreaker では、プレイヤーが名前を書いた
    キューブの単語の表 (P-QBUF) に使う。

    Args:
        text: 単語。
        part: 品詞 (ADJ / ADJECTIVE、NOUN / OBJECT、BUZZ)。省略時は登録だけする。

    Returns:
        辞書の単語。
    """
    key = str(text)
    word = _word(key)
    kind = str(part).upper() if part else ""
    if kind in ("ADJ", "ADJECTIVE"):
        word.parts[PS_ADJECTIVE] = _adjective_id(key)
    elif kind in ("NOUN", "OBJECT"):
        word.parts.setdefault(PS_OBJECT, 0)
    elif kind == "BUZZ":
        word.parts.setdefault(PS_BUZZ_WORD, 0)
    _invalidate_vocabulary()
    return word


def PSEUDO(*entries: Any) -> Table:
    """部屋の THINGS プロパティ (擬似オブジェクトの表) を作る。

    Spellbreaker の `(THINGS <PSEUDO (SURLY GUARD GUARD-PSEUDO) (<> BUILDING ...)>)` は、
    元はコンパイル時の MDL 関数で、「名詞の単語, 形容詞の単語 (なければ 0), ルーチン」の
    3 つ組を並べた LTABLE を作る。パーサーは名詞と形容詞を入力と比べ、一致した
    ルーチンを擬似オブジェクトの ACTION にする。

    Args:
        entries: (形容詞, 名詞, ルーチン名) のタプル。形容詞がなければ空のタプル。

    Returns:
        先頭のワードに要素数を持つテーブル。
    """
    # 表の形は、ゲームが PSEUDO を定義しているかで決まる (Dictionary.pseudo_triples)。
    # 以前は LAST-PSEUDO-LOC の有無で決めていたが、Spellbreaker も LAST-PSEUDO-LOC を
    # 持つので 2 つ組になり、パーサー (3 つ組を読む) が表の外まで読んで止まっていた
    two_word = not get_context().dictionary.pseudo_triples
    cells: list[Any] = []
    for entry in entries:
        adjective, noun, routine = entry
        noun_word = _word(str(noun))
        noun_word.parts.setdefault(PS_OBJECT, 0)
        adjective_word: Any = 0
        if adjective:
            adjective_word = _word(str(adjective))
            adjective_word.parts[PS_ADJECTIVE] = _adjective_id(str(adjective))
        if two_word:
            cells += [adjective_word, noun_word]
        else:
            if isinstance(routine, str):
                # ルーチンは名前で渡る。未定義の擬似ルーチン (例: Lurking Horror の SHAFT-PSEUDO) は 0 とする
                routine = getattr(ZG, _identifier(routine), 0)
            cells += [noun_word, adjective_word, routine]
    _invalidate_vocabulary()
    return LTABLE(*cells)


def _identifier(name: str) -> str:
    """ZIL の名前を、生成コードが使う Python の識別子に変換する。

    Args:
        name: ZIL の名前 (例: 'V-LAMP-ON')。

    Returns:
        識別子 (例: 'V_LAMP_ON')。
    """
    ident = "".join(ch if ch.isalnum() or ch == "_" else "_" for ch in name)
    return ident + "_" if _keyword.iskeyword(ident) else ident


def _location_bits(names: Any) -> int:
    """SYNTAX の位置指定 (HELD など) を、parser の定数のビット和にする。

    Args:
        names: 位置指定の名前のタプル。0 なら指定なし。

    Returns:
        ビット和。
    """
    if not names:
        return 0
    return sum(
        getattr(ZG, _LOCATION_BITS[name], 0) for name in names if name in _LOCATION_BITS
    )


def _prep_number(word: Any) -> int:
    """SYNTAX に書かれた前置詞の番号を返す。

    Args:
        word: 前置詞の単語。0 なら前置詞なし。

    Returns:
        前置詞の番号。
    """
    if not word:
        return 0
    return get_context().dictionary.prep_numbers.get(
        str(word)[:_significant_chars()].lower(), 0
    )


def _build_verbs() -> Table:
    """動詞ごとの構文テーブル (VERBS) を作る。

    VERBS の添字は動詞のインデックス (動詞番号は 255 - 添字)。各要素は
    先頭バイトがエントリ数で、続けて 8 バイトずつ (オブジェクト数、前置詞 1・2、
    FIND フラグ 1・2、位置指定 1・2、アクション番号) を持つバイトテーブル。

    Returns:
        VERBS のテーブル。
    """
    _finalize_vocabulary()
    d = get_context().dictionary
    per_verb: list[list[tuple[int, list[Any]]]] = [[] for _ in d.verb_names]
    for syntax in d.syntaxes:
        verb, preps, finds, locs, action, _pre, count = _syntax_slots(syntax)
        index = d.verb_index[verb[:_significant_chars()].lower()]
        entry = [
            min(count, 2),
            _prep_number(preps[0]),
            _prep_number(preps[1]),
            finds[0],
            finds[1],
            _location_bits(locs[0]),
            _location_bits(locs[1]),
            _action_id(action),
        ]
        per_verb[index].append((count, entry))
    tables = []
    for entries in per_verb:
        # ZILCH は、同じ動詞の構文を宣言と逆の順に並べる (コンパイル済みの Zork I
        # zork1.zip の VERBS で確認。目的語の数での並べ替えはしない)。パーサーの
        # SYNTAX-CHECK は、目的語が足りないとき最後に調べた構文で補う (DRIVE1 を
        # 上書きする) ので、この順は「take」だけの入力の返事などに効く
        entries.reverse()
        cells: list[Any] = [len(entries)]
        for _count, entry in entries:
            cells += entry
        tables.append(Table.of(cells, byte=True))
    return Table.of(tables)


def _build_prepositions() -> Table:
    """前置詞の表 (PREPOSITIONS) を作る。

    先頭のワードが個数で、続けて (単語, 番号) のワードの組を並べる。

    Returns:
        PREPOSITIONS のテーブル。
    """
    _finalize_vocabulary()
    d = get_context().dictionary
    cells: list[Any] = [len(d.prep_words)]
    for key in d.prep_words:
        cells += [_word(key), d.prep_numbers[key]]
    return Table.of(cells)


def _action_routines(names: dict[int, str] | list[str]) -> Table:
    """アクション番号ごとのルーチンを並べたテーブルを作る。

    Args:
        names: アクション番号 -> ルーチン名。

    Returns:
        番号を添字とするテーブル。ルーチンがない要素は 0。
    """
    _finalize_vocabulary()
    ctx = get_context()
    items = names.items() if isinstance(names, dict) else enumerate(names)
    routines = [0] * len(ctx.actions.action_names)
    for number, name in items:
        if name:
            routines[number] = getattr(ctx, _identifier(name), 0)
    return Table.of(routines)


# コンパイラが生成する、ゲームのソースには定義がないグローバル
_PROVIDERS: dict[str, Callable[[], Any]] = {
    "VERBS": _build_verbs,
    "PREPOSITIONS": _build_prepositions,
    "ACTIONS": lambda: _action_routines(get_context().actions.action_names),
    "PREACTIONS": lambda: _action_routines(get_context().actions.preaction_names),
    "UEXIT": lambda: 1,
    "NEXIT": lambda: 2,
    "FEXIT": lambda: 3,
    "CEXIT": lambda: 4,
    "DEXIT": lambda: 5,
    "REXIT": lambda: 0,
    "NEXITSTR": lambda: 0,
    "FEXITFCN": lambda: 0,
    "CEXITFLAG": lambda: 1,
    "CEXITSTR": lambda: 1,
    "DEXITOBJ": lambda: 1,
    "DEXITSTR": lambda: 1,
}


def SYMBOL(name: str) -> Any:
    """コンパイラが定義する記号定数の値を返す。

    V?NAME (アクション番号)、ACT?NAME (動詞の単語の番号)、PR?NAME (前置詞の番号)、
    A?NAME (形容詞の番号) を扱う。

    Args:
        name: 記号定数の名前 (例: 'V?TAKE')。

    Returns:
        番号。ACT?・PR? で単語が見つからない場合は 0。
    """
    _finalize_vocabulary()
    prefix, _, base = name.partition("?")
    if prefix == "V":
        return _action_id("V-" + base)
    word = get_context().dictionary.words.get(base[:_significant_chars()].lower())
    if prefix == "A":
        return _adjective_id(base)
    if word is None:
        return 0
    part = {"ACT": PS_VERB, "PR": PS_PREPOSITION}[prefix]
    return word.parts.get(part, 0)


def _tokenize(text: str) -> list[tuple[str, int]]:
    """入力文字列を単語と区切り文字に分割する。

    Args:
        text: 入力文字列。

    Returns:
        (単語, 文字列中の開始位置) のリスト。
    """
    tokens: list[tuple[str, int]] = []
    start = -1
    for pos, ch in enumerate(text + " "):
        if ch.isspace() or ch in WORD_SEPARATORS:
            if start >= 0:
                tokens.append((text[start:pos], start))
                start = -1
            if ch in WORD_SEPARATORS:
                tokens.append((ch, pos))
        elif start < 0:
            start = pos
    return tokens


def READ(inbuf: Table, lexv: Table) -> bool:
    """1 行を読み込み、文字を inbuf に、単語の解析結果を lexv に格納する。

    inbuf は 0 バイト目が最大文字数、1 バイト目以降が文字。lexv は 0 バイト目が
    最大単語数、1 バイト目が単語数、2 バイト目から 4 バイトごとに
    (辞書の単語, 文字数, inbuf 中の位置) を格納する。

    Args:
        inbuf: 文字を格納するバイトテーブル。
        lexv: 単語の解析結果を格納するテーブル。

    Returns:
        常に True。
    """
    ctx = get_context()
    inbuf_keys = [k for k, v in ctx.__dict__.items() if v is inbuf]
    lexv_keys = [k for k, v in ctx.__dict__.items() if v is lexv]
    _sys.stdout.flush()
    input_hook = ctx.io.input_hook
    try:
        line = (input_hook() if input_hook is not None else input()).lower()
    except EOFError:
        QUIT()
    if inbuf_keys and isinstance(ctx.__dict__.get(inbuf_keys[0]), Table):
        inbuf = ctx.__dict__[inbuf_keys[0]]
    if lexv_keys and isinstance(ctx.__dict__.get(lexv_keys[0]), Table):
        lexv = ctx.__dict__[lexv_keys[0]]
    max_chars = GETB(inbuf, 0) or len(line)
    text = line[:max_chars]
    for pos, ch in enumerate(text):
        PUTB(inbuf, pos + 1, ord(ch))
    if len(text) + 1 < inbuf.size():
        PUTB(inbuf, len(text) + 1, 0)

    max_words = GETB(lexv, 0) or (lexv.size() - 2) // LEXV_ENTRY_SIZE
    tokens = _tokenize(text)[:max_words]
    PUTB(lexv, 1, len(tokens))
    for index, (word, start) in enumerate(tokens):
        pos = 2 + index * LEXV_ENTRY_SIZE
        lexv.write(pos, _lookup_word(word), word=True)
        PUTB(lexv, pos + 2, len(word))
        PUTB(lexv, pos + 3, start + 1)
    return True


def VERSION(*args: Any) -> bool:
    """対象の Z-machine バージョンを宣言する。

    Args:
        args: バージョン (例: 'ZIP')。

    Returns:
        常に True。
    """
    get_context().world.game_info["VERSION"] = args
    return True


def SYNTAX(*parts: Any) -> bool:
    """構文 (動詞・前置詞・目的語・アクション) を宣言する。

    Args:
        parts: 構文の要素 (例: 'TAKE', 'OBJECT', ('FIND', 'TAKEBIT'), '=',
            'V-TAKE')。

    Returns:
        常に True。
    """
    return get_context().dictionary.syntax(*parts)


def SYNONYM(*words: Any) -> bool:
    """同義語を宣言する。

    Args:
        words: 同義語の単語。

    Returns:
        常に True。
    """
    return get_context().dictionary.synonym(*words)


# 品詞を限った同義語の宣言 (後期の作品。例: Spellbreaker の <VERB-SYNONYM TAKE GET>)。
# 単語の照合では品詞を区別しないので、SYNONYM と同じに扱う
VERB_SYNONYM = SYNONYM
PREP_SYNONYM = SYNONYM
ADJ_SYNONYM = SYNONYM
DIR_SYNONYM = SYNONYM


def BUZZ(*words: Any) -> bool:
    """無視する単語 (a、the など) を宣言する。

    Args:
        words: 単語。

    Returns:
        常に True。
    """
    return get_context().dictionary.buzz(*words)


def DIRECTIONS(*names: Any) -> bool:
    """方向を宣言する。

    Args:
        names: 方向の名前 (例: 'NORTH')。

    Returns:
        常に True。
    """
    return get_context().dictionary.directions(*names)


def GDECL(*_args: Any) -> bool:
    """グローバル変数の型宣言 (実行時には何もしない)。

    Args:
        _args: 型宣言。

    Returns:
        常に True。
    """
    return True


def FREQUENT_WORDS_p() -> bool:
    """頻出語の圧縮を行うかどうか (Python では不要)。

    Returns:
        常に False。
    """
    return False


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .context import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    LEXV_ENTRY_SIZE,
    SEPARATOR_WORD_NAMES,
    WORD_SEPARATORS,
    WORD_SIGNIFICANT_CHARS,
    WORD_SIGNIFICANT_CHARS_V4,
    ZG,
    ZilError,
    get_context,
)
from .exits import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    _wide_exits,
)
from .objects import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    Direction,
)
from .saves import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    QUIT,
)
from .tables import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    GETB,
    LTABLE,
    PUTB,
    Table,
)
