"""変換時のエラー。"""


class ConversionError(ValueError):
    """ZIL の書き方が変換できないことを表すエラー。

    黙って不正なコードを出さないために使う (例: LOWCORE の表にないフィールド名)。
    ProjectBuilder はこのエラーをファイル名と行番号つきで報告し、変換の失敗として数える。
    """
