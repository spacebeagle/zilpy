# SUSPENDED ゲームプレイ解説（LLM 攻略用リファレンス）

Infocom の **Suspended**（開始画面の表示は `Release 88 / Serial number 840726`）を、次に遊ぶ LLM がこの資料とゲーム出力だけでクリアできるようにまとめた攻略メモ。

- **どこまで確かめたか**:
  - 第 6 章の推奨ルートを **乱数の種を変えて 5 回（種 1〜5）実行し、5 回ともクリア**。全回 **129 サイクル、地表の犠牲者 29,000 人、評価 1（最良）**。乱数で変わるのはリセットコードの文字列だけで、手順は同じまま通った。
  - 予備ルート（人間に酸漏れを直させる、4.10 節）は、**酸漏れが直るところまで確認**した。そのあとクリアまでは通していない。
- **根拠の印**: 【確認済み】＝実行で出力を見た。【推測】＝推し量った部分。章や節の見出しにまとめて付けた所は、その中の全項目に当てはまる。

> 注意: 解き方がすべて書かれています。自分で解きたい人は読まないでください。
> ゲームの文章は「出力から探すための短い目印」だけを原文で引用し、全体の解説は日本語でまとめています。

---

## 0. 最初に読むこと（注意・操作の基本）【確認済み】

### 0.1 進行上の注意

- 75 サイクル目以降に食料が 50 トン未満だと、その回の犠牲者の計算が 1 に上書きされることがあるが、攻略への影響は無い。

### 0.2 このゲームの操作の基本

`out/suspended` ディレクトリで `python suspended.py` を実行してプレイする。
あなた（プレイヤー）は地下施設のカプセルに入った人間で、6 台のロボットを遠隔操作して施設を修理する。**自分では動けない。すべての行動はロボットへの命令で行う。**

| やりたいこと | 通った書き方 | 備考 |
|---|---|---|
| ロボットに命令する | `waldo, take grasper` | `ロボット名, 命令`。これで **そのロボットとの「Cryolink」が切り替わり**、以後は名前なしの命令（`wear grasper` など）がそのロボットに行く |
| 遠くへ自動で移動させる | `sensa, go to hallway junction` | 1 サイクルに 1 部屋ずつ進む。着くと `…I am at the Hallway Junction.` のような到着報告が出る |
| 1 部屋だけ動く | `north` / `east` など | すぐ移る |
| 2 台で同時に作業 | `both sensa and auda, move fred` | **`both` を先頭に置く**。`sensa and auda, move fred together` だと 1 台ずつ別々に試して失敗する |
| 待つ | `wait` | **3 サイクル進む。途中で割り込みの文が出るとそこで止まる**（1〜3 サイクル） |
| 全ロボットの居場所 | `arl` | 1 サイクル |
| 全ロボットの詳細報告 | `arr` | **7 サイクルも使う**ので避ける |
| 犠牲者数と経過サイクル | `score` | 時間は進まない |
| 保存・復元 | `save` / `restore` | 時間は進まない |

- **1 回の命令 = 1 サイクル**。どのロボットへの命令でも、そのサイクルの間に `go to` で移動中の全ロボットが 1 部屋ずつ進む。長い移動は `go to` で出しておき、その間に別のロボットを操作すると速い。
- 通らなかった書き方 → 通った書き方:

| 通らなかった | 通った | 理由 |
|---|---|---|
| `sensa and auda, move fred together` | `both sensa and auda, move fred` | `both`/`together` はコンマより前でないと二台同時の扱いにならない |
| `auda, climb on wedge` | （Sensa など他のロボットで行う） | Auda には楔が知覚できない（0.3） |
| `red cable`（悪い赤ケーブルのつもり） | `four-inch cable` | 色の形容詞が付いていない物がある。長さで呼ぶ（4.8） |

### 0.3 ロボットごとの知覚の違い（重要）

ロボットはそれぞれ感覚が違い、**同じ物でも呼び名と説明が変わる**。さらに、そのロボットの説明が空の物は **知覚できず、命令しても「…cannot detect any X here」になる**。【Auda と楔は確認済み】

| ロボット | 知覚できない主な物 |
|---|---|
| Iris（修理前） | ほぼ何も見えない。`look` しても `Visual function nonfunctional.` など |
| Auda | 楔、カメラ、新品 IC、ソケット、ボタン、ヒューズ、円盤（コード入力の円）、標識、ダイヤル、レバー、スイッチ、上の棚、ワイヤーカッター、キャビネット、フロースイッチ |
| Iris（修理後） | キャビネット、グルーヴ、黄・緑・白・青・黒ケーブル、乗り物、ダイヤル、レバー、スイッチ |
| Sensa・Poet 以外 | フロースイッチ（Sensa が調べた後でも、回せるのは Sensa だけ） |

- 呼び名は違っても、**同義語・形容詞は全ロボット共通**。推奨ルートでは、どのロボットにも通る名前（`camera`、`twelve-inch cable` など）を使っている。

### 0.4 その他の教訓

