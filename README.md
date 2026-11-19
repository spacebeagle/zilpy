# ZilPy

ZIL (Zork Implementation Language) のソースコードを Python または Lua 5.1 互換コードへ変換するトランスパイラです。
Infocom のテキストアドベンチャー (Zork I・II・III など) の ZIL ソースを読み込み、Python または Lua で動作するモジュール群を生成します。

## 特長

- ZIL ソースを字句解析・構文解析して AST を生成し、Python または Lua 5.1 互換ソースへ変換します (`--target python` / `--target lua`)。
- `<INSERT-FILE "...">` を再帰的にたどり、参照先の ZIL ファイルも個別のモジュールへ変換します。
- 生成コードが使うランタイム (入口の `ZilRuntime.py` と中身の `zilrt/` フォルダー。Lua 版は `ZilRuntime.lua` と `zilrt/`) を出力先へ自動でコピーします。出力先のフォルダーを丸ごとコピーすれば、ほかの場所でも動きます。
- 生成した `.py` / `.lua` を直接実行して遊べます (Python 版・Lua 版ともに、Zork I・II・III を含む Infocom の 16 作品で変換・クリアまで動作確認済みです。このリポジトリに含むのは、MIT ライセンスの Zork I・II・III だけです)。
- Z-machine のバージョン 3 向けの作品に加えて、バージョン 4 以降 (EZIP) 向けの作品 (Trinity、A Mind Forever Voyaging) も変換してクリアまで動作確認済みです。ただし、v4 対応は一部機能が簡易実装です (「既知の制限」を参照)。

## 必要環境

- Python 3.10 以降 (`X | Y` 形式の型ヒントを使用しています)
- 外部ライブラリは不要です。
- `--target lua` の生成コードを実行する場合は、Lua 5.1 互換の `lua` 実行環境 (Lua 5.1 / LuaJIT / Lua 5.4 など) が必要です。

## 使い方

```powershell
python ZilPy.py [--target {python,lua}] [-d DIR] [--print-ast] [オプション] zilfile [zilfile ...]
```

| 引数 | 説明 |
|---|---|
| `zilfile` | 変換するメインの ZIL ファイル (複数指定可) |
| `--target {python,lua}` | 出力言語 (既定値: `python`) |
| `-d`, `--outdir DIR` | 出力先ディレクトリ (既定値: `out`) |
| `--print-ast` | 変換前に AST を標準出力へ表示する |
| `--zil-source` | ルーチンの前に、ZIL の原文をコメントとして入れる (`# | <ROUTINE V-VERBOSE ()`。既定はオフ) |
| `--annotate {normal,full}` | マクロの注記の量。`full` では、関数にしたマクロと共通マクロの組み込みの呼び出しにも付ける (既定値: `normal`) |
| `--no-macro-comments` | マクロを展開した場所の注記と、`DEFMAC` の原文のコメントを出さない |
| `--no-zil-locations` | 定義の前の `# zil: ファイル:行` を出さない |
| `--no-zil-comments` | ZIL のコメント (`;"..."`) を残さない |
| `--no-macro-functions` | マクロを関数にせず、すべての呼び出しをその場で展開する |
| `--macro-report FILE` | 作品のマクロの扱いと呼び出しの数の一覧を書く |
| `--name-report FILE` | ゲームとランタイムで重なる名前と、呼び出しにどちらを使うかの一覧を書く |

### 例

Zork I を Python / Lua へ変換します。

```powershell
python ZilPy.py -d out\zork1 zork1\zork1.zil
python ZilPy.py --target lua -d lua\zork1 zork1\zork1.zil
```

出力先を指定しない場合は、カレントディレクトリの `out` 直下に出力されます。
ゲームごとに分けたい場合は、`-d` で `out\<ゲーム名>` のように指定してください。

### 終了コード

| 値 | 意味 |
|---|---|
| 0 | すべて成功 |
| 1 | 読み込み・構文解析の失敗、または INSERT-FILE の参照先が見つからなかった |

## 変換したゲームの起動

変換した出力先のディレクトリへ移動して、メインモジュールを実行します。
メインモジュールの名前は、変換に指定した ZIL ファイル名を小文字にしたものです。

```powershell
# Python 版
python ZilPy.py -d out\zork1 zork1\zork1.zil     # 変換
cd out\zork1
python zork1.py                                   # 起動

# Lua 版
python ZilPy.py --target lua -d lua\zork1 zork1\zork1.zil
cd lua\zork1
lua zork1.lua
```

Zork II・III も同じ手順です (`out\zork2` の `zork2.py`、`out\zork3` の `zork3.py`)。

- コマンドは標準入力から 1 行ずつ読みます。終了するには `quit` と入力して `y` と答えます。
- 出力先には `ZilRuntime.py`・`zilrt/`・`ZilGlobal.py` が一緒に置かれるので、そのディレクトリの中から実行してください。別のディレクトリから実行する場合は、出力先を `PYTHONPATH` に指定します。
- 起動時に、全ファイルのグローバル宣言を評価してからゲームの開始ルーチン (`GO`) を呼びます。

### セーブとリストア

