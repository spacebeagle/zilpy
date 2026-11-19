# Zork I ゲームプレイ解説（LLM 攻略用リファレンス）

対象: `zork1/`（Infocom ZORK I Release 119 の ZIL ソース）と、それを ZilPy で変換した `out/zork1/zork1.py`（Python 版、`out/zork1` ディレクトリで `python zork1.py` として実行）。

このファイルはソースコードの読解を元に作り、**その後 Python 版（`out/zork1/zork1.py`）を直接通しプレイして 350/350 点クリアを確認し、修正済み**（第 7 章が実際に通った手順）。
Python 版（`out/zork1/zork1.py`）は Release 88 ベースで、ZIL ソース (Release 119) と細部が少し違う（例: 家の中の trophy case は最初閉まっている）。プレイ中にゲーム出力と食い違ったら、ゲーム出力を正とすること。
特に **第 7 章冒頭の「実プレイで分かった重要な教訓」** を先に読むこと。

- 「確認済み」= `1dungeon.zil` / `1actions.zil` / `gverbs.zil` の該当ルーチンを読んで確かめた内容
- 「推奨手順」= 上記の事実から組んだルート。乱数（戦闘・泥棒）が絡むので結果は毎回変わる

---

## 1. ゲームの目的と勝利条件

1. 地下帝国に散らばる **19 個の宝物** を集め、白い家の Living Room にある **trophy case** に入れる。
2. スコアが **ちょうど 350 点** になった瞬間（`SCORE-UPD`、`gverbs.zil`）に `WON-FLAG` が立ち、
   「Look to your treasures for the final secret.」という声が聞こえる。
3. `WON-FLAG` が立つと West of House から **南西 (SW)** に Stone Barrow への道が開く。
4. Stone Barrow で `west`（または `enter barrow`）と入力するとエンディング（`STONE-BARROW-FCN`）。

### 絶対に守るべきこと（確認済み）

| 事項 | 理由 |
|---|---|
| **一度も死なない** | 死亡のたびに `SCORE-UPD -10`。勝利判定は「スコア == 350」なので、1 回でも死ぬと 350 に届かずクリア不能になる。死んだら `restore` する |
| **こまめに `save`** | 戦闘・泥棒は乱数。Python 版は乱数状態ごと保存される（`ZilRuntime.SAVE`） |
| **卵 (egg) を自分で開けない** | 自分で開けると壊れて broken egg (2点) / broken canary (1点) になり 350 点に届かない。泥棒に開けさせる |
| **宝物は容器から出して trophy case に入れる** | `OTVAL-FROB` は入れ子の中身の点数を合計に加えていない。canary は egg から、sceptre は coffin から、emerald は buoy から出して別々に入れる |
| **3 回目の死亡でゲーム終了** | `JIGS-UP` で `DEATHS >= 2` なら強制終了 |

---

## 2. 得点の内訳（確認済み、合計 350）

スコア = 初取得点 (VALUE) + trophy case 内の点 (TVALUE) + 部屋到達点。

### 宝物 19 個

| 宝物 | 場所 | 取得点 | ケース点 | 入手の要点 |
|---|---|---:|---:|---|
| jewel-encrusted egg | Up a Tree の nest | 5 | 5 | 自分で開けない |
| clockwork canary | egg の中 | 6 | 4 | 泥棒が egg を開けると取り出せる |
| brass bauble | 森で canary を巻く | 1 | 1 | `wind canary` |
| painting | Gallery | 4 | 6 | |
| bag of coins | Maze（骸骨の部屋 MAZE-5） | 10 | 5 | 骸骨には触らない |
| platinum bar | Loud Room | 10 | 5 | `echo` |
| gold coffin | Egypt Room | 10 | 15 | 重い (SIZE 55)。South Temple で `pray` して運び出す |
| sceptre | coffin の中 | 4 | 6 | 虹で `wave sceptre` |
| ivory torch | Torch Room の pedestal | 14 | 6 | 永久光源。Gas Room に持ち込むと爆死 |
| trunk of jewels | Reservoir（水を抜く） | 15 | 5 | ダムを開ける |
| crystal trident | Atlantis Room | 4 | 11 | Reservoir の北 |
| pot of gold | End of Rainbow | 10 | 10 | sceptre を振ると出現 |
| crystal skull | Land of the Living Dead | 10 | 10 | 悪霊祓いの儀式 |
| jade figurine | Bat Room | 5 | 5 | garlic 必携 |
| sapphire bracelet | Gas Room | 5 | 5 | 火気厳禁 |
| huge diamond | Machine（coal から生成） | 10 | 10 | 炭鉱パズル |
| scarab | Sandy Cave の砂の中 | 5 | 5 | shovel で 4 回掘る |
| large emerald | buoy の中（River-4） | 5 | 10 | ボートで川下り |
| chalice | Treasure Room | 10 | 5 | 泥棒を倒してから取る |
| **小計** | | **143** | **129** | |