- **移動中のロボットに物を置かせると、移動途中の部屋に置いてしまう**。到着報告を見てから次の作業を命令する。
- `go to` の自動経路は路線表の決め打ちで、**人間側の区域では大回りになる**（Sloping Corridor から Small Supply Room へ `go to` すると、Sterilization Chamber 経由の 8 部屋になった）。人間側の短い移動は方角で 1 歩ずつ命令する。
- `hint`（`help`）を使うと、FC が Whiz を勝手に Advisory Peripheral へ向かわせる。Whiz に別の仕事をさせている間は使わない。

---

## 1. ゲームの目的と全体の流れ

### 1.1 勝利条件【確認済み】

**Main Supply Room の機械で、FC（Filtering Computer）のリセットコード 2 つ（3 文字ずつ）を押すとクリア。** 押してよいのは、次の 2 本の差し替えが済んだ後だけ。

1. **Primary Channel** の溝の、壊れた赤い 4 インチケーブル（`four-inch cable`）を、Gamma Repair の壊れたロボット「Fred」から切り取った **12 インチの赤い配線**（`twelve-inch cable`）に替える。
2. **Secondary Channel** の溝の、壊れたオレンジの 9 インチケーブル（`nine-inch cable`）を、Main Supply Room の機械の中の **14 インチのオレンジ配線**（`fourteen-inch cable`）に替える。

2 本とも替えると `FC INTERRUPT: Approaching balance between all three units.` と出る（これが「コードを押してよい」合図）。

- **コードは乱数**。Biological Laboratory のカメラを初めて手に取った瞬間に決まる。それまでは押しても正解が無い。
- コードは Primary/Secondary Channel の標識に出ている。**修理済みの Iris が、カメラ越しに標識を見る**ことで読める（`point camera at sign` → `IRIS INTERRUPT: … It says BLEMUM.`）。`BLEMUM` なら `BLE` と `MUM` の 2 つ。
- 円盤は 8 つ: `FOO` `MUM` `BLE` `BAR` `KLA` `CON` `BOZ` `TRA`。`push ble circle` → `push mum circle` のように押す。順番は問わない。

### 1.2 依存関係

```
クリア（Main Supply Room で 2 つのコードを押す）
├─ 赤い配線を Primary Channel に入れる
│   ├─ 赤い配線: Gamma Repair の Fred（キャビネットの中）
│   │   ├─ Sensa がフロースイッチを回してキャビネットを開ける（Sensa か Poet が先にキャビネットを調べる）
│   │   ├─ 2 台同時に Fred を動かす → 配線が見える
│   │   └─ ワイヤーカッターで切る ← Small Supply Room の上の棚（楔に乗って取る）
│   │       └─ 楔: Sub Supply Room → Hallway Junction の段差に置かないと人間側へ渡れない
│   └─ 酸の霧の向こう（Cavernous Room の先）へ運ぶ … 2.3 節・4.7 節・4.10 節
├─ オレンジ配線を Secondary Channel に入れる
│   └─ 機械のボタンを押して前面パネルを開ける
│       ├─ 赤ソケットに赤 IC、黄ソケットに黄 IC（Middle Supply Room のかご）
│       └─ ヒューズを抜いてから配線を取り、ヒューズを戻す
└─ コードを知る
    ├─ Iris を修理する（Waldo が手術用の手を付けて青 IC を入れる）
    └─ カメラ（Biological Laboratory、車で行く）を Channel の穴に挿して標識に向ける
```

### 1.3 進行の順番（推奨ルートの概要）

サイクル数は種 1 の実行で見た値（どの種でも同じだった）。

| # | 担当 | やること | サイクル |
|---|---|---|---|
| 1 | 全員 | 最初の 4 手で Whiz・Poet・Waldo・Sensa を出発させる | 1〜4 |
| 2 | Poet | **15 サイクル目より前に** East End（酸の霧の向こう側）へ入って待機 | 8 頃に到着 |
| 3 | Sensa | 楔を Hallway Junction の段差に置き、持って人間側へ渡る | 5〜15 |
| 4 | Whiz | 天候ダイヤル・交通スイッチ・水耕レバーを設定（評価を上げるため。クリアには不要） | 16〜31 |
| 5 | Sensa | 上の棚からカッターを取り、楔を段差に戻して Gamma Repair へ | 32〜46 |
| 6 | Waldo | Iris 修理 → ソケットに IC → ボタン → ヒューズとオレンジ配線 → Short Corridor へ | 47〜68 |
| 7 | Sensa＋Auda | Gamma Repair で Fred から赤い配線を取る | 69〜75 |
| 8 | Sensa | 車で Biological Laboratory へ行きカメラを取る（ここでコードが決まる）→ Short Corridor へ | 76〜108 |
| 9 | Sensa | Waldo からオレンジ配線を受け取り、霧を突っ切って East End に全部置く（**Sensa はここで壊れる**） | 109〜112 |
| 10 | Poet | 2 本の配線を差し替え、カメラで標識を読む | 113〜126 |
| 11 | Iris | Main Supply Room でコードを押す | 127〜129 |

### 1.4 得点（犠牲者数）と評価【確認済み（数値は推奨ルートの実績）】

このゲームの「点数」は **地表の犠牲者数（千人単位）**。少ないほど良い。`score` で見られる（時間は進まない）。

