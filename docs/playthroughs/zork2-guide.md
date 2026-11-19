# Zork II ゲームプレイ解説（LLM 攻略用リファレンス）

対象: `out/zork2/`（Infocom ZORK II: The Wizard of Frobozz, Release 88 / 840726 を ZilPy で Python に変換したもの。`out/zork2` で `python zork2.py` を直接実行）。

このファイルは `_2dungeon.py` / `_2actions.py` / `gverbs.py` / `gparser.py` / `gclock.py` の読解を元に作り、
**Python 版を別プロセスで直接起動してコマンド列を流し、400/400 点でのクリア（324 手）を確認済み**（第 7 章がその手順）。

検証の前提と限界（正直な申告）:

- 通しの検証は **魔法使いの出現を止めた状態**（デバッグ用に `I_WIZARD` を無効化。悪魔の場面だけ再有効化）で行った。魔法使いの挙動は、有効にした別の走行での観察とソース読解による。
- 乱数が絡む箇所（回転部屋・Low Room・迷路・魔法使い）は毎回結果が変わる。
- プレイ中にゲーム出力とこの文書が食い違ったら、ゲーム出力を正とすること。

- 「確認済み」= 実際に動かして出力を見た内容
- 「ソース読解」= コードから読み取ったが実行はしていない内容

---

## 0. 最初に読むこと（Python 版固有の落とし穴・確認済み）

### 0.1 呪文を掛けられたら

呪文中は `wait` を繰り返せば切れる。ただし Float・Fall・Freeze・Filch は場所や状況によって致命的なので（3 章の表）、危ない場面の前には `save` しておく。

### 0.2 その他の実プレイ上の教訓（確認済み）

- **8 個以上持つと `take` が確率で失敗する**（`You're holding too many things already!`）。7 個を超えた状態での `take` は「所持数 × 8%」で失敗。失敗が致命的になる場面（爆破後の金庫）があるので、常に 7 個以下で動く。
- **`wait` は 1 回で 3 ターン進む**。導火線・気球・姫のタイマーがある場面で安易に `wait` しない。
- **`follow princess` は当てにならない**。1 手遅れただけで `I seem to have lost track of her.` になる。姫は固定ルートを歩くので、こちらも歩いて先回りする。
- `take crown` は「かぶる」扱い（`You are now wearing the gaudy crown.`）。そのまま `give crown to demon` できる。
- 重い物: sword 30、portrait 25、lamp 15、place mat 12、brick 9、赤球・黒球・violin・pearl・crown・coin・bills 各 10。上限は合計 100。

---

## 1. ゲームの目的と勝利条件

1. 魔法使いフロボズの杖 (wand) を手に入れ、**杖を持ったまま** Crypt の隠し扉の南 (Landing) に入るとクリア（`ZORK3_FCN` が `WON_FLAG` を立てて `FINISH`）。
2. 杖を持たずに Landing に入ると即死。
3. 得点は勝利条件ではないが、下の手順どおりに進めると自然に 400 点になる。

杖を得る唯一の現実的な方法:

1. 赤・青・透明の 3 つの水晶球を工房の台に置いて黒い球を得る
2. 黒い球を五芒星の円に置いて悪魔 (demon) を呼ぶ
3. 悪魔に宝物を 10 個渡して報酬を払う
4. 悪魔に「杖を私によこせ」と命じる

### 絶対に守るべきこと

| 事項 | 理由 |
|---|---|
| **姫を起こす前に `save`** | 姫が gazebo に着いて 6 ターン後、自分が Gazebo か North End of Garden に居ないと金の鍵が永久に失われる（`I_UNICORN`）。鍵が無いと工房の扉が開かず、クリア不能。フリーズの呪文で足止めされて失敗するのを実際に確認した |
| **悪魔への願いは「杖をよこせ」だけ** | 願いは 1 回きり。`move menhir` や `take wand`（悪魔が杖を持ち去る）に使うと杖が手に入らない |
| **宝物を小人 (gnome) に渡さない** | 悪魔に渡せる宝物はちょうど 10 個しかない（下表）。火山の小人・銀行の小人に 1 個でも渡すと 400 点に届かない |
| **死なない** | 死亡で −10 点。宝物は魔法使いの陳列棚に飛ばされ、悪魔に手渡せなくなる（1 個につき −2 点）。悪魔を呼んだ後に死ぬと復活できずゲーム終了（ソース読解） |
| **機械室のボタンを自分で押さない** | 感電死。必ずロボットに押させる |
| **flask を開けない・投げない・割らない** | 毒ガスで即死 |
| **バケツの外から水を注がない** | Circular Room でバケツの外から水を入れると、バケツだけが上がってしまい戻らない（ソース読解） |