ゲーム内で `save` と入力すると、カレントディレクトリの `<ゲーム名>.sav` (例: `zork1.sav`) に状態を保存します。`restore` で読み込みます。
既定では単一ファイルへの上書きですが、ランタイムの Python API (`SAVE(slot=...)`、`RESTORE(slot=...)`、`LIST_SAVES()`) では名前付き複数スロット (`<ゲーム名>.<slot>.sav`) にも対応しています。

- 保存する内容は、グローバル変数、全オブジェクト (プロパティ・フラグ・親子関係)、乱数の状態です。
- 通常の保存先への書き込みが権限エラーなどで失敗した場合は、一時ディレクトリ (`<temp>/zilpy_saves/`) へ自動的にフォールバックして保存・復元し、失敗原因を標準エラー出力へ記録します。
- 保存には Python の `pickle` を使います。ファイルは Python のバージョンや、変換後のコードに依存します。変換し直したゲームでは、古い保存ファイルを読み込めないことがあります (その場合は `Failed.` と表示します)。
- 信頼できない保存ファイルを読み込まないでください (`pickle` は、読み込み時にコードを実行できます)。
- `restart` は、ゲームのプロセスを再起動します (MCP サーバーの場合は後述)。

### コマンドをまとめて入力する

入力をファイルに書いて、リダイレクトで渡せます。動作確認に便利です。

```powershell
cmd /c "python zork1.py < commands.txt"
```

PowerShell のパイプ (`Get-Content ... | python zork1.py`) は、先頭に BOM が付いてゲームが最初の 1 行を読み違えることがあるため、`cmd /c` のリダイレクトを使ってください。ファイルは ASCII で保存します。

### MCP サーバーとして LLM から遊ぶ

`ZilMcp.py` (Python 版) および `ZilMcp.lua` (Lua 版) は、変換したゲームを MCP サーバー (標準入出力の JSON-RPC 2.0) として公開します。外部パッケージは不要です。

```powershell
python ZilMcp.py out/zork1                 # Python 版: out/zork1/zork1.py を起動する
python ZilMcp.py out/zork2
lua ZilMcp.lua lua/zork1 --entry zork1     # Lua 版: lua/zork1/zork1.lua を起動する
```

プロジェクトの `.mcp.json` には、動作を確認した 16 作品の Python 版と Lua 版 (`zork1` と `zork1-lua` など、32 個) を登録してあります。このリポジトリに変換結果が入っている `zork1`・`zork2`・`zork3` (と `-lua`) は、Claude Code からそのまま使えます (初回は MCP サーバーの使用の承認を求められます)。ほかの作品のサーバーは、その作品を手元で `out/<作品名>` (Lua 版は `lua/<作品名>`) に変換すると使えるようになります (「ほかの Infocom 作品を変換する」を参照)。

| ツール | 内容 |
|---|---|
| `send_command` | 英語のコマンドを 1 つ送り、次の入力待ちまでの出力を返す。初回はゲームを開始し、開始時の文章も返す |
| `look_state` | プレイヤーが今知覚できる範囲 (場所・明るさ・持ち物・見える物) を JSON で返す。隠れた物や他の部屋は含めない |
| `restart_game` | 最初からやり直す (`quit` で終了した後も使える) |
| `save_state` | 現在のゲーム状態をメモリ上の名前付きスロット (既定: `default`) へ保存する (ターンを進めず、ファイル書き込みも行わない) |
| `restore_state` | メモリ上の名前付きスロットから状態を復元し、復元後の知覚状態 (`look_state`) を返す |
| `undo` | `send_command` 実行前に自動保存された履歴を使い、指定手数 (既定: 1、最大 20 手) 前の状態へ戻す |
| `list_states` | 保存済みメモリスロットの一覧と Undo 履歴を JSON で返す |

- ゲームは別スレッドで通常どおり動かし、`ZilRuntime.set_io` で入出力だけを差し替えます。変換したコードには手を入れません。
- MCP サーバーでのゲーム内 `save` / `restore` は `<ゲーム名>-mcp.sav` (例: `out/zork1/zork1-mcp.sav`) を使い、コマンドラインで遊ぶときの保存ファイルとは分けています。あわせて `save_state` / `restore_state` / `undo` を使うと、ディスク権限やファイル上書きを気にせずメモリ上で高速にやり直せます。
- `restart` は、プロセスを再起動せず、開始時に保存した状態へ戻します (`undo` 履歴はクリアされますが、名前付きメモリスロットは保持されます)。

## 生成されるファイル

ZIL ファイル 1 つにつき、Python モジュールが 1 つ生成されます。
モジュール名はファイル名を小文字にし、Python の識別子として有効な形へ変換したものです
(例: `1dungeon.zil` → `_1dungeon.py`)。

メインとして指定したファイルの末尾には、起動用のコードが追加されます。

```python
if __name__ == "__main__":
    ZG._link()
    ZG.GO()
```

各モジュールは、先頭で `from ZilRuntime import *` によりランタイムを取り込み、`import ZilGlobal` でグローバル宣言を登録します。
`INSERT-FILE` の位置は、対応するモジュールの `from モジュール import *` に置き換わります。

出力先には、ZIL ファイルごとのモジュールのほかに、次のファイルが作られます。