- 毎サイクル、天候・交通・食料の状態に応じて犠牲者が増える。
  - 風が 25 を超えると増える。50 を超えると大きく増える。
  - 気温が 40 未満だと増える。
  - 75 サイクル目以降: 交通スイッチが入ったままだと 1 つにつき 1 ずつ増える。食料が 50 トン未満だと増える。
  - 浮遊車（first switch）を切った瞬間、その時点で空中にいた分（およそ 2×経過サイクル）が一度に加算される。早く切るほど安い。
- クリア時に「回復までの予測犠牲者」が加算され、合計で評価が決まる（通常ゲームは 1〜7、1 が最良）。

| 合計の犠牲者（千人） | 評価 |
|---|---|
| 40 以下 | 1（田舎の家と無制限の銀行口座） |
| 41〜100 | 2 |
| 101〜300 | 3 |
| 301〜500 | 4 |
| 501〜600 | 5 |
| 601〜700 | 6 |
| 701 以上 | 7 |

- 実績: 天候を何もしないと 75 サイクル目で約 1,000 に達した。Whiz で 10 サイクル台にダイヤルを直した推奨ルートでは、最終 29（評価 1）。直すのが 30 サイクル目台だと 214（評価 3）。何もしないで 114 サイクルでクリアすると 1,184＋予測 289（評価 7）。
- 犠牲者が 30,000 を超えると全滅でゲーム終了（通常の進め方では起きない）。

---

## 2. 詰み条件・ゲーム終了の一覧（絶対に避ける）

### 2.1 即ゲーム終了【「人間の到着」は確認済み】

| やってはいけないこと／起きてはいけないこと | 結果 |
|---|---|
| Central Chamber の柱（`column`/`home`/`cpu`/`door`）を開ける、`kill me` など | カプセルが開いて **プレイヤーが死ぬ** |
| 人間が Central Chamber に着く（何もしないと **161 サイクル目**）【確認済み】 | プレイヤーが交換されてゲーム終了 |
| 食料が 0 トン以下になる（レバーをでたらめに動かした場合） | 全システム停止でゲーム終了 |
| 全ロボットが壊れる | ゲーム終了 |
| 犠牲者が 30,000（千人）を超える | ゲーム終了 |

人間（2 人組）の動き【確認済み、何もしない場合】: **100 サイクル目に Sterilization Chamber に現れる**（`FC INTERRUPT: ALERT! ALERT!` / `Intruders detected in Sterilization Chamber!`）→ Small Supply Room で工具袋を取る → 108 頃 Sleep Chamber で眠る（約 20 サイクル）→ 129 頃起きて Library Core へ → 車で Cryogenic Area へ行き交換用のクローンを連れて戻る → **161 サイクル目に Central Chamber に着いてゲーム終了**。
**推奨ルートは 129 サイクル目にクリアするので間に合う。遅れたら 4.10 節の時間稼ぎを使う。**

### 2.2 ロボットが壊れる【酸は確認済み】

| やってはいけないこと | 結果 |
|---|---|
| **15 サイクル目以降に Cavernous Room で命令を受ける／`go to` で Short Corridor から Cavernous Room に入る** | そのロボットは酸に冒され、**約 5 サイクル後に壊れる**（2.3） |
| 溝の **生きているケーブル**（黄・緑・桃・白・青・黒）を取る・替える | `Sizzzzzzzzzle...` で壊れる |
| 機械の **ヒューズが入ったまま** オレンジ配線を取る | 感電して壊れる |
| 人間を攻撃する（`kill humans` など） | そのロボットが止められる |

### 2.3 酸の霧の仕組み（このゲームの最大の関門）【確認済み】

- **15 サイクル目**に `SENSA INTERRUPT: Secondary tremor detected in lower level.` が出る。ここから **Cavernous Room（Short Corridor の東）に酸の霧** が出る。FC 区域（East End・Beta FC・Primary/Secondary Channel など）へは、この部屋を通るしかない。
- 霧に冒される条件:
  - Cavernous Room にいるロボットに **何か命令する**（その命令が `east` でも `drop` でも同じ）。
  - `go to` の自動移動で **Short Corridor → Cavernous Room** に入る。
  - 逆向き（East End → Cavernous Room → Short Corridor）の **自動移動** は冒されない。ただし途中で Cavernous Room にいる間にそのロボットへ命令すると冒される。
- 冒されたロボットには `…not working reliably.` → `Warning: …` → `SYSTEM FAILURE …` と出て壊れる。実測では、`east` で East End に入った命令の後、**5 回目の命令の処理が終わった直後に壊れた**（どのロボットへの命令でも 1 回と数える）。
- **15 サイクル目より前に霧を通り抜けたロボットは安全**。East End から先にいる限り、ずっと無事に働ける。推奨ルートではこれを Poet にやらせる。
- 霧は人間が Maintenance Access の弁を回すと止まり、二度と出ない（4.10 節）。

### 2.4 取り返しのつかない操作

| 操作 | 結果 | 回復方法 |
|---|---|---|
| 間違ったコードの組を押す | `New reset code being generated` で **コードが作り直される** | カメラを持ったロボットが Channel でもう一度 `plug camera in hole` → `point camera at sign` |
| 配線を替える前にコードを押す | `Code entry premature` で押した記録が消える（コードは同じ） | 配線を替えてから押し直す |
| 楔を段差から持ち去る | 人間側との行き来ができなくなる（ロボットだけ。人間は通れる） | 楔を段差に置き直す |
| 15 サイクル目までに Poet が霧を抜けられなかった | 推奨ルートが使えない | 4.10 節の予備ルートへ切り替える |

