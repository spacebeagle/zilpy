# STATIONFALL ゲームプレイ解説（LLM 攻略用リファレンス）

Infocom の **Stationfall**（Planetfall の続編）を、次に遊ぶ LLM がこの資料とゲーム出力だけで **80/80 点（満点）** でクリアできるようにまとめた攻略リファレンス。

- **対象**: `stationfall/`（Infocom STATIONFALL の原作 ZIL ソース `s6.zil`, `misc.zil`, `parser.zil`, `interrupts.zil`, `syntax.zil`, `verbs.zil`, `globals.zil`, `ship.zil`, `station.zil`, `village.zil`）および ZilPy 変換版。
- **検証根拠**: 記載する満点・得点条件・即死／ソフトロック条件・計算式・コマンド構文・マップ接続は、すべて原作 ZIL ソースコードから直接確認済み。

> 注意: 解き方がすべて書かれています。自分で解きたい人は読まないでください。

---

## 1. ゲームの目的と勝利条件・絶対に守るべきこと

### 1.1 勝利条件（確認済み）

1. 宇宙ステーション「Gamma Delta Gamma 777-G」の機械暴走の原因である異星兵器 **pyramid** を突き止め、秘密の **Factory**（Level 8）へ到達する。
2. Factory でスタンレイを構えてピラミッドを守っている **Floyd を zapgun で撃つ**（`shoot floyd` → `FLOYD-SHOT = T`、`ship.zil`）。
3. バーバーショップの鏡の裏から入手した **reflective foil** をピラミッドに被せる（`put foil on pyramid`、`PYRAMID-F`、`station.zil:L3915-3954`）。
4. ピラミッドが自らの邪悪な波動を反射して爆発・自壊し、複製ピラミッドの発射とリアクター暴走が中止される。**+5 点**が加算されてエンディング（`TELL-SCORE` → `QUIT`）。

### 1.2 絶対に守るべきこと（即死・不可逆ソフトロック一覧）

#### 即死トラップ（確認済み）

| やってはいけないこと | 条件式・ルーチン（ZIL 根拠） | 結果 |
|---|---|---|
| **ハッチを開けたまま／席に座らず／Cargo Bay にいたまま発進** | `I-SPACETRUCK` (`ship.zil:L1158-1174`)：`SPACETRUCK-COUNTER == 0` で `HERE == CARGO-BAY` / `SPACETRUCK-HATCH` が `OPENBIT` / 座席外 | 排気ガス死・真空死・加速圧死 |
| **誤ったコース番号で発進** | `COURSE-PICKED != RIGHT-COURSE` (`ship.zil:L1215-1226`) → `I-SUFFOCATE` | 宇宙空間で燃料切れ → 酸素切れ死 |
| **S.P.S. Duffy 上で眠る** | `WAKING-UP` (`globals.zil:L1024-1035`)：`SPACETRUCK-COUNTER == -1` | 軍法会議 → 銃殺 |
| **Rex（Bin 1）を選んで行動する** | `I-OTHER-ROBOT` (`ship.zil:L877-888`)：`ROBOT-PICKED == REX` | Rex の暴走事故で即死 |
| **宇宙服を着たまま眠る** | `WAKING-UP` (`globals.zil:L1008-1014`)：`SPACESUIT` が `WORNBIT` | 酸素切れで窒息死 |
| **ステーション到着後、ベッド以外（床など）で眠る** | `WAKING-UP` (`globals.zil:L1036-1045`)：`IN? PROTAGONIST HERE` かつ `DOCKING-BAY-2` 訪問済みで `PROB (DAY * 40)` | 就寝中に暴走機械に襲われ死亡 |
| **爆薬を穴に詰めたまま／ダチョウ＋ニップ同室で眠る** | `WAKING-UP` (`globals.zil:L1039-1051`)：`IN? EXPLOSIVE DRILLED-HOLE` 等 | 暴走機械または爆死 |
| **空腹レベル 5 に達する** | `I-HUNGER-WARNINGS` (`globals.zil:L1218-1219`)：`HUNGER-LEVEL == 5` | 飢餓・脱水死 |
| **Mess Hall のコーヒーを飲む** | `COFFEE-F` (`station.zil:L1765`) | 毒入りコーヒーで即死 |
| **Laundry の presser を付けたまま放置** | `I-PRESSER` (`station.zil:L1426-1437`)：25+25=50 millichrons 後 | 腕を挟まれ死亡（使用後すぐ `turn off presser`） |
| **Commander's Office の log reader を点けっぱなし** | `I-LOG-READER` (`interrupts.zil:L448-453`)：14 ターン後 | 同室で爆発死（読んだら `turn off log reader`） |
| **PX 自販機（dispenser）にドリルを使う** | `DISPENSER-F` (`station.zil:L231-239`) | 電源直撃で感電・爆死 |
| **Comm Center のボタンを押す（後半）** | `COMM-BUTTON-F` (`station.zil:L623-625`)：`ROBOT-EVILNESS > 14` | 感電死（8〜14 では全所持品を落とす） |
| **Hull Welder と同室に居座る** | `I-WELDER` (`interrupts.zil:L16-20`)：`WELDER-COUNTER == 4` | 溶接アークで焼死（部屋を出るか消灯で回避） |
| **爆薬起爆時に同じ部屋にいる** | `I-TIMER` (`interrupts.zil:L409-413`)：`META-LOC EXPLOSIVE == HERE` | 爆死 |
| **Day 3 以降にエレベーターを使う** | `ELEVATOR-TYPE` (`verbs.zil:L2167-2170`)：`G? DAY 2`／開いたシャフトへの転落 (`station.zil:L2967`) | 墜落死（Day 3 以降は必ずハシゴを使う） |
| **宇宙服なし／磁気ブーツなしでエアロック外扉を開く** | `OUTER-AIRLOCK-DOOR-F` (`village.zil:L1201-1206`) | `VACUUM-DEATH` / `LOST-IN-SPACE` |
| **Plato の襲撃時に Floyd に助けを求めない** | `I-PLATO-ATTACK` (`station.zil:L3583-3603`)：5 ターン目に `FLOYD-TOLD == <>` | スタンレイで心停止死 |
| **Floyd 不在／停止中に Oliver を撃つ** | `OLIVER-F` (`station.zil:L2587-2593`) | 隕石直撃で即死 |
| **暗闇を歩く／暗闇に留まる** | `verbs.zil:L2393, L2968`：`PROB 75` | グルーに食われて即死 |
| **Computer Control で Exercise Machine / Forklift を放置** | `I-EXERCISE-MACHINE` (3ターン)、`I-FORKLIFT` (4ターン) (`station.zil:L3800-3842`) | 圧殺／串刺し死 |
| **最終カウントダウン完了** | `I-ANNOUNCEMENT` → `I-LAUNCH` (`station.zil:L3674-3691`)：発射アナウンス後 200 millichrons | ステーションのリアクター爆発死 |

