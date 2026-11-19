# THE LURKING HORROR ゲームプレイ解説（Claude 攻略用リファレンス）

> **注意（ライセンス・ネタバレ）**
> 本ガイドは *The Lurking Horror*（© 1987 Infocom, Inc.）の実行検証をもとに、MCP 経由でプレイする Claude 向けの攻略リファレンスとして作成したものである。MIT ライセンス対象作品ではないため、ゲームの文章やソースコードの転載は行わず、判断の目印となる短い引用と構造・手順の解説にとどめる。ゲームを自力で解きたい場合は読まないこと。

- **対象:** `out/lurkinghorror`（エントリ `h1`、MCP サーバー名 `lurkinghorror`、`--entry h1`）
- **検証範囲と前提:**
  - `out/lurkinghorror`（Python 版）および `lua/lurkinghorror`（Lua 版）をテストドライバー / MCP 経由で最初からエンディングまで **100 / 100 点（`President of the Institute`）でクリア確認済み**。
- **根拠の表記:** 各節・項目に **【確認済み】**（実行して出力を確認）を記す。

---

## 0. 最初に読むこと（実プレイ上の落とし穴・資源管理）

### 0.1 入力・パーサーの落とし穴 【確認済み】
| 通らない・意図と違う入力 | 通る入力 | 理由 |
|---|---|---|
| `login xyzzy` / `password plugh` | `login 872325412` / `password uhlersoth` | ゲームの正規 ID/PW は `872325412` / `uhlersoth`（内部で `xyzzy`/`plugh` に変換される） |
| `ask hacker for key` / `master key` | 先に `ask hacker about keyring` → 中華料理を渡す → `ask hacker for master key` | `keyring` の話を聞くまで `MASTER_KEY` が `GLOBAL_OBJECTS` にあり認識されない |
| `open manhole with forklift` | `move junk with forklift` × 4 → `east` → `stand` → `open manhole with crowbar` | ガラクタを 4 回押しのけて `Ancient Storage` へ進み、降りてバールで開ける |
| `open valve` / `turn valve` | `open valve with axe`（2 回。2 回目はネズミ出現後）→ `close valve` | 錆びついており武器/工具が必要。開けっ放しだと蒸気に阻まれて西へ進めない |
| `cut curtain with axe` | `open flask` → `pour nitrogen on curtain` → `unlock door with master key` | 液体窒素で凍らせずに斧で切るとスライムに襲われて死亡する |
| `unplug cable` | `take coaxial cable`（または `unplug coaxial cable`） | `box` を開けたあと `coaxial cable` を抜いてソケットを空ける |

### 0.2 資源管理（所持数・懐中電灯・疲労） 【確認済み】
- **所持数上限:** 所持品が多すぎると `You're holding too many things...` で拾えない。不要になった物は捨てる（開始直後の `assignment`、ワックスを撒いた後の `container`、レンガ壁に鉄棒を出した後の `crowbar`、五芒星を切った後の `knife` など）。
- **狭い通路の制限:** `Subbasement` から `nw`（`Tomb`）へ抜ける亀裂は `fire axe` と `metal flask` を持ったまま通れない。亀裂の手前に置いて `Tomb` から南京錠（`padlock`）だけ取って戻り、回収する。
- **懐中電灯（`flashlight`）の電池:** 有限（約 100〜120 ターンで電池切れ）。**明るい部屋に出たら必ず `turn off flashlight` で消す**こと。暗闇で 2 ターン経過すると即死する。
- **疲労タイマー（`I_SLEEP`）:** 時間が経つと `You are feeling tired.` などの警告が出て、放置すると居眠りして襲われ即死する。Kitchen の冷蔵庫から **`coke`** を取っておき、眠気の警告が出たら **`drink coke`** で回復する。

---

## 1. ゲームの目的と全体の流れ

