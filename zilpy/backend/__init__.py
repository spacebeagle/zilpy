"""出力する言語ごとの部分。

- base.py: TranscoderBase (両方の変換器に共通の骨組み)
- python.py・lua.py: ZilToPythonTranscoder・ZilToLuaTranscoder
- mode.py: Mode (生成コードで式の値をどう扱うか)
- global_file.py・lua_global_file.py: ZilGlobal.py・ZilGlobal.lua を作る
- runtime_names_*.py: ランタイムの公開名の一覧 (tools/runtime_names.py が書き出す)
"""