---

## 3. 基本システム・共通の仕掛け

### 3.1 ロボット一覧【開始位置は確認済み】

| ロボット | 開始位置 | 手の数 | 運べる重さ | 特技・役目 |
|---|---|---|---|---|
| **Iris** | Weather Monitors | 2 | 75 | 目。**最初は壊れていて何も見えない**。修理後はモニター（天候・交通・水耕）を読めて、カメラの映像を受ける。**Central Chamber と 3 つのモニター室・3 つの補給室から出られない** |
| **Waldo** | Gamma Repair | 6（手術用の手を付けると 7） | 100 | 手。手術用の手（`grasper`）を付けると Iris のパネルを開けられる |
| **Sensa** | Central Chamber | 3 | 60 | 感覚。**フロースイッチを回せる唯一のロボット** |
| **Auda** | Entry Area（人間側） | 1 | 70 | 耳。人間の会話が聞こえる。知覚できない物が多い（0.3） |
| **Poet** | Central Chamber | 3 | 20 | 診断。触ると異常が分かる。運べるのは大きさ 5 の物 3 個まで（自分の重さ 5 を含めて 20） |
| **Whiz** | Advisory Peripheral | 2 | 50 | CLC（中央図書館）への接続役。台座で `plug in` すると質問できる |

- 物の大きさは指定が無ければ 5。運べる重さには **ロボット自身の 5 も含まれる**。
- `replace X with Y` は **手が 1 本空いていないと「extensions are full」で断られる**。

### 3.2 地図【推奨ルートで通った所は確認済み】

**監視・補給区域**（Iris はここから出られない）
```
[Main Supply Room]--e--[Weather Monitors]--e--[Central Chamber]--e--[Hydroponics Monitors]
        | s                   | s                  | s       \ ne
[Middle Supply Room]--e--[Sub Supply Room]  [Transit Monitors]  [Angling Corridor]
```
- Main Supply Room: リセット用の機械（ボタン、赤・黄ソケット、前面パネルの 8 つの円盤、ヒューズ、オレンジ配線）。
- Middle Supply Room: かご（新品 IC 5 個）、手術用の手（`grasper`）、16 インチの青ケーブル（不要）。
- Sub Supply Room: **楔（wedge）**、壊れた棚（動かすと潰れた箱、中身は使えない予備ケーブル）。

**中央の通路**
```
[Angling Corridor]--ne--[Bending Corridor]--e--[Hallway Junction]--e--[Southeast Junction]--e--[Short Corridor]--e--[Cavernous Room]--e--[East End]
 (sw: Central Chamber)                          | n（段差・楔が必要）    | se                     | ne                  （酸の霧）
                                                | s                     [Southeast Passage]      [Rising Passage]
                                    [Outer Library Area]                | se                     | ne
                                                | s                     [Bending Passage]        [Top Passage]
                                    [Index Peripheral]                  | s                      | n
                                                                        [Alpha Repair]           [Skywalk Alpha]
                                                                        | s
                                                                        [Beta Repair]
                                                                        | s
                                                                        [Gamma Repair]（Waldo の開始位置、キャビネット＝Fred）
```
- Hallway Junction の北は段差で、**楔を `put wedge against step` で置かないとロボットは渡れない**（人間は渡れる）。置いた後は段差の両側（Hallway Junction と Sloping Corridor）を行き来できる。
- Alpha/Beta/Gamma Repair の動く歩道は修理用ベルト（4.11）。

**図書館（CLC）**: Outer Library Area の南に Index Peripheral。Index（北）・Technical（東）・Advisory（南、Whiz の開始位置）・Historical（西）の 4 つの台座が Central Core を囲む。Index から SE が Technical、SW が Historical。Technical から SW が Advisory、Historical から SE が Advisory。

**スカイウォーク（地表の制御室）**
```
[Transit Control Area]   [Hydroponics Control Area]   [Weather Control Area]
          | n                       | n                         | n
   [Skywalk Gamma]--e--------[Skywalk Beta]--e--------[Skywalk Alpha]--s--[Top Passage]--sw--[Rising Passage]--sw--[Short Corridor]
```
- スカイウォークで物を落とすと、北の制御室へ吸い上げられる。

**FC 区域**（Cavernous Room の東。15 サイクル目以降は霧の向こう）
```
                [Alpha FC]
                    | s
             [Primary Channel]（溝に赤 4 インチ・黄・緑・桃。標識と穴）
                    | s
[East End]--e--[Beta FC]
    | se            | s
    |        [Secondary Channel]（溝に白・青・黒・橙 9 インチ。標識と穴）
    |               | s
    +----------[Gamma FC]
```
- East End から ne で Alpha FC、se で Gamma FC へも行ける。