### 1.1 勝利条件 【確認済み】
地下深部の `Inner Lair` に到達し、以下を実行する:
1. `open box` → `take coaxial cable` でソケットを空ける。
2. `reach in pool` → `take line` → `cut line with axe` × 3 → `take line` → `put line in socket`（この時点で `gloves` と `boots` を**両方着用**していること）。
3. 高圧電流で怪物の本体（`FROB`）が実体化する（`END_CNT == 1`、+5 点）。**ここでは石を投げない**（1 ターン目に投げると飲み込まれて詰む）。
4. **`wait`** を 1 回行い、`smooth stone` が真っ赤に光る（`END_CNT == 2`）のを確認する。
5. **`throw stone at creature`** → 怪物が消滅し、**100 / 100 点**になる。
6. **`take stone`** → 中から羽化した何かが飛び立ち、ハッカーが生還してゲームクリア（`FINISH`）。

### 1.2 全体の進行順と主な得点（合計 100 点） 【確認済み】
本作はほぼすべての主要イベント・部屋到達が 5 点刻みで加算され、最終的に 100 点になる。

1. **PC ログインと悪夢:** `smooth stone` を入手。
2. **ハッカーと中華料理:** 中華料理を電子レンジで温めて渡し、`master key` を借りる（+5 点）。
3. **道具の収集と地下:** エレベーター内の `flashlight`、Temp Basement の `gloves`・`crowbar`、Temp Lab の `flask`（液体窒素）、Forklift で `Dead Storage` を突破しマンホールを開けて（+5 点）、地下祭壇の `knife` を取る。
4. **Infinite Corridor と Great Dome:** `Inf-4` の非常用キャビネットから `axe` を取り、`Inf-3` からドームを登って（`gloves` 着用）頂上のブロンズ栓から **`note`** を入手（+5 点）。ワックスと `axe` で床磨き機の男を突破（+5 点）。
5. **Brown Building とミイラの手:** `Brown Basement` で `boots` を入手・着用し、屋上のドーム内で `hand` を掘り出す（+5 点）。帰りの屋根で `Flier` に `smooth stone` を投げつけて追い払い（+5 点）、中庭で石を回収する。
6. **Alchemy Lab:** 教授に `note` を見せて中に入り、教授が自分の五芒星に入って詠唱を始めたら（2 ターン待つ）`knife` で五芒星を切り、`stand` → `move bench` → `open trapdoor` → `down` で避難。教授の死後に戻って `ring` を着け、大釜（`vat`）で `hand` を蘇生する（+5 点）。
7. **Urchin とボルトカッター:** 動く `hand` を `urchin` に見せて怯えさせ、`bolt cutter` を入手する。
8. **エレベーター縦坑とレンガ壁:** `Tomb` から `padlock` を取り、`CS-Basement` のエレベーターを 1 階に置いて `ELEVATOR-PIT` で `crowbar` を使ってレンガ壁から `rod` を露出させ、`chain` + `padlock` + `hook` を繋いでエレベーターを 2 階へ呼び、壁を破壊する（+5 点）。
9. **Steam Tunnel と Lair:** 蒸気バルブでネズミを撃退（+5 点）、大部屋で `bolt cutter` により `urchin-wire` を切断（+5 点）、迷路を抜けて `Outer Lair` のスライムを液体窒素で凍らせて `Inner Lair` へ突入し、`FROB` を倒す（100 点）。

---

## 2. 詰み条件・即死条件の一覧 【確認済み】