### 部屋・イベント点

| 条件 | 点 |
|---|---:|
| Kitchen に入る | 10 |
| Cellar に入る | 25 |
| East-West Passage に入る | 5 |
| Treasure Room に入る | 25 |
| **明かりがある状態** で Lower Shaft（炭鉱最下層）に入る (`LIGHT-SHAFT`) | 13 |
| **小計** | **78** |

143 + 129 + 78 = **350**。1 つでも欠けるとクリアできない。

ランク: 350=Master Adventurer / 331+=Wizard / 301+=Master / 201+=Adventurer / 101+=Junior Adventurer。

---

## 3. 基本システム（確認済み）

### 明かり
- 暗闇で動き回ると grue に食われて死ぬ。
- **brass lantern**: 電池式。点灯中のみ消耗し、点灯 200 ターンで「a bit dimmer」→ +100「definitely dimmer」→ +70「nearly out」→ +15 で消える。**合計約 385 ターン**。使わない時は `turn off lamp`。
- **torch**: 消えない永久光源（消せない）。ただし宝物なので泥棒に盗まれる。入手後は lamp を消して torch で歩く。
- **candles**: 最初から点灯状態。合計 75 ターン（40+20+10+5）。儀式専用。Tiny Cave では風で吹き消されることがある。torch で点火しようとすると蒸発して消滅する。
- **matchbook**: 実質 5 本。1 本は 2 ターンで消える。Timber Room / Lower Shaft では即消える。
- 屋外・家の中（Kitchen/Living Room）・Dam 周辺の一部は常時明るい。Attic、Sandy Beach、Treasure Room は暗いので光源が必要。

### 所持制限
- 重量合計 100 まで (`LOAD-ALLOWED`)。coffin は 55 もある。
- **7 個を超えて持つ** と、取るときに落とす確率が出る (`FUMBLE-NUMBER 7`)。常に 7 個以下に抑える。

### 戦闘
- 強さ = 2 + スコア/70（最大 7）。**スコアが高いほど強い**。泥棒戦は後半に回す。
- troll には sword、thief には nasty knife が特効（`VILLAINS` テーブル）。
- 負傷は 30 ターンごとに 1 段階回復。`diagnose` で確認。
- sword が青く光ると近くに敵がいる。

### 泥棒 (thief)
- 地下を巡回し、プレイヤーや訪問済みの部屋に置かれた **宝物** を盗んで Treasure Room に貯める。
- SACREDBIT の部屋（Living Room、Kitchen、家の周囲、Dam Base、Sandy Beach、Aragain Falls など）には入らない。coffin も盗まれない。
- 倒すと盗品はすべてその場に現れる。盗まれても取り返せるので慌てなくてよい。
- 泥棒が egg を持った状態で Treasure Room に戻るか死ぬと、egg が **開いた状態** になる（`DEPOSIT-BOOTY`）。これが canary の唯一の入手方法。
- 宝物を `give` すると見とれて隙ができる (`THIEF-ENGROSSED`)。
- **実プレイで確認**: 泥棒は宝物（torch）だけでなく、持ち物の光源を奪って「The thief seems to have left you in the dark.」にすることがある。暗闇で複数コマンドを連続入力するとグルーに即死する。torch と lamp を併用し、暗くなったらすぐ `turn on lamp`。
- 泥棒を倒すと盗まれていた torch も Treasure Room に戻る。

### 死亡時の挙動（参考。実際は restore すること）
- -10 点、所持品は地上や地下にばらまかれ、lamp は Living Room に戻る。
- South Temple 訪問済みだと幽霊として Entrance to Hades に飛ばされる。South Temple まで歩いて `pray` すると復活する。

### 即死トラップ一覧
| 行為 | 結果 |
|---|---|
| 暗闇を歩く | grue |
| 火（torch・点いた candles・match）を持って Gas Room に入る | 爆発 |
| Maze の skeleton に触る | 死にはしないが所持宝物が Land of the Living Dead に飛ばされる |
| rusty knife で攻撃する | 自分の喉を切る |
| 尖った物（sword, knife, rusty knife, axe, stiletto, **sceptre**）を持ってボートに乗る | ボートに穴。川の上なら溺死 |
| River-5 を過ぎる | 滝から落下 |
| 水が戻る Reservoir にボートなしで居る | 溺死 |
| Maintenance Room の **blue button** | 水漏れ。部屋が水没する（押さない） |
| Sandy Cave で 5 回目を掘る | 生き埋め |
| On Rainbow で sceptre を振る | 落下 |
| cyclops の前で長居する | 食われる |
| Up a Tree で egg / nest を落とす | egg が壊れる |
| Dome Room で jump | 死 |
| 鏡を壊す | 運が悪くなる（確率判定が不利に） |