---

## 2. 得点の内訳（合計 400・確認済み）

得点 = 宝物を初めて手にした点 + 部屋に初めて入った点 + イベント点 + 悪魔に渡した点。Zork I と違い、陳列ケースに入れる必要はない。

### 宝物（初取得点の合計 330）

| 宝物 | 場所 | 点 | 使い道 |
|---|---|---:|---|
| pearl necklace | Pearl Room（謎かけの扉の先） | 15 | 悪魔へ |
| package of candy | Pool Room の池の底 | 15 | 扉のトカゲに食べさせる（消費） |
| red crystal sphere | Dingy Closet（檻の罠） | 20 | ruby stand へ（消費） |
| fancy violin | Carousel Room の steel box（回転を止めると現れる） | 20 | 悪魔へ |
| blue crystal sphere | Dreary Room（鍵穴パズル） | 20 | sapphire stand へ（消費） |
| portrait | Bank の Chairman's Office | 20 | 悪魔へ |
| stack of zorkmid bills | Bank の Vault | 25 | 悪魔へ |
| golden dragon statuette | Dragon's Lair の chest | 20 | 悪魔へ |
| delicate gold key | 姫と一角獣から受け取る | 15 | 工房の扉を開けた後、悪魔へ |
| ruby | Lava Room | 15 | 悪魔へ |
| priceless zorkmid (coin) | 火山の Narrow Ledge | 20 | 悪魔へ |
| Flathead stamp | Library の purple book の中 | 10 | 悪魔へ |
| gaudy crown | 火山の Dusty Room の金庫 | 20 | 悪魔へ |
| clear crystal sphere | Aquarium（水槽を割る） | 20 | diamond stand へ（消費） |
| black crystal sphere | 3 球を台に置くと出現 | 30 | 五芒星の円へ（消費） |
| Wizard's magic wand | 悪魔に命じる | 30 | クリアに必須 |
| gigantic dog collar | Kennel | 15 | ケルベロスに着ける（消費） |

悪魔に渡せるのは **necklace / violin / portrait / bills / statuette / gold key / ruby / coin / stamp / crown のちょうど 10 個**。

### 部屋・イベント・悪魔

| 条件 | 点 |
|---|---:|
| 謎かけに正解する | 5 |
| Top of Well に着く | 10 |
| ドラゴンに氷河を溶かさせる | 5 |
| Wizard's Workshop に入る | 10 |
| 悪魔に宝物を渡す（1 個 2 点 × 10） | 20 |
| 迷路（Oddly-angled Room）を解く | 5 |
| Cerberus Room に入る | 10 |
| Crypt Anteroom に入る | 3 |
| Crypt に入る | 2 |
| **小計** | **70** |

330 + 70 = **400**。

悪魔の報酬判定は「手渡した数 + 魔法使いの陳列棚にある宝物の数 ≥ 10」（`GENIE_FCN` / `CASE_WORTH`）。Filch で盗まれた宝物や死亡時に飛ばされた宝物も数には入るが、手渡しの 2 点は入らない。

ランク: 400=Master Adventurer / 361+=Wizard / 321+=Master / 241+=Adventurer / 161+=Junior / 81+=Novice / 41+=Amateur。

---

## 3. 基本システム

### 明かり

