# Zork III ゲームプレイ解説（LLM 攻略用リファレンス）

対象: `out/zork3/`（Infocom ZORK III: The Dungeon Master, Release 88 / 840726 を ZilPy で Python に変換したもの。`out/zork3` ディレクトリで `python zork3.py` により直接実行）。

このファイルは `_3dungeon.py` / `_3actions.py` / `gverbs.py` / `gglobals.py` / `gmain.py` の読解を元に作り、
**`out/zork3/zork3.py` を直接起動してコマンド列を流し、7/7 点でのクリア（230 手・243 手など）を確認済み**（第 7 章がその手順）。

検証の前提と限界（正直な申告）:

- 乱数の種を 8 通り変えて同じコマンド列を流した。クリアまで到達したのは 3 通り（243〜263 手）。残り 5 通りは固定のコマンド列が乱数の展開に合わなかったもの（776 年で衛兵に殺された 1、地震がまだ来ておらず博物館に入れなかった 1、影の人物に斬り殺された 1、影の人物との戦いで文面を取り違えて hood を取り損ねた 2）で、原因は第 5 章の注意点に反映してある。また、状況に応じて分岐する対話的ドライバでの `python zork3.py` 直接実行でも 7/7 点（230 手・死亡なし）でのクリアを確認している。
- プレイ中にゲーム出力とこの文書が食い違ったら、ゲーム出力を正とすること。

- 「確認済み」= 実際に動かして出力を見た内容
- 「ソース読解」= コードから読み取ったが実行はしていない内容

---

## 0. 最初に読むこと（Python 版固有の落とし穴）

### 0.1 パーサーの落とし穴（確認済み）

| やりたいこと | 通らない書き方 | 通る書き方 |
|---|---|---|
| Dungeon Master に命令する | `master, stay` / `master, turn dial to 1`（`That sentence isn't one I recognize.` / `There were too many nouns`） | `tell master to stay` / `tell master to turn dial to 1` / `tell master to push button` |
| 合言葉で Dungeon Entrance へ飛ぶ | `say "frotz ozmoo"`（`Talking to yourself is a sign of impending mental collapse.`） | `say then frotz ozmoo` |
| Technology Museum でタイムマシンに乗る | `enter machine`（機械が 3 台あり `Which machine do you mean` と聞き返される） | `enter gold machine` / `get out of gold machine` |
| Jewel Room の扉 | — | `open stone door` |
| Technology Museum の扉 | — | `open wooden door` |

`tell master "..."` の形も通らない（`Please consult your manual`）。

### 0.2 その他の実プレイ上の教訓（確認済み）

- **8 個以上持つと `take` が確率で失敗する**（`You're holding too many things already!`）。身に着けている物も数に入る。所持数が 7 を超えた状態での `take` は「所持数 × 8%」で失敗。実際に Royal Puzzle の中で `take book` が失敗し、`take all` で hood を取り損ねた。最後に必要な品は 7 個 + 明かり 1 個なので、**不要品（lamp・sword・repellent・vial・warning note）は持ち歩かない**。
- **`wait` は 1 回で 3 ターン進む**（途中で何か起きるとそこで止まる）。地震のタイマーがあるので序盤は無駄に `wait` しない。
- **`take all` は危ない場面がある**。776 年の Jewel Room で `take all` すると sceptre と knife まで取ってしまい、指輪盗みが失敗扱いになる。
- `take cloak` / `take hood` / `take ring` / `take amulet` は「身に着ける」扱い。そのままで条件を満たす。
- `save` / `restore` はゲーム内コマンドとして使える。乱数で死ぬ場面が多いので 5 章の各節の「save」指示に従う。

---

## 1. ゲームの目的と勝利条件

1. **Dungeon Master と同じ格好をして** Dungeon Entrance の扉を叩く（`LOOK_LIKE_DM_p`）。
2. 中に入れてもらったら、Dungeon Master に命令して牢を回転させ、4 番の牢の青銅の扉から Treasury of Zork に入るとクリア（`NIRVANA_F` が `FINISH`）。

必要な品はちょうど 7 個。**どれか 1 個でも永久に失うとクリア不能**。