#### 取り返しのつかないソフトロック（確認済み）

| 操作・事故 | 条件式・ルーチン（ZIL 根拠） | 結果・回避策 |
|---|---|---|
| **磁気ブーツと ID カードを同時に持つ／着脱する** | `V-TAKE` (`verbs.zil:L1919-1927`) / `BOOTS-F` (`village.zil:L1940-1944`) → `ID-SCRAMBLED = T` | ID カードの磁気が破損し、ID Changer でも Security Door でも二度と使えない → **Armory に入れず詰み**。磁気ブーツに触る前に必ず ID カードを床に置くこと |
| **PX 自販機でコインを `9`（Large Drill Bit）に使う** | `DISPENSER-TYPE` (`verbs.zil:L2220-2225`) | コインは 1 枚しかない。`6`（**All-Purpose Timer**）を買わないと金庫が爆破できず詰み（金庫の穴は Medium Bit で十分） |
| **金庫（safe）以外にドリルで穴を開ける** | `MAKE-HOLE-WITH-DRILL` (`station.zil:L1000-1004`) → `DRILL-DEAD = T` | 別の場所（strong box や Dome の storage bin）に穴を開けると、金庫を掘る際にドリルが故障して二度と動かない → **詰み** |
| **Detonator に `DIODE-J` を入れて起爆テストする** | `I-TIMER` (`interrupts.zil:L399-400`) | `DIODE-J` は焼損するだけ（`DIODE-M` を使うこと。タイマー自体は 0 で止まるので再セット可能） |
| **爆薬を常温で溶かす／寝て消滅させる** | `I-EXPLOSIVE-MELT` (`interrupts.zil:L366-373`, `MELT-COUNTER > 210`) / `WAKING-UP` (`globals.zil:L1081-1084`) | 爆薬は 1 個のみ。真空倉庫から出したら**空の Thermos に入れてフタを閉める**（融解速度 1/4）こと。爆薬を持ったまま寝ないこと |
| **Spray Can（12 回制限）を使い切る** | `SPRAY-CAN-F` (`village.zil:L1479-1482`, `SPRAY-COUNTER 12`) | バルーン生物を Chapel まで誘導できなくなる。最短ルートなら **9 回**で到着可能 |
| **バルーン生物やダチョウ、自販機を撃つ／エアロックで吹き飛ばす** | `BALLOON-F`, `OSTRICH-F`, `DISPENSER-F`, `OUTER-AIRLOCK-DOOR-F` | 必要オブジェクトが消滅して詰み |
| **Zapgun（全 7 発）を無駄撃ちして残弾 0 にする** | `ZAPGUN-SHOTS 7` (`station.zil:L1066`) | 必須射撃は **2 発**（Loan Shark の `strong box` と Factory の `Floyd`） |
| **Headlamp（92 ターン制限）を点けっぱなしにする／点けたまま寝る** | `I-HEADLAMP` (`interrupts.zil:L45-62`) / `WAKING-UP` (`globals.zil:L1085-1088`) | バッテリー切れで `VACUUM-STORAGE` や `I-LIGHTS-OUT` 後の暗闇を探索できなくなる。明るい場所・就寝前には必ず `turn off headlamp` |

---

## 2. 得点の内訳（確認済み・合計 80 点）

満点は **80 点**（`TELL-SCORE`、`verbs.zil:L68-90`）。減点要素はない。

