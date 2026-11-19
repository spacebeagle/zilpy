"""呼び出しの名前の解決 (refactor-plan.md Phase 2-5、§1.7)。

フォーム `<NAME ...>` の NAME が、次のどれを指すかを決める。両方の変換器は、
この結果だけを見て出力する。

- GAME: ゲームの定義 (ROUTINE・DEFINE・GLOBAL など、共有名に入る名前)
- MACRO: 変換時に展開するマクロ (単純な DEFMAC)。展開した後の式が変換される
- RUNTIME: ランタイムの命令 (ZIL の命令・ZILCH の組み込み・ランタイムが用意する関数)

規則 (§4 の 6):
- ゲームの定義がランタイムの関数と同じ名前なら、ゲームの定義を使う。ランタイムの
  内部からの呼び出し (TELL の書式指定子 D・A・N・C から PRINTD などを呼ぶ所) にも
  同じ定義を使う (ランタイムの側で、ゲームのルーチンがあればそれを呼ぶ)。
- ただし、物体 (OBJECT・ROOM) の名前は呼び出せないので、物体と同じ名前のフォームは
  ランタイムの命令とする (例: Trinity の <SOUND 1> は効果音、物体 SOUND とは別)。
- 共通マクロ (VERB? など) の作品の定義が組み込みと違うとき、作品の定義から作った同じ名前の
  関数は、ゲームの定義として呼ぶ (組み込みを上書きする。§4 の 8)。
- 宣言のフォーム (SYNTAX・PSEUDO など) はランタイムの関数にする。ゲームの同じ名前の
  DEFINE (Spellbreaker の PSEUDO など) は、コンパイル時の関数なので変換しない。
- DEFMAC は共有名に入らない。作品のマクロは、扱いが EXPAND なら評価器で展開する (macro_registry.py)。
  展開できなかった呼び出しは、警告を出して、ランタイムの同じ名前の関数に落ちる。
"""

from collections.abc import Iterable

from zilpy.constants import DECLARATION_FORMS
from zilpy.front.nodes import to_identifier

GAME = "game"
MACRO = "macro"
RUNTIME = "runtime"

# 宣言のフォーム (SYNTAX・PSEUDO など)。ゲームが同じ名前の DEFINE を持っていても、それは
# コンパイル時にだけ動く MDL の関数なので変換しない。呼び出しはランタイムの関数にする
_DECLARATION_IDENTS = frozenset(to_identifier(name) for name in (*DECLARATION_FORMS, "IFSOUND"))


class NameResolver:
    """呼び出しの名前 (識別子) を、ゲームの定義・マクロ・ランタイムの命令に振り分ける。"""

    def __init__(
        self,
        global_names: frozenset[str] | set[str],
        object_names: frozenset[str] | set[str],
        macro_names: Iterable[str] = (),
        overrides: Iterable[str] = (),
    ) -> None:
        """
        Args:
            global_names: 共有名 (識別子)。
            object_names: OBJECT・ROOM の名前 (識別子)。
            macro_names: 変換時に展開するマクロの名前 (ZIL の表記)。
            overrides: 共通マクロの組み込みを上書きする、作品の定義から作った関数の名前
                (識別子。宣言のフォームの VERB? なども、ゲームの定義として呼ぶ)。
        """
        self.global_names = global_names
        self.object_names = object_names
        self.macro_names = frozenset(macro_names)
        self.overrides = frozenset(overrides)

    def call(self, ident: str, zil_name: str | None = None) -> str:
        """フォームの先頭の名前を解決する。

        Args:
            ident: 名前を識別子に変換したもの。
            zil_name: ZIL の表記 (マクロかを調べるのに使う。大文字)。

        Returns:
            GAME・MACRO・RUNTIME のどれか。
        """
        if zil_name is not None and zil_name in self.macro_names:
            return MACRO
        if ident in self.overrides:
            return GAME
        if ident in _DECLARATION_IDENTS:
            return RUNTIME
        if ident in self.global_names and ident not in self.object_names:
            return GAME
        return RUNTIME

    def shadows_runtime(self, ident: str) -> bool:
        """ゲームの宣言が、同じ名前のランタイムの関数を隠すか (呼び出しは RUNTIME のまま)。

        Lua 版は、ゲームの宣言もランタイムの関数も同じ ZG テーブルに入るので、
        物体と同じ名前の命令は `ZG._rt.X` として呼ぶ必要がある。
        """
        return ident in self.global_names


def name_report(
    game_names: Iterable[str],
    object_names: frozenset[str] | set[str],
    runtime_names: frozenset[str] | set[str],
    macros: dict[str, str] | None = None,
) -> str:
    """ゲームとランタイムで重なった名前と、呼び出しにどちらを使うかの一覧を作る。

    golden 比較の対象にして、名前の解決が変わったら気づけるようにする。

    Args:
        game_names: ゲームの共有名 (識別子)。
        object_names: OBJECT・ROOM の名前 (識別子)。
        runtime_names: 出力する言語のランタイムの公開名。
        macros: 作品のマクロの名前 (識別子) と、その扱い (expand・builtin・runtime・game)。

    Returns:
        レポートの本文。
    """
    resolver = NameResolver(frozenset(game_names), object_names)
    lines = [
        "# ゲームの定義とランタイムの公開名が重なる名前 (呼び出しに使うもの)",
        "# game: ゲームの定義 (ランタイムの内部からの呼び出しにも使う)",
        "# runtime: ランタイムの命令 (物体と同じ名前の命令、または宣言のフォーム)",
    ]
    for ident in sorted(set(game_names) & set(runtime_names)):
        kind = resolver.call(ident)
        note = " (object)" if ident in object_names else ""
        if ident in _DECLARATION_IDENTS:
            note = " (declaration form; the game's DEFINE runs only at compile time)"
        lines.append(f"{ident}\t{kind}{note}")
    overlapping = sorted(set(macros or {}) & set(runtime_names))
    if overlapping:
        lines.append("# 作品のマクロのうち、ランタイムに同じ名前の関数があるもの (macro: マクロの扱い)")
        lines += [f"{ident}\t{MACRO}: {(macros or {})[ident]}" for ident in overlapping]
    return "\n".join(lines) + "\n"
