"""ZilPy の変換器のパッケージ。

- constants.py: 定数群 (フォーム名の分類、演算子の対応表など)
- front/: 読み込み (文字の読み出し・字句解析・構文解析と、AST の定義)
- compiletime/: 言語に依存しない、コンパイル時の処理
- backend/: 出力する言語ごとの部分

リポジトリの直下には、直接呼び出すスクリプト (ZilPy.py・ZilMcp.py・ZilMcp.lua) だけを置く。
"""