---

## 4. マップ（確認済みの接続）

方角は n/s/e/w/ne/nw/se/sw/u/d。

### 地上
```
                Grating Clearing
                      |
Forest-1 ---- Forest Path(木に登れる:u) ---- Forest-2 ---- Mountains
   |                  |
   |           North of House
   |          /               \
West of House                  Behind House(East of House) -- Clearing -- Canyon View
   |          \               /      |(window)                               | d
(SW:Barrow)    South of House     Kitchen -- Living Room                Rocky Ledge
                                     | u         | d (trap door)             | d
                                   Attic       Cellar                  Canyon Bottom
                                                                             | n
                                                                       End of Rainbow
```
- West of House: n=North of House, s=South of House, w=Forest-1
- Forest-1: n=Grating Clearing, e=Forest Path, s=Forest-3
- Forest Path: u=Up a Tree, s=North of House, n=Grating Clearing
- Behind House: w=Kitchen（窓を開けてから）, e=Clearing
- Clearing: e=Canyon View, w=Behind House
- Canyon View: d→Rocky Ledge→d→Canyon Bottom→n→End of Rainbow。戻りは sw, u, u, nw, w

### 家と地下入口
- Kitchen: w=Living Room, u=Attic, e=外。煙突は上からは降りられない
- Living Room: e=Kitchen, d=Cellar（rug を動かして trap door を開ける）, w=Strange Passage（cyclops 撃退後）
- Cellar: n=Troll Room, s=East of Chasm, u=Living Room（trap door が開いていれば）
- East of Chasm: e=Gallery。Gallery: n=Studio。Studio: u=Kitchen（煙突。**lamp を含め 2 個以下** でないと登れない）

### 中央部
- Troll Room: s=Cellar, e=East-West Passage, w=Maze
- East-West Passage: e=Round Room, d/n=Chasm
- **Round Room（ハブ）**: w=E-W Passage, e=Loud Room, n=N-S Passage, s=Narrow Passage, se=Engravings Cave
- N-S Passage: n=Chasm, ne=Deep Canyon, s=Round Room
- Chasm: ne=Reservoir South, sw/u=E-W Passage, s=N-S Passage
- Deep Canyon: e=Dam, nw=Reservoir South, sw=N-S Passage, d=Loud Room
- Loud Room: w=Round Room, e=Damp Cave, u=Deep Canyon

### ダム・貯水池
- Dam: n=Dam Lobby, s=Deep Canyon, w=Reservoir South, d/e=Dam Base
- Dam Lobby: n/e=Maintenance Room
- Reservoir South: n=Reservoir（水位が低い時のみ）, e=Dam, sw=Chasm, se=Deep Canyon
- Reservoir: n=Reservoir North, s=Reservoir South
- Reservoir North: n=Atlantis Room
- Atlantis Room: u=Cave(Small Cave), s=Reservoir North
- Small Cave: n=Mirror Room(北側)

### 鏡の部屋（2 つある）
- **Mirror Room(南側 / MIRROR-ROOM-2)**: n=Narrow Passage(→n=Round Room), e=Cave(Tiny Cave), w=Winding Passage
- **Mirror Room(北側 / MIRROR-ROOM-1)**: n=Cold Passage, e=Small Cave, w=Twisting Passage
- 鏡を `rub mirror`（素手）すると **もう一方の Mirror Room に瞬間移動** する。南側→北側は炭鉱への近道
- Tiny Cave: d=Entrance to Hades, n=Mirror Room(南側)

### 神殿
- Engravings Cave: nw=Round Room, e=Dome Room
- Dome Room: d=Torch Room（rope を railing に結んでから。一方通行）
- Torch Room: s/d=Temple(North Temple)
- Temple: e/d=Egypt Room, s=Altar(South Temple), n/u=Torch Room
- Altar: n=Temple, d=Tiny Cave（**coffin を持っていると降りられない**）。ここで `pray` すると **Forest-1 に瞬間移動**
- Entrance to Hades: u=Tiny Cave, s/in=Land of the Living Dead（儀式後）