- **lamp**: 点灯中だけ消耗。点灯 200 ターンで `a bit dimmer` → +300 `definitely dimmer` → +100 `nearly out` → +50 で消える。**合計 650 ターン**。
- 検証走行は 324 手で終わったが、魔法使いの呪文待ちで手数は膨らむ。明るい部屋で待つときは `turn off lamp`。
- 常に明るい部屋: Barrow〜Shallow Ford、庭園一帯（Gazebo 含む）、Tea Room / Low Room / Machine Room / Dingy Closet / Posts Room、Safety Depository、Dreary Room、Dusty Room、Wizard's Workroom / Pentagram Room / Aquarium Room。
- 暗い部屋: Dark Tunnel、Carousel Room とその周辺、ドラゴン周辺、銀行の Depository 以外、火山全体、Top of Well、Pool Room、迷路、Crypt 周辺。
- 暗闇での移動は 80% で grue に食われる。
- lamp が切れた後、得点が 200 を超えていれば魔法使いが `Fluoresce!` で常時明るくしてくれる（悪魔を呼ぶ前のみ・ソース読解）。
- 杖を得た後は `wave wand at <物>` → `say then fluoresce` でその物が永久光源になる（ソース読解）。
- grue repellent（Room 8）を自分に吹くと 8 ターンだけ grue を避けられる。必須ではない。

### 魔法使い (Wizard of Frobozz)

4 ターンごとに 10% で現れる。現れたうち 20% は何もせず去り、残りは「80% − 20% ×（所持している赤・青・透明球の数）」で呪文を掛ける。**黒い球を持っていると必ず逃げる**。悪魔を呼んだ後は二度と現れない。

呪文は 12 種。持続は 5〜35 ターン（球を持つほど短い）。75% は呪文名を言い、25% は聞き取れない。

| 呪文 | 効果 | 対処 |
|---|---|---|
| Feeble | 所持上限 50。先頭の持ち物を落とす | 落とした物を拾い直す |
| Fumble | 先頭の持ち物を落とす。`take` が失敗しやすくなる | 同上 |
| Fear | 生き物の居る部屋から勝手に逃げ出す | 切れるまで待つ |
| Filch | **持っている宝物が陳列棚へ盗まれる**。効果中に拾った宝物も消える（球・金の鍵・candy は対象外） | `restore`。宝物は持ち歩かず床に置く |
| Freeze | `wait` 以外できない | 待つ。姫の護送中なら `restore` |
| Fall | 下への出口がある部屋で動くと、橋の見える部屋なら即死、それ以外は 25% で転落死。乗り物から放り出される | 動かず待つ。気球の中なら `restore` |
| Ferment | 進む方向がランダムになる | 待つ |
| Fierce | 生き物が居ると勝手に攻撃する | ドラゴン・ケルベロスの近くでは危険。待つ |
| Float | 歩けない。**火山の空中・岩棚・Top of Well で切れると墜落死** | 該当場所なら `restore` |
| Fireproof | 害なし | — |
| Fence | 歩けない | 待つ |
| Fantasize | 幻が見える | — |

宝物を床に置いておけば魔法使いは盗まない。だから **Carousel Room を集積所にして、宝物は拾ったらすぐそこへ置く**。

### 剣

`sword` を持っていると、生き物が同じ部屋に居れば `glow very brightly`、隣の部屋に居れば `faint blue glow` と知らせる。戦闘システムは無い。使うのはドラゴンを怒らせる時と水槽を割る時だけ。

### 死んだとき（ソース読解）

Room of Red Mist に飛ばされる。`w` を 3 回で黒い霧の部屋に着き、死亡 3 回未満なら Barrow で復活する。lamp は Barrow、金の鍵・candy・3 色の球は Carousel Room、宝物は魔法使いの陳列棚、その他は Gazebo へ飛ぶ。400 点が目標なら `restore` する。

---

## 4. マップ（確認済みの接続）

### 入口〜庭園

```
Inside the Barrow (lamp, sword)
  S: Narrow Tunnel - S: Foot Bridge - S: Great Cavern - SW: Shallow Ford (水) - S: Dark Tunnel
Dark Tunnel  SE: North End of Garden / SW: Path Near Stream
North End of Garden  IN: Gazebo (teapot, place mat, newspaper, letter opener, matchbook) / S: Formal Garden
Formal Garden  W: Path Near Stream / S: Topiary
Topiary  W: Carousel Room        ← 長居すると植木の動物に殺されることがある
Path Near Stream  SW: Carousel Room / NE: Dark Tunnel / E: Formal Garden
```

### Carousel Room（中心）