| # | 内容 | 点数 | ZIL 根拠（ファイル・条件） |
|---:|---|---:|---|
| 1 | Spacetruck が宇宙ステーションにドッキングする | 5 | `ship.zil:L1205` (`SPACETRUCK-COUNTER 5`) ※就寝中到着時は `globals.zil:L1135` で付与（排他） |
| 2 | 1 日目の夜を眠って Day 2 を迎える | 3 | `globals.zil:L1072` (`WAKING-UP`, `DAY` 1→2 のみ) |
| 3 | 認証済み `VILLAGE-FORM` を Iris Hatch のスロットに入れる | 6 | `globals.zil:L742` (`FORM-SLOT-F`, `VILLAGE-FORM-VALIDATED`) |
| 4 | `ROULETTE-WHEEL`（Casino）を回す | 4 | `village.zil:L734` (`ROULETTE-WHEEL-F`) |
| 5 | `FOIL`（Barbershop の鏡を割って入手）を取る | 4 | `village.zil:L304` (`OBJECT FOIL VALUE=4`) |
| 6 | `OSTRICH-NIP`（Pet Store 天井パネル）を取る | 3 | `village.zil:L546` (`OBJECT OSTRICH-NIP VALUE=3`) |
| 7 | `VACUUM-STORAGE`（In Space）に入る | 3 | `village.zil:L1346` (`ROOM VACUUM-STORAGE VALUE=3`) |
| 8 | `ARMORY` に入る | 5 | `station.zil:L1063` (`ROOM ARMORY VALUE=5`) |
| 9 | `COIN`（Loan Shark の strong box を撃って入手）を取る | 5 | `village.zil:L1632` (`OBJECT COIN VALUE=5`) |
| 10 | ダチョウに PX の自販機から商品（Timer）を落とさせる | 6 | `station.zil:L322` (`OSTRICH-INTO-DISPENSER`) |
| 11 | `MEDIUM-BIT`（Robot Shop の heating chamber）を取る | 3 | `station.zil:L2537` (`OBJECT MEDIUM-BIT VALUE=3`) |
| 12 | `DIODE-M`（Chapel の seven-pointed star 内部）を取る | 7 | `station.zil:L1509` / `L1542` (`STAR-F` または `DIODE-M VALUE=7`) |
| 13 | Commander's Quarters の金庫の穴に `EXPLOSIVE` を入れる | 3 | `station.zil:L984` (`DRILLED-HOLE-F`) |
| 14 | `KEY`（爆破した金庫の中）を取る | 7 | `station.zil:L1030` (`OBJECT KEY VALUE=7`) |
| 15 | Plato の襲撃を Floyd の助けで生き延びる | 7 | `station.zil:L3588` (`I-PLATO-ATTACK`, `FLOYD-TOLD`) |
| 16 | `TOP-OF-AIR-SHAFT`（Dome の grating 内）に入る | 2 | `station.zil:L3703` (`ROOM TOP-OF-AIR-SHAFT VALUE=2`) |
| 17 | `FACTORY`（Level 8）に入る | 2 | `station.zil:L3873` (`ROOM FACTORY VALUE=2`) |
| 18 | Factory で Floyd を撃った後、`put foil on pyramid` でクリア | 5 | `station.zil:L3950` (`PYRAMID-F`) |
| | **合計** | **80** | **100% 一致** |

**ランク一覧（`TELL-SCORE`、`verbs.zil:L73-89`）**:
- `80`: **Intergalactic Mega-Hero**
- `65〜79`: Interstellar Superstar
- `50〜64`: Interplanetary Star
- `40〜49`: International VIP
- `27〜39`: Footnote in History
- `17〜26`: One-Day Flash on the Evening News
- `1〜16`: Rising Young Insignificant Nobody
- `0`: Insignificant Nobody

---

## 3. 基本システム（確認済み）

### 3.1 時間（`INTERNAL-MOVES` / `C-ELAPSED` / `DAY`）

- 単位は **millichron**。1 日目は `4431〜5650`（`4430 + RANDOM(1220)`、`misc.zil:L190`）から開始。
- 通常コマンドは `C-ELAPSED = 7`。
- `Spacetruck` 飛行中（`I-SPACETRUCK` 動作中、`SPACETRUCK-COUNTER < 5`）は 1 コマンド = **240**。
- エレベーター移動は **5 × 移動階数**、ドリル掘削は **30**、`wait` は通常 7〜数ターン相当。
- `time` / `score` / `save` / `restore` は時間消費 **0**。
- **Day 3 の変化**（`WAKING-UP`、`globals.zil:L1140-1147`）：
  - 腕時計（`CHRONOMETER`）が `9947` で停止する。
  - エレベーターの無重力が切れて暴走状態になり、**ボタンを押すと即死**する。
  - `EXERCISE-MACHINE` が Gym から `COMPUTER-CONTROL` へ移動する。
- **Day 4 の変化**（`globals.zil:L1117-1121`）：
  - 金庫未開放なら 177 millichrons 後に停電（`I-LIGHTS-OUT`）、開放済みなら 383 millichrons 後に最終発射アナウンス（`I-ANNOUNCEMENT`）が始まる。**Day 2 のうちにクリアするのが最も安全かつ高速**（Day 1 で 1 回寝て Day 2 にすれば +3 点も回収でき、エレベーターも安全に使える）。

### 3.2 空腹・睡眠

- **空腹（`I-HUNGER-WARNINGS`、`globals.zil:L1194-1220`）**:
  - 開始から 1330 後に Lv1 → +450 で Lv2 → +300 で Lv3 → +150 で Lv4 → +150 で **Lv5（餓死）**。
  - 警告（Lv1 以上）が出てから食べる。食料は Spacetruck の `survival kit`（`blue soup`、`gray goo`、`orange goo`）、Grocery の `vacuum taffy`（`plastic bag` 内）、Greasy Straw の `nectar`。
  - **重要**: `blue soup` は早めに飲んで（または捨てて）`Thermos bottle` を空にしておくと、後の爆薬運搬に使える。
