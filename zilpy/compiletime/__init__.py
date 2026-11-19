"""言語に依存しない、コンパイル時の処理。

- project.py: 変換の前に全ファイルを走査して集める情報 (collect_*)
- static_eval.py: コンパイル時に決まる条件 (zilch_branch)
- macros.py: 変換時のマクロ展開
- loader.py: 読み込み時に展開するマクロ (expand_load_macros)
"""