| 方向 | 行き先 |
|---|---|
| N | Marble Hall（brick）→ N: Deep Ford（水）→ N/U: Ledge in Ravine |
| NE | Path Near Stream |
| E | Topiary |
| SE | Riddle Room → E: Pearl Room → E: Circular Room（井戸の底） |
| S | Menhir Room → SW: Kennel（石碑をどかす）/ S: Stairway → D: 迷路 |
| SW | Cobwebby Corridor（string）→ SW: Guarded Room → S: 工房 |
| W | Room 8（grue repellent）※回転中は絶対に行けない |
| NW | Cool Room → N: Stone Bridge → N: Dragon Room / W: Ice Room |

**回転中**（ロボットに三角ボタンを押させるまで）は、指定した方向へ行けるのは 20%。残り 80% は N/E/S/NE/SE/SW/NW からランダム。`w` は必ずランダムに振り替えられる。
外れた先から戻る方向: Marble Hall→`s`、Path Near Stream→`sw`、Topiary→`w`、Menhir Room→`n`、Cobwebby Corridor→`ne`、Cool Room→`se`。

### 北側（峡谷・ドラゴン・銀行）

```
Ledge in Ravine  U: Tiny Room (N: 扉 → Dreary Room) / W: End of Ledge / D,S: Deep Ford
End of Ledge  N: Dragon Room
Dragon Room  E: End of Ledge / W: Fresco Room / S: Stone Bridge / N: Dragon's Lair（氷河を溶かした後）
Fresco Room  W: Bank Entrance
Stone Bridge  S: Cool Room
Cool Room  SE: Carousel Room / W: Ice Room
Ice Room  U: Lava Tube / W: Lava Room（氷河を溶かした後）
Lava Tube  S: Cobwebby Corridor / U: Volcano View（眺めるだけ）
Lava Room (ruby)  S: Volcano Bottom（気球）
```

### 不思議の国（井戸の上）

```
Top of Well  E: Tea Room
Tea Room (4 つのケーキ)  NW: Low Room / W: Top of Well
Low Room (robot)  E: Machine Room / SE: Tea Room
Machine Room (3 つのボタン)  S: Dingy Closet (red sphere) / W: Low Room
Posts Room（縮んだ時の Tea Room）  E: Pool Room (flask, 池)
```

ロボットが三角ボタンを押した後、Low Room はどの方向へ出ても 50% で Machine Room、50% で Tea Room になる。

### 工房

```
Guarded Room  S: Wizard's Workshop（扉）
Wizard's Workshop  W: Wizard's Workroom / S: Trophy Room（触ると感電。用は無い）
Wizard's Workroom（3 つの台）  S: Pentagram Room / W: Aquarium Room
Aquarium Room  S: Wizard's Quarters（用は無い） / IN: 水槽の中（即死）
```

### 終盤

```
Menhir Room - S: Stairway - D: Oddly-angled Room（中央）- D: Cerberus Room - E: Crypt Anteroom - S: Crypt - S: Landing（クリア）
```

---

## 5. パズルの解法

### 5.1 謎かけ（Riddle Room）— 確認済み

答えは well。`say then well` で石の扉が開く（+5）。東が Pearl Room（necklace）、その東が井戸の底。

### 5.2 井戸とバケツ — 確認済み

- 上り: Circular Room で `get in bucket` → `pour water in bucket`。水の重さでバケツが Top of Well まで上がる（+10）。
- 下り: Top of Well で `get in bucket` → **`fill teapot with water`**。水が無くなるとバケツが下がる。
- 水は Shallow Ford か Deep Ford で `fill teapot with water`。
- バケツは自分が乗っている時しか動かない。上に着いて 100 ターン経つと水は蒸発するが、乗り直せば下がる（ソース読解）。

### 5.3 ケーキと池（Tea Room / Pool Room）— 確認済み

| ケーキ | 文字 | 効果 |
|---|---|---|
| green | Eat Me | Tea Room で食べると縮んで Posts Room へ |
| blue | Enlarge | **Posts Room で食べる**と元に戻る。他の部屋で食べると圧死 |
| red | Evaporate | 池に投げると水が蒸発して candy が現れる。食べると死ぬ |
| orange | Explode | 食べても投げても爆死 |

手順: `take red cake` → `take blue cake` → `eat green cake` → `e` → `throw red cake in pool` → `take candy` → `w` → `eat blue cake`。

- green を食べた時に Tea Room の床にある物は巨大化して持てなくなる。必要な物は持っておく。
- ケーキは不思議の国の外へ持ち出すと崩れる。
- flask は触らない（文字を読む虫眼鏡になるだけで、開けると死ぬ）。