- **睡眠（`I-SLEEP-WARNINGS` / `WAKING-UP`、`globals.zil:L899-1188`）**:
  - 1 日目は時刻 `8100` 付近、2 日目以降は起床から `5900` 後に眠気警告。
  - 必ず **ベッド**（Barracks、Officers' Quarters、Commander's Quarters 等）で `get in bed` → `wait` で眠る。
  - **就寝前チェックリスト**:
    1. できれば空腹 Lv0 で寝る（空腹のまま寝ると起床時に即 Lv3 になる）。
    2. `SPACESUIT` を脱いでいること。
    3. `HEADLAMP` を消していること（`turn off headlamp`）。
    4. `EXPLOSIVE` を取り出していないこと（寝ると溶けて消滅）。
    5. `LOG-READER` を消していること。
  - **起床時**: 身に着けている物以外はすべて床に落ちる（`ROB PROTAGONIST HERE`）。`stand` してから必要な荷物を拾い直すこと。

### 3.3 所持制限・光源

- **重量上限**: 合計 **100**（`ITAKE`、`verbs.zil:L2548`）。
- **個数ファンブル**: 直接持つアイテムが **8 個以上** になると取得時に物を落とす確率が発生（8個=10%、9個=30%、…、13個=100%）。小物は `patrol uniform` のポケットや `survival kit`、`plastic bag` に入れて直接所持数を 7 個以下に保つ。
- **Headlamp**（Space Village の `Field Office` で入手）: バッテリー寿命 **92 ターン**（`HEADLAMP-COUNTER 92`）。暗闇（`Storage`、`File Room`、`Shipping Room`、`Vacuum Storage`、および金庫爆破後の停電 `I-LIGHTS-OUT` 発生後）以外では必ず `turn off headlamp`。

### 3.4 ロボット仲間と `ROBOT-EVILNESS`

- **`ROBOT-EVILNESS`**（初期値 0）: 1000 millichrons ごと、就寝時、および各種スコア獲得イベントごとに +1 上昇する。
  - `> 11`: `I-PLATO-ATTACK` が起動し、プラトンがスタンレイで襲ってくる。
  - `> 17`（または Dome の storage bin 爆発時）: Floyd が完全にピラミッドの支配下に入り、`FACTORY` へ移動する（`MOVE-FLOYD-TO-FACTORY`）。
- **Floyd**（S.P.S. Duffy の Robot Pool、**Bin 3**）:
  - 必ず `type 3` で Floyd を選ぶこと（Bin 1 の Rex は即死、Bin 2 の Helen は非協力）。
  - よく勝手に出歩いたり戻ってきたりする。必要な場面（Robot Shop の Heating Chamber で `floyd, take medium drill bit`、Plato 襲撃時）では同じ部屋にいることを確認する。
- **Plato**: ステーション到着後に Floyd が連れてくる読書好きのロボット。`ROBOT-EVILNESS > 11` で敵対する。
- **Oliver**: Robot Shop にいる赤ちゃんロボット。撃ってはいけない。

### 3.5 暴走機械への対処

- **Hull Welder（溶接機）**: `NWELDERBIT` が付いていない通路・部屋にランダム出現（`I-WELDER`）。出現後 3 ターン以内に別室へ移動（または消灯）すれば安全にやり過ごせる。4 ターン同室に留まると即死。
- **Presser（Laundry）**: 電源を入れてから 50 millichrons で襲ってくる。アイロンがけが終わったら即 `turn off presser`。
- **Log Reader（Commander's Office）**: 電源を入れて 14 ターンで爆発。読んだら即 `turn off log reader`。

---

## 4. マップ構造

### 4.1 S.P.S. Duffy（序盤・宇宙船 `ship.zil`）

```
                      [Robot Pool] (Floyd = Bin 3)
                           | N/S
[Deck Twelve] --E/W-- [Cargo Bay Entrance] --E/W-- [Cargo Bay] --IN/OUT-- [Spacetruck]
     | N/S
[Forms Storage Room]
```
※ Deck Twelve 西のドアは帰還用（本編では開かない）。

### 4.2 Space Station 階層構造（縦軸：ハシゴ `u`/`d` および東側 `Elevator`）

```
Level 1: [Dome] ──(grating)──> [Top of Air Shaft] ──(d×7)──> [Bottom of Air Shaft]
           | u/d                                                   | (open grating)
Level 2: [Mess Hall] ── Main Storage(N/S), Meeting Room 1(NE)─2(S)─Library(S/W)
           | u/d
Level 3: [Level Three] ── Gym(N), Laundry(NW), Chapel(SW), Theatre(S)
           | u/d
Level 4: [Level Four] ── Docking Bay #3(W), Female Barracks(N)─SanFac(SE)─Male Barracks(S)
           | u/d
Level 5: [Level Five] ── (下記 4.3 詳細マップ参照：Command Module 中枢 + 科学サブモジュール + Space Village)
           | u/d
Level 6: [Level Six] ── Docking Bay #1(NW)─[Alien Ship], Bay #4(SW), Aux Barracks(N)─SanFac(E),
           |            Officers' Qtrs A(S), End of Corridor(SE)──Armory(N), Shipping Room(E), Qtrs B(SW)/C(S)
           | u/d
Level 7: [Printing Plant] ── Paper Recycling Plant(NW)   ※Level 8 へのハシゴは封鎖
           :
Level 8: [Factory] (Pyramid & 最終決戦)
           | u/d
Level 9: [Computer Control] ──(N)── [Shaft at Level Nine]
```

### 4.3 Level 5（Command Module 中枢）詳細マップ