| やってはいけないこと | 結果 | 対策 |
|---|---|---|
| **暗闇で 2 ターン以上過ごす** | 闇に引きずり込まれて即死 | 暗い場所に入る直前に `turn on flashlight`、明るい部屋では消す |
| **眠気警告を無視して進める** | 居眠りして即死（約 420 手前後） | Kitchen で `coke` を取り、警告が出たら `drink coke` |
| **Prof. が自分の五芒星に入る前（1 ターン目）に五芒星を切る** | 気づかれて所持品をすべて没収され脱出不能 | `Alchemy Lab` に入って **`wait` × 2** してから `cut pentagram with knife` |
| **8 ターン目までに `Alchemy Lab` から逃げない** | 触手に引きずり込まれて即死 | 2 ターン待ったらすぐ切断・`stand`・`move bench`・`open trapdoor`・`down` |
| **屋上で `hand` を持ったまま `Flier` に近づく/待つ** | `hand` を飲み込まれて飛び去り、蘇生・ボルトカッター入手が不能に | `Skyscraper Roof` に出たら即 `throw stone at creature` |
| **床磨き機の電源コードを `wax` なしで切る** | 管理人が追いかけてきて絞殺される | 先に同じ部屋へ `pour wax` してから `cut cord with axe` |
| **手袋なしで `cable` を登る／感電する** | 手を焼く・または `Inner Lair` で感電死 | `gloves` と `boots` を常に着用しておく |
| **液体窒素なしで `Outer Lair` のスライムを斧で切る** | スライムが腕を伝って窒息死 | `open flask` → `pour nitrogen on curtain` で凍らせる |
| **`Inner Lair` でハッカー登場後に長居する** | 怪物がハッカーを取り込み、変貌したハッカーに同化されゲームオーバー | 素早く配線を切ってソケットに差し込む |
| **怪物（`FROB`）出現 1 ターン目に `smooth stone` を投げる** | 石を飲み込まれて紛失し、3 ターン目に即死 | 必ず **`wait` で 1 ターン待って石が赤く光ってから** 投げる |

---

## 3. マップ概要 【確認済み】

### 3.1 CS 館・Temp 館・地下
```
[Terminal Room] (PC, Hacker)
      | s
[CS-2nd] --w-- [Kitchen] (Fridge: Coke, Carton / Microwave)
      | d
[Comp Center] (1F) <-- [Elevator] (Panel: Flashlight)
      | d
[Aero Lobby]--d--[Aero Stairs]--w--[Aero Basement]--e--[CS-Basement]--e--[Temp Basement]--e--[Dead Storage]--e--[Ancient Storage]
      | s               | d                (Forklift)        | d (Pit)          | u                   (Forkliftで突破)    | d (Manhole)
  (Inf-1へ)       [Subbasement]                        [Elevator Pit]     [Temp Lab] (Flask)                        [Brick Tunnel]
                        | nw (狭い: axe/flask不可)           | n (壁破壊後)                                              | n / s
                     [Tomb] --d-- [Tunnel]             [Steam Tunnel East]                                      [Cave]/[Under Lab]
```

### 3.2 Infinite Corridor・Brown Building・Alchemy
```
[Aero Lobby]
      | s
  [Inf-1] --e-- [Inf-2] --e-- [Inf-3] --e-- [Inf-4] --e-- [Inf-5] --n-- [Nutrition] --d-- [Brown Tunnel] --se-- [Brown Basement] (Boots)
  (Wax)                        | u          (Axe)            | s                                                       | u
                          [Great Dome]                 [Chemistry Bldg]                                         [Brown Building] --s-- [Courtyard]
                               | (climb strand)              | s                                                       | u               (石回収)
                          [Top of Dome]                [Alchemy Dept]                                            [Top Floor]
                               | out -> u                    | s                                                       | w -> u
                           [On Dome] (Plug -> Note)    [Alchemy Lab] --d-- [Under Alchemy Lab]                  [Brown Roof] -> [Inside Dome] (Tub: Hand)
```

### 3.3 Steam Tunnel 〜 Inner Lair
```
[Elevator Pit] --n-- [Steam Tunnel East] --w-- [Steam Tunnel] --w-- [Tunnel East] (Valve) --w-- [Tunnel] --w-- [Tunnel West] --w-- [Tunnel Entrance]
                                                                                                                                         | d
                                                                                                                                   [Muddy Tunnel]
                                                                                                                                         | d
                                                                                                                                   [Large Chamber] (Urchins / Wire)
                                                                                                                                         | d
                                                                     [Inner Lair] <--in-- [Outer Lair] <--d-- [Lair-5] <--s-- [Lair-4] <--s-- [Lair-3] <--d-- [Lair-2] <--n-- [Lair-1]
```

---

## 4. 章別攻略 【確認済み】