### 炭鉱
- Cold Passage: s=Mirror Room(北側), w=Slide Room
- Slide Room: n=Mine Entrance, e=Cold Passage, d=Cellar（滑り台。一方通行の帰り道）
- Mine Entrance: w=Squeaky Room。Squeaky Room: n=Bat Room。Bat Room: e=Shaft Room
- Shaft Room: n=Smelly Room, w=Bat Room。basket がある
- Smelly Room: d=Gas Room。Gas Room: e=Coal Mine
- Coal Mine 4 部屋: **Gas Room から e, ne, se, sw, d** で Ladder Top。戻りは **u, n, e, s, n** で Gas Room
- Ladder Top: d=Ladder Bottom。Ladder Bottom: s=Dead End（coal）, w=Timber Room
- Timber Room: w=Lower Shaft（**重さ 4 を超える物を 1 つも持っていない時だけ通れる**。全部置くのが安全）
- Lower Shaft: s=Machine Room, e=Timber Room

### 迷路（Maze）
Troll Room の西。必要な経路だけ覚えればよい。
- **Troll Room → 骸骨の部屋 (MAZE-5)**: `w, s, e, u`
- **MAZE-5 → Cyclops Room**: `sw, e, s, se`
- まとめ: Troll Room から `w, s, e, u, sw, e, s, se`
- Cyclops Room: nw=迷路, u=Treasure Room（cyclops を無力化後）, e=Strange Passage→e=Living Room（撃退後）
- Grating Room（地上の格子の真下）は MAZE-11 の ne。skeleton keys で開くが、クリアには不要
- 迷路内に物を置くと泥棒に持ち去られやすい。一方通行の down が 4 か所ある（`MAZE-DIODES`）

### 川
- Dam Base で進水 → River-1 (4ターン) → River-2 (4) → River-3 (3) → **River-4 (2)** → River-5 (1) → 滝で死亡
- River-4: buoy がある。e=Sandy Beach, w=White Cliffs Beach South
- Sandy Beach: ne=Sandy Cave, s=Shore。Shore: s=Aragain Falls
- Aragain Falls: w=On Rainbow（虹が固体の時）→ w=End of Rainbow

---

## 5. 重要アイテムの場所（確認済み）

| アイテム | 場所 | 用途 |
|---|---|---|
| brass lantern, sword | Living Room | 光源 / troll 戦 |
| brown sack（lunch, **garlic**）, bottle（water） | Kitchen の table | garlic=Bat Room 対策。lunch+water は cyclops の別解 |
| rope, nasty knife | Attic（暗い） | Dome Room / thief 戦 |
| skeleton keys, bag of coins, rusty knife, 壊れた lantern | MAZE-5 | keys は格子用（不要）。rusty knife は取らない |
| matchbook, tour guidebook | Dam Lobby | 儀式で candles に点火 |
| wrench, screwdriver, tube（putty 入り） | Maintenance Room | bolt / machine / （putty はボート修理・水漏れ修理） |
| air pump | Reservoir North | ボートを膨らませる |
| 畳まれた plastic（ボート） | Dam Base | 川下り |
| brass bell | Temple | 儀式 |
| black book, candles | Altar | 儀式 |
| shovel | Sandy Beach | scarab を掘る |
| coal | Dead End（Ladder Bottom の南） | diamond の材料 |
| timbers | Timber Room | 不要 |

---

## 6. パズル解法（確認済みのロジック）

### 6.1 家への侵入と地下入口
`open window` → Kitchen。Living Room で `move rug` → `open trap door` → `d`。
初めて Cellar に降りると trap door が外から閂をかけられる（上に戻れない）。別ルートで Living Room に戻れば、次に開けた時からは閉まらない。
ただし **煙突 (Studio→Kitchen) で戻ると閉まるフラグが再セットされる** ので、戻りは Cyclops ルート（下記）を使うのがよい。
実プレイでは、Cyclops 経由で Living Room に戻って `open trap door` した後は、Cellar から `up` で何度でも戻れた。

### 6.2 Troll
`attack troll with sword` を繰り返す。乱数勝負なので事前に save。倒すと東と西が通れる。
武器を投げたり渡したりしない（食べられることがある）。

### 6.3 Cyclops（2 通り）
- **推奨**: Cyclops Room で `odysseus`（`ulysses` も同義）。cyclops が東の壁を壊して逃げ、**Living Room への恒久的な近道** (Strange Passage) ができ、階段 (u) も通れる。
- 別解: `give lunch to cyclops` → `give bottle to cyclops`（水）で眠る。階段は通れるが近道はできない。
- 何もせず数ターン居ると食われる。