```
                     [Scientists' Quarters]
                              | u/d
               [Astro Office]-+-[Astro Lab] (20-prong fromitz board)
                              | u/d
        [Engineering Office]-+-[Engineering Lab]
                              | u/d          | S
                 [Bio Office]-+-[Bio Lab]  [Tube]
                              | u/d          | S
                    [Holding Tank Level]     |
                                             |
         [Storage](暗) --E/W-- [North Connection] --E/W-- [The PX] (Dispenser)
              | N/S                   | N/S                 / SW
         [Workshop]                   |                   /
              | N/S            [North Junction] --------+
              |                / SW   | E         \ SE
[Bay #2]--E--[Level Five]----+     [Sick Bay]--E--[Brig]
(Truck)       |   \ SE                 \ SE          |
        (E:Elev)   \                    \            |
                    \             [East Junction]    |
                     \             / SW     | E      |
                [South Junction]--+   [East Connection] ==(Iris Hatch E)==> [Makeshift Connector] (Village)
                 / SW  | S   | E   \ SE    | S      / SW
          [File Rm]    |  [Station Ctrl] [Comm Ctr] |
          (暗)         |     | S                    |
                       |  [Commander's Office]------+
                       |     | E            | S
                       |  [Cmdr's Qtrs]  [Briefing Room]
                       |  (Safe, Bed)       | W
         [Robot Shop]-W-[South Connection]--+
         (Oliver,            | S (Iris Hatch)
          Medium Bit)        v
                      [Grimy Passage] (Village)
```

### 4.4 Space Village（無重力区画 `village.zil`）

※ すべて無重力（`WEIGHTLESSBIT`）。`East Connection` から東へ `Makeshift Connector`、または `South Connection` から南へ `Grimy Passage` で接続。**`SPACESUIT` は Iris Hatch を通れない**（村の中専用）。

```
           [Recruitment Office]   [Rec Shop]
                     | N           / NE
[East Conn]==W==[Makeshift]--E--[Broadway]--E--[Field Office] (Headlamp)
                [Connector]     / SW  | S  \ SE    (D: Fortune Teller)
                               /      |     \
                    [Pet Store]   [Grocery]--E--[Barbershop] (Mirror -> Foil)
                    (Balloon,     (Taffy)        |
                     Ceiling Panel)   | S   \ SE
                              \ SE    |      \
      [Studio]--E/W--[Trading Post]--E/W--[Saloon]--E/W--[Casino]--(N:Opium Den / U:Flophouse[Spacesuit])
      (Diode-J)       / SW  | D   \ SE                   (Roulette Wheel)
                     /      |      \
          [Greasy Straw]    |    [Shady Dan's] (ID Changer)
              / SW          |         | D
             /              |    [Junk Yard] (Magnetic Boots)
[South Conn]                |         | W
     | S                    |         |
[Grimy Passage]             +----[Warehouse] (U:Trading Post, SW:Alley, D:Airlock->Vacuum Storage[Explosive])
     | S                              / SW
[Main Street]--(SE/D)-------------[Alley]--(N:Missionary, S:Loan Shark[Strong Box->Coin],
(U:Mayor's Off,                    / SW \ SE
 W:Travel Agency,                 /      \
 S:Bank[Detector])        [Pawn Shop]   [Doc Schuster's] (Ostrich)
                          (Spray Can)
```

---

## 5. 主要パズル・仕掛けの解法（確認済み）

### 5.1 S.P.S. Duffy 発進とコース計算式（`SPACETRUCK-TYPE`、`verbs.zil:L2125-2161`）

1. **Floyd の取得**: `Robot Pool` で `put robot form in slot` → `type 3`（Bin 3 = Floyd）。
2. **搭乗と起動**: `Cargo Bay` で `open hatch` → `in` → `close hatch` → `sit in pilot seat`（Floyd が自動で copilot seat に座る）→ `put activation form in slot`。
3. **コース番号の算出（重要）**:
   - `time` を入力し、現在時刻（`INTERNAL-MOVES`、例: `4812`）を確認する（`time` は時間消費 0）。
   - 以下の整数除算式で正解コース `RIGHT-COURSE` を計算する：
     ```
     x = (INTERNAL-MOVES // 50) - 132
     RIGHT-COURSE = ((x * x) // 4) + 103
     ```
   - 例: `INTERNAL-MOVES = 4812` なら `4812 // 50 = 96`、`x = 96 - 132 = -36`、`x*x = 1296`、`1296 // 4 = 324`、`RIGHT-COURSE = 427`。
   - `type <計算した番号>` を入力し、**席に座ったまま** `wait` を繰り返すと約 5 ターンで Docking Bay #2 に自動着陸する（**+5 点**）。

### 5.2 Space Village への侵入（`FORM-SLOT-F`、`PRESSER-F`）

1. **くしゃくしゃのフォーム回収**: Level 7 `Printing Plant` の `trash can` から `crumpled form` を取る（ついでに北西の `Paper Recycling Plant` で `drill`（中に `small drill bit` 入り）も回収）。
2. **アイロンがけ**: Level 3 `Laundry` で `open presser` → `put form in presser` → `close presser` → `turn on presser` → **すぐ `turn off presser`** → `open presser` → `take form`。これで `neatly ironed Illegal Space Village Entry Form FW-83-Q` になる。
3. **認証スタンプ回収**: Level 5 `Commander's Quarters` で **`look under bed`** → `take validation stamp`（`globals.zil:L876-882`）。
4. **認証と開門**: `validate village form with stamp` → `East Connection`（または `South Connection`）で `put village form in slot`。Iris Hatch が半開し、両方の接続口から Space Village へ入れるようになる（**+6 点**）。

### 5.3 ID カード偽造と武器庫（`ID-CHANGER-F`、`ID-READER-F`）