### 5.4 ロボット — 確認済み

1. Low Room で `tell robot to go east`、自分も `e`。
2. Machine Room で `tell robot to push triangular button` → `A dull thump is heard in the distance.`（Carousel Room の回転が止まり、steel box が現れる）。
3. `tell robot to go south`、自分も `s`（Dingy Closet）。
4. `take red sphere` → 檻が落ち毒ガスが出る。**5 手以内に** `tell robot to lift cage`。
5. `take red sphere`。

- 四角ボタンは押させない（回転が速くなり、Low Room に入ると感電死する）。丸ボタンはそれを戻すだけ。
- ロボットに球を取らせると、ロボットが檻に潰されて球も失う。
- ロボットが同じ部屋に居ない状態で球に触ると助からない。

### 5.5 鍵穴の扉（Tiny Room）— 確認済み

扉の向こう側の鍵穴に鍵が刺さっている。

1. `put mat under door`
2. `open lid`
3. `put opener in keyhole` → 向こうで鍵が落ちる音
4. `take mat` → マットを引くと鍵が床に出る
5. `take key`、`take opener`（鍵穴を空ける）
6. `unlock door with key` → `open door` → `n`
7. Dreary Room で `take blue sphere`

### 5.6 銀行 — 確認済み

Safety Depository の北の「光のカーテン」をくぐった先は、**直前にどの方向へ歩いて Depository に入ったか**で決まる。

| Depository への入り方 | カーテンの先 |
|---|---|
| 東へ歩いて入る（East Teller から） | East Viewing Room |
| 西へ歩いて入る（West Teller から） | West Viewing Room |
| 北へ歩いて入る（Office から） | Small Room |
| Small Room の南壁を抜けて入る | Vault |

- portrait か bills を持っていると Depository の東西の出口は警報で通れない。Viewing Room の南は制限なし。
- Vault には 12 ターン以内しか居られない（超えると死ぬ）。
- Small Room に長居すると Zurich の小人が現れ、宝物と引き換えでしか出してくれない。すぐ南壁を抜ける。

手順（Bank Entrance から）:

```
ne / e / s / take portrait / n          … 北向きに入ったのでカーテンの先は Small Room
enter curtain / enter south wall        … Small Room → Depository（次の行き先が Vault になる）
enter curtain / take bills / enter north wall
drop bills / drop portrait / w / w      … 手ぶらで出て、西向きに入り直す
take bills / take portrait / enter curtain / s   … West Viewing Room → Bank Entrance
```

### 5.7 ドラゴンと氷河 — 確認済み

ドラゴンは剣では倒せない。怒らせて Ice Room まで付いて来させると、氷に映った自分に火を吐き、溶けた水で自滅する（+5）。

- 怒りの値: `attack dragon with sword` で +4、毎ターン −2。ターン終了時に **7 以上だと焼き殺される**。0 になるとドラゴンは巣へ戻る。
- 怒りが 1 以上ある間は、歩いた先へ付いて来る。
- ドラゴンに話しかける・調べる・攻撃するまでは、Dragon Room を素通りできる。
- ドラゴンが付いて来ている最中に Dragon Room へ戻ると殺される。

確認済みの手順（Dragon Room から）:

```
attack dragon with sword   （怒り 4→2）
attack dragon with sword   （6→4）
s                          Stone Bridge（4→2）
attack dragon with sword   （6→4）
s                          Cool Room（4→2）
attack dragon with sword   （6→4）
w                          Ice Room → 氷河が溶ける
```

3 回続けて攻撃すると 8 になって死ぬ。攻撃と移動を交互にすること。

### 5.8 姫と金の鍵 — 確認済み（最重要）

1. Dragon's Lair で `open chest` を 2 回（1 回目で姫が目を覚まし、2 回目で開く）。`take statuette`。
2. 姫は 1〜2 ターンに 1 部屋ずつ歩く: Lair → Dragon Room → End of Ledge → Ledge in Ravine → Deep Ford → Marble Hall → Path Near Stream → Formal Garden → North End of Garden → Gazebo。
3. 姫が Gazebo に着いて 6 ターン後、自分が **Gazebo か North End of Garden** に居れば、金の鍵と薔薇を渡される（+15）。居なければ鍵は消える。