**人間側の区域**（Hallway Junction の北の段差の先）
```
[Sterilization]--e--[Decontamination]--e--[Entry Area]--e--[Small Supply Room]--e--[Activities Area]--e--[Sleep Chamber]
      | s                                                                                  | s                      | s
[Hallway T]--e--[Hallway]--e--[Hallway]--e--[Access Hallway]--------------e-------------[Hallway]------e------[Hallway Corner]
      | w                                          | s                                                                | s
  [Dead End]                               [Sloping Corridor]                                                  [Hallway Branch]--e--[Maintenance Access]
                                                   | s（段差。楔が必要）                                               | s
                                           [Hallway Junction]                                                  [Library Entrance]--w--[Library Core]
                                                                                                                       | s
                                                                                                                [Hallway End]（車）
```
- Sterilization Chamber の西は立入禁止（地表への出口）。
- Entry Area: Auda の開始位置。Small Supply Room: 上の棚（ワイヤーカッター）と、人間用の戸棚（工具袋。ロボットは開けられない）。Maintenance Access: 高い所に酸の冷却系の弁（ロボットには届かない）。
- Hallway End で `board car` すると、車ごと **Vehicle Debarkation Area** に移る（1 台しか乗れない）。そこから北が Biology Corridor、その西が **Biological Laboratory（カメラ）**、北が Cryogenic Area（クローン）。帰りも `board car`。

### 3.3 時間の目印

| サイクル | 出来事 | 目印の文 |
|---|---|---|
| 15 | 酸の霧が出る | `Secondary tremor detected in lower level.` |
| 50・80・120 頃 | 修理前の Iris が催促する（修理後は出ない） | `IRIS INTERRUPT: You may not be aware of this…` |
| 75 | 交通・水耕の自動制御が壊れる（レバーの効き方が変わる。3.4） | `Secondary tremor detected by Filtering Computers.` |
| 100 | 人間が現れる | `Intruders detected in Sterilization Chamber!` |
| 161 | 何もしないと人間が Central Chamber に着いてゲーム終了 | — |

### 3.4 地表の制御（評価を上げるため。クリアには不要）【推奨値は確認済み】

担当は **Whiz**（ダイヤル・レバー・スイッチを知覚できる。Auda と Iris は不可）。

- **Weather Control Area**（Skywalk Alpha の北）: 3 つのダイヤル。塔の気圧はダイヤルの値へ 5 サイクルごとに少しずつ近づくが、第 2 塔は毎回「減衰」分だけ下がり、減衰は 25 サイクルごとに 1 ずつ増える。**`set second dial to 100`、`set first dial to 60`、`set third dial to 60`** で、ゲームの終わりまで風が弱いままになった。
- **Transit Control Area**（Skywalk Gamma の北）: 3 つのスイッチ。**`turn off first switch`、`turn off second switch`、`turn off third switch`**。75 サイクル目以降に入ったままだと毎サイクル犠牲者が増える。first（浮遊車）は切った瞬間に空中の分が加算されるので、なるべく早く切る。
- **Hydroponics Control Area**（Skywalk Beta の北）: 3 つのレバー（水・ミネラル・照明）。75 サイクル目以降は実際の値が設定より 20・15・20 低くなるので、**`set first lever to 90`、`set second lever to 45`、`set third lever to 70`** にすると 75 サイクル目以降が最適（70・30・50）になる。75 サイクル目より前に設定しても害は無い（75 より前の食料不足は犠牲者に数えられない）。
- 修理後の Iris を Weather/Transit/Hydroponics Monitors で `look` させると、数値が読める。

### 3.5 CLC への質問（必要なら）

Whiz を台座のある部屋に置いて `whiz, plug in`（または `plug in pedestal`）→ `ask about <物>`。Index で「どの台座にデータがあるか」、Technical/Advisory/Historical で中身が出る。推奨ルートでは使わない。

---

## 4. 章別攻略（4.1〜4.9 が推奨ルート【確認済み】。4.10・4.11 は見出しの印に従う）

コマンドは第 6 章にまとめてある。ここでは場面ごとの意味と目印を書く。見出しのかっこ内は種 1 の実行で見たサイクル。

### 4.1 出発（1〜4 サイクル）

1. `whiz, go to weather control area`
2. `poet, go to east end` ← **最優先**。Poet は 8 サイクル目頃に East End に着く（`POET INTERRUPT: As much as I can be anyplace, I'm here at the East End.`）。**この文が `Secondary tremor detected in lower level.` より先に出ることを確かめる。** 出なかったら推奨ルートは使えない（4.10 節へ）。
3. `waldo, go to middle supply room`
4. `sensa, go to sub supply room`

Poet はこの後クリア直前まで East End で待つ。**Poet には East End から西へ戻る命令を出さない。**

### 4.2 Sensa: 楔とワイヤーカッター（5〜15、32〜46）

1. `I am at the Sub Supply Room.` が出るまで `wait` → `sensa, take wedge` → `go to hallway junction`。
2. `I am at the Hallway Junction.` が出るまで `wait` → `put wedge against step`（`…has been positioned at the step.`）。
3. `north`（Sloping Corridor）→ `take wedge`（楔を持って人間側へ）。
   - ここで一度 Whiz の作業（4.3）を挟むと効率が良い。