1. Space Village の `Shady Dan's` にある `innocuous machine`（`ID-CHANGER`）を使う。
2. `turn on machine` → `put id card in slot` → `type 10`（7 以上なら可）→ `take id card`。
3. Level 6 `End of Corridor` で `put id card in reader` → `Security Door` が開く（1 ターンで自動閉鎖）→ 即 `north` で `Armory` へ（**+5 点**）。
4. `take zapgun`（残弾 7 発）。
5. **厳守**: 磁気ブーツ（`Junk Yard`）を扱う間は、絶対に ID カードを持たないこと（`ID-SCRAMBLED` 回避）。

### 5.4 ダチョウと PX 自販機（`STRONG-BOX-F`、`DISPENSER-TYPE`、`OSTRICH-F`）

1. **コイン入手**: Space Village の `Loan Shark` で `shoot strong box`（Zapgun 1 発目）→ `take coin`（**+5 点**）。
2. **ダチョウニップ入手**: `Pet Store` で **`look up`**（天井パネル出現、`globals.zil:L323-328`）→ `open panel` → `take ostrich nip`（**+3 点**）。
3. **ダチョウ誘導**: `ostrich nip` を持った状態で `Doc Schuster's` へ行くとダチョウが付いてくるようになる。
   - そのまま `Alley` → `Main Street` → `Grimy Passage` → `South Connection` → `South Junction` → `East Junction` → `North Junction` → `The PX` へ連れて行く。
4. **タイマー購入＆取り出し**:
   - `The PX` で `put coin in slot` → **`type 6`**（All-Purpose Timer。**絶対に 9 を押さないこと**）。
   - 商品が引っかかるので、**`scare ostrich`**（または `put ostrich nip in hole`）。ダチョウが穴に首を突っ込んで `timer` を落とす（**+6 点**）→ `take timer`。

### 5.5 バルーン生物と M-series ハイパーダイオード（`SPRAY-CAN-F`、`STAR-F`）

1. **事前準備**:
   - Level 3 `Chapel` へ行き、`open pulpit` → **`turn off switch`**（`eternal flame` を消しておかないとバルーン生物が怖がって入らない）。
   - Space Village の `Pawn Shop` で `spray can`（全 12 回）を取る。
   - `Pet Store` で `open cage`（バルーン生物が解放される）。
2. **最短 9 回誘導ルート**（`NEXT-ROOM?` は上下階移動にも対応、`village.zil:L1539-1580`）：
   - 各部屋へ移動したら `spray can` を 1 回だけ行う（計 9 回）：
     1. `ne` (`Broadway`) → `spray can`
     2. `west` (`Makeshift Connector`) → `spray can`
     3. `west` (`East Connection`) → `spray can`
     4. `west` (`East Junction`) → `spray can`
     5. `nw` (`North Junction`) → `spray can`
     6. `sw` (`Level Five`) → `spray can`
     7. `up` (`Level Four`) → `spray can`
     8. `up` (`Level Three`) → `spray can`
     9. `sw` (`Chapel`) → `spray can`
3. **ダイオード回収**:
   - `Chapel`（重力あり）で `take leash`（バルーンが膨張して天井付近まで持ち上げられる、`HANGING-IN-AIR = T`）→ `take star`（**+7 点**）→ `drop leash` → `open star` → `take m-series hyperdiode`。

### 5.6 真空倉庫・爆薬・金庫爆破（`OUTER-AIRLOCK-DOOR-F`、`MAKE-HOLE-WITH-DRILL`、`I-TIMER`）

1. **準備物品**:
   - `Thermos`（中身を空にしておく、`Spacetruck` の `survival kit` 内）
   - `Headlamp`（`Field Office`、使う時だけ点ける）
   - `Spacesuit`（`Casino` で `turn roulette wheel`（**+4 点**）→ `up` (`Flophouse`) → `open locker` → `take spacesuit`）
   - `Magnetic Boots`（`Junk Yard`、**ID カードを別の部屋に置いてから**取る）
   - `Drill`（`Paper Recycling Plant`）＋ `Medium Drill Bit`（`Robot Shop` で Floyd に **`floyd, take medium drill bit`** → 床に落ちたら `take medium drill bit`（**+3 点**）→ `take small drill bit` → `put medium drill bit in drill`）
   - `Detonator`（Level 2 `Main Storage`）：`open detonator` → `take blackened hyperdiode` → `put m-series hyperdiode in detonator`
   - `Timer`（PX 自販機から入手済み）
2. **金庫に穴を開ける（爆薬を取る前に済ませると時間余裕が大）**:
   - Level 5 `Commander's Quarters` で **`drill safe`**（Medium Bit を装着したドリルで 1 回掘る。**他の物には絶対にドリルを使わないこと**）。
3. **真空倉庫で爆薬を回収**:
   - `Warehouse` で `wear spacesuit`、`wear boots`、`open inner door` → `down` (`Airlock`) → `close inner door` → `open outer door` → `turn on headlamp` → `down` (`In Space / Vacuum Storage`、**+3 点**)。
   - `take explosive` → `put explosive in thermos` → `close thermos`（融解速度 1/4）→ `up` (`Airlock`) → `turn off headlamp` → `close outer door` → `open inner door` → `up` (`Warehouse`)。
   - **重要**: `take off spacesuit`、`drop spacesuit`（村の外に持ち出せない）、`take off boots`、`drop boots`。
4. **金庫の爆破**:
   - 急いで `Commander's Quarters` へ戻る。
   - `open thermos` → `take explosive` → `put explosive in hole`（**+3 点**）。
   - `connect detonator to explosive` → `connect detonator to timer` → `set timer to 20`（10 でも可だが安全のため 20 推奨）。
   - **即座に部屋を出る**（`west` で `Commander's Office` へ）→ `wait` を繰り返すと爆発音が聞こえて金庫が開く（同時に `I-LIGHTS-OUT` が 20〜220 millichrons 後に予約される）。
   - `east` → `take key`（**+7 点**）。