### 第 1 章：PC ログインと悪夢〜マスターキー入手
1. `Terminal Room` で `turn on pc` → `login 872325412` → `password uhlersoth`。
2. `click menu box` → `click red box` → `read paper` → `click more box` → `read paper` → `click more box` → `wait` × 3（悪夢の世界 `At Platform` へ）。
3. `take stone` で現実に戻ったら `wait` × 4（ハッカーが PC を調べて席に戻るまで待つ）。
4. `drop assignment`、`ask hacker about keyring`。
5. `south` → `west`（`Kitchen`）→ `open refrigerator` → `take coke` → `take carton`。
6. `open microwave` → `put carton in microwave` → `close microwave` → `push high` → `push 4` → `push 0` → `push 0` → `push start` → `wait` × 3 → `open microwave` → `take carton`。
7. `east` → `north` → `give carton to hacker` → `ask hacker for master key`（**`master key`** 入手）。

### 第 2 章：懐中電灯・作業具・ナイフ回収
1. `south` → `down` → `down`（`CS-Basement`）→ `push up button` → ドアが開くまで `wait` → `south`（エレベーター内）。
2. `open panel` → `take flashlight` → `turn on flashlight` → `push 2` → 2 階でドアが開くまで `wait` → `north` → `down` → `down`（`CS-Basement`）。
3. `east`（`Temporary Basement`）→ `take gloves` → `wear gloves` → `take crowbar` → `up`（`Temporary Lab`）→ `take flask` → `down`。
4. `west` → `west`（`Aero Basement`）→ `enter forklift` → `turn on forklift` → `east` × 3（`Dead Storage`）→ `move junk with forklift` × 4 → `east`（`Ancient Storage`）→ `stand` → `open manhole with crowbar`。
5. `down` → `north` → `down`（`Before the Altar`）→ `take knife` → `up` → `south` → `up` → `west` × 5（`Aero Stairs`）→ `up`（`Aero Lobby`）→ `south`（`Inf-1`）→ `turn off flashlight` → `take container`。

### 第 3 章：Great Dome のメモ・斧・Brown Building・手
1. `Inf-1` から `east` × 2 で `Inf-3` へ（床磨き機に塞がれたら `wait` して通り過ぎるのを待つ）。
2. `Inf-3` から `up`（`Great Dome`）→ `climb strand`（要 `gloves`）→ `lower ladder` → `unlock door with master key` → `open door` → `out` → `up`（`On Dome`）。
3. `take plug` → `take note` → `drop plug` → `down` → `in` → `down` × 2（`Inf-3`）。
4. `east`（`Inf-4`）→ `break glass with crowbar` → `take axe`（`crowbar` は後で使うのでまだ捨てない）→ `east`（`Inf-5`）。
   - ※ `Inf-4`〜`Inf-5` で床磨き機に塞がれたら、同じ部屋で `open container` → `pour wax` → `drop container` → `cut cord with axe` で無力化する。
5. `north`（`Nutrition`）→ `down` → `se`（`Brown Basement`）→ `take boots` → `wear boots`。
6. `up` → `up` → `unlock door with master key` → `open door` → `west` → `up`（`Inside Dome`）→ `search tub` → `take hand`。
7. `down`（`Skyscraper Roof`）→ **`throw stone at creature`**（`Flier` が石を追って落ちる）→ `east` → `down` → `south`（`Courtyard`）→ `take stone` → `north` → `down` → `nw` → `up`（`Inf-5`）。

### 第 4 章：Alchemy Lab と手の蘇生・Urchin 撃退
1. `Inf-5` から `south` → `south`（`Chemistry Bldg`）→ `unlock door with master key` → `open door` → `south`（`Alchemy Dept`）。
2. **`show note to professor`** → `turn on flashlight` → `south`（`Alchemy Lab`）。
3. 教授が自分の五芒星に入って詠唱を始めるまで **`wait` × 2** → `cut pentagram with knife` → `stand` → `move bench` → `open trapdoor` → `down`（`Under Alchemy Lab`）。
4. 上で爆発と閃光が起きるまで `wait`（約 1〜2 ターン）→ `open trapdoor` → `up` → `take ring` → `take off gloves` → `wear ring` → `wear gloves`。
5. `put hand in vat` → `wait` × 3 → `take hand`（動く手になる）。
6. `north` → `open door` → `north` → `turn off flashlight` → `north`（`Inf-5`）。
7. `CS-Basement` / `Temporary Basement` / `Dead Storage`（暗闇に入るときは `turn on flashlight`）を巡回し、`Slouching nearby is an urchin.` と出たら即 **`show hand to urchin`** → **`take bolt cutter`**（+5 点）。（`knife` はここで捨ててよい）