確認済みの先回りルート（Lair から 10 手。回転を止めてあること）:

```
s / e / e / d / s / s / ne / e / n / in    → Gazebo で wait を 2〜3 回
```

- 事前に **回転を止め**、**荷物を軽くし**、**`save`** しておく。
- 姫が Marble Hall の壁を開けて Path Near Stream へ抜ける瞬間に同席していれば東の近道が開くが、当てにしない。
- 姫を攻撃すると魔法使いに焼き殺される。一角獣に触ると逃げる。

### 5.9 火山と気球 — 確認済み

Lava Room（ruby）の南が Volcano Bottom。気球は「受け皿で物を燃やすと上がり、蓋を閉めると下がる」。3 ターンに 1 段動く。

高さ: Volcano Bottom → Volcano Core → **Near Small Ledge**（西に Narrow Ledge）→ by Viewing Ledge → **Near Wide Ledge**（西に Wide Ledge）→ その上は火口の外で **墜落死**。

- 上昇: `open receptacle` → `put newspaper in receptacle` → `light match` → `burn newspaper with match`。新聞は 100 ターン燃える。マッチは 5 本、1 本 2 ターン。
- 着陸: 岩棚の高さで `land`。着いたら **すぐ `tie wire to hook`**。繋がないと 3 ターン後に気球だけ飛んで行き、小人が現れて宝物を要求する。
- 離陸: `get in basket` → `untie wire`。3 ターン後に岩棚を離れる。
- 下降: `close receptacle`。
- 籠の中で `drop` した物は籠に載って一緒に運ばれる。所持数を減らすのに使える。
- **Near Wide Ledge に着いたら次の手で必ず `land`**。もう 1 段上がると死ぬ。

Narrow Ledge: coin。南の Library で `open purple book` → `take stamp`。

Wide Ledge の南の Dusty Room（金庫の爆破）:

1. 事前に `put string in brick`（爆弾になる）。
2. `put brick in hole` → `light match` → `burn string with match` → **すぐ `n`**（次のターンに爆発）。
3. **`wait` せずに** `s` → `take crown` → `n`。爆発の約 5 ターン後に部屋が崩れる（中に居ると死ぬ）。
4. `get in basket` → `untie wire` → `close receptacle`。爆発の約 13 ターン後に岩棚も崩れる。

- brick に直接火を点けると爆死。
- 検証では `wait` を 1 回挟んだうえ `take crown` が所持数オーバーで失敗し、そのまま生き埋めになった。ここは 7 個以下で入ること。

### 5.10 工房 — 確認済み

1. Guarded Room で `give candy to lizard`（扉のトカゲが眠る）→ `unlock door with key`（金の鍵）→ `open door` → `s`（+10）。
   - トカゲが起きているうちに鍵を使うと噛みつかれる。20% で鍵を落とし、5% で鍵を食われる（ソース読解）。必ず先に candy。
2. `w` `w` で Aquarium Room。`throw sword at aquarium`（水槽が割れ、海蛇は陸で死ぬ）→ `take clear sphere`。
   - `break aquarium with sword` は不可（海蛇に殺される）。水槽に入るのも不可。
3. `e` で Workroom。`put red sphere on ruby stand` / `put blue sphere on sapphire stand` / `put clear sphere on diamond stand` → 黒い台と黒い球が現れる → `take black sphere`（+30）。
4. `s` で Pentagram Room。`put black sphere in circle` → 悪魔が現れる。数ターン後に魔法使いが駆けつけるが、もう何もできない。
5. `give <宝物> to demon` を 10 回。10 個目で `This will do for my fee.` と言う。
6. `tell demon to give me wand` → 杖が床に置かれ、魔法使いは逃げる → `take wand`（+30）。

悪魔を呼んだ後は魔法使いが出なくなるので、宝物の運搬は悪魔を呼んでから行うと安全。

### 5.11 杖の使い方 — 確認済み（float のみ）

`wave wand at <対象>` の **次のターンに** `say then <呪文>`。効果は 11〜20 ターン。効果が切れるまで杖は使えない（無理に振ると 5% で死ぬ）。