4. `sensa, north`（Access Hallway）→ `east` → `north`（Activities Area）→ `west`（Small Supply Room）。**`go to small supply room` は大回りになるので使わない。**
5. `drop wedge` → `climb on wedge` → `take cutters` → `take wedge`（自動で楔から降りる）。
6. `east` → `south` → `west` → `south`（Sloping Corridor）→ `put wedge against step` → `south`（Hallway Junction）。
   - **楔は段差に置いたままにする。** 以後、ロボットは段差を自由に渡れる。
7. `go to gamma repair`。続けて `auda, go to gamma repair`（Auda も楔のおかげで渡れる。**楔を置く前に Auda を出発させると `impossible to get from Hallway Junction to Sloping Corridor` で止まる**）。

### 4.3 Whiz: 地表の制御（16〜31）

Whiz が `CLC indicates matched arrival coordinates at the Weather Control Area.` を出したら（実行例では 10 サイクル目頃に着き、Sensa が楔を持った 15 サイクル目の後で始めた）:

1. `whiz, set second dial to 100` → `set first dial to 60` → `set third dial to 60`
2. `south` → `west` → `west` → `north`（Transit Control Area）→ `turn off first switch` → `turn off second switch` → `turn off third switch`
3. `south` → `east` → `north`（Hydroponics Control Area）→ `set first lever to 90` → `set second lever to 45` → `set third lever to 70`

Whiz の仕事はこれで終わり。以後は放っておいてよい。

### 4.4 Waldo: Iris の修理と機械の準備（47〜68）

Waldo は Middle Supply Room に着いている（`WALDO INTERRUPT: Internal mapping indicates arrival at the Middle Supply Room.`）。

1. `waldo, take grasper` → `wear grasper`（手術用の手。これが無いと Iris のパネルは「too delicate」で開かない）。
2. `take blue ic` → `take red ic` → `take yellow ic`（かごの中から。かごごと持たなくてよい）。
3. `go to weather monitors` → 到着（`…arrival at the Weather Monitors.`）まで `wait`。
4. `open panel` → `take blue chip`（焼けた青チップ。先に抜かないとパネルに入りきらない）→ `put blue ic in panel`（`OOOH! That felt good! Close my panel…`）→ `close panel`（`IRIS INTERRUPT: You never looked so good.`）。**これで Iris が直る。**
5. `west`（Main Supply Room）→ `take burned chip` → `take fried chip`（ソケットの焼けたチップ）→ `put red ic in red socket` → `put yellow ic in yellow socket`。
6. `push button` → 前面パネルが開き、円盤 8 つ・14 インチのケーブル・ヒューズが現れる。
   - 赤 IC と黄 IC が正しいソケットに入り、ヒューズが機械に入っていないとボタンは「Nothing happens.」。
7. **`take fuse` → `take orange wire` → `put fuse in machine`**。順番厳守（2.2）。ヒューズを戻さないとコードの円盤が反応しない。
8. `go to short corridor`（オレンジ配線を持ったまま、Sensa との受け渡し場所で待つ）。

### 4.5 Sensa＋Auda: Fred から赤い配線（69〜75）

Sensa と Auda が Gamma Repair にそろったら（`I am at the Gamma Repair.` と Auda の `…I've arrived at the Gamma Repair.`）:

1. `sensa, examine cabinet`（フロースイッチが見えるようになる）→ `turn flowswitch`（`The flow of electrons aligns and the panel opens.`）。
2. **`both sensa and auda, move fred`**（`FC: Dual-Cryolink established…` → `FC: The robots have moved it.`）。1 台では動かせない。
3. `sensa, cut wire with cutters` → `take wire`（12 インチの赤い配線）→ `drop cutters`（もう不要。手を空ける）。

Auda の仕事はこれで終わり。

### 4.6 Sensa: 車でカメラを取る（76〜108）

1. `go to hallway end` → `I am at the Hallway End.` が出るまで `wait`（Gamma Repair から 13 部屋。実行例では 76 サイクル目に出発して 89 サイクル目頃に着いた）。
2. `board car`（Vehicle Debarkation Area に着く）→ `get out of car` → `north` → `west`（Biological Laboratory）→ **`take camera`**（ここでリセットコードが決まる）。
3. `east` → `south` → `board car`（Hallway End に戻る）→ `get out of car`。
   - 車を Hallway End 側に戻しておくのは推奨ルートの手順どおり。戻さないと人間は車を待って足止めされる（4.10 節）。
4. `go to short corridor` → `I am at the Short Corridor.` が出るまで `wait`。途中で人間が現れる（100 サイクル目）が気にしなくてよい。

### 4.7 受け渡しと霧の突破（109〜112）【Sensa はここで壊れる】

1. `waldo, give orange wire to sensa`（Sensa の手: 赤い配線・カメラ・オレンジ配線の 3 本で満杯）。
2. `sensa, east`（Cavernous Room）→ `east`（East End。**この命令で Sensa が冒される**）→ `drop all`（3 つとも East End の床に置く）。
3. 以後、Sensa には命令しない。数サイクル後に `SENSA INTERRUPT: SYSTEM FAILURE…` → `FC: So much for that robot. Too bad.` で壊れる。予定どおり。

### 4.8 Poet: 配線の差し替えとコードの読み取り（113〜126）

Poet は East End にいる。手は 3 本だが、`replace` には 1 本空きが要るので 2 つずつ運ぶ。