| 品 | 入手場所 | 失う原因（絶対に避ける） |
|---|---|---|
| golden amulet | 湖の底（Underwater）の shiny object | — |
| strange key | Key Room | 地震の前に Key Room から水道橋を渡りきらないと戻れない |
| wooden staff | Cliff の男に助けてもらう | 男を無視する／ロープを掴まない／男を剣で攻撃する（折れる）／崖から投げる（折れる）／torch で燃やす（即死） |
| hood | Land of Shadow の影の人物から剥ぎ取る | 影の人物を殺してしまう |
| cloak | 同上（hood を取ると地面に残る） | 同上 |
| golden ring | 776 年の Jewel Room から盗み、タイムマシンの座席の下に隠して持ち帰る | 手順を外すと `clumsy robbery` 扱いでタイムマシンが消える |
| very ancient book (lore book) | Royal Puzzle の中 | slot に入れる（没収）／燃やす |

加えて、秘密の扉を見つけるために **waybread**（Cliff）を Engravings Room の老人に渡す必要がある。

### 絶対に守るべきこと

| 事項 | 理由 |
|---|---|
| **序盤 70 ターン以内に Key Room → 水道橋 → Damp Passage を済ませる** | 最初のコマンドから 71〜140 ターン目に地震が起き、High Arch と Water Slide の間が崩れる。Key Room 側に取り残されると戻れない（repellent は 1 回分しかない） |
| **影の人物が `badly hurt and defenseless` になったら攻撃をやめて `take hood`** | もう一撃当てると 85% で死に、hood と cloak が永久に失われる |
| **lamp・torch・waybread を持って湖に入らない** | 身に着けていない物は全部湖底に落ちる。lamp と torch は壊れ、waybread は消える |
| **Scenic Vista の表示が `IV` の時に table に触らない** | Sacrificial Altar に飛ばされて即死 |
| **Guardians（石像）の居る Hallway に歩いて入らない** | 即死。鏡の箱に乗って通る |
| **Dungeon Master を攻撃しない** | 復活なしの死（ゲーム終了） |
| **タイムマシンのダイヤルは 776 と 948 以外に合わせてボタンを押さない** | 776 未満は岩に埋まって死亡、それ以外の過去は衛兵に殺される（どちらも復活なし） |
| **lore book を Royal Puzzle の slot に入れない** | 扉は開くが本は没収される |
| **torch を消さない** | `turn off torch` で消すと二度と点けられない |

---

## 2. 得点の内訳（合計 7・確認済み）

得点表示は `Your potential is N of a possible 7`。勝利条件ではないが、下の手順どおりなら自然に 7 になる。

| 条件 | 点 |
|---|---:|
| 湖に入る（On the Lake に初めて入る） | 1 |
| Scenic Vista の table に初めて触る | 1 |
| Cliff Ledge に初めて降りる | 1 |
| 影の人物が初めて現れる | 1 |
| 影の人物を剣で初めて攻撃する | 1 |
| ダイヤルを 776 に合わせてタイムマシンのボタンを押す | 1 |
| Royal Puzzle で初めて壁を押す | 1 |

---

## 3. 基本システム

### 明かり

- **lamp**: 点灯中だけ消耗。合計 650 ターン（ソース読解）。序盤に湖岸まで歩く 4 手にしか使わない。
- **torch**（Scenic Vista の壁）: 時間切れが無い永久光源（ソース読解、実走でも最後まで点いていた）。**入手後は torch だけで足りる。lamp は Lake Shore に置き捨ててよい。**
- 暗い部屋: Junction、Barren Area、Hairpin Loop、Creepy Crawl、Tight Squeeze、Foggy Room、Land of Shadow 全域、Damp Passage、Dead End、Engravings Room、Royal Hall、Great Door、Dark Place ×2、Room 8、Timber Room。
- 常に明るい部屋: Endless Stair、Cliff / Cliff Ledge / Cliff Base、Flathead Ocean、湖の周辺（Lake Shore、On the Lake、Underwater、Western Shore、Southern Shore、Aqueduct View）、Scenic Vista、Key Room、水道橋 3 部屋、Crystal Grotto、博物館一帯、Royal Puzzle、Button Room から先の終盤全域。
- 暗闇から暗闇への移動は 80% で grue に食われる。
- **grue repellent**（Room 8）: `spray repellent on me` で 5 ターンだけ grue を避けられる。**1 回しか使えない**。Dark Place を抜けるための専用品。

### 地震（確認済み）

最初のコマンドを打った時点でタイマーが始まり、**71〜140 ターン目**に `There is a great tremor from within the earth.` と出る（`wait` は 3 ターン分数える）。実走では 95〜136 手目に起きた。

| 地震の前 | 地震の後 |
|---|---|
| 水道橋（High Arch ↔ Water Slide）を渡れる | 崩れて渡れない |
| Great Door の東（博物館）に入れない（`The great iron door is rusted shut.`） | 裂け目ができて入れる |