### 5.7 プラトン襲撃イベント（`I-PLATO-ATTACK`、`station.zil:L3481-3604`）

- `ROBOT-EVILNESS > 11` になると、明かりのある通常部屋で Plato がスタンレイで先制攻撃してくる（所持品がすべて床に落ちる）。
- 身動きできないが会話は可能。4 ターン以内に以下のいずれかを入力して `FLOYD-TOLD = T` にする（`ship.zil:L322-333`）：
  - **`floyd, help`**
  - **`floyd, save me`**
  - **`floyd, kill plato`**
  - **`floyd, take stun ray`**
- その後 `wait` を続けると、5 ターン目に Floyd がスタンレイに飛びかかり、Plato が自爆して死亡（**+7 点**）。麻痺が解けたら**床に落ちた所持品を必ず回収する**こと。

### 5.8 最終決戦：Dome → Computer Control → Factory（`HOUSING-F`、`JAMMER-F`、`PYRAMID-F`）

1. **最終持ち物チェック**（これ以外は不要）：
   - `key`（金庫から）
   - `zapgun`（残弾 1 以上）
   - `reflective foil`（`Barbershop` で `break mirror` → `take foil`、**+4 点**）
   - `jammer`（Level 5 `Storage`（暗闇なので headlamp 使用）から入手）
   - `twenty-prong fromitz board`（科学サブモジュール `Astro Lab` から入手）
   - `headlamp`（停電対策）
2. **Jammer のセットアップ**:
   - `put twenty-prong fromitz board in jammer`
   - `set jammer to 710`
   - `turn on jammer`
3. **Dome の爆破と Air Shaft 降下**:
   - Level 1 `Dome` で `unlock bin with key` → `open bin`。燃料電池が爆発し、所持品が床に落ちて気絶→起床（`GRATING-LOOSE = T`、空腹・眠気停止、Floyd が Factory へ移動）。
   - **重要**: 必ず床から `take jammer`, `take zapgun`, `take foil`（＋暗ければ `take headlamp`）を回収する！
   - `open grating` → `enter grating`（`Top of Air Shaft`、**+2 点**）。
   - `down` を 7 回入力して `Bottom of Air Shaft` へ → `open grating` で `Computer Control` へ落下。
4. **Computer Control の 2 連戦**:
   - 落下したターンに `I-EXERCISE-MACHINE` が起動するが、設定済み（`710`・20-prong 装着・ON）の `jammer` を持っていれば **Exercise Machine が即座に停止**し、直後に **Forklift** が降りてくる。
   - **次のターンで即座に `turn off jammer`** を入力！ Exercise Machine が再起動して Forklift に組み付き、2 台とも相打ちで爆発・消滅する（`JAMMER-F`、`station.zil:L151-161`）。
5. **Factory とエンディング**:
   - `up` で `Factory` へ（**+2 点**）。
   - **`shoot floyd`**（Zapgun 2 発目、`FLOYD-SHOT = T`）。
   - **`put foil on pyramid`** → ピラミッド自壊、**+5 点**で **80/80 点（Intergalactic Mega-Hero）** クリア！

---

## 6. 推奨攻略手順（ステップバイステップ）

※ 乱数（Welder 出現、Floyd の行動、停電タイミング、Plato 襲撃タイミング）により適宜調整すること。**Welder が出たら即別室へ退避、空腹警告が出たら食事、眠気警告が出たらベッドで就寝**を徹底する。

### Phase 1: S.P.S. Duffy 発進（目標スコア: 5）

```text
east
north
put robot form in slot
type 3
south
east
open hatch
in
close hatch
sit in pilot seat
put activation form in slot
time
```
→ 表示された時刻 `T` から `x = (T // 50) - 132`, `RIGHT-COURSE = ((x * x) // 4) + 103` を計算し：
```text
type <RIGHT-COURSE>
wait   (Docking Bay #2 に着陸するまで繰り返す → +5点)
```
着陸後、`survival kit` を取り、中の `thermos` 等を確認してステーションへ出る：
```text
stand
take survival kit
open hatch
out
east
save   (推奨セーブ①：ステーション到着)
```

### Phase 2: ステーション探索・Space Village 開通・Day 1 就寝（目標スコア: 14）

```text
# Printing Plant で crumpled form と drill 回収
down
down
take crumpled form from trash can
nw
take drill
se
up
up

# Level 3 Laundry でアイロンがけ & Chapel の炎を消す
up
up
nw
open presser
put form in presser
close presser
turn on presser
turn off presser
open presser
take form
east
sw
open pulpit
turn off switch
east
down
down

# Commander's Quarters で Validation Stamp 回収 & Village フォーム認証
se
se
east
look under bed
take stamp
validate village form with stamp
west
north
ne
put village form in slot   (→ +6点、Iris Hatch 開通)
```
※ 1 日目の夜（眠気警告が出たら）に `Commander's Quarters` 等のベッドで眠って **Day 2 (+3点)** にする。空腹警告が出ていれば `survival kit` の `blue soup` を飲んで `thermos` を空にしておく（`open kit` → `take thermos` → `open thermos` → `eat soup`）。眠る前に `get in bed` → `wait`。起きたら `stand` して持ち物を回収。

### Phase 3: Space Village 探索・ID 偽造・武器庫（目標スコア: 31）