### 第 5 章：南京錠回収〜エレベーター縦坑・レンガ壁破壊
1. `Subbasement`（`CS-Basement` から `west` × 2 → `down`）で `turn on flashlight` → `drop axe` → `drop flask` → `nw`（`Tomb`）。
2. `unlock padlock with master key` → `open padlock` → `take padlock` → `open hatch` → `se` → `turn off flashlight` → `take axe` → `take flask` → `up` → `east` → `east`（`CS-Basement`）。
3. エレベーターを `CS-Basement` へ呼び（`push up button` → ドアが開くまで `wait`）、`south` → `push 1` → 1 階でドアが開くまで `wait` → `north` → `down`（`CS-Basement`）。
4. `turn on flashlight` → `open elevator door` → `wedge door with axe` → `down`（`ELEVATOR-PIT`）。
5. `take chain` → `pry wall with crowbar` × 2（`rod` が露出）→ `tie chain to rod` → `lock chain with padlock` → `up`（`CS-Basement`）。
6. `tie chain to hook` → `drop crowbar` → `take axe` → `turn off flashlight` → `up` × 2（`CS-2nd`）→ `push down button` → 壁が崩れる音とドア開放まで `wait` → `down` × 2（`CS-Basement`）。

### 第 6 章：Steam Tunnel 〜 Inner Lair 決戦
1. `turn on flashlight` → `open elevator door` → `down`（`ELEVATOR-PIT`）→ `north`（`Steam Tunnel East`）。
2. `west` × 2（`Tunnel East`）→ `open valve with axe`（1 回目）→ `wait` してネズミの群れが出るまで待つ → **`open valve with axe`**（2 回目、撃退）→ **`close valve`**。
3. `west` × 4（`Tunnel Entrance`）→ `down`（`Muddy Tunnel`）→ `down`（`Large Chamber`）→ **`cut wire with bolt cutter`**。
4. `down`（`Lair-1`）→ `north`（`Lair-2`）→ `down`（`Lair-3`）→ `south`（`Lair-4`）→ `south`（`Lair-5`）→ `down`（`Outer Lair`）。
5. `open flask` → `pour nitrogen on curtain` → `unlock door with master key` → `open door` → `in`（`Inner Lair`）。
6. 第 1 節「勝利条件」のとおり `open box` → `take coaxial cable` → `reach in pool` → `take line` → `cut line with axe` × 3 → `take line` → `put line in socket` → `wait` → `throw stone at creature` → `take stone` でクリア！

---

## 5. 乱数・タイマー総表

| 割り込み / 乱数 | 挙動・条件 | 対策 |
|---|---|---|
| `I_URCHIN` | 10 ターンごとに移動。明るい部屋に本人が入ってくると逃げるが、プレイヤーが彼の居る部屋に入ると留まる確率が高い（`PROB(80)`） | `Temporary Basement`〜`Dead Storage`〜`CS-Basement` 周辺を巡回して遭遇したら即 `show hand to urchin` |
| `I_WAXER_MOVES` | `Inf-1`〜`Inf-5` を往復する。同室にいると前進を塞がれる | 同じ部屋で `pour wax` + `cut cord with axe` するか、やり過ごす |
| `I_FLASHLIGHT` | 点灯中の累積ターン数で電池が切れる | 明るい部屋では必ず `turn off flashlight` |
| `I_SLEEP` | 一定手数ごとに疲労が進行し、限界で強制睡眠→即死 | `coke` を所持し、疲労メッセージが出たら `drink coke` |
| `I_PROFESSOR` | `Alchemy Lab` 入室後 8 ターンで儀式完了しプレイヤー死亡 | 2 ターン待って詠唱開始後に五芒星を切り、7 ターン目までに `down` で避難 |
| `I_RATS` | `Steam Tunnel` 付近でネズミが接近・襲撃 | バルブを 1 回開けておき、群れが見えたら 2 回目を開けて一掃、直後に `close valve` |
| `I_LINE_IN_WATER` | 高圧線を切断後 2 ターンで水中に落ちる | 切断直後に `take line` → `put line in socket` |
| `I_FROB_APPEARS` | `END_CNT=1` 出現、`=2` 石が赤熱、`=3` 飛びかかられて即死 | `END_CNT=2` で `throw stone at creature` |