| ファイル | 内容 |
|---|---|
| `ZilRuntime.py` | ランタイムの入口 (リポジトリの `runtime/python/` のものをコピー)。生成コードは `from ZilRuntime import *` で読み込む |
| `zilrt/` | ランタイムの中身 (`context`・`objects`・`tables`・`vocab`・`saves` などのモジュール)。入口の `ZilRuntime.py` が読み込む |
| `ZilGlobal.py` | 全 ZIL ファイルの `GLOBAL`、`CONSTANT`、トップレベルの `SETG` の宣言 |
| `zilmap.json` | 生成コードの名前と、元の ZIL の名前・種類・ファイル・行の対応表。ルーチンごとのローカル変数の改名 (`OBJ` → `OBJ_l` など) も載せる |

### 元の ZIL へたどる

生成コードには、元の ZIL へたどるための情報を残します。

- 定義の前に、元のファイルと行を書きます (`# zil: gverbs.zil:13  <ROUTINE V-VERBOSE ()>`。Lua は `--`)。
- ZIL のコメント (トップレベルと、ルーチンの本体の文と文の間のもの) を、原文のまま残します (`# ;"V-DIAGNOSE is in ACTIONS.ZIL"`)。
- マクロを展開した文の直前に、元の呼び出しと定義の場所を書きます (`# macro: <PROB 30> (macros.zil:66) -> expanded`)。
- ルーチンは ZIL の名前でも登録します (`@ZG.routine("V-VERBOSE")`)。
- `--zil-source` を付けると、ルーチンの前に ZIL の原文を 1 行ずつコメントにして入れます。原文がそのまま入るので、ライセンスのない作品では、生成物を配布しないときだけ使ってください。
- MCP サーバーの実行時エラーの表示には、traceback のあとに ZIL のルーチンと位置を並べます (`ZIL call stack: ROUTINE V-TAKE (gverbs.zil:120)`)。Python 版は `zilmap.json` を、Lua 版は `-- zil:` の注記を使います。

### グローバル名前空間 (ZG)

ZIL では、`INSERT-FILE` で取り込んだ全ファイルの `GLOBAL`、`CONSTANT`、`ROUTINE`、`OBJECT` が 1 つの名前空間になります。
Python のモジュールは名前空間が別々なので、共有する名前はランタイムの `ZG` オブジェクトの属性として扱います。

```python
ZG.SCORE = ZG.SCORE + 5       # <SETG SCORE <+ ,SCORE 5>>
ZG.PERFORM(ZG.V_TAKE, obj)    # <PERFORM ,V?TAKE .OBJ>
```

- `GLOBAL`、`CONSTANT`、トップレベルの `SETG` は `ZilGlobal.py` に集めます。元のモジュールには、宣言をコメントとして残します。

  ```python
  # GLOBAL LOAD_MAX = 100  ->  ZilGlobal.py
  ```

- `ROUTINE` は `@ZG.routine("ZIL の名前")` で登録します (関数名と ZIL の名前の両方で引ける)。
- `OBJECT` と `ROOM` は元のモジュールに `ZG._declare_object(...)` として宣言します。
- 値は最初に参照された時に評価するので、後で定義されるオブジェクトやルーチンを前方参照できます。部屋の出口のように、オブジェクトどうしが循環して参照していても解決できます。
- `ZG._link()` が、残りの未評価の宣言をまとめて評価します。ゲームを開始する前に呼び出します。
- `.X` (ローカル変数) は `ZG` を通さず、Python のローカル変数になります。
- 条件分岐 (`%<COND ...>`) の中の `GLOBAL` と `CONSTANT` は、条件を保つため `ZilGlobal.py` へ移さず、その場に宣言します。

## 変換の規則

- ZIL のシンボル名は Python の識別子へ変換します。
  - 先頭の `.` と `,` (変数参照) は取り除きます。
  - 末尾の `?` は `_p` にします (例: `FSET?` → `FSET_p`)。
  - 識別子に使えない文字は `_` にします。
  - 予約語と衝突する場合は、末尾に `_` を付けます。
- ZIL ではすべてが式ですが、Python には文と式の区別があります。
  `COND` や `REPEAT` のように文が必要なフォームは、一時変数 (`_tmp...`) を使って直前の文へ巻き上げます。
  Lua 版では、関数のローカル変数が 200 個までなので、引数・ローカル変数と合わせて 150 個に収まる分の一時変数だけを名前の付いた変数 (`_tmp1` など) にし、収まらない分は配列の要素 (`_L[31]` など) にします (トップレベルの文の一時変数は、いつも配列の要素です)。
- `ROUTINE` は Python の関数、`GLOBAL` と `CONSTANT` は `ZilGlobal.py` の宣言、`OBJECT` と `ROOM` は `ZG._declare_object` の宣言へ変換します (前節を参照)。

## ソースコードの構成

リポジトリの直下には、直接呼び出すスクリプト (`ZilPy.py`・`ZilMcp.py`・`ZilMcp.lua`) だけを置きます。変換器の本体は `zilpy/` パッケージで、読み込み (`zilpy/front/`)、コンパイル時の処理 (`zilpy/compiletime/`)、コードの生成 (`zilpy/backend/`) の 3 つに分かれています。ランタイムは `runtime/` にあります。