したがって順番は「湖・鍵・水道橋 → 崖・影の人物・老人 →（地震を待って）博物館」になる。
Great Door で `rusted shut` と言われたら、まだ地震が来ていないだけなので `wait` する。

### 所持品

- 重さの上限は合計 100。sword 25、chest 40、sceptre 30、knife 20、lamp 15、staff 10、key 10、ring 5、book 4、bread 3、その他 5。
- 個数は 0.2 のとおり 7 個以下を保つ。

### 死んだとき（ソース読解）

- 通常の死: Endless Stair に戻される。持ち物（身に着けた物も）は Junction / Barren Area / Damp Passage / Creepy Crawl / Tight Squeeze / Foggy Room / Dead End にばらまかれ、lamp は Endless Stair に戻る。**4 回目の死でゲーム終了。**
- 崖の男・タイムマシンなどの進行中のイベントは打ち切られるので、場面によってはクリア不能になる。**死んだら `restore` する。**
- 復活なしの死: 過去の衛兵、Flathead、ダイヤル 776 未満、Dungeon Master への攻撃。

### 剣

Junction の岩に刺さっていて取れない（`take sword` は無駄）。影の人物が現れた瞬間に勝手に手の中に飛んでくる。
用が済んだら `drop sword` で捨てる（影の人物が居る間は捨てても手に戻ってくる）。

---

## 4. マップ（確認済みの接続。※印はソース読解）

### 中央部

```
Endless Stair (lamp)
  S: Junction（岩に刺さった剣）
Junction  N: Endless Stair / W: Barren Area / S: Creepy Crawl / E: Damp Passage
Barren Area  E: Junction / W: Cliff / SW: Land of Shadow(北東の区画) / NW: Hairpin Loop※
Hairpin Loop※  SE,U: Barren Area / SW,D: Cliff Base
Creepy Crawl  N: Junction / S: Foggy Room / E: Tight Squeeze / SW: Land of Shadow(東端)※
Foggy Room  N: Creepy Crawl / S: Lake Shore / W: Land of Shadow(東端)※
Tight Squeeze  W: Creepy Crawl / E: Crystal Grotto
Crystal Grotto  W: Tight Squeeze / S: Royal Hall
Royal Hall  N: Crystal Grotto / S: Great Door
Great Door  N: Royal Hall / E: Museum Entrance（地震の後のみ）
Damp Passage  W: Junction / E: Dead End / NE: Engravings Room（S,U,N は不可）
Dead End  W: Damp Passage / NW: Engravings Room
Engravings Room  SW: Damp Passage / SE: Dead End / N,D: Button Room（秘密の扉を開けた後）
```

### 崖

```
Cliff (waybread、木に結ばれたロープ)
  E: Barren Area / SW: Land of Shadow(崖の上の区画) / D: Cliff Ledge
Cliff Ledge (chest)  D: Cliff Base（一方通行。上へは男に引き上げてもらうしかない）
Cliff Base※  NE: Hairpin Loop / S: Flathead Ocean
```

### Land of Shadow と海

8 区画が互いに斜めにも繋がった平原。迷っても致命的ではない。確認した経路だけ記す。

```
Cliff --SW--> Land of Shadow(崖の上。「standing atop a steep cliff」)  N: Cliff / W,SW,D: Flathead Ocean
Flathead Ocean  E: Land of Shadow(「To the west, the land dips sharply」) --NE--> Land of Shadow(北に石壁) --N--> Barren Area
Flathead Ocean  N: Cliff Base※
```

南端の区画は流砂に囲まれている。`enter quicksand` は即死※。

### 湖

```
Lake Shore  N: Foggy Room / SE,D: Aqueduct View※（眺めるだけ） / enter lake: On the Lake
On the Lake  N: Lake Shore / W: Western Shore / S: Southern Shore / D: Underwater
Underwater  U: On the Lake
Western Shore  S: Scenic Vista (torch、table) / enter lake
Southern Shore  S,U: Dark Place(1) / enter lake
Dark Place(1)  N,D: Southern Shore / S,U: Dark Place(2)
Dark Place(2)  N,D: Dark Place(1) / E,U: Key Room
Key Room (key、manhole cover)  W: Dark Place(2) / D: Aqueduct（cover を動かした後）
Aqueduct  N: High Arch（上へは戻れない）
High Arch  S: Aqueduct / N: Water Slide（地震の前のみ）
Water Slide  N,D: Damp Passage（一方通行）
```

### 博物館