1. `poet, take twelve-inch cable` → `take camera`
2. `east`（Beta FC）→ `north`（Primary Channel）
3. **`replace four-inch cable with twelve-inch cable`**（`Okay. It's done.`）
4. `plug camera in hole`（`IRIS INTERRUPT: Receiving transmissions.`）→ **`point camera at sign`** → `IRIS INTERRUPT: … It says XXXYYY.` **この 6 文字を控える**（例 `BLEMUM` → `BLE` と `MUM`）。
5. `drop four-inch cable` → `south`（Beta FC。カメラは自動で抜ける）→ `west`（East End）→ `take fourteen-inch cable`
6. `east` → `south`（Secondary Channel）→ **`replace nine-inch cable with fourteen-inch cable`** → `FC INTERRUPT: Approaching balance between all three units. … Reset codes may be entered now…`

注意:
- 溝のほかのケーブル（黄・緑・桃・白・青・黒）には絶対に触らない（2.2）。`replace` の対象は **four-inch** と **nine-inch** だけ。
- Poet はカメラを持ったまま。コードを間違えて作り直しになったら、Secondary Channel でも `plug camera in hole` → `point camera at sign` で読み直せる（Primary/Secondary の両方に標識と穴がある）。

### 4.9 Iris: コードを押してクリア（127〜129）

1. `iris, go to main supply room` → `I've reached my destination, the Main Supply Room.` が出るまで `wait`（1 部屋）。
2. **`save`**（念のため。押し間違えるとコードが作り直される）。
3. `push xxx circle` → `FC: First access code accepted. Enter second access code now.`
4. `push yyy circle` → `FC: Second access code accepted.` → 終了画面（`You successfully completed your task…`）。

### 4.10 予備ルート: 人間に酸漏れを直させる【酸漏れが直るまで確認済み】

Poet が 15 サイクル目までに霧を抜けられなかった場合や、ロボットを壊したくない場合の方法。ゲームが本来想定している解き方。

1. 楔を段差に置いておく（4.2 の 1〜2）。人間側の Auda が人間の後を追えるようにするため。
2. 100 サイクル目に人間が現れたら、Auda を Sleep Chamber に入れて待つ（`auda, east` を 3 回: Entry Area → Small Supply Room → Activities Area → Sleep Chamber）。`auda, listen` で Auda の耳を開いておくと、Auda を操作していない時も会話が表示される。
3. 人間が来て寝ると `AUDA: I hear the sound of metal being placed on the floor.`（工具袋を床に置いた）。`take bag`。
   - `"That robot's a thief! Let's get it!"` で人間が追いかけてくる。
4. Auda を **Short Corridor へ逃がす**: `west` → `south` → `west` → `south` → `south`（段差を渡って Hallway Junction）→ `east` → `east`。
5. Short Corridor で `wait`。追いついた人間が床から霧が上がっているのに気づき（`The mist is coming up through the grating!`）、工具袋を取り返して Maintenance Access の弁を回しに行く。実測ではこの後 30 サイクル以内に **霧が止まり、以後は二度と出ない**。その後、人間は Activities Area でゲーム（Starcross）を始め、**約 200 サイクルはそこにいる**。
6. あとはロボットが霧を気にせず FC 区域に出入りできる。4.4〜4.9 と同じ作業を、壊れる心配なしで行う。

時間稼ぎの手段:
- 寝ている人間から盗んだ工具袋を `give bag to humans` で返すと、もう一度眠る（約 20 サイクル）。2 回目に返すと怒ってすぐ行動を再開する。
- 車が Hallway End に無い（または誰かが乗っている）と、人間は車を待つ。ただし 75 サイクル待つと、クローン無しで Central Chamber へ向かい、着いた時点でゲーム終了。
- 人間を襲ってはいけない（2.2）。

### 4.11 壊れたロボットの修理

壊れた（SYSTEM FAILURE の後の）ロボットは、Alpha Repair の修理ベルトで直せる。

1. 楔を Alpha Repair の段差に置く（`put wedge against step`。**Hallway Junction の段差から楔を外すことになる**ので、人間側との行き来ができなくなる点に注意）。
2. 動けるロボットに壊れたロボットを引きずらせる: `waldo, drag sensa to alpha repair`。
3. Alpha Repair で `push sensa onto walkway`（`Umph! Hard work…`）。ベルトで Gamma Repair まで運ばれ、`It's great to be back!` で復活する。
- 酸に冒されただけでまだ壊れていないロボットは押し上げられない（壊れるまで待つ）。
- 推奨ルートでは使わない。

---

## 5. 乱数・タイマーまわりの注意

### 5.1 乱数

| 乱数 | 影響 | 対処 |
|---|---|---|
| **リセットコード**（8 つの円盤から異なる 2 つ） | カメラを初めて取った時に決まる。種 1〜5 では `BLEMUM` `FOOMUM` `BARBLE` `BARKLA` `KLACON` | 必ず Iris に標識を読ませる。間違えると作り直し（2.4） |
| ロボットの台詞（到着報告・冗談） | 文言の揺れだけ | 無視 |
| 7 個より多く持つと、取る時に落とすことがある | 手の数が最大 7 なので実際には起きない | — |

`save` / `restore` はいつでも使え、乱数の状態も一緒に保存される。