### 6.4 Loud Room の platinum bar
- 通常状態で入ると専用の入力ループに入り、`echo` / 移動 (w,e,u) / save / restore 以外は受け付けない。**`echo` と入力** すると音響が変わり、`take bar` できる。
- **ダムの水門を開けてから水位が下がりきるまでの 8 ターン** は、入ると轟音でランダムな隣室に叩き出される。この間は近づかない。

### 6.5 Dome Room → Torch Room → 神殿
Dome Room で `tie rope to railing` → `d`。rope は残る（何度でも降りられるが登れない）。
出口は Altar での `pray`（Forest-1 へ）か、Altar から `d`（Tiny Cave へ。coffin 不可）。

### 6.6 Coffin と sceptre
Egypt Room で `take coffin`。`open coffin` で sceptre。coffin を持ったまま Altar で `pray` すれば地上に出られる。

### 6.7 虹と pot of gold
Aragain Falls か End of Rainbow で `wave sceptre` → 虹が固体になり、End of Rainbow に pot of gold が出現。
もう一度振ると元に戻る（虹の上の宝物は落ちる）。**虹の上では絶対に振らない**。
川下りの帰り道に虹を渡るので、**川下りの前に** 歩いて End of Rainbow へ行き振っておく。

### 6.8 ダムと貯水池
1. Maintenance Room で `push yellow button`（制御盤の緑の bubble が光る）。brown は解除、red は照明、**blue は水漏れなので押さない**。
2. Dam で `turn bolt with wrench` → 水門が開き、8 ターン後に Reservoir が干上がる。
3. Reservoir South から n で Reservoir（trunk）→ Reservoir North（pump）→ Atlantis Room（trident）。
4. もう一度 bolt を回すと水門が閉じ、8 ターン後に水が戻る。閉じる必要はない。開けたままにしておく。

### 6.9 悪霊祓い（Entrance to Hades）
必要: bell, black book, candles, matchbook。手順（時間制限あり）:
1. `ring bell` — bell が赤熱して落ち、持っていた candles も落ちて消える。**ここから 6 ターン以内** に次へ。
2. `take candles`
3. `light match`
4. `light candles with match` — 火の点いた candles を手に持った状態でターンが終わると「The flames flicker wildly...」。**ここから 3 ターン以内** に次へ。
5. `read book` — 悪霊が消え、s で Land of the Living Dead に入れる。`take skull`。

失敗したら「resume their hideous jeering」と出るので 1 からやり直し（bell は 20 ターン後に冷める）。
candles は Altar で取ったらすぐ `turn off candles`（`extinguish candles`）で温存する。

### 6.10 炭鉱と diamond
- **Bat Room**: garlic を持っている（または部屋にある）と bat は手を出さない。無いと炭鉱のどこかへ運ばれる。
- **Gas Room**: 火気厳禁。lantern だけで入る。torch は Shaft Room の basket に入れておく。
- **Timber Room → Lower Shaft**: ほぼ手ぶらでしか通れない。そこで basket を使う:
  1. Shaft Room で torch と screwdriver を basket に入れる。
  2. lantern で Gas Room 経由で Dead End まで降りて coal を取り、Shaft Room まで戻る。
  3. coal を basket に入れ、`lower basket`。
  4. 再び降りて Timber Room で **全部置き**（lantern は点けたまま床に）、w で Lower Shaft へ。basket の torch で明るいので **13 点** 入る。
  5. basket から torch, coal, screwdriver を取り、s の Machine Room へ。
  6. `open lid` → `put coal in machine` → `close lid` → `turn switch with screwdriver` → `open lid` → `take diamond`。
     （蓋が開いたままだと動かない。coal 以外を入れると slag になる）
  7. Lower Shaft に戻り diamond と torch を basket に入れ、screwdriver は捨てる。e で Timber Room、荷物を拾って Shaft Room へ戻り `raise basket`、diamond と torch を回収。
- 帰りは Slide Room から d で Cellar に滑り降りる。

### 6.11 川下り
1. Dam Base で `inflate plastic with pump`（素手や肺では不可）。
2. 尖った物を持っていないことを確認して `board boat`（`enter boat`）→ `launch`。
3. 川は自動で流される。River-1(4ターン) → River-2(4) → River-3(3) → River-4。
   River-4 に着いたら **すぐ** `take buoy` → `east`（Sandy Beach に上陸）。River-4 の猶予は 2 ターンしかない。
   `wait` は複数ターン進む可能性があるので、時間つぶしは `look` など 1 ターンのコマンドで行い、「The flow of the river carries you downstream.」を数える。進水前に save。