```
Museum Entrance  W: Great Door / N: Technology Museum(木の扉) / E: Jewel Room(石の扉) / S,D: Royal Puzzle Entrance
Technology Museum (gold machine = タイムマシン、grey machine、black machine)
Jewel Room (檻の中に sceptre、knife、ring)
Royal Puzzle Entrance (warning note)  N,U: Museum Entrance / W: Side Room / D: Royal Puzzle（穴に飛び降りる）
Side Room  N: Royal Puzzle Entrance / E: 鋼鉄の扉（パズルの中から本を払わないと開かない）
```

### 終盤

```
Engravings Room --N--> Button Room (赤いボタン) --N--> Beam Room (赤い光線)
  --N--> Hallway A --N--> Hallway B (鏡の箱の初期位置) --N--> Hallway C
  --N--> Hallway G (Guardians。歩いて入ると即死) --N--> Hallway D --N--> Dungeon Entrance
Dungeon Entrance --(扉)--> Narrow Corridor --N--> South Corridor
South Corridor  E: East Corridor / W: West Corridor※
East Corridor / West Corridor  N: North Corridor / S: South Corridor
North Corridor  N: Parapet (sundial、button) / S: Prison Cell(扉)
```

Hallway は全部同じ名前で表示される。A〜D・G はこの文書での呼び名（ソースの `MRA`〜`MRD`・`MRG`）。

---

## 5. 各パズルの詳細

### 5.1 湖・Scenic Vista・Key Room（最優先。確認済み）

**目的**: amulet、torch、repellent、key を取り、地震の前に Damp Passage へ抜ける。実走では 46 手。

**湖の規則**（ソース読解 + 実走）

- `enter lake` で、身に着けていない持ち物は全部 Underwater に落ちる。
- 水面・水中に合計 8 ターン居ると溺死（4 ターン目と 6 ターン目に警告）。岸に上がるとリセットされる。
- 水中は 3 ターンで息が切れて勝手に水面へ戻る。
- 水面では毎ターン 10% で roc が襲来を予告し、2 ターン後にまだ水面に居ると食われる。予告を見たら岸に上がるか潜る。
- 水中では毎ターン 4% で魚に食われる（防げない）。
- 水中での `take` は 30% で取り落とす。`take amulet` は 50% で成功。
- **湖に入る前に毎回 `save`。**

**Scenic Vista の table**（確認済み）

- 表示は 4 ターンごとに I → II → III → IV → I と変わる（ゲーム開始時から回り続けている）。`examine indicator` で確認できる。
- `touch table` でその番号の場所へ飛び、**触った後 2 回行動した時点で自動的に Scenic Vista に戻る**。物を持って行き来できる。

| 表示 | 行き先 | 用途 |
|---|---|---|
| I | Timber Room（Zork I の炭鉱） | 用なし※ |
| II | Room 8（Zork II） | **grue repellent を取る**。暗い部屋なので torch を持って行く |
| III | Damp Passage | **torch を置いてくる**（後で水道橋から滑り降りた先の明かりになる） |
| IV | Sacrificial Altar | **即死。触らない** |

**必ず II（repellent）を先、III（torch を置く）を後にする。** 逆だと Room 8 が暗くて repellent を取れない。

**手順**

1. Endless Stair で `take lamp`、`turn on lamp`、`s`、`s`、`s`、`s` で Lake Shore。`drop lamp`（もう使わない）。
2. `save`。`enter lake`、`d`、`take amulet`（成功するまで。息が切れて浮いたら `d` で潜り直す。8 ターンに注意）、`w` で Western Shore。
3. `s` で Scenic Vista。`take torch`。
4. `examine indicator` で `II` になるのを待つ → `touch table` → `take can` → もう 1 手（`look` など）で戻される。
5. `III` になるのを待つ → `touch table` → `drop torch` → もう 1 手で戻される。
6. `n` で Western Shore。`save`。`enter lake`（repellent が湖底に落ちる）、`d`、`take can`（成功するまで）、`u`、`s` で Southern Shore。
7. `spray repellent on me`、すぐ `s`、`s`、`e` で Key Room（効果は 5 ターン。実走では Key Room で `take key` した時に切れた）。
8. `take key`、`move cover`、`d`、`n`、`n`、`n` で Damp Passage。`take torch`。repellent の空き缶は `drop can` で捨てる。

この時点の持ち物: torch、key、amulet（着用）。得点 2。

### 5.2 崖の男と staff（確認済み）

1. Damp Passage から `w`、`w`、`w` で Cliff。`take bread`。
2. `d` で Cliff Ledge（chest がある。得点 +1）。
3. `wait` を繰り返すと 5 ターン後に男が崖の上に現れる（`a man appears`）。
4. `tie rope to chest`。男が chest を引き上げて一度去る。
5. `wait` を繰り返すと 10 ターン後に戻ってくる（`grab onto the rope`）。
6. `take rope`。引き上げられ、**wooden staff** を渡される。空の chest は放っておく。