### 5.2 save の置き場所

| 場面 | 理由 |
|---|---|
| 4.1 の後（4 サイクル目） | Poet の霧越えが間に合ったかを確かめる前 |
| 4.7 の直前（Short Corridor で受け渡す前） | Sensa が霧に入ると後戻りできない |
| 4.9 でコードを押す直前 | 押し間違えるとコードが作り直される |

### 5.3 タイマーの総表【15・75・100・161 は確認済み】

| 起点 | サイクル | 何が起きるか |
|---|---|---|
| 開始 | 15 | 酸の霧 |
| 開始 | 75 | 交通・水耕の自動制御が壊れる（レバー −20/−15/−20） |
| 開始 | 100 | 人間が現れる |
| 開始から 5 ごと | — | 天候の気圧が更新される |
| 開始から 25 ごと | — | 第 2 塔の減衰が 1 増える |
| 霧に冒された時 | 約 5 命令後 | ロボットが壊れる |
| 人間が寝た時 | 約 21 | 起きて Library Core へ |
| 人間が Library Core に着いた時 | 3 | Hallway End へ向かう |
| 人間が車で Cryogenic Area へ行った時 | 15 | クローンを連れて戻り、Central Chamber へ |
| 人間が車を待ち始めた時 | 75 | クローン無しで Central Chamber へ |
| 人間が Starcross を始めた時 | 200 | 再び Library Core へ |

---

## 6. 確認済みコマンド列（推奨ルート、5 回とも 129 サイクルでクリア・評価 1）

「…まで `wait`」は、その文が出力に現れるまで `wait` を繰り返す（すでに出ていれば不要）。`XXX` `YYY` は Iris が読んだコード。

```
whiz, go to weather control area
poet, go to east end
waldo, go to middle supply room
sensa, go to sub supply room
  …「I am at the Sub Supply Room」まで wait
sensa, take wedge
go to hallway junction
  …「I am at the Hallway Junction」まで wait
put wedge against step
north
take wedge
  …「CLC indicates matched arrival coordinates at the Weather Control Area」まで wait（実行例では既に出ていた）
whiz, set second dial to 100
set first dial to 60
set third dial to 60
south
west
west
north
turn off first switch
turn off second switch
turn off third switch
south
east
north
set first lever to 90
set second lever to 45
set third lever to 70
sensa, north
east
north
west
drop wedge
climb on wedge
take cutters
take wedge
east
south
west
south
put wedge against step
south
go to gamma repair
auda, go to gamma repair
waldo, take grasper
wear grasper
take blue ic
take red ic
take yellow ic
go to weather monitors
  …「arrival at the Weather Monitors」まで wait
open panel
take blue chip
put blue ic in panel
close panel
west
take burned chip
take fried chip
put red ic in red socket
put yellow ic in yellow socket
push button
take fuse
take orange wire
put fuse in machine
go to short corridor
sensa, examine cabinet
turn flowswitch
both sensa and auda, move fred
sensa, cut wire with cutters
take wire
drop cutters
go to hallway end
  …「I am at the Hallway End」まで wait
board car
get out of car
north
west
take camera
east
south
board car
get out of car
go to short corridor
  …「I am at the Short Corridor」まで wait
waldo, give orange wire to sensa
sensa, east
east
drop all
poet, take twelve-inch cable
take camera
east
north
replace four-inch cable with twelve-inch cable
plug camera in hole
point camera at sign
  → 「It says XXXYYY.」を控える
drop four-inch cable
south
west
take fourteen-inch cable
east
south
replace nine-inch cable with fourteen-inch cable
iris, go to main supply room
  …「I've reached my destination, the Main Supply Room」まで wait
push XXX circle
push YYY circle
```

- `sensa, examine cabinet` の時点で Auda がまだ Gamma Repair に着いていなければ、`…I've arrived at the Gamma Repair.` まで `wait` してから `both sensa and auda, move fred`。実行例では、Waldo の作業中に着いていた。
- Waldo の「`go to weather monitors`」は、実行例では Main Supply Room 経由で 2 サイクルかかった。

---

## 7. 補足

- **開始時のオプション**（1 手目だけ）: `advanced`（上級。霧が 3 サイクル目、人間が 80 サイクル目、Whiz が最初から壊れている、評価は 1〜5）、`configure`（ロボットの配置やタイマーを自分で決める）、`impossible`（2 サイクルで恒星が爆発して終わる冗談）。推奨ルートは通常ゲーム前提。
- **攻略に不要な物**: 16 インチの青ケーブル、潰れた箱と予備ケーブル（使えない）、プレート（Iris が読むと開発者のクレジット）、新品 IC のうち緑・格子柄、Cryogenic Area のスイッチ（届かない）、Maintenance Access の弁（ロボットには届かない。人間が回す）。
- **Auda の `listen`**: 耳を開くと、Auda と同じ部屋で人間が話した内容が、他のロボットを操作中でも表示される。人間の動きを知るのに便利。
- **Poet に `touch` させる**と、物や部屋の異常を詩的に教えてくれる（診断）。
- **エンディング**: 2 つ目のコードで `All systems returning to normal.` と、犠牲者数・予測・生存者数・評価、`You successfully completed your task… in N cycles.` が出て終わる。