```text
# East Connection から Space Village へ
east
east

# Field Office で Headlamp、Barbershop で Foil (+4)
east
take headlamp
west
se
break mirror
take foil
west

# Pet Store で Balloon 解放 & Ostrich Nip (+3)
nw
sw
open cage
look up
open panel
take ostrich nip

# Casino で Roulette Wheel (+4)
se
east
east
turn roulette wheel

# Shady Dan's で ID 偽造（磁気ブーツに触る前に完了させる！）
west
west
se
turn on machine
put id card in slot
type 10
take id card
nw

# Pawn Shop で Spray Can 回収
down
sw
sw
take spray can
ne

# Level 6 Armory へ戻り Zapgun 回収 (+5)
nw
north
north
north
nw
down
se
put id card in reader
north
take zapgun
south
nw
up
save   (推奨セーブ②：Zapgun 入手)
```

### Phase 4: コイン入手・ダチョウ誘導・Timer 取得（目標スコア: 42）

```text
# Level 5 から再び Space Village (Loan Shark) へ
se
south
south
south
se
south
shoot strong box
take coin   (→ +5点)

# Doc Schuster's のダチョウを Ostrich Nip で PX まで誘導
north
se
nw
nw
north
north
north
ne
nw
ne
put coin in slot
type 6
scare ostrich   (→ +6点、Timer が落ちる)
take timer
```

### Phase 5: バルーン誘導 & Diode-M 入手 & Medium Bit 入手（目標スコア: 52）

```text
# Robot Shop で Floyd に Medium Drill Bit を取らせる (+3)
sw
sw
se
south
west
# （Floyd が同じ部屋にいることを確認してから）
floyd, take medium drill bit
take medium drill bit   (→ +3点)
take small drill bit
put medium drill bit in drill
east

# Space Village (Pet Store) へ行き、バルーン生物を最短 9 回で Chapel へ誘導
north
ne
east
east
east
sw
# ここから 9 回スプレー移動
ne
spray can
west
spray can
west
spray can
west
spray can
nw
spray can
sw
spray can
up
spray can
up
spray can
sw
spray can

# Chapel で Star -> Diode-M 回収 (+7)
take leash
take star   (→ +7点)
drop leash
open star
take m-series hyperdiode
east
down
down
save   (推奨セーブ③：Diode-M 入手)
```

### Phase 6: Detonator 修理・金庫掘削・真空倉庫・金庫爆破（目標スコア: 62）

```text
# Level 2 Main Storage で Detonator 回収＆Diode-M 装着
up
up
up
north
take detonator
open detonator
take blackened hyperdiode
put m-series hyperdiode in detonator
sw
down
down
down

# Commander's Quarters の金庫に Medium Bit で穴を開ける
se
se
east
drill safe
west
north
ne

# Space Village へ行き、ID カードを置いてから Spacesuit + Magnetic Boots で爆薬回収
# （Thermos は必ず空にして持参すること）
east
east
south
south
east
east
up
open locker
take spacesuit
down
west
west
se
# ★重要★ ID カードを床に置いてから Junk Yard へ！
drop id card
down
take boots
west
ne
wear spacesuit
wear boots
open inner door
down
close inner door
open outer door
turn on headlamp
down   (Vacuum Storage → +3点)
take explosive
put explosive in thermos
close thermos
up
turn off headlamp
close outer door
open inner door
up
take off spacesuit
drop spacesuit
take off boots
drop boots

# 急いで Commander's Quarters へ戻り爆破 (+3 → Key +7)
sw
nw
north
north
north
se
east
open thermos
take explosive
put explosive in hole   (→ +3点)
connect detonator to explosive
connect detonator to timer
set timer to 20
west
wait   (爆発音が聞こえるまで繰り返す)
east
take key   (→ +7点)
save   (推奨セーブ④：Key 入手)
```

### Phase 7: Jammer 準備 & Plato 襲撃突破（目標スコア: 69）

※ もし既に Plato 襲撃が発生していなければ、この移動中または少し待つ間に `ROBOT-EVILNESS > 11` で発生する。襲撃されたら **`floyd, help`** → `wait`（4回）で撃退（**+7 点**）し、**床に落ちた所持品を必ず拾い直す**。

```text
# Storage-5 (暗闇) で Jammer 回収
west
north
ne
west
nw
north
turn on headlamp
west
take jammer
east
turn off headlamp

# 科学サブモジュール Astro Lab で 20-prong fromitz board 回収
north
north
up
take twenty-prong fromitz board
put twenty-prong fromitz board in jammer
set jammer to 710
turn on jammer
down
south
south
south
sw
```

### Phase 8: 最終決戦 Dome → Computer Control → Factory（目標スコア: 80）

※ この時点で所持品に **`key`, `zapgun`, `foil`, `jammer`（20-prong 装着・`710`・ON）, `headlamp`** が揃っていることを確認。もし Plato 襲撃がまだなら、Dome の bin を開ける前に `wait` してイベントを消化しておくと 80/80 満点が確実になる。

```text
# Level 1 Dome へ（ハシゴで up×4）
up
up
up
up
save   (推奨セーブ⑤：最終決戦直前)
unlock bin with key
open bin
# 爆発後、床に落ちた必須アイテムを必ず回収！
take jammer
take zapgun
take foil
take headlamp
open grating
enter grating   (Top of Air Shaft → +2点)
down
down
down
down
down
down
down
open grating    (Computer Control へ落下 → Exercise Machine 停止、Forklift 出現)
turn off jammer (Exercise Machine と Forklift が相打ちで爆発！)
up              (Factory → +2点)
shoot floyd
put foil on pyramid   (→ +5点、80/80 点クリア！)
```