注意（ソース読解）:

- 男が現れてから 10 ターン放置すると去り、戻ってきてからも 4 ターン掴まないと去る。どちらも staff が手に入らなくなる。**男が現れたらすぐ結び、戻ってきたらすぐ掴む。**
- 男が戻る前に Cliff Ledge を離れない（Cliff Base へ降りると戻れない）。
- chest は開かない。key も合わない。持って降りる意味はない。
- 崖の上で男を `attack` しない（staff が折れる）。

### 5.3 影の人物と hood・cloak（確認済み）

1. Cliff から `sw` で Land of Shadow。**明かり（torch）を持っていること**（暗いと現れない）。
2. `look` などで時間を進めると、`a cloaked and hooded figure appears before you` と出て影の人物が現れる（得点 +1）。同時に剣が手の中に飛んでくる。実走では数手〜30 手ほどかかった。`You can hear quiet footsteps nearby.` は予兆。
3. **現れたら間を置かずに `attack figure with sword` を繰り返す**（初回で得点 +1）。放っておくと相手から斬ってくる。実際に、相手が居るのに `look` を続けていて殺された。
4. 相手の状態は攻撃が当たるたびに表示される。

   | 表示 | 相手の体力 | 行動 |
   |---|---:|---|
   | `has a great deal of strength` | 5 | 攻撃 |
   | `has a light wound` | 4 | 攻撃 |
   | `has some wounds and is probably not capable of hindering your movement` | 3 | 攻撃 |
   | `is hurt, and its strength appears to be fading` | 2 | 攻撃（ここからの一撃で死ぬことはない） |
   | **`appears to be badly hurt and defenseless`** | 1 | **攻撃をやめて `take hood`** |

5. `take hood`（相手が消え、cloak が地面に残る）→ `take cloak` → `drop sword`。

注意:

- `Although you are defenseless, the figure reaches for your sword and hands it back to you` は**自分が**体力 1 まで落ちたという意味。相手の `defenseless` と取り違えない（テスト用スクリプトはこれを取り違えて失敗した）。
- 自分の体力は `diagnose` で分かる。体力 1 だと相手の強打（低確率）で死ぬ。危なければ塞がれていない方向へ部屋を出る。両者とも 10 ターンごとに 1 回復する。相手は体力 4 以上に戻るまで再登場しない。
- 相手の体力が 2 以下だと `take hood` は `strong enough to force you back` などで失敗する。1 になるまで待つ。
- **戦う前に `save`。**

### 5.4 海の船乗りと vial（確認済み・任意）

Flathead Ocean（Land of Shadow の西）で `look` を繰り返すと、毎ターン 20% で Viking ship が通る。
出たら**次の 1 手で** `hello sailor` と言うと vial を投げてくれる（`take vial`）。船は 2 ターンで去り、二度と来ない。

vial の中身（透明な液体）を飲むと 3 ターンだけ透明になり、Guardians の脇を歩いて抜けられる（ソース読解・未検証）。
この文書の手順は鏡の箱で Guardians を抜けるので **vial は不要**。得点にも関係ない。

### 5.5 老人と秘密の扉（確認済み）

1. waybread を持って Engravings Room へ（Damp Passage の `ne`）。
2. 部屋に入るたびに 30% で老人が隅で眠っている（`An old and wizened man is huddled, asleep`）。居なければ `se`（Dead End）と `nw` を往復して入り直す。実走では 5〜6 回目で現れた。
3. `wake old man` → 次の手で `give bread to old man`（起こしてから 3 ターンでまた眠る）。
4. 老人が北の壁を指して消える。`open secret door`。

老人を攻撃すると消えて二度と現れない。博物館へ行く前に済ませておくと、持ち物が 1 個減る。

### 5.6 タイムマシンと ring（確認済み）

地震の後、Great Door の `e` で Museum Entrance に入れる。

**仕組み**（ソース読解）