4. Sandy Beach で `disembark`（`get out of boat`）。`take shovel` → ne の Sandy Cave で `dig sand with shovel` を **ちょうど 4 回**（4 回目で scarab が見える）。
5. `open buoy` → `take emerald`。
6. s, s で Aragain Falls → w, w で End of Rainbow（事前に虹を固体化しておくこと）→ sw, u, u, nw, w で Behind House。
- Sandy Beach / Sandy Cave は常時点灯ではないので torch か lamp を持っていく（どちらも尖っていないので可）。

### 6.12 泥棒・egg・canary・chalice
1. egg は取るだけで開けない。
2. 終盤（スコアが高い時）に nasty knife、egg、**lantern**（torch は盗まれうる）を持って Treasure Room へ。入ると泥棒が必ず現れて戦闘になり、部屋の宝物は一時的に見えなくなる。
3. `give egg to thief` → `attack thief with knife` を繰り返す。事前に save、負傷したら restore。
4. 泥棒が死ぬと盗品が現れ、egg は開いている。`take chalice`、`take egg`、`take canary` ほか全部回収。
5. 森（Forest Path、Forest-1〜3、Up a Tree）で `wind canary` → songbird が bauble を落とす。`take bauble`。

泥棒が生きている間は chalice を取ろうとしても「stabbed in the back」で取れない。

---

## 7. 攻略ルート（Release 88 Python 版で通しクリア済み: 350 点・397 手）

実際に `out/zork1` ディレクトリで `python zork1.py` を直接実行し、**350/350 点、Master Adventurer、Stone Barrow でエンディング** まで到達した手順。
`…` の後ろは確認した出力・補足。乱数（戦闘・泥棒の出没）は実行ごとに変わるので、細部は変わりうる。

### 実プレイで分かった重要な教訓（必読）

1. **trophy case は最初閉まっている**。最初に収納する前に必ず `open case`。
2. **coffin は重い（SIZE 55）**。lamp 以外を持たない状態で取る。torch + bar + lamp 持参では「Your load is too heavy.」になる。
3. **泥棒に光源を盗まれる**。地下を歩くと泥棒が通りかかり、lamp や torch を持ち去ることがある（実際に torch を盗まれた）。
   - 暗くなったら **その場で即 `turn on lamp`**。コマンドを何個も連続で送らない（暗闇で動くと 1 手でグルーに食われて死ぬ。実際に 1 回死んだ）。
   - 地下の移動は出力を見ながら 1〜数コマンドずつ。lamp と torch の **両方** を持っておく。
4. **死んだら即 `restore`**。死亡で -10 点になり 350 に届かなくなる。save は各フェーズの区切りで。
5. **canary は bauble を得るまでケースに入れない**（`wind canary` が必要）。
6. **basket は大物 3 つ程度で一杯**（coal + screwdriver + torch で「no room」）。jade と bracelet は basket に入れず Shaft Room の床に置いた。
7. **泥棒は早めに倒すのがよい**。Treasure Room で戦えば 3 ターンで倒せた（スコア 275 時点、knife 使用）。倒すと盗まれた torch も返る。
8. 一度開けた trap door は Cellar から `up` で戻れる（閉まるのは最初に降りた時だけ）。
9. 帰り道の近道: Tiny Cave → 北 → Mirror Room で `rub mirror` → n → Cold Passage → w → Slide Room → `down` → Cellar → `up` → Living Room。

### フェーズ A: 地上の準備
```
(West of House) n, n, u, take egg, d, s, e, open window, w        … Kitchen (+10)
open sack, take garlic, w                                          … Living Room
take lamp, take sword, e, u, turn on lamp, take rope, take knife, turn off lamp, d, w
drop knife, drop egg, drop garlic                                  … Living Room に置く
move rug, open trap door, save
```
所持: lamp, sword, rope。Attic は暗いので `u` の後に点灯。

### フェーズ B: Troll・絵・迷路・Cyclops
```
turn on lamp, d                         … Cellar (+25)。trap door が閉まる
n, attack troll with sword (倒すまで)   … 今回は 1 発で倒れた。乱数なので事前に save
s, s, e, take painting, w, n, n         … Gallery で painting。Troll Room へ戻る
w, s, e, u, take bag                    … 迷路。骸骨の部屋で coins の袋（skeleton・rusty knife には触らない）
sw, e, s, se                            … Cyclops Room
odysseus                                … cyclops が壁を壊して逃走
e, e                                    … Strange Passage → Living Room
open case, put painting in case, put bag in case, drop sword     … スコア 65
open trap door, save
```