- Menhir Room: `wave wand at menhir` → `say then float` → 石碑が浮く → `sw`（Kennel）→ `take collar` → `ne`。石碑が沈む前に出る。
- 使える呪文（ソース読解）: float、fluoresce（光らせる）、filch（手元に引き寄せる。陳列棚に掛けると中身が足元に出る）、fry（消滅させる）。

### 5.12 迷路（Oddly-angled Room）— 確認済み

野球のダイヤモンドになっている。階段のある中央の部屋から適当に動くと、ランダムな部屋へ飛ばされる。床の菱形の窓の明るさが進み具合を示す。

| 窓の状態 | 次に進む方向 |
|---|---|
| `dark` | どこでもよい（やり直し） |
| `flickering dimly` | **se** |
| `dimly glowing` | **ne** |
| `glowing` | **nw** |
| `glowing brightly` | **sw** → `rusty squeal` が聞こえて解決（+5） |

- `flickering dimly` の部屋に着くまで適当な方向（例 `n`）を繰り返し、そこから `se` `ne` `nw` `sw`。
- 間違えるとランダムな部屋へ飛ばされる。やり直せばよい。
- 解決後は普通の迷路になる。中央へ戻る出口は部屋ごとに `s` `e` `w` `n` のどれか 1 つなので順に試す。中央の説明に `secret passage leading down` が加わったら `d`。
- 途中に落ちている wooden club は不要。

### 5.13 ケルベロスと Crypt — 確認済み

1. Cerberus Room（+10）で `put collar on dog`。着けた首輪を外すと殺される。
2. `e`（Crypt Anteroom、+3）→ `open door` → `s`（Crypt、+2）。
3. `turn off lamp` → 暗闇で南の壁に "F" の扉の輪郭が見える → `turn on lamp` → `open secret door` → 杖を持って `s`。

Crypt の首（heads）に触ると死ぬ。

---

## 6. 取り返しがつかない失敗

| 失敗 | 結果 |
|---|---|
| 姫が Gazebo に着いた時に居合わせない | 金の鍵を失いクリア不能 |
| 悪魔への願いを杖以外に使う | クリア不能 |
| candy を食べる・失う | トカゲの扉が開かない |
| 3 色の球のどれかを失う（ロボットに取らせる等） | 黒い球が作れない |
| newspaper など燃やす物・matchbook を失う | 気球が飛ばない |
| brick か string を失う、爆破前に気球を失う | crown が取れない |
| 宝物を小人に渡す、Filch で盗まれる | 400 点に届かない（クリアは可能） |
| 気球が火口の外へ出る、岩棚が崩れる時に岩棚に居る | 死亡 |

---

## 7. 確認済みの通し手順（400 点・324 手）

回転部屋・Low Room・迷路の「〜まで繰り返す」は乱数次第。それ以外は書いてある順に 1 行 1 コマンドで送る。
魔法使いが現れたら 0.1 と 3 章のとおり対処する。**節目ごとに `save`**。

### A. 準備（0 点）

```
take lamp / take sword / turn on lamp
s / s / s / sw / s / se / in
take all                         … teapot, place mat, newspaper, letter opener, matchbook
out / n / ne
fill teapot with water           … Shallow Ford
s / sw / sw                      … Carousel Room（回転中）
drop sword / drop mat / drop newspaper / drop opener / drop matchbook
```

### B. 謎かけ・井戸・不思議の国（→ 85 点）

```
se を Riddle Room に着くまで繰り返す（外れたら 4 章の表で戻る）
say then well
e / take necklace / e
get in bucket / pour water in bucket / get out of bucket
e
take red cake / take blue cake / eat green cake
e / throw red cake in pool / take candy / w
eat blue cake
nw
tell robot to go east / e
tell robot to push triangular button
tell robot to go south / s
take red sphere / tell robot to lift cage / take red sphere
n / w
Low Room: Tea Room に出るまで se（Machine Room に出たら w で戻ってやり直す）
w / get in bucket / fill teapot with water / get out of bucket
w / w / nw                       … Carousel Room（停止済み）
open box / take violin
```

### C. 鍵穴の扉・銀行・ドラゴン（→ 155 点）