| ファイル | 内容 |
|---|---|
| `ZilPy.py` | コマンドラインツール。INSERT-FILE をたどって変換し、出力する |
| `zilpy/constants.py` | 定数群 (フォーム名の分類、演算子の対応表など) |
| `zilpy/front/char_reader.py` | `CharReader`: 行・桁を追跡しながら文字を読み出す |
| `zilpy/front/lexer.py` | `Lexer`: ソースをトークン列に分割する |
| `zilpy/front/parser.py` | `Parser`: トークン列から AST を構築する |
| `zilpy/front/compiler.py` | `ZilCompiler`: ZIL ファイルを読み込み、AST を生成・表示する |
| `zilpy/front/nodes.py` | AST ノード (`Span`、`Token`、`ZSymbol`、`ZString`、`ZList`、`ZExp`) とヘルパー関数 |
| `zilpy/compiletime/project.py` | 変換の前に全ファイルを走査して集める情報 (共有名・オブジェクト名・フラグ名など) |
| `zilpy/compiletime/static_eval.py` | コンパイル時に決まる条件の評価 (`%<COND ...>`、`<GASSIGNED? ZILCH>` の節の選択。`StaticEvaluator`) |
| `zilpy/compiletime/lowering.py` | AST から AST への変形 (`INC`/`DEC`、`DO`/`MAP-CONTENTS` → `REPEAT`) と、ルーチンの引数リストの解釈 |
| `zilpy/compiletime/mdl.py` | コンパイル時の MDL 評価器。作品の `DEFMAC` と補助の `DEFINE` を変換時に実行する |
| `zilpy/compiletime/macro_registry.py` | 作品ごとのマクロの登録と、マクロごとの扱い (展開・組み込み・関数化) の決定 |
| `zilpy/compiletime/builtin_macros.py` | 共通マクロ 11 個の正規の展開と、作品の定義との比較 |
| `zilpy/compiletime/macro_functions.py`・`purity.py` | マクロの関数化の判定と、副作用のない式の判定 |
| `zilpy/compiletime/tell.py` | `DEFMAC TELL` から書式指定子とルーチンの対応表を作る |
| `zilpy/compiletime/names.py` | 呼び出しの名前の解決 (ゲームの定義・ランタイムの命令) |
| `zilpy/compiletime/loader.py` | 読み込み時に展開するマクロ |
| `zilpy/compiletime/sourcemap.py` | `ZilMap`: 生成コードの名前と元の ZIL の位置の対応表 (`zilmap.json`) |
| `zilpy/backend/base.py` | `TranscoderBase`: 両方の変換器に共通の骨組み (`Mode` による文の振り分け、一時変数の巻き上げ、ループの管理) |
| `zilpy/backend/python.py` | `ZilToPythonTranscoder`: AST を Python ソースへ変換する (Python の文字列の生成) |
| `zilpy/backend/lua.py` | `ZilToLuaTranscoder`: AST を Lua 5.1 互換ソースへ変換する (Lua の文字列の生成) |
| `zilpy/backend/runtime_names_*.py` | ランタイムの公開名の一覧 (ローカル変数の改名に使う。ランタイムから機械的に作ったもの) |
| `zilpy/backend/mode.py` | `Mode`: 生成コードで式の値をどう扱うか (破棄・返す・代入) |
| `zilpy/backend/global_file.py` | `ZilGlobalFile`: 各ファイルのグローバル宣言を集めて `ZilGlobal.py` を作る |
| `zilpy/backend/lua_global_file.py` | `ZilLuaGlobalFile`: 各ファイルのグローバル宣言を集めて `ZilGlobal.lua` を作る |
| `runtime/python/ZilRuntime.py` | Python 版のランタイムの入口 (`from zilrt import *`)。変換のたびに出力先へコピーする |
| `runtime/python/zilrt/` | Python 版のランタイムの中身: `context` (GameContext・ZG・入出力の差し込み口)・`io` (出力・TELL)・`objects`・`tables`・`vocab` (辞書・構文テーブル・READ)・`instructions`・`builtin_macros` (共通マクロ)・`exits`・`mdl_compat`・`saves` (保存・スナップショット)・`screen`・`source_fixes` (原作ソースの補正)。公開名の分類 (`PUBLIC_NAMES`) は `__init__.py` |
| `runtime/lua/ZilRuntime.lua`・`runtime/lua/zilrt/` | Lua 版のランタイムの入口と中身 (Python 版と同じ分け方)。入口が、各モジュールを共通の環境 (表) の中で順に読み込む |
| `ZilMcp.py` | 変換した Python 版ゲームを MCP サーバーとして公開する |
| `ZilMcp.lua` | 変換した Lua 版ゲームを MCP サーバーとして公開する (コルーチン駆動) |

### 処理の流れ

```
ZIL ソース
  → CharReader → Lexer → Parser              (front/compiler.py の ZilCompiler.read_zil_file。読み込み時のマクロは compiletime/loader.py)
  → AST (ZNode のリスト)
  → 全ファイルを走査して、名前とマクロを集める    (ZilPy.ProjectBuilder.scan: compiletime/project.py・macro_registry.py)
  → マクロごとの扱いを決める                    (MacroRegistry.finalize: 評価器 mdl.py での展開、共通マクロの比較、関数化の判定)
  → ZilToPythonTranscoder / ZilToLuaTranscoder (static_eval.py で %<COND> の節を選び、lowering.py で変形し、Mode に応じて文を生成)
  → 出力先: モジュール + ZilGlobal + zilmap.json + ランタイム (ZilRuntime と zilrt/ をコピー)
```