### フェーズ C: Loud Room・Torch・Coffin
```
d, n, e, e, e                           … Troll Room → E-W Passage(+5) → Round Room → Loud Room
echo, take bar, w                       … 「The acoustics of the room change subtly.」の後に取る
se, e, tie rope to railing, d           … Engravings Cave → Dome Room → Torch Room
take torch, turn off lamp
s, s, pray                              … Temple → Altar → Forest へ
e, s, e, w, w                           … Forest Path → North of House → Behind House → Kitchen → Living Room
put bar in case, put torch in case      … スコア 105
```
**coffin は別便で取る**（lamp だけ持って）:
```
turn on lamp, d, n, e, e, se, e, d, s, e   … Egyptian Room
take coffin, w, s, pray                      … Forest へ
e, s, e, w, w                                … Living Room
open coffin, take sceptre, put coffin in case     … スコア 134
```
bell は Temple にある。この時点で取らず、悪霊祓いの時に取る。

### フェーズ D: 虹
```
(所持: sceptre) turn off lamp, e, e, e, e         … Kitchen → Behind House → Clearing → Canyon View
d, d, n, wave sceptre, take pot                   … 「rainbow becomes solid」。pot of gold が出現
sw, u, u, nw, w, w, w                             … Living Room
put pot in case, put sceptre in case              … スコア 160
```

### フェーズ E: ダム・貯水池
```
turn on lamp, d, n, e, e, n, ne, e         … Dam
n, n                                        … Dam Lobby → Maintenance Room
take wrench, take screwdriver, push yellow button     … 「Click.」
s, take matchbook, s, turn bolt with wrench           … 「The sluice gates open」
drop wrench, w                                         … Reservoir South
look を約 8 回                                          … 「water level is now quite low」→ 水位低下
n, take trunk, n, take pump, n, take trident
s, s, s, e, d, drop pump, u                            … pump を Dam Base に置く（川下りで使う）
s, sw, s, w, w, s, up                                  … Cellar から up で Living Room
put trunk in case, put trident in case                 … スコア 195
```
blue button は押さない。screwdriver と matchbook は持ったまま。

### フェーズ F: 悪霊祓い
```
d, n, e, e, se, e, d, s, take bell, s       … Altar
take book, take candles, turn off candles
d, d                                         … Tiny Cave → Entrance to Hades
save
ring bell, take candles, light match, light candles with match, read book
s, take skull, n
u, n, rub mirror, n, w, d, up               … 近道で Living Room（上記の教訓 9）
put skull in case                            … スコア 209
```
bell・book・candles は Living Room に捨ててよい。garlic と torch はこの後取る。

### フェーズ G: 炭鉱は「泥棒を倒してから」が安全
泥棒に torch を盗まれると 13 点の Lower Shaft 用の光源がなくなる。**フェーズ H（川）→ I（泥棒）→ G の順** にした。

### フェーズ H: 川下り
```
(所持: lamp, screwdriver, matchbook, garlic。尖った物なし)
d, n, e, e, n, ne, e, d                      … Dam Base
take pump, inflate plastic with pump, drop pump, save
board boat, launch
look を 1 回ずつ                              … 約 12 ターンで River-4（red buoy が見える）
take buoy, east                               … Sandy Beach
disembark, take shovel, ne
dig sand with shovel を 4 回                  … 4 回目で「You can see a scarab here in the sand.」
take scarab, drop shovel, open buoy, take emerald, drop buoy
sw, s, s, w, w, sw, u, u, nw, w, w, w        … Aragain Falls → On Rainbow → End of Rainbow → … → Living Room
put scarab in case, put emerald in case      … スコア 234
```
虹は D で渡れる状態のまま（もう一度 wave しない）。

### フェーズ I: 泥棒討伐
```
take knife, take egg, take sword, turn on lamp（Strange Passage は暗い）
w, w, u                                       … Strange Passage → Cyclops Room → Treasure Room (+25)
give egg to thief, attack thief with knife    … 3 回で撃破（乱数）。負傷したら restore
take chalice, take egg                        … 重いので drop sword, drop knife の後 take torch, take canary
down, e, e                                    … Living Room
put chalice in case, put egg in case          … スコア 289（canary はまだケースに入れない）
```

### フェーズ J: bauble
```
(canary を持って) e, e, n, n                  … Forest Path
wind canary, take bauble
s, e, w, w                                     … Living Room
put bauble in case, put canary in case         … スコア 291
```

