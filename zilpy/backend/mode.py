"""コード生成時の値の扱い方 (Mode)。"""

from dataclasses import dataclass


@dataclass(frozen=True)
class Mode:
    """生成するコードで式の値をどう扱うかを表す文脈。

    Attributes:
        kind: 'discard' (値を捨てる)、'return' (関数から返す)、
            'assign' (target へ代入する) のいずれか。
        target: kind が 'assign' のときの代入先の変数名。
    """

    kind: str
    target: str = ""


DISCARD_MODE = Mode("discard")
RETURN_MODE = Mode("return")