```
drop necklace / drop violin / drop candy / drop teapot
take sword / take mat / take opener
n / n / n / u                    … Tiny Room
put mat under door / open lid / put opener in keyhole
take mat / take key / take opener
unlock door with key / open door / n
take blue sphere / s
drop opener / drop key / d
w / n / w / w                    … Bank Entrance
ne / e / s / take portrait / n
enter curtain / enter south wall / enter curtain
take bills / enter north wall
drop bills / drop portrait / w / w
take bills / take portrait / enter curtain / s
e / e                            … Dragon Room
attack dragon with sword / attack dragon with sword
s / attack dragon with sword
s / attack dragon with sword
w                                … Ice Room（氷河が溶ける）
```

### D. 姫と金の鍵（→ 190 点）

```
e / se                           … Carousel Room
drop portrait / drop bills
save
nw / n / n / n                   … Dragon's Lair
open chest / open chest / take statuette
s / e / e / d / s / s / ne / e / n / in
wait（鍵と薔薇を受け取るまで。2〜3 回）
```

### E. 火山（→ 255 点）

```
out / s / s / w                  … Carousel Room
drop statuette / drop sword / drop rose / drop key
take newspaper / take matchbook
n / take brick / s
sw / take string / put string in brick
n / d / w / take ruby / s        … Volcano Bottom
save
get in basket / drop ruby
open receptacle / put newspaper in receptacle
light match / burn newspaper with match
wait を "Volcano Near Small Ledge" が出るまで（1 回の wait で 1 段上がる）
land / tie wire to hook / get out of basket
take coin / s / open purple book / take stamp / n
get in basket / drop coin / drop stamp / untie wire
wait を "Volcano Near Wide Ledge" が出るまで → 出たら即
land / tie wire to hook / get out of basket
s / put brick in hole / light match / burn string with match
n / s / take crown / n
get in basket / untie wire / close receptacle
wait を "Volcano Bottom" に着くまで
take ruby / take coin / take stamp / get out of basket
```

### F. 工房・悪魔・杖（→ 365 点）

```
n / e / e / se                   … Carousel Room
drop ruby / drop coin / drop stamp / drop crown / drop matchbook
take key / take sword / take candy / take necklace / take violin
sw / sw                          … Guarded Room
give candy to lizard / unlock door with key / open door
s / w / w
throw sword at aquarium / take clear sphere
e
put red sphere on ruby stand
put blue sphere on sapphire stand
put clear sphere on diamond stand
take black sphere
s
put black sphere in circle
give necklace to demon / give violin to demon / give key to demon
n / e / n / n / ne               … Carousel Room
take statuette / take ruby / take coin / take stamp / take bills / take portrait / take crown
sw / sw / s / w / s              … Pentagram Room
give statuette to demon / give ruby to demon / give coin to demon / give stamp to demon
give bills to demon / give portrait to demon / give crown to demon
tell demon to give me wand
take wand
```

### G. 終幕（→ 400 点）

```
n / e / n / n / ne / s           … Menhir Room
wave wand at menhir
say then float
sw / take collar / ne
s / d                            … 迷路の中央
5.12 のとおり迷路を解き、中央へ戻る
d                                … Cerberus Room
put collar on dog
e / open door / s                … Crypt
turn off lamp / turn on lamp
open secret door
s                                … クリア
```

---

## 8. 検証のやり方（次に確かめたくなった時のために）

元のゲーム状態を汚さずに確かめるには、`out/zork2` で `python -u zork2.py` を標準入出力経由で実行するか、`out/zork2` を import する小さなドライバを別ディレクトリに置いて実行する。import で確かめる場合の要点は 3 つ。

1. `ZilRuntime._input_hook` に「次のコマンドを返す関数」を入れる（`READ` がこれを呼ぶ）。
2. `import zork2` の後に `ZilRuntime._random.seed(n)` で乱数を固定し、`ZG._link()` → `ZG.GO()`。
3. `ZG.HERE` / `ZG.SCORE` / `ZG.SPELL_p` / `ZG.DIAMOND_COUNT` などを直接読めば、回転部屋や迷路を自動で抜けられる。

魔法使いを止めるには `ZilRuntime.PUT(ZG.INT(ZG.I_WIZARD), 0, 0)`（有効に戻すのは第 3 引数を 1）。ただし悪魔の場面では魔法使いが Pentagram Room に来ないと杖が無いことになる（`I don't see any wand here!`）ので、黒い球を置いた直後に有効へ戻す。