- gold machine（Temporizer）は押して動かせる。乗ってダイヤルを合わせてボタンを押すと、**今居る部屋の**その年へ飛ぶ。
- 時間移動すると、持ち物と機械の中の物は全部「出発した時代の部屋」に置き去りになる。**例外は座席の下に隠した ring だけ。**
- 776 年（博物館の建設中）は ring が檻に入っていない。ただし Jewel Room の石の扉は Museum Entrance 側からは開かないので、**現代で機械を Jewel Room まで押して行き、そこから 776 年へ飛ぶ**。
- 776 年では機械は Technology Museum に在る（機械だけ元の展示場所に現れる）。そこまで歩いて ring を座席の下に隠し、948 年へ戻る。
- 戻る時に「ring が隠されている・機械が Technology Museum に在る・sceptre と knife が台座に残っている」の 3 つが揃っていれば成功。揃っていないと `clumsy robbery` 扱いで機械が消える。
- 過去に居られるのは 40 ターン。過ぎると強制的に現代へ戻される。
- 機械を階段（Royal Puzzle Entrance）や裂け目（Great Door）へ押すと壊れる。

**手順**

1. Museum Entrance から `n` で Technology Museum。`push gold machine south`、`open stone door`、`push gold machine east` で Jewel Room。
2. **`save`**。`drop all`（どうせ置き去りになる）。
3. `turn dial to 776`、`enter gold machine`、`push button`（得点 +1）。776 年の Jewel Room に立っている。扉の外に衛兵が居る。
4. **`wait` を繰り返して** `You hear, from outside the door, guards marching away` を待つ（4〜15 ターン）。
   衛兵が居る間は **1 コマンドにつき 3%** で見つかって殺される（復活なし）。`wait` なら 1 コマンドで 3 ターン進むので最も安全。実走でも 8 回中 1 回ここで殺された。
5. `take ring`（**`take all` は不可**）、`open stone door`、`w`、`open wooden door`、`n`。
6. `put ring under seat`、`enter gold machine`、`turn dial to 948`、`push button`。
7. `look under seat`（ring が指にはまる）、`get out of gold machine`。
8. `open wooden door`、`s`、`open stone door`、`e`、`take all` で置いていった物を回収する。

現代の Jewel Room に機械を置いている間、毎ターン 4% で掃除ロボットが機械を Technology Museum に戻してしまう（ソース読解）。そうなったら押し直す。

### 5.7 Royal Puzzle と lore book（確認済み）

Royal Puzzle Entrance の穴に `d` で飛び降りると、6×6 のマス目の左上（マス 1）に落ちる。
砂岩の壁（SS）は押すと 1 マス動く。大理石の壁（MM）は動かない。斜め移動は、隣り合う 2 マスのどちらかが空いていれば可能。

初期配置（`.` = 空き、`S` = 砂岩、`M` = 大理石、`L` = 西面に梯子の付いた砂岩、`l` = 東面に梯子の付いた砂岩）:

```
      列1 列2 列3 列4 列5 列6
行1    @   S   .   .   S   .        @ = マス 1（天井に入口の穴）
行2    S   .   M   .   L   .
行3    .   .   .   .   M   .
行4    l   .   .   S*  S   .        S* = マス 22。この砂岩の下に lore book
行5    .   .   S   .   .   .
行6    M   M   D   .   .   M        D = マス 33（西の壁に鋼鉄の扉と slot）
```

**脱出条件**: 梯子付きの砂岩 `L` をマス 2（入口のすぐ東）まで運び、マス 1 で `u`。
slot に本を入れれば鋼鉄の扉からも出られるが、本を失うので使わない。

**入る前に Royal Puzzle Entrance で `drop all`**（中は明るい。持ち物が多いと `take book` が失敗する）。

解（探索プログラムで求め、実機で確認。37 手 + `u`）:

```
d
push south wall
n
push east wall
s
se
ne
n
push east wall
sw
s
push south wall        ← マス 22 に入る。「Nestled inside the niche is an old and dusty book.」
take book              ← 「Taken.」を必ず確認する
push south wall
push west wall
s
push east wall
ne
ne
n
n
push west wall
nw
push south wall
push south wall
push south wall
push east wall
s
push west wall
sw
push north wall
push north wall
ne
push west wall
sw
push north wall
push north wall
nw                     ← 「In the ceiling above you is a large circular opening.」「There is a ladder here, firmly attached to the east wall.」
u                      ← 「With the help of the ladder, you exit the puzzle.」
```

- 1 手でも表示が違ったら、そこで止めて `restore` する（壁の配置がずれると解が成り立たない）。**入る前に `save`。**
- 最初の `push south wall` で得点 +1。
- マス 1 に壁を押し込むと入口が塞がる。
- 出たら `take all` ではなく 1 個ずつ `take` して、取り損ねが無いか `i` で確かめる。warning note は取らない。

### 5.8 鏡の箱で Guardians を抜ける（確認済み）

Button Room の北の長い廊下には、Hallway B に「鏡の箱」が置かれている。中に入って箱ごと北へ滑らせ、Guardians の間を通り抜ける。