---

## 6. 確認済みコマンド列（概要） 【確認済み】

Python 版（`out/lurkinghorror`、`seed=42`）にて **100 / 100 点・299 手** で完走した主要コマンド列。`【…】` は状態や乱数に応じて調整する箇所。

```text
turn on pc / login 872325412 / password uhlersoth
click menu box / click red box / read paper / click more box / read paper / click more box
wait / wait / wait / take stone / wait / wait / wait / wait
drop assignment / ask hacker about keyring
south / west / open refrigerator / take coke / take carton
open microwave / put carton in microwave / close microwave
push high / push 4 / push 0 / push 0 / push start / wait / wait / wait
open microwave / take carton / east / north
give carton to hacker / ask hacker for master key
south / down / down / push up button / 【ドアが開くまで wait】 / south
open panel / take flashlight / turn on flashlight / push 2 / 【2階でドアが開くまで wait】 / north
down / down / east / take gloves / wear gloves / take crowbar / up / take flask / down
west / west / enter forklift / turn on forklift / east / east / east
move junk with forklift (×4) / east / stand / open manhole with crowbar
down / north / down / take knife / up / south / up / west (×5) / up / south / turn off flashlight / take container
【床磨き機を避けつつ east×2 で Inf-3 へ】
up / climb strand / lower ladder / unlock door with master key / open door / out / up
take plug / take note / drop plug / down / in / down / down
east / 【Inf-4 で】 break glass with crowbar / take axe / east
【Inf-5 で床磨き機に塞がれたら: open container / pour wax / drop container / cut cord with axe】
north / down / se / take boots / wear boots / up / up / unlock door with master key / open door / west / up
search tub / take hand / down / throw stone at creature / east / down / south / take stone / north / down / nw / up
south / south / unlock door with master key / open door / south / show note to professor / turn on flashlight / south
wait / wait / cut pentagram with knife / stand / move bench / open trapdoor / down
【閃光まで wait】 / open trapdoor / up / take ring / take off gloves / wear ring / wear gloves
put hand in vat / wait / wait / wait / take hand / north / open door / north / turn off flashlight / north
【地下を巡回し、Slouching nearby is an urchin. が出たら: show hand to urchin / take bolt cutter / drop knife】
【Subbasement へ】 / turn on flashlight / drop axe / drop flask / nw
unlock padlock with master key / open padlock / take padlock / open hatch / se / turn off flashlight / take axe / take flask
up / east / east / 【CS-Basement でエレベーターを 1 階へ移動させる】
turn on flashlight / open elevator door / wedge door with axe / down
take chain / pry wall with crowbar / pry wall with crowbar / tie chain to rod / lock chain with padlock / up
tie chain to hook / drop crowbar / take axe / turn off flashlight / up / up / push down button / 【ドアが開くまで wait】 / down / down
turn on flashlight / open elevator door / down / north / west / west / open valve with axe
【ネズミの群れが出るまで wait】 / open valve with axe / close valve
west / west / west / west / down / down / cut wire with bolt cutter
down / north / down / south / south / down
open flask / pour nitrogen on curtain / unlock door with master key / open door / in
open box / take coaxial cable / reach in pool / take line / cut line with axe (×3) / take line / put line in socket
wait / throw stone at creature / take stone
```