### フェーズ G（実行順は最後）: 炭鉱
```
(所持: lamp, screwdriver, matchbook, garlic, torch) save
d, n, e, e, s, s, rub mirror                 … Mirror Room(南) → (北)
n, w, n, w, n, take jade                      … Bat Room（garlic があれば bat は無害）
e, put torch in basket, put screwdriver in basket, turn on lamp   … Shaft Room
n, d, take bracelet                           … Smelly Room → Gas Room
e, ne, se, sw, d, d, s, take coal             … Coal Mine → Ladder Top → Ladder Bottom → Dead End
n, u, u, n, e, s, n, up, s                    … Gas Room → Smelly Room → Shaft Room
put coal in basket, lower basket              … jade・bracelet は入らない。drop して床に置く
n, d, e, ne, se, sw, d, d, w                  … Timber Room
drop lamp, drop garlic, drop matchbook, w     … Drafty Room (Lower Shaft)。スコア +13 → 314
take coal, take screwdriver, take torch, s    … Machine Room
open lid, put coal in machine, close lid, turn switch with screwdriver, open lid, take diamond
n, put diamond in basket, put torch in basket, drop screwdriver, raise basket
e, take lamp, take garlic                     … Timber Room
e, up, up, n, e, s, n, up, s                  … Shaft Room
take diamond, take torch, take jade, take bracelet, turn off lamp
w, s, e, s, down, up                          … Bat Room → … → Slide Room → Cellar → Living Room
put diamond in case, put jade in case, put bracelet in case, put torch in case
```
最後の収納で **「Look to your treasures for the final secret.」** と表示され 350 点になる。

### フェーズ K: エンディング
```
score                                    … 350 を確認
e, e, s, w, sw                           … Kitchen → Behind House → South of House → West of House → Stone Barrow
west                                     … Inside the Barrow でエンディング
```
West of House で「A secret path leads southwest into the forest.」と表示されていれば開通している。
エンディング後は RESTART / RESTORE / QUIT の選択画面になる。

350 に届かない場合は、(a) 容器の中に入れたままの宝物、(b) 未回収の盗品、(c) 未訪問の得点部屋、(d) 死亡による -10 点を確認する。

---

## 8. Python 版（`out/zork1/zork1.py`）を直接プレイする際の注意

- 実行は `out/zork1` ディレクトリで `python zork1.py`（または `python -u zork1.py`）を起動し、プロンプト `>` に対して 1 行ずつコマンドを入力する。最初からやり直す場合はゲーム内で `restart` と入力する。
- `save` / `restore` はゲーム内コマンドとして使える。保存先はカレントディレクトリ（`out/zork1`）の `zork1.sav` の 1 スロットのみ。上書きされるので、**安全な状態でだけ** save する（死亡後や詰み状態で save しない）。
- すべてのコマンドがターンを消費する。lamp が点いている間の無駄な `look` や `inventory` は電池を減らす。
- 曖昧さの質問（"Which ... do you mean?"）には次のプロンプトで対象を答える。
- Loud Room の入力ループ中は `echo` / `w` / `e` / `u` / `save` / `restore` / `quit` 以外は反復表示されるだけ（Python 版 `LOUD_ROOM_FCN` でも同じ実装）。
- 乱数要素: troll 戦、thief 戦、thief の出没、Tiny Cave の風、bat の行き先。結果が悪ければ restore して再試行する。

---

## 9. 参照したソース

| 内容 | ZIL | Python |
|---|---|---|
| 部屋・オブジェクト定義、得点、初期配置 | `zork1/1dungeon.zil` | `out/zork1/_1dungeon.py` |
| パズル・NPC・戦闘・死亡処理 | `zork1/1actions.zil` | `out/zork1/_1actions.py` |
| 動詞、スコア更新、勝利フラグ、所持制限 | `zork1/gverbs.zil` | `out/zork1/gverbs.py` |
| セーブ・乱数 | — | `out/zork1/ZilRuntime.py` |

主なルーチン: `SCORE-UPD` / `OTVAL-FROB`（得点）、`JIGS-UP`（死亡）、`I-THIEF` / `DEPOSIT-BOOTY`（泥棒と egg）、`LLD-ROOM`（儀式）、`BOLT-F` / `BUTTON-F` / `I-REMPTY`（ダム）、`LOUD-ROOM-FCN`、`CYCLOPS-FCN` / `V-ODYSSEUS`、`BOOM-ROOM` / `NO-OBJS` / `MSWITCH-FUNCTION`（炭鉱）、`RBOAT-FUNCTION` / `I-RIVER`（川）、`SAND-FUNCTION`、`SCEPTRE-FUNCTION`、`CANARY-OBJECT`、`STONE-BARROW-FCN`（エンディング）。