変換の前に、`INSERT-FILE` をたどって全ファイルを走査し、`ROUTINE`、`GLOBAL`、`OBJECT` などの名前と、`DEFMAC` を集めます。
別のファイルで定義される名前を `ZG.NAME` として正しく参照するためと、マクロの扱いを全ファイルを見てから決めるためです。

依存の向きは次のとおりで、循環参照はありません。

```
zilpy.constants → zilpy.front.nodes → zilpy.compiletime の基本 (static_eval・loader・project・lowering・mdl・names・purity)
                                    → zilpy.compiletime のマクロ (builtin_macros・macro_functions・tell) → macro_registry
zilpy.front.char_reader → lexer → parser → compiler (compiletime.loader も使う)
                                    (builtin_macros は、共通マクロの正規の定義を front.compiler で読む)
backend.mode・global_file・lua_global_file・zilpy.compiletime → zilpy.backend.base → zilpy.backend.python / lua
                                    zilpy.backend.runtime_names_* ↗
ZilPy.py (コマンドライン) → 上のすべて
```

変換器はランタイム (`runtime/`) を import しません。

## リポジトリの内容

| パス | 内容 |
|---|---|
| `ZilPy.py`・`ZilMcp.py`・`ZilMcp.lua`・`zilpy/`・`runtime/` | 変換器・MCP サーバー・ランタイム (前節) |
| `zork1/`、`zork2/`、`zork3/` | Zork I・II・III の ZIL ソース (historicalsource から取得。MIT ライセンス) |
| `out/zork1/`、`out/zork2/`、`out/zork3/` | Zork I・II・III の Python 版の変換結果 (元の `LICENSE` を同梱) |
| `lua/zork1/`、`lua/zork2/`、`lua/zork3/` | Zork I・II・III の Lua 版の変換結果 (元の `LICENSE` を同梱) |
| `docs/playthroughs/` | Zork I・II・III およびほか 13 作品 (AMFV、Deadline、Enchanter、The Hitchhiker's Guide to the Galaxy、The Lurking Horror、Moonmist、Planetfall、Sorcerer、Spellbreaker、Stationfall、Suspended、Trinity、The Witness) の攻略メモと構造の解説 (後述) |
| `docs/refactoring-decisions.md` | 2026 年 11 月の変換器とランタイムの作り直しで決めたことと、その理由 |
| `.mcp.json` | Claude Code 用の MCP サーバーの登録 (16 作品 × Python 版・Lua 版) |

Zork I・II・III のソースは、2025 年 11 月に MIT ライセンスで公開されたものです (各フォルダーの `LICENSE`)。

```powershell
python ZilPy.py -d out\zork1 zork1\zork1.zil
python ZilPy.py -d out\zork2 zork2\zork2.zil
python ZilPy.py -d out\zork3 zork3\zork3.zil
```

### ほかの Infocom 作品を変換する

GitHub の [historicalsource](https://github.com/historicalsource) には、ほかの Infocom 作品の ZIL ソースも公開されています。ただし、MIT ライセンスが付いているのは Zork I・II・III だけで、ほかの作品にはライセンスがありません。手元で変換して遊ぶことはできますが、ソースや変換結果を再配布しないでください。

Deadline の例です (開発中は Deadline でも、事件の解決まで動作を確認しています)。

```powershell
git clone https://github.com/historicalsource/deadline.git deadline
python ZilPy.py -d out\deadline deadline\deadline.zil
cd out\deadline
python deadline.py
```

- メインの ZIL ファイルは、たいてい作品名と同じ名前 (`deadline.zil` など) です。
- 取得したソース (`deadline/`) と変換結果 (`out/deadline/`・`lua/deadline/`) は、`.gitignore` に追加して、誤ってコミットしないようにしてください。
- MCP サーバーで遊ぶ場合は `python ZilMcp.py out/deadline` のように指定します。`.mcp.json` に登録してある 13 作品は、`out/<作品名>` (Lua 版は `lua/<作品名>`) に変換すれば、Claude Code からそのまま使えます。メインの ZIL ファイルが作品名と違う作品 (AMFV は `s5.zil`、HHGG は `s4.zil`、Lurking Horror は `h1.zil`、Spellbreaker は `z6.zil`、Stationfall は `s6.zil`) は、`.mcp.json` で `--entry` を指定してあります。
- Zork I・II・III 以外の 13 作品 (AMFV、Deadline、Enchanter、The Hitchhiker's Guide to the Galaxy、The Lurking Horror、Moonmist、Planetfall、Sorcerer、Spellbreaker、Stationfall、Suspended、Trinity、The Witness) についても、手元で変換した Python 版・Lua 版を MCP (`ZilMcp.py` / `ZilMcp.lua`) 経由でクリアまで動作を確認しています (「既知の制限」を参照)。

### 攻略メモと構造の解説

`docs/playthroughs/` には、Zork I・II・III、A Mind Forever Voyaging、Deadline、Enchanter、The Hitchhiker's Guide to the Galaxy、The Lurking Horror、Moonmist、Planetfall、Sorcerer、Spellbreaker、Stationfall、Suspended、Trinity、The Witness の全 16 作品をクリアしたときの資料があります。**ゲームの解き方がすべて書かれているので、自分で解きたい人は読まないでください。**

| ファイル | 内容 |
|---|---|
| `*-guide.md` (`zork1-guide.md` など) | LLM 等が攻略する際の参考資料としてまとめた攻略メモ |
| `*-architecture.md` (`zork1-architecture.md` など) | 作品の内部構造 (パーサー・時計・得点・詰みなど) の解説。位置は元の ZIL ソースの `ファイル:行` で示す |

Zork I・II・III 以外の 13 作品の資料は、攻略メモと構造の解説だけです。これらの作品のソースと変換結果はリポジトリに含めていません。構造の解説の `ファイル:行` は、historicalsource で公開されている元の ZIL ソースの位置なので、原本と並べて読めます。

## コンパイル時の処理

ZIL では、コンパイラがコンパイル時に MDL のコードを実行して、コードを展開します。ZilPy は、その一部を変換時に処理します。

- `%<COND ...>` のうち、`<==? ,ZORK-NUMBER 1>` のように、コンパイル時に決まる値の比較だけで書かれたものは、変換時に評価して、選ばれた節だけを出力します。`<COND %<COND ...> ...>` のように、節そのものをコンパイル時に選ぶ書き方にも対応しています。
- トップレベルの `<SETG NAME 整数>` が、コンパイル時に決まる値になります。
- 作品の `DEFMAC` と、それが呼ぶ補助の `DEFINE` (`MULTIFROB` など) は、変換時に MDL の評価器 (`zilpy/compiletime/mdl.py`) で作品の定義どおりに実行して展開します。展開した文の直前には `# macro: <呼び出し> (定義の場所) -> expanded` の注記を、`DEFMAC` の位置には元の定義の原文のコメントを出力します (`--no-macro-comments` で消せます)。
- 関数にしても動きが同じになるマクロ (`PROB`、`DISABLE` など) は、作品の定義から関数を作って `DEFMAC` の位置に出力し、呼び出しを関数の呼び出しにします (`--no-macro-functions` で、すべてその場で展開します)。
- 14 作品のどこでも同じ意味に定義されている共通マクロ 12 個は、ランタイムの組み込みを使います (次の節)。
- `TELL` は展開せず、`TELL(...)` の形のまま出力します。書式指定子とルーチンの対応は、作品の `DEFMAC TELL` を評価器で展開して作ります。
- マクロごとの扱いは `ZilPy.py --macro-report FILE` で一覧にできます。
- 同じ名前の `ROUTINE` があるマクロは、`ROUTINE` のほうを呼びます (Zork II の `ROOM?`)。
- `ASSIGNED?` は、省略可能な引数が `None` かどうかの判定に変換します。
- ファイルの取り込み用のマクロ (一部の作品で使われる `<DEFINE IFILE (STR) <INSERT-FILE .STR T>>` と、それを使う `<IFILE "PARSER" T>`) は、`INSERT-FILE` に置き換えます。マクロの定義と、`<OR <GASSIGNED? X> ...>` の形のコンパイル時の分岐、ビルド用の指示 (`ENDLOAD`、`GC`、`GC-MON`) は取り除きます。
- ZIL のローカル変数が、ランタイムの関数・定数と同じ名前の場合 (例: `LOC`、`C`) は、変数名の末尾に `_l` を付けます。ZIL では変数 `.LOC` と関数 `<LOC>` は別の名前空間にあるためです。
- 宣言がないのに参照されるローカル変数 (原典の誤記) は、ルーチンの先頭で 0 に初期化します。コンパイラが値 0 として通すのと同じ扱いです。
- テーブルに書かれた、どこにも定義がないアトムは 0 にします。
- マクロの補助用に `DEFINE` された関数 (`MULTIFROB` など、MDL でしか動かないもの) は、生成コードには変換しません (評価器が変換時に実行し、原文をコメントで残します)。
- コンパイラが定義する記号定数は、種類によって次のように扱います。
  - プロパティ名 (`P?ACTION` は `'ACTION'`)、単語 (`W?NORTH` は `'north'`)、フラグ (`OPENBIT` は `'OPENBIT'`) は、名前を表す文字列です。
  - 品詞 (`PS?VERB`、`P1?VERB` など) は、ランタイムの定数 (`PS_VERB`、`P1_VERB`) です。
  - 構文の宣言で番号が決まるもの (`V?TAKE`、`ACT?WALK`、`PR?THROUGH`、`A?RED`) は、ランタイムの `SYMBOL('V?TAKE')` の呼び出しです。

### 共通マクロ

次の 12 個のマクロは、定義するどの作品でも同じ意味なので、ランタイムに組み込みの関数として用意しています。変換するときに、作品の定義を評価器で試しの引数に対して展開し、組み込みの展開と同じになるかを確かめます。同じなら組み込みを呼び、違えば、作品の定義から同じ名前の関数を作って組み込みを上書きします (可変長の引数のマクロは、引数の数ごとに関数を作ります)。今の 14 作品では、上書きした作品はありません。

| マクロ | 組み込み | 意味 (元の定義を展開した結果) | 定義する作品 (どれも組み込みと同じ意味) |
|---|---|---|---|
| `VERB?` | `VERB_p` | `PRSA` が `V?名前` のどれかに等しい | 14 作品すべて |
| `PRSO?` / `PRSI?` | `PRSO_p` / `PRSI_p` | `PRSO` (`PRSI`) が引数のどれかに等しい | AMFV、Enchanter、HHGG、Lurking Horror、Sorcerer、Spellbreaker、Trinity、Zork I・II・III (10) |
| `ROOM?` | `ROOM_p` | `HERE` が引数のどれかに等しい | AMFV、Enchanter、HHGG、Sorcerer、Spellbreaker、Zork I・II・III (8)。Zork II は同じ名前の `ROUTINE` を呼ぶ |
| `BSET` / `BCLEAR` / `BSET?` | `BSET` / `BCLEAR` / `BSET_p` | フラグを `FSET` / `FCLEAR` で並べる、`FSET?` を `OR` でつなぐ | AMFV、Enchanter、HHGG、Lurking Horror、Sorcerer、Spellbreaker、Zork I・II・III (9)。どの作品からも呼ばれていない |
| `OPENABLE?` | `OPENABLE_p` | `<OR <FSET? .OBJ ,DOORBIT> <FSET? .OBJ ,CONTBIT>>` | Deadline、Enchanter、Planetfall、Sorcerer、Suspended、Witness、Zork I・II・III (9) |
| `FLAMING?` | `FLAMING_p` | `<AND <FSET? .OBJ ,FLAMEBIT> <FSET? .OBJ ,ONBIT>>` | Deadline、Enchanter、Witness、Zork I・II・III (6) |
| `ABS` | `ABS` | `<COND (<L? .NUM 0> <- 0 .NUM>) (T .NUM)>` | Deadline、Enchanter、Planetfall、Sorcerer、Suspended、Trinity、Witness、Zork I・II・III (10) |
| `ENABLE` | `ENABLE` | `<PUT .INT ,C-ENABLED? 1>` | Deadline、Enchanter、HHGG、Planetfall、Sorcerer、Suspended、Trinity、Witness、Zork I・II・III (11) |
| `RFATAL` | (`return 2`) | ルーチンから 2 を返す | 14 作品すべて |

`PROB` (確率の判定の `>=` と `>` が作品ごとに違う)、`DISABLE` (AMFV だけ `C-RTN` を使う)、`TELL` (書式指定子が作品ごとに違う) は、作品ごとに定義が違うので組み込みにせず、作品の定義から展開します。

## 辞書と構文テーブル

ZIL のパーサー (`gparser.zil`) は、コンパイラが作る辞書と構文テーブルを前提にしています。ZilPy はランタイムの `zilrt/vocab.py` (Lua 版は `zilrt/vocab.lua`) で、これを再現します。

| ZIL の宣言 | ランタイムでの再現 |
|---|---|
| `SYNTAX`、`SYNONYM`、`BUZZ`、`DIRECTIONS` | 宣言を記録し、最初に必要になった時に番号を割り当てる |
| オブジェクトの `SYNONYM`、`ADJECTIVE` | 名詞と形容詞として辞書に登録し、プロパティを単語・番号のテーブルにする |
| 辞書の単語 | `Word` クラス。`GETB` で品詞と値を読める。バージョン 3 の配置 (`P-PSOFF` が 4) では先頭 6 文字を区別し、品詞は 4 バイト目、値は 5・6 バイト目。バージョン 4 以降の配置 (`P-PSOFF` が 6) では先頭 9 文字を区別し、品詞は 6 バイト目、値は 7・8 バイト目 |
| `VERBS` | 動詞ごとの構文テーブル。1 エントリ 8 バイト (オブジェクト数、前置詞 2 つ、FIND フラグ 2 つ、位置指定 2 つ、アクション番号) |
| `ACTIONS`、`PREACTIONS` | アクション番号ごとの `V-NAME`、`PRE-NAME` ルーチンの表 |
| `PREPOSITIONS` | 前置詞の単語と番号の表 |
| 部屋の出口 | 出口の種類を `PTSIZE` で区別する Z-machine の形式のテーブル (`UEXIT`、`NEXIT`、`FEXIT`、`CEXIT`、`DEXIT`)。部屋を 1 バイトで持つ配置 (`UEXIT` が 1) と、ワードで持つ配置 (`UEXIT` が 2。Trinity、AMFV) に対応 |
| `<ITABLE BYTE n>` | 先頭に要素数 `n` のバイトを持つテーブル (入力バッファ用)。要素はワード |

`VERBS` などは、ゲームのソースに定義がないグローバルです。`ZG` が最初に参照された時に作ります。

## 既知の制限

- 対象 16 作品はすべて、変換後の **Python 版**（直接実行・`ZilMcp.py`）および **Lua 版**（`ZilMcp.lua`）の両方でエンディングまでクリアできることを確認しました (攻略の手順は `docs/playthroughs/` を参照)。
  - **Zork I:** 350/350 点 (Python: 385 手 / Lua: 397 手)
  - **Zork II:** 400/400 点 (Python: 334 手 / Lua: 395 手)
  - **Zork III:** 7/7 点 (Python: 230 手 / Lua: 228 手)
  - **A Mind Forever Voyaging (AMFV):** Part I〜III・Epilogue 完走 (`ACKNOWLEDGEMENTS` 到達)
  - **Deadline:** 事件解決 (9/5 有罪判決の手紙)
  - **Enchanter:** 400/400 点 (Python: 262 手 / Lua: 261 手)
  - **The Hitchhiker's Guide to the Galaxy:** 400/400 点 (Python: 400 ターン / Lua: 394 ターン)
  - **The Lurking Horror:** 100/100 点 (`President of the Institute`, Python: 538 ターン / Lua: 289 コマンド)
  - **Moonmist:** 事件解決 (Red バリエーション・逮捕エンド到達, Python・Lua ともに 129 コマンド)
  - **Planetfall:** 80/80 点 (`Galactic Overlord`)
  - **Sorcerer:** 400/400 点 (Python: 396 手 / Lua: 396 手)
  - **Spellbreaker:** 600/600 点 (Python: 589 手 / Lua: 591 手)
  - **Stationfall:** 80/80 点 (`Intergalactic Mega-Hero`, Python: 412 コマンド / Lua: 438 コマンド)
  - **Suspended:** 129 サイクル・被害 29,000 (`Ranking: 1`, Python・Lua ともに 114 コマンド)
  - **Trinity:** 100/100 点 (Python: 419 手 / Lua: 427 手)
  - **The Witness:** 事件解決 (モニカ逮捕・有罪判決 + 作者サマリー, Python: 31 コマンド / Lua: 29 コマンド)

  ただし、すべての場面や、通らなかった選択肢まで確認したわけではありません。
- 条件が実行時の値に依存する `%<...>` には対応していません。`DEFMAC` は評価器で展開しますが、評価器の扱える MDL は 14 作品のマクロが使う範囲だけです (展開できない呼び出しは警告を出し、`ZilPy.py --macro-report` の一覧に載ります)。
- ZIL のすべてのフォームに対応しているわけではありません。
  未対応のフォームは、関数呼び出しとして出力されます。実行するには、ランタイム (`zilrt/`) に同名の関数が必要です。
- プロパティ名は番号ではなく文字列で扱います。`LOW-DIRECTION` との大小比較は、「方向のプロパティか」という判定に置き換えています。
- 同じ動詞の構文は、宣言と逆の順に並べます。コンパイル済みの Zork I (`zork1/zork1.zip`) の構文テーブルと同じ並びであることを確認しました (ほかの作品のコンパイル結果とは比べていません)。
- Z-machine の仕様は、バージョン 3 を基本にしています。バージョン 4 以降 (EZIP) には暫定で対応しています。
  - `<VERSION>` は読まず、ゲームが定義する定数から辞書と出口の配置を判定します (`P-PSOFF` が 4 ならバージョン 3、6 ならバージョン 4 以降の辞書。`UEXIT` が 2 なら部屋をワードで持つ出口)。ゲームの実際のバージョンとは一致しないことがあります。
  - Trinity と A Mind Forever Voyaging も通しプレイでエンディングまで確認済みです。
  - 画面分割、効果音 (`SOUND` は何もしません)、1 文字入力 (`INPUT` は 1 行を読んで先頭の文字を返します) などは、簡易的な実装です。
  - 版表示 (Release / Serial number) は、ランタイム共通の固定値です。
- MCP サーバーの実行時エラーの表示に出す ZIL の呼び出しの並び (`ZIL call stack`) は、Lua 版では末尾呼び出しをしたルーチンが抜けます (Lua は末尾呼び出しの呼び出し元のフレームを残さないため)。

## 原作ソースの補正

元の ZIL ソースそのものにバグがあり、Z-machine では意味のない値を読んで動き続けるのに、ZilPy では型の違いなどで止まってしまう箇所は、ランタイムの `zilrt/source_fixes.py` (Lua 版は `zilrt/source_fixes.lua`) で補正します。補正は `GLOBAL` の名前ごとに登録し、ゲームの値が元の値と完全に一致したときだけ適用します (適用したときは標準エラー出力に知らせます)。

| 作品 | GLOBAL | 補正の内容 |
|---|---|---|
| Zork III | `YUKS` | `zork3.zil` は `gverbs.zil` と `3actions.zil` の両方で `YUKS` を定義し、後に読む `3actions.zil` 版 (先頭に 0 がない) が残る。`gmacros.zil` の `PICK-ONE` はワード 1 を使用済みの数として読むので、取れない物を TAKE するたびに文字列のアドレスを数として読み書きしていた。`gverbs.zil` 版と同じ `<LTABLE 0 ...>` の形に直す |

ほかに、効果音を鳴らす作品のルーチン (`zilpy/constants.py` の `SILENT_ROUTINES`。Lurking Horror の `SOUNDS`) は、変換器が本体を何もしないものにします (ZilPy は効果音を出しません)。

## 作者

ZilPy は、同人サークル「物語記述機構 (The Instrumentality of Narrative Description)」の開発プロジェクト SpaceBeagle が開発しています。

## ライセンス

ZilPy 自身のコード (`Zil*.py` など) は MIT ライセンスです (ルートの `LICENSE`、Copyright (c) 2026 SpaceBeagle)。

Zork I・II・III の ZIL ソース (`zork1/` など) とその変換結果 (`out/zork1/` など) は、Microsoft が MIT ライセンスで公開したものです (Copyright (c) 2025 Microsoft。各フォルダーの `LICENSE`)。
ZORK などの名前は各権利者の商標であり、このプロジェクトは権利者とは関係のない非公式のものです。