1. Beam Room で何か 1 個を床に置いて赤い光線を遮る。**torch でよい**（`drop torch` → `You conveniently drop the torch in position to block the beam of light.`）。この先は全部明るい。
2. `s` で Button Room、`push red button`（`Click. Snap!` なら成功。`Click.` だけなら光線が遮られていない）。
3. 鏡が開いているのは 7 ターン。`n`、`n`（Hallway A）、`n` で Inside Mirror。
4. 箱の中の操作:

```
raise short pole          ← 短い棒を上げると回転できる
push red panel            ← 時計回りに 45°。矢印が northwest
push red panel            ← 矢印が north
lower short pole          ← 棒を溝に下ろす（下ろさずに Guardians の間に入ると死ぬ）
push mahogany panel       ← 北へ 1 部屋（Hallway C）
push mahogany panel       ← Hallway G（Guardians の間。ここでは何もしない）
push mahogany panel       ← Hallway D
raise short pole
push red panel            ← northeast
push red panel            ← east
push red panel            ← southeast
push red panel            ← south
lower short pole
push pine panel           ← 松の板が開く（5 ターンで閉じる）
n                         ← Dungeon Entrance
```

規則（ソース読解）:

- red / yellow のパネルを押すと時計回り、black / white は反時計回りに 45° 回る。回転は短い棒が上がっている時だけ。
- 矢印が north の時に mahogany を押すと北へ、south の時は南へ滑る。
- pine を押すと出口が開く。出られる方向は矢印の反対側（矢印 south なら北へ出る）。
- **Hallway G で死ぬ条件**: 回転させる／pine を開ける／短い棒が上がったまま入る／鏡を割ってある／入口の鏡が開いたまま入る。
- Hallway D で矢印が north のまま pine を開けても死ぬ（Guardians の視界に入る）。必ず south まで回してから開ける。

### 5.9 Dungeon Master と最後の牢（確認済み）

1. Dungeon Entrance で 7 品（hood、cloak、amulet、ring を着用、staff、key、book を所持）が揃っているか `i` で確かめ、`knock on door`。
   揃っていれば Dungeon Master が扉を開け、Narrow Corridor に入る。以後は彼がついてくる。
2. `n`（South Corridor）、`e`（East Corridor）、`n`（North Corridor）、`n`（Parapet）。
3. Parapet で `tell master to stay`、`turn dial to 4`、`push button`。4 番の牢（南に青銅の扉がある唯一の牢）が正面に来る。
4. `s`、`open cell door`、`s` で Prison Cell に入る（`Behind you, to the south, is a bronze door` と出る）。
5. `tell master to turn dial to 1`、`tell master to push button`。牢が自分ごと回って奥へ移動し、木の扉は固く閉まる。
6. `unlock bronze door with key`、`open bronze door`、`s` で Treasury of Zork。クリア。

補足:

- 牢は 8 個が火の穴を囲んで並んでいて、ダイヤルの番号の牢がボタンで正面に来る。4 番の牢に自分が入った状態で別の番号に回してもらうと、青銅の扉が開けられる位置（Treasury の前）に来る。本を `read` するとこの絵が見える（ソース読解）。
- 5 のダイヤルは 4 以外なら何でもよい※。
- Dungeon Master は牢には入らない。自分で Parapet のボタンを押しても、自分が牢の外に居るので意味がない。
- **品が足りないまま `knock on door` すると**、足りない度合いに応じた台詞を言われて Button Room に戻される（実害なし）。足りない品を揃えたら、**Engravings Room で `say then frotz ozmoo`** と言えば Dungeon Entrance に直接飛べる（確認済み。一度 Dungeon Entrance に来た後でのみ有効）。鏡の箱は北の端に行ったままなので、歩いては戻れない。

---

## 6. 危険の一覧

| 場所・行動 | 結果 | 対処 |
|---|---|---|
| 暗闇から暗闇へ移動 | 80% で死亡 | torch を常に持つ |
| 湖に 8 ターン | 溺死 | 5.1 |
| 湖面の roc、水中の魚 | 死亡 | `save` してから入る |
| Scenic Vista の `IV` | 即死 | 表示を必ず確かめてから触る |
| 地震の後に Key Room 側に居る | 詰み | 5.1 を最優先で済ませる |
| Cliff で `jump`、Land of Shadow の流砂、水道橋で `jump` | 死亡 | やらない |
| 影の人物を放置／殺す | 自分が死ぬ／hood・cloak を失う | 5.3 |
| 776 年で衛兵が居る間にコマンドを重ねる | 3%/コマンドで死亡（復活なし） | `wait` で待つ |
| 776・948 以外の年へ飛ぶ | 死亡（復活なし） | やらない |
| 776 年の Jewel Room で扉を開ける（衛兵が居る間） | メッセージだけで無害 | — |
| Guardians の Hallway に歩いて入る | 即死 | 5.8 |
| staff を torch で `burn`、木を `burn`、repellent を `burn` | 即死 | やらない |
| Dungeon Master を攻撃 | 死亡（復活なし） | やらない |

---

## 7. 確認済みの通し手順（7/7 点・243 手）

乱数で展開が変わる箇所は「…まで繰り返す」と書いてある。**その都度ゲーム出力を読んで次の手を決めること。** 固定のコマンド列をそのまま流すと、8 回中 5 回は途中で噛み合わなくなった。

### フェーズ A: 湖・鍵・水道橋（地震の前に終える。実走 46 手）

```
take lamp
turn on lamp
s
s
s
s                         Lake Shore
drop lamp
save
enter lake
d
take amulet               成功するまで（5.1）
w                         Western Shore（水中なら先に u）
s                         Scenic Vista
take torch
examine indicator         II になるまで繰り返す
touch table               Room 8
take can
look                      Scenic Vista に戻される
examine indicator         III になるまで繰り返す
touch table               Damp Passage
drop torch
look                      Scenic Vista に戻される
n
save
enter lake
d
take can                  成功するまで
u
s                         Southern Shore
spray repellent on me
s
s
e                         Key Room
take key
move cover
d
n
n
n                         Damp Passage
drop can
take torch
```

### フェーズ B: 崖・影の人物（実走 ここまで約 95 手）

```
w
w
w                         Cliff
take bread
d                         Cliff Ledge
wait                      「a man appears」まで繰り返す
tie rope to chest
wait                      「grab onto the rope」まで繰り返す
take rope                 Cliff に引き上げられ staff を受け取る
save
sw                        Land of Shadow
look                      「a cloaked and hooded figure appears」まで繰り返す
attack figure with sword  「appears to be badly hurt and defenseless」まで繰り返す
take hood
take cloak
drop sword
```

### フェーズ C: 老人

```
n                         Cliff
e
e                         Junction
e                         Damp Passage
ne                        Engravings Room（老人が居なければ se / nw を繰り返す）
wake old man
give bread to old man
open secret door
```

### フェーズ D: 博物館（地震の後）

```
sw
w                         Junction
s
e
e                         Crystal Grotto
s
s                         Great Door（「rusted shut」なら地震がまだ。wait する）
e                         Museum Entrance
n                         Technology Museum
push gold machine south
open stone door
push gold machine east    Jewel Room
save
drop all
turn dial to 776
enter gold machine
push button
wait                      「guards marching away」まで繰り返す
take ring
open stone door
w
open wooden door
n
put ring under seat
enter gold machine
turn dial to 948
push button
look under seat
get out of gold machine
open wooden door
s
open stone door
e                         Jewel Room
take all                  torch、key、staff、hood、cloak、amulet を回収
w
s                         Royal Puzzle Entrance
drop all
save
（5.7 の 39 コマンド）
take ring                 以下 1 個ずつ。warning note は取らない
take amulet
take hood
take cloak
take staff
take key
take torch
i                         book、ring、amulet、hood、cloak、staff、key、torch の 8 個
```

### フェーズ E: 終盤

```
n                         Museum Entrance
w
n
n                         Crystal Grotto
w
w                         Creepy Crawl
n                         Junction
e
ne                        Engravings Room
n                         Button Room
n                         Beam Room
drop torch
s
push red button           「Click. Snap!」
n
n
n                         Inside Mirror
（5.8 の箱の操作 15 コマンド。最後の n で Dungeon Entrance）
i                         7 品を確認
save
knock on door             Narrow Corridor
n
e
n
n                         Parapet
tell master to stay
turn dial to 4
push button
s
open cell door
s                         Prison Cell
tell master to turn dial to 1
tell master to push button
unlock bronze door with key
open bronze door
s                         Treasury of Zork（クリア）
```

---

## 8. 未検証の事項

- vial の透明化で Guardians を歩いて抜ける方法（5.4）。
- Scenic Vista の `I`（Timber Room）から先。Timber Room の西は手ぶらでないと通れず、その先の Machine Room には出口も説明も定義されていない（ソース読解）。行く理由はない。
- 死亡後の復帰（3 章「死んだとき」）。
- 4 番以外の牢に入った場合の挙動。
