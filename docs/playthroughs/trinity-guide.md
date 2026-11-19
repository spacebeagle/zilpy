# TRINITY ゲームプレイ解説（LLM 攻略用リファレンス）

ZilPy で変換した Infocom 版 *Trinity*（1986 年、開始画面に Release 表示なし・"Interactive Fiction PLUS"）を、`out/trinity` で `python trinity.py` を直接実行して遊んでクリアするための資料。
プレイと検証から流れを組み立て、**最初から最後（"You've completed the story of TRINITY."）まで自動実行で通した**。旧版 `trinity-guide-old.md` で未確認だった後半（魔女の小屋〜Trinity 実験場〜ロンドンの結末）も、すべて実行して確かめた。

> 注意: 解き方がすべて書かれています。自分で解きたい人は読まないでください。
> この資料は、実際のプレイと検証をもとに日本語でまとめたものです。ゲームの文章は転載していません（コマンドと、場面を見分けるための短い語句だけを英語のまま書いています）。
> 権利者から申し出があれば、速やかに修正・削除します。

## 検証の前提と限界（2026-11-16 時点）

- 対象: ZilPy で変換した変換版 Trinity。
- 直接実行: スクラッチパッドのドライバー（出力の文言を見て `look` を繰り返す「待ち」と、ジープのダイヤル値・切る電線の色を出力から拾って差し込む仕組みつき）で、第 6 章のコマンド列を最初から流した。
  - 乱数の種 1〜15 の **15 回すべてで 100/100 点・419 手でクリア**。種で変わったのはダイヤルの数字と切る電線の色だけで、待ちの回数（`look` の数）は 15 回とも同じだった。
- 実行方法: `out/trinity` ディレクトリで `python trinity.py` を直接実行して遊ぶ。古い `*.sav` は読めないことがある。
- 確かめていない範囲: 別解（例: `hold coconut over cauldron`、塔に上がる別の手段）、乱数で長く待たされる分岐、満点以外の勝ち方。
- 印の意味: **[確認済み]** = 実行して出力を見た / **[未確認]** = 実行での確認をしていない箇所 / **[推測]** = 挙動からの推測で裏付けが弱い。章見出しの印はその章全体に掛かる。

---

## 0. 最初に読むこと（Python 版固有の落とし穴）

### 0.1 パーサーの落とし穴（すべて [確認済み]）

| やりたいこと | 通らない・危ない書き方 | 通る書き方 |
|---|---|---|
| 日時計の針を外す | `unscrew gnomon`, `turn gnomon` | `unscrew gnomon from sundial` |
| 指輪で扉を選ぶ | — | `turn ring to 6`（数字） |
| 塚の鍵を回す | `turn key` | `turn key with hands` |
| 小屋の扉 | — | `open front door` / `open back door` |
| 割ったココナッツを大鍋へ | 床に置いたまま `put coconut in cauldron`（`You're not holding a cracked coconut.`） | `take coconut` → `put coconut in cauldron`（2 手以内。2.の詰み参照） |
| 蜂蜜を大鍋へ | — | `put hand in cauldron` |
| 環礁の扉を開ける | `open doors` | `open box` → `push button` |
| walkie-talkie の電源 | `turn on switch`（**ランタンの switch と解釈され、ランタンが点く**） | `turn on rocker switch` |
| walkie-talkie の周波数 | — | `move slider to 73`（数字はジープのダイヤルで読んだ値） |
| ロードランナーに鍵を取らせる | — | `roadrunner, take key` |
| 南京錠つきの箱を開ける | `open box`（`take off the padlock` と言われる） | `unlock padlock with key` → `remove padlock` → `open box` |
| 配線箱を開ける | — | `pull chain`（電球）→ `open enclosure with screwdriver` |
| 電線を切る | `cut detonator wire`（`[You must refer to the wires by their color.]`） | `cut blue wire with knife`（色で指す） |
| 双眼鏡で覗く | — | `look at shelter through binoculars` |
| 物の名前全般 | — | 形容詞つきも名詞だけも通る。「Which ... do you mean」と聞かれたら形容詞で答える |

### 0.2 実プレイ上の教訓

- **1 手 = 時計の 15 秒。`wait` も 1 手（15 秒）しか進まない** [確認済み]。この資料では待ちに `look` を使った（同じく 1 手）。
- 起動直後の `[Press any key to begin.]`、白い扉をくぐった直後のタイトル画面、結末の画面は、**次の 1 行をキー入力として飲み込む**。害のない `look` などを送る [確認済み]。
- **荷物の制限** [確認済み]:
  - 重さの合計 25 まで（`Your load is too heavy.`）。判定は **物を取る瞬間だけ**。歩く・乗る時には見ない。
  - **身に着けた物は 1 つにつき 1 と数える**（ブーツは 3 → 1、経帷子は 4 → 1）。**ポケットの中身は 0**。
  - 手に持てるのは身に着けた物を除いて **7 個まで**（`You're holding too much already.`。旧版で「重さ」と書いたのはこちら）。
  - 主な重さ: lump 10、axe 7、spade 7、umbrella 7、cage 6（＋中身。lemming 3）、walkie-talkie 5、lantern 4、shroud 4、coconut 4、binoculars 4、screwdriver 3、boot 各 3、bag 2、knife 2、slip / ruby / key / watch 各 1。
- **ランタン（lantern）は電池が 30 手分しかない**（点けている間だけ減る）。Trinity の貯水池の底で必要になるので、**ネバダ（地下）では氷の洞窟に入ったらすぐ消す**。旧版の確認済みコマンド列は消し忘れていて、Trinity では電池切れになる [確認済み: 下記ルートで Trinity 到着時に残り 14]。
- 死ぬと冥界の渡し場（The River）の場面になり `RESTART / RESTORE / QUIT` を聞かれる。**取り返しのつかない操作の前に `save`**（5.1）。

---

## 1. ゲームの目的と全体の流れ

勝利条件（1 文）: **1945 年 7 月 16 日の Trinity 実験場で、塔の上の小屋の配線箱（enclosure）を開け、ブレーカー操作で無線から聞いた線の名前（positive / ground / informer / detonator）に当たる色の電線を、5:29:00〜5:29:44 の間にナイフで切る** [確認済み]。その後ロンドンに戻り、Lancaster Gate で老婆の傘が木に飛ばされる場面を見届けると "You've completed the story of TRINITY." で終わる [確認済み]。

```
電線を切る（5:29:00〜5:29:44、knife、小屋で電球を点けて配線箱を screwdriver で開けてある）
 ├ 切る色 ← 本のしおり（slip）の配線図の凡例 RD/BL/ST/WH = POS/GND/INF/DET（毎回ランダム）
 │          × ブレーカーを開けた瞬間に無線で言われる線の名前（毎回ランダム）
 │    └ 無線を聞く ← walkie-talkie（ネバダの地下）を、ジープの無線のダイヤル値に合わせ、アンテナを伸ばし電源 ON
 │    └ ブレーカー ← 塔の下の箱の南京錠 ← steel key ← 双眼鏡で南の掩蔽壕を覗き、ロードランナーに取らせる
 │                        └ 双眼鏡 ← 風車の上（取ると足場が崩れ貯水池に落ちる）→ 水底で拾う ← 点くランタン
 ├ knife ← 牧場の台所 / screwdriver ← 牧場の Assembly Room ← 毒蛇をレミングで追い払う ← レミング（ツンドラ）＋鳥かご（魔女の小屋）
 ├ 塔に登り直す ← 番犬の陽動（ロードランナー＋パン屑の袋を Outside Blockhouse に置く）
 ├ 砂漠を 1 手で移動 ← 翼の生えたブーツ 2 つを履く（赤に ruby、緑に emerald）
 │    ├ ruby ← Trinity でロードランナーが返してくれる
 │    └ emerald ← 大鍋に 4 材料（にんにく・宇宙で殺したトカゲ・ココナッツの汁・蜂蜜）→ 爆発
 │         ├ 死んだトカゲ ← 地下で捕まえ、宇宙で握りつぶす ← 泡（巨人の皿）＋冷ました隕鉄
 │         └ ココナッツ ← 環礁（イルカ）/ 蜂蜜 ← 蜂をハエトリグサに捕まえさせてから巣に手を入れる
 └ Trinity に行く ← 小島の扉（指輪 7）← 渡し守に銀貨＋**経帷子を着て**乗る ← 墓の死体（スコップで蓋を開ける）
```

進行順（すべて [確認済み]。第 4 章の節番号）:

1. London（4.1）: 袋・紙の鳥・gnomon・ボール・傘・乳母車 → 白い扉
2. ファンタジー世界の準備（4.2）: 光る木片・斧・樫の橋・Vertex に gnomon・太陽を止める
3. 長崎（4.3）: スコップ・鶴
4. 墓所（4.4）: 経帷子・銀貨・ブーツ
5. 塚〜地下（ネバダ）〜氷の洞窟（4.5）: 鍵・ランタン・walkie-talkie・トカゲ・氷柱
6. 隕鉄と宇宙（4.6）: トカゲを殺す
7. 魔女の小屋・薬草園・ツンドラ（4.7〜4.8）: 鳥かご・にんにく・レミング
8. 環礁（4.9）: ココナッツ
9. 大鍋（4.10）: エメラルド
10. 荷物を整えて渡し守 → 小島（4.11）
11. Trinity（4.12）→ ロンドンの結末（4.13）

### 得点表（100 点満点。実行ログの加点を全部数えて 100 に一致）[確認済み]

| 行為（コマンド） | 点 | 累計 |
|---|---|---|
| `buy bag` | 1 | 1 |
| `take bird`（Round Pond） | 3 | 4 |
| `take gnomon` | 5 | 9 |
| `take ball` | 1 | 10 |
| `take umbrella` | 5 | 15 |
| `take splinter` | 1 | 16 |
| `take axe` | 1 | 17 |
| `push oak north` | 3 | 20 |
| `screw gnomon into sundial` | 5 | 25 |
| `take spade` | 1 | 26 |
| `give umbrella to girl` | 3 | 29 |
| `open lid with spade` | 3 | 32 |
| `take shroud` | 1 | 33 |
| `take silver coin` | 1 | 34 |
| `take key`（Ossuary） | 1 | 35 |
| `take lantern` | 1 | 36 |
| `take walkie-talkie` | 1 | 37 |
| `take skink` | 3 | 40 |
| `turn key with hands` | 1 | 41 |
| `take icicle` | 1 | 42 |
| `put icicle on lump` | 3 | 45 |
| `take lump` | 1 | 46 |
| `squeeze skink`（宇宙） | 3 | 49 |
| `take cage` | 1 | 50 |
| `take garlic` | 1 | 51 |
| `put lemming in cage` | 1 | 52 |
| 大鍋: `put garlic in cauldron` / `put skink in cauldron` | 1+1 | 54 |
| `take coconut` | 3 | 57 |
| `hit coconut with axe` | 1 | 58 |
| `put coconut in cauldron` | 1 | 59 |
| `reach into hive`（2 回目、蜂蜜） | 3 | 62 |
| `put hand in cauldron` | 1 | 63 |
| `take emerald` | 1 | 64 |
| `put emerald in green boot` | 1 | 65 |
| `take slip` | 1 | 66 |
| `examine diagram` | 3 | 69 |
| `take ruby` | 1 | 70 |
| `put ruby in red boot` | 1 | 71 |
| `examine dial`（ジープ） | 3 | 74 |
| `move slider to <ダイヤル値>` | 3 | 77 |
| `take knife` | 1 | 78 |
| 毒蛇がレミングを食べて去る（`open door`） | 3 | 81 |
| `take screwdriver` | 1 | 82 |
| `take binoculars`（水底） | 1 | 83 |
| `look at shelter through binoculars` | 3 | 86 |
| `roadrunner, take key` | 3 | 89 |
| `take key`（steel key） | 1 | 90 |
| `unlock padlock with key` | 1 | 91 |
| `close breaker`（無線を聞きながら） | 1 | 92 |
| `open enclosure with screwdriver` | 3 | 95 |
| `cut <色> wire with knife` | 5 | 100 |

減点はない。満点はクリアの条件ではない（正しい電線を正しい時刻に切れば終わる）。

---

## 2. 詰み条件の一覧（絶対に避ける）

| やってはいけないこと | 結果 | 印 |
|---|---|---|
| London で袋とおつりを 3 手以内に受け取らない | 老婆がしまい込む。袋（パン屑）は Trinity の陽動に必須 | 確認済み（しまい込み）/ 未確認（必須） |
| London で gnomon を取らずに白い扉をくぐる | Vertex の日時計が使えず、扉を選べない | 未確認 |
| 鏡像にせずに Vertex で gnomon をはめる | ねじ山が合わない（3.3） | 未確認 |
| 長崎で落下中に傘を開かない（入ってから 2 手） | 墜落死 | 未確認 |
| 長崎で鶴に乗った次の手に `in` しない | 原爆で死ぬ | 確認済み（旧版） |
| 長崎で先生や子供の方へ行く（north / northeast / southeast / south） | 見つかって騒ぎになり死ぬ（確認の質問に `no` なら戻れる） | 未確認 |
| 光る木片を持たずに Barrow から北へ進む / Barrow で暗いまま過ごす | 塚の亡霊（wight）に殺される。暗いと穴の鍵も抜き取られる | 未確認 |
| 地下（ネバダ）に 18:00 まで残る（入ってから 40 手） | 地下核実験で死ぬ | 未確認 |
| 墓の蓋を傘や斧でこじ開ける | 道具が折れて失われる。**スコップで** | 未確認 |
| 地下で walkie-talkie を取らずに出る | 地下への扉は 1 回きり。無線が聞けず電線を選べない | 確認済み（扉が消える） |
| ネバダでランタンを点けっぱなしにする | 電池（30 手）が切れ、Trinity の水底で双眼鏡が見えない | 確認済み（電池残量）/ 推測（見えない） |
| 氷柱を持って暖かい所で 6 手過ごす | 溶ける。Vertex に置けば溶けない | 確認済み（旧版） |
| 泡をまとってから 3 手より多くかける / 宇宙で泡を割らずに 9 手目 | 窒息死 / 衛星の爆発で死ぬ | 確認済み（旧版）/ 未確認 |
| 小屋で鳥かごを開ける前に玄関か裏口を開けていない | カササギが小屋の中を飛び回って戻される（何度でもやり直せる） | 未確認 |
| **ココナッツを割ってから 2 手以内に大鍋へ入れない**（床に置いたまま `put` すると失敗扱いで 1 手失う） | 汁が流れ切る（3 手）。ココナッツは 1 つしかなく、大鍋が完成しない | 確認済み（汁が切れた）/ 未確認（取り返し不可） |
| 大鍋の 4 つ目を入れてから小屋に 3 手いる | 爆発で死ぬ。鳥かご（レミング入り）も小屋に置かない（中の動物が死ぬ） | 未確認 |
| 蜂に刺されたまま同じ場所にいる | 3 回刺されると死ぬ | 未確認 |
| **経帷子を着ずに渡し舟に乗る** | 渡し守に蹴り出される（舟は 12 手周期で戻るので、着てから乗り直せば可） | 未確認（旧版にはない注意） |
| 渡し守に小銭やクレジットカードを渡す | 川に捨てられる。**銀貨（silver coin）を渡す** | 未確認 |
| Trinity で 5:00:00 より前に塔の踊り場（Tower Landing）に降りる | 見張りに捕まる | 未確認 |
| Trinity で塔の上（Tower Platform / Tower Landing）で合計 4 手を過ごす（陽動中を除く） | 見つかって実験中止、警察に捕まる。**降りるだけで 2 手使う**ので、登り直しは陽動が必須 | 確認済み |
| ジープの無線のダイヤルを読む前に動かす | 正しい周波数が決まらず、無線が永遠に聞けない | 未確認 |
| walkie-talkie の orange button を押す | 感電して取り落とす | 未確認 |
| 無線が聞こえない状態でブレーカーを開ける / 2 回開ける / 開けたまま次の手を迎える | 線の名前が分からなくなる / 実験中止 | 未確認 |
| **Assembly Room（毒蛇）で 2 手目を迎える** | 噛まれ、数手後に死ぬ | 確認済み |
| 鳥かご（レミング入り）・walkie-talkie・袋を持って風車に上がり双眼鏡を取る / 貯水池に入る | 足場が崩れて水に落ち、レミングは溺れ、walkie-talkie は濡れて壊れ、袋のパン屑は駄目になる | 未確認 |
| **Trinity で袋をロードランナーのそばに置く**（`drop bag` や開いた鳥かごに入れる） | ロードランナーがパン屑を食べ尽くし、番犬の陽動が使えなくなる | 確認済み（食べ尽くした） |
| 5:29:00 より前、または違う色の電線を切る | 実験中止、警察に捕まって失敗 | 未確認 |
| 5:29:45 を過ぎる | 原爆が爆発して死ぬ | 未確認 |

---

## 3. 基本システム・共通の仕掛け

### 3.1 ファンタジー世界の日時計と 7 つの扉 [確認済み]

- 巨大な三角形（日時計の針）の影が森の上を回り、影の先端が毒キノコに触れている間だけその扉が開く。
- **Vertex**（Bottom of Stairs から `north` 2 回）の日時計に gnomon をはめ、`turn ring to N` でその記号の扉を開ける。最初に一度 `lower lever` で太陽を止めれば、以後は指輪を回すだけで扉を選べ、開いた扉は開いたまま。
- **扉は 1 回通って戻ると消える**。各実験場は 1 回きり。

| 指輪 | 扉のある場所（`in`） | 行き先（開始時刻 → 爆発） | 主な目的 |
|---|---|---|---|
| 1 | Meadow | （入口。最初に消える） | — |
| 2 | Waterfall | 地球周回軌道 | トカゲを殺す |
| 3 | Ossuary | 地下・ネバダ（17:50 → 18:00） | walkie-talkie、トカゲ、ランタン |
| 4 | Mesa（樫の橋が要る） | 環礁（4:52 → 5:00） | ココナッツ |
| 5 | Herb Garden（小屋の裏） | ツンドラ（14:41 → 15:00） | レミング |
| 6 | Moor | 長崎（10:54 → 11:02） | スコップ |
| 7 | Islet（渡し守が要る） | Trinity（4:58:30 → 5:29:45） | 最終章（戻れない） |

### 3.2 地図（ファンタジー世界、鏡像でない状態）[確認済みの移動だけ]

- Meadow `north` Summit `east` Forest Clearing `north` South Bog
- South Bog `southeast` Trellises / `west` Waterfall / `north` North Bog / `northeast` Chasm's Brink
- Trellises `southwest` Arborvitaes `east` Arboretum（`north` でアーチの下、`up` で頂上）。戻りは Arboretum `west` → Arborvitaes `northeast` → Trellises
- Trellises `north` Bottom of Stairs（`north` `north` で Vertex）/ `northeast` The Bend / `northwest` South Bog
- Bottom of Stairs `west` South Bog / `northeast` Under Cliff
- The Bend `east` Moor / `south` The River（渡し場）/ `northwest` Chasm's Brink / `southwest` Trellises
- Waterfall `north` Cemetery（`north` Barrow `north` Ossuary）/ `northeast` North Bog
- North Bog `north` Promontory（巨人と皿）/ `southeast` Bottom of Stairs / `southwest` Waterfall / `east` Chasm's Brink
- Chasm's Brink `north` Mesa（倒した樫）/ `northeast` Bluff / `east` Under Cliff / `west` North Bog / `southeast` The Bend
- Bluff `east` Cottage（`open front door` が要る）`east` Herb Garden（`open back door`）。Bluff `southwest` Chasm's Brink
- Under Cliff（蜂の巣）`east` Crater's Edge `east` Crater（隕鉄）。Crater's Edge `southwest` The Bend。Under Cliff `west` Chasm's Brink / `southwest` Bottom of Stairs
- Barrow `down` Ice Cavern（鍵を回した後）`east` Waterfall

### 3.3 アーチ（Arboretum）と鏡像の世界 [確認済み]

- Arboretum の `north` から入って `up` → `south` → `down` と**入った側と反対へ抜ける**と世界が鏡像になる（東西が入れ替わる）。頂上は暗いので光る木片を持って入る。頂上に斧。
- 目的は 1 つ: London の gnomon（左ねじ）を Vertex（右ねじ）にはめること。はめたら同じ抜け方でもう一度くぐって元に戻す。

### 3.4 荷物の運び方

- 0.2 の制限を前提に、**ブーツは履いて運ぶ**（3+3 → 1+1）。これで Trinity に必要な物（鳥かご＋レミング 9、walkie-talkie 5、ランタン 4、袋 2、ブーツ 2、経帷子 1、腕時計 1 = 24）が 25 に収まる [確認済み]。
- 置き場所（確認済みの手順）: 斧 → Arboretum（宇宙で使った後は Vertex）、スコップ・包帯 → Cemetery、ランタン・walkie-talkie・経帷子 → Vertex、鳥かご（レミング入り）→ Bluff。

### 3.5 Trinity の仕組み（手順は 4.12 で確認済み）

- **砂漠の移動**: ブーツを 2 つとも履き、2 つとも宝石入りなら 1 手（`WHOOSH!`）。そうでないと 1 歩で 19〜29 手かかる。
- **見張りの許容**: 初期 4。5:00 以降、塔の踊り場か上の足場で手番を終えるたびに 1 減り、0 で発見・中止。陽動の開始時に 2 に戻り、陽動中（3 手）は減らない。
- **陽動**: ロードランナーが Outside Blockhouse（番犬）にいて、パン屑を食べ終え、プレイヤーがその場にいない時に始まる。犬が吠え、探照灯が塔から外れる。陽動は 2 回まで（2 回目でロードランナーは撃たれる）。
- **ロードランナー**: プレイヤーのいる部屋へ付いて来る。ブーツで飛ぶと 2 手遅れる。地面や開いた容器の中の袋を見るとパン屑を食べ始め、食べ終わるまで動かない。**部屋の説明（`look`）で「つついている」様子が描かれるとパン屑が余分に減る**ので、陽動の仕掛け中は `look` を控える。
- **無線**: walkie-talkie の周波数がジープのダイヤル値と同じ・アンテナを伸ばす・電源 ON・手元にある（濡れていない）の 4 条件で管制の会話が聞こえる。

---

## 4. 章別攻略

### 4.1 London（Kensington Gardens）[確認済み]

開始 15:30:00。15:57:45 の空襲警報の後 London は消える（それまでに白い扉へ）。

1. キー入力の代わりに 1 行（`x` など）。
2. `north` → `buy bag` → `take bag` → `take coin`（**3 手以内に受け取る**）
3. `east`（Round Pond）→ `paper bird` が出るまで `look`（1 回）→ `take bird`
4. `south`（The Wabe）→ `examine sundial` → `unscrew gnomon from sundial` → `take gnomon`
5. `northeast` → `south`（Flower Walk）→ `take ball`
6. `north` → `north`（Lancaster Gate）→ 傘が `branches of the tree` に飛ばされるまで `look`（1 回）→ `throw ball at umbrella` → `take umbrella`
7. `southwest` → `northwest`（Black Lion Gate）→ `open pram` → `push pram southeast`
8. `eat crumbs`（袋からルビーが出て鳥が持ち去り、風が西風に変わる）→ `look`
9. `enter pram` → `open umbrella`（Long Water に墜落）→ `take all`
10. `east` → `look` → `east`（白い扉）→ タイトル画面で `look`

持ち越す物: 傘、袋（パン屑入り）、小銭、丸まった紙、gnomon。

### 4.2 ファンタジー世界の準備 [確認済み]

1. `north` → `east` → `north`（South Bog）→ `kick log` → `take splinter`
2. `southeast` → `southwest` → `east`（Arboretum）→ `north` → `up` → `take axe` → `south` → `down`（**鏡像**）
3. 鏡像のまま: `east` → `northwest` → `northeast` → `northwest`（Chasm's Brink）→ `chop oak with axe` → **次の手で** `push oak north`
4. `southeast` → `west` → `north` → `north`（Vertex）→ `screw gnomon into sundial` → `turn ring to 6` → `lower lever`
5. `south` → `south` → `south` → `southwest` → `east` → `north` → `up` → `south` → `down`（元に戻る）→ `drop axe`

### 4.3 長崎 [確認済み]

`west` → `northeast` → `northeast`（The Bend）→ `east`（Moor）→ `in`（10:54:00、上空から落下）

1. **すぐ** `open umbrella` → `take all` → `east` → `take spade` → `west`
2. `little girl races` が出るまで `look`（3 回、10:56 頃）
3. `give paper to girl` → `give umbrella to girl` → `climb on bird` → **次の手で** `in`（Moor へ）

### 4.4 墓所 [確認済み]

`west` → `west` → `north` → `north` → `turn ring to 3` → `south` → `south` → `west` → `west` → `north`（Cemetery）

`open lid with spade` → `take shroud` → `take bandage` → `take silver coin` → `drop spade` → `drop bandage`（手に持つ数を減らす）→ `take red boot` → `take green boot` → `drop red boot` → `drop green boot`（後で取りに来る）

### 4.5 塚・地下（ネバダ）・氷の洞窟 [確認済み]

1. `north`（Barrow）→ `north`（Ossuary）→ `search bones` → `take key` → `in`（17:50:00、40 手で爆発）
2. `take lantern` → `turn on lantern` → `west` → `take walkie-talkie`（**必ず**）→ `drop lantern`（点けたまま）
3. `west` → `put splinter in crevice` → `take skink` → `put skink in pocket`
4. `east` → `take lantern` → `east` → `east`（Ossuary）→ `south`（Barrow）→ `put key in hole` → `turn key with hands` → `down`（Ice Cavern）
5. **ここで `turn off lantern`**（電池節約。Trinity で使う）
6. `hit icicles with shroud` → `take icicle` → 4 手で Vertex へ: `east` → `northeast` → `southeast` → `north` → `north` → `drop icicle`

### 4.6 隕鉄と宇宙 [確認済み]

1. Vertex: `turn ring to 2` → `drop lantern` → `drop walkie-talkie` → `drop shroud` → `take icicle`
2. `south` → `south` → `northeast` → `east` → `east`（Crater）→ `put icicle on lump` → `take lump`
3. `west` → `southwest` → `southwest` → `southwest` → `east`（Arboretum）→ `take axe`
4. `west` → `northeast` → `northwest` → `north` → `north`（Promontory）→ `in`（皿の中へ）
5. `enveloped in a soapy film` が出るまで `look`（3 回）→ **すぐ** `south` → `southwest` → `in`（宇宙）
6. `pulling you towards the satellite` が出るまで `look`（3 回）→ `take skink` → `squeeze skink`
7. `heading straight for the white door` が出るまで `look`（1 回）→ `hit bubble with axe`（Waterfall に帰還、49 点）

### 4.7 魔女の小屋と薬草園 [確認済み]

Waterfall から: `northeast` → `southeast` → `north` → `north`（Vertex）→ `turn ring to 5` → `south` → `south` → `northeast` → `west` → `northeast`（Bluff）

1. `open front door` → `east`（Cottage。大鍋・地図・巨大な本・カササギ入りの鳥かご）
2. `take cage`（カササギがレシピの一節を口ずさむ）→ `open cage`（玄関が開いているので**カササギは外へ飛び去る**。かごは空で開いたまま）
3. `open back door` → `east`（Herb Garden）→ `search pile` → `take garlic`

### 4.8 ツンドラ（ソ連、14:41 → 15:00）[確認済み]

Herb Garden で `in`（扉 5）。

1. `down`（Under Platform）→ `northeast` → `northeast`（Cliff Edge。レミングの群れ）
2. `look in fissure`（閉じ込められたレミングが見つかる）→ `take lemming` → **すぐ** `put lemming in cage` → `close cage`（手に持ったままだと次の手で逃げる）
3. `southwest` → `southwest` → `up`（Platform）→ `in`（Herb Garden へ）
4. `west`（Cottage）→ `put garlic in cauldron` → `put skink in cauldron`（材料 2/4）→ `west`（Bluff）→ `drop cage`（爆発に巻き込まないため小屋の外に置く）

### 4.9 環礁（4:52 → 5:00）[確認済み]

Bluff から: `southwest` → `east` → `southwest` → `north` → `north`（Vertex）→ `turn ring to 4` → `south` → `south` → `northeast` → `west` → `north`（Mesa）→ `in`（Scaffold）

1. `down` → `open box` → `push button`（引き戸が開く）→ `south`（South Beach）→ `west`（West Beach）
2. 待つ（`look`）。途中でイルカが現れ、4:55:15 に小島にココナッツが落ちる。**`floats away from the distant islet` が出るまで `look`（12 回）**。それより前に頼むと「潮がまだ低い」と断られる
3. **すぐ** `ask dolphin about coconut`（砂浜に投げてくれる）→ `take coconut`（4:58:15 に流れ去るので急ぐ）
4. `southeast` → `north` → `up` → `in`（Mesa へ）

### 4.10 大鍋 → エメラルド [確認済み]

Mesa から: `south` → `northeast` → `east`（Cottage）

1. ココナッツ: `drop coconut` → `hit coconut with axe` → **次の手で** `take coconut` → **次の手で** `put coconut in cauldron`（材料 3/4。汁は 3 手で切れる）
2. 蜂蜜: `west` → `southwest` → `east`（Under Cliff）→ `reach into hive`（1 回目は刺され、蜂が追ってくる）→ **立ち止まらず** `west` → `west`（North Bog。開いたハエトリグサに蜂が捕まる）→ `east` → `east` → `reach into hive`（2 回目、指に蜂蜜）→ `west` → `northeast` → `east`（Cottage）→ `put hand in cauldron`（材料 4/4、煮え立つ）
3. **すぐ** `west`（Bluff）→ `BOOM` が出るまで `look`（1 回）→ `east` → `take emerald`

### 4.11 ブーツ・荷物・渡し守・小島 [確認済み]

1. `west` → `southwest` → `west` → `southwest` → `north`（Cemetery）→ `take red boot` → `take green boot` → `put emerald in green boot` → `wear red boot` → `wear green boot`
2. `south` → `northeast` → `southeast` → `north` → `north`（Vertex）→ `drop axe` → `take walkie-talkie` → `take shroud` → `take lantern` → `wear shroud` → `turn ring to 7`
3. `south` → `south` → `northeast` → `west` → `northeast`（Bluff）→ `take cage` → `southwest` → `southeast` → `south`（The River。小舟がすぐ現れる）
4. `soundless landing` が出るまで `look`（2 回）→ `enter dory`（**経帷子を着ていること**）→ `give silver coin to oarsman`（Sand Bar に着く）
5. `south`（Islet。ロードランナーが先に扉をくぐる）→ `remove shroud` → `drop shroud`（以後不要）→ **ここで `save`** → `in`（Trinity。**戻れない**）

持ち込む物（確認済み）: 鳥かご（レミング入り）、walkie-talkie、ランタン（電池残り 14）、袋（パン屑）、腕時計、履いたブーツ 2 つ。重さ 24。

### 4.12 Trinity（1945 年 7 月 16 日、4:58:30 → 5:29:45）[確認済み]

到着は塔の上の小屋（Shack）。約 125 手で原爆が爆発する。確認したルートの時刻: 牧場終了 5:09:30、双眼鏡 5:15:30、ブレーカー 5:21:45、小屋に戻る 5:26 頃、電線 5:29:00。

**地図**（確認済みの移動）:

- Shack `west` Tower Platform `down` Tower Landing `down` Base of Tower（`up` `up` `east` で逆）
- Base `northwest` ×3 → Paved Road（ジープ。`in` / `out`）
- Base `southeast` Shallow Crater `southeast` Northwest of Ranch（`open gate`、`southeast` Back Yard `south` Hallway。`open door` で `east` Kitchen、`north` Northwest Room、`east` Assembly Room、`north` Closet）
- Northwest of Ranch `east` Northeast of Ranch `east` North of Reservoir `southeast` Under the Windmill（`up` で風車）。貯水池から: `south`（Edge of Reservoir）→ `down`（South of Reservoir）→ `northeast` Under the Windmill。North of Reservoir から `west` `west` `northwest` `northwest` で Base
- Base `south` ×4 → Behind the Shed（南の掩蔽壕を覗く場所）
- Base `southwest` ×4 → Outside Blockhouse（眠っている番犬）

**手順**:

1. **小屋（5:00 まで降りない）**: `open book`（しおりが落ちる）→ `take slip` → `examine slip` → `examine diagram` → **凡例 `RD=... BL=... ST=... WH=...` を控える** → `drop slip`。`motor revving` が出る（5:00:00、ジープが去る）まで `look`（1 回）
2. `west` → `down` → `down`（Base。ロードランナーが箱の上にルビーを置く）→ `take ruby` → `put ruby in red boot`（履いたままで入る。これで飛べる）
3. **ジープ**: `northwest` ×3 → `in` → `examine dial`（**動かす前に読む。数字を控える**）→ `out` → `move slider to <数字>` → `raise antenna` → `turn on rocker switch`（以後、無線の雑音や会話が聞こえる）
4. **牧場**: `southeast` ×5（Northwest of Ranch）→ `open gate` → `southeast` → `south` → `open door` → `east`（Kitchen）→ `take knife` → `north` → `east`（Assembly Room。毒蛇が現れ、ロードランナーが戦って退く）→ **次の手ですぐ** `north`（Closet へ逃げる）→ `close door` → `open cage`（レミングが床に降りる）→ `open door`（レミングが飛び出し蛇に食べられ、蛇が去る）→ `south` → `search paper`（screwdriver が転がり出る）→ `take screwdriver` → `drop cage`
5. **袋を守りながら風車へ**: `west` → `south` → `west` → `north` → `northwest` → `east` → `east`（North of Reservoir）→ `drop bag`（**ロードランナーが追いつく前に置いてすぐ離れる**）→ `southeast`（Under the Windmill）→ `drop walkie-talkie` → `drop knife` → `drop screwdriver`（水に落ちると駄目になる物を置く）
6. **双眼鏡**: `turn on lantern` → `up` → `take binoculars`（足場が崩れて貯水池に落ち、持ち物は水底へ）→ `down`（潜る。息は 4 手）→ `take binoculars` → `take lantern` → `up` → `turn off lantern` → `south` → `down` → `northeast` → `drop lantern` → `take walkie-talkie` → `take knife` → `take screwdriver` → `northwest` → `take bag`（ロードランナーより先に拾う）
7. **鍵**: `west` → `west` → `northwest` → `northwest`（Base）→ `south` ×4（Behind the Shed）→ `look at shelter through binoculars`（箱の南京錠に鍵が見える）→ ロードランナーが来るまで `look`（1 回）→ `roadrunner, take key` → `take key`
8. **ブレーカー（5:29 より前に 1 回だけ）**: `north` ×4（Base）→ `unlock padlock with key` → `remove padlock` → `drop padlock` → `open box` → `open breaker`（無線で `reconnected the ___ line` と線の名前が言われる）→ **次の手で** `close breaker`
9. **切る色を決める**: 線の名前 positive / ground / informer / detonator を POS / GND / INF / DET に直し、凡例でその略号の付いた色（RD = red、BL = blue、ST = striped、WH = white）を選ぶ。例: 凡例 `RD=GND BL=DET ST=INF WH=POS` で `detonator` なら blue。
10. **陽動と登り直し**: `southwest` ×4（Outside Blockhouse）→ `drop bag` → ロードランナーが `begins to peck` するまで `look`（1 回）→ **`look` せずにすぐ** `northeast` ×4（Base）→ `sweeps away suddenly`（探照灯が塔から外れる）を確認（確認したルートでは Base に着いた手に出た。出ていなければ `look` で待つ）→ **すぐ** `up` → `up` → `east`（Shack）。途中で "movement on the tower" と言われるが、許容は 1 残る
11. **配線箱**: `pull chain`（電球を点ける。点けないと中が暗い）→ `open enclosure with screwdriver`
12. **5:29:00 を待つ**: `Sequencer will assume control in fifteen seconds` が出るまで `look`（15 回）→ **次の手で** `cut <色> wire with knife`（100 点）。声の独白の後、ロンドンの Palace Gate に戻る

### 4.13 ロンドンの結末 [確認済み]

Palace Gate: `north` → `east`（Round Pond）→ `northeast`（Lancaster Gate。傘を開こうとする老婆）→ `It's time` が出るまで `look`（1 回。**老婆に話しかけたり近づいたりしない**と、2 手後に傘が木に飛ばされる）→ 画面のキー入力に `look` → "You've completed the story of TRINITY."（100/100、419 手）

- The Wabe からの `northeast` は gnomon が戻っているため進めない（`A noise makes you hesitate.`）[確認済み]。Round Pond の `northeast` を使う。

---

## 5. 乱数・タイマーまわりの注意

### 5.1 save の置き場所

- 長崎に入る前（Moor）、地下に入る前（Ossuary）、泡をまとう前（Promontory）、環礁に入る前（Mesa）、大鍋の 3 つ目を入れる前（Cottage）、Trinity に入る前（Islet。必須）。
- Trinity の中では: 牧場に入る前、風車に上がる前、ブレーカーを開ける前、袋を Outside Blockhouse に置く前、電線を切る前。

### 5.2 タイマーの総表

| 場面 | 起点 | 期限・出来事 | 印 |
|---|---|---|---|
| London | 15:30:00 | 15:57:45 空襲警報、9 手後に消滅 | 未確認 |
| 老婆の袋とおつり | 買った直後 | 3 手で取り上げられる | 確認済み |
| 紙の鳥 / 傘 | Round Pond / Lancaster Gate に入った時 | 2 手目に現れる / 飛ばされる | 確認済み |
| Long Water | 墜落した時 | 6 手後に消滅。扉は 2 手後から | 確認済み |
| 樫 | `chop oak` | 次の手に `push oak north`。遅れると反対側に倒れる | 確認済み / 未確認 |
| 長崎 | 10:54:00 | 2 手後に墜落（傘）。少女は 10:56 頃（`look` 3 回）。11:02 爆発 | 確認済み |
| 鶴 | 少女に傘を渡した時 | 乗ったら次の手に `in` | 確認済み |
| 地下 | 17:50:00 | 18:00 爆発（40 手） | 未確認 |
| ランタン | 点けている間 | 合計 30 手で電池切れ | 確認済み（残量）/ 未確認 |
| 氷柱 | 折った時 | 暖かい所で 6 手目に溶ける。Vertex・氷の洞窟では減らない | 確認済み |
| 泡 | 皿で包まれた時（`look` 3 回目） | 宇宙以外で 3 手 | 確認済み |
| 宇宙 | 入った時 | `look` 3 回 → `take skink`、9 手目に死 | 確認済み |
| ツンドラ | 14:41:00 | 15:00 爆発 | 未確認 |
| レミング | 手に持った時 | 次の手で逃げる | 確認済み |
| 環礁 | 4:52:00 | 4:55:15 小島にココナッツ、4:56:15 浮く（West Beach で `look` 12 回目）、4:58:15 流れ去る、5:00 爆発 | 確認済み |
| ココナッツの汁 | 割った時 | 3 手で切れる | 確認済み / 未確認 |
| 蜂 | 巣に手を入れた時 | 同じ所にいると刺される（3 回で死） | 未確認 |
| 大鍋 | 4 つ目の材料 | 3 手目に爆発（Bluff で `look` 1 回目に `BOOM`） | 確認済み |
| 渡し舟 | The River に入った時 | 2 手後に着岸、12 手周期 | 確認済み |
| Trinity | 4:58:30 | 5:00:00 まで塔の踊り場に降りない。5:29:00〜5:29:44 に電線を切る。5:29:45 爆発 | 確認済み |
| 見張りの許容 | 5:00 以降 | 塔の上で合計 4 手（陽動で 2 に戻る） | 確認済み |
| 毒蛇 | Assembly Room に入った時 | 2 手目に噛む | 確認済み |
| 風車の足場 | 上がった時 | 4 手で崩れる（`take binoculars` で即崩れる） | 確認済み / 未確認 |
| 水中の息 | 潜った時 | 4 手 | 未確認 |
| ブレーカー | 開けた時 | 次の手に閉じる | 確認済み |
| 陽動 | パン屑を食べ終えた時（置いてから約 5 手） | 3 手だけ探照灯が塔から外れる | 確認済み |

### 5.3 乱数

- **毎回変わるもの**: 配線図の凡例、無線で言われる線の名前、ジープのダイヤル値（20〜80）。種 1〜15 で、ダイヤル 22〜75、切る色は 4 色すべてが出た [確認済み]。
- 待ちの回数（少女、泡、宇宙、ココナッツ、渡し舟、陽動、5:29 までの `look` の数）は、種 1〜15 ですべて同じだった [確認済み]。それでも「`look` × n」ではなく、各節に書いた**目印の文言が出るまで待つ**こと。

---

## 6. 確認済みコマンド列（種 1〜15 で 100/100・419 手）

ドライバーに流したスクリプトそのもの。`# ...` は区切りの説明でコマンドではない。`@until 文言 | look | 上限` は「直前の出力に文言がなければ、出るまで `look` を送る」の意味（括弧内は実際の回数）。`{DIAL}` はジープで読んだ数字、`{WIRE}` は 4.12 の 9. で決めた色。

```
# ===== London =====
x
north
buy bag
take bag
take coin
east
@until paper bird | look | 4                 (1 回)
take bird
south
examine sundial
unscrew gnomon from sundial
take gnomon
northeast
south
take ball
north
north
@until branches of the tree | look | 4       (1 回)
throw ball at umbrella
take umbrella
southwest
northwest
open pram
push pram southeast
eat crumbs
look
enter pram
open umbrella
take all
east
look
east
look                                         (タイトル画面のキー入力)
# ===== fantasy prep =====
north
east
north
kick log
take splinter
southeast
southwest
east
north
up
take axe
south
down
east
northwest
northeast
northwest
chop oak with axe
push oak north
southeast
west
north
north
screw gnomon into sundial
turn ring to 6
lower lever
south
south
south
southwest
east
north
up
south
down
drop axe
# ===== Nagasaki =====
west
northeast
northeast
east
in
open umbrella
take all
east
take spade
west
@until little girl races | look | 8          (3 回)
give paper to girl
give umbrella to girl
climb on bird
in
# ===== Cemetery / Barrow / Nevada / ice =====
west
west
north
north
turn ring to 3
south
south
west
west
north
open lid with spade
take shroud
take bandage
take silver coin
drop spade
drop bandage
take red boot
take green boot
drop red boot
drop green boot
north
north
search bones
take key
in
take lantern
turn on lantern
west
take walkie-talkie
drop lantern
west
put splinter in crevice
take skink
put skink in pocket
east
take lantern
east
east
south
put key in hole
turn key with hands
down
turn off lantern
hit icicles with shroud
take icicle
east
northeast
southeast
north
north
drop icicle
# ===== meteor and space =====
turn ring to 2
drop lantern
drop walkie-talkie
drop shroud
take icicle
south
south
northeast
east
east
put icicle on lump
take lump
west
southwest
southwest
southwest
east
take axe
west
northeast
northwest
north
north
in
@until enveloped in a soapy film | look | 6  (3 回)
south
southwest
in
@until pulling you towards the satellite | look | 6   (3 回)
take skink
squeeze skink
@until heading straight for the white door | look | 3 (1 回)
hit bubble with axe
# ===== cottage, garden, tundra =====
northeast
southeast
north
north
turn ring to 5
south
south
northeast
west
northeast
open front door
east
take cage
open cage
open back door
east
search pile
take garlic
in
down
northeast
northeast
look in fissure
take lemming
put lemming in cage
close cage
southwest
southwest
up
in
west
put garlic in cauldron
put skink in cauldron
west
drop cage
# ===== atoll =====
southwest
east
southwest
north
north
turn ring to 4
south
south
northeast
west
north
in
down
open box
push button
south
west
@until floats away from the distant islet | look | 20   (12 回)
ask dolphin about coconut
take coconut
southeast
north
up
in
# ===== cauldron =====
south
northeast
east
drop coconut
hit coconut with axe
take coconut
put coconut in cauldron
west
southwest
east
reach into hive
west
west
east
east
reach into hive
west
northeast
east
put hand in cauldron
west
@until BOOM | look | 5                       (1 回)
east
take emerald
# ===== boots, loadout, ferry =====
west
southwest
west
southwest
north
take red boot
take green boot
put emerald in green boot
wear red boot
wear green boot
south
northeast
southeast
north
north
drop axe
take walkie-talkie
take shroud
take lantern
wear shroud
turn ring to 7
south
south
northeast
west
northeast
take cage
southwest
southeast
south
@until soundless landing | look | 14         (2 回)
enter dory
give silver coin to oarsman
south
remove shroud
drop shroud
in
# ===== Trinity =====
open book
take slip
examine slip
examine diagram
drop slip
@until motor revving | look | 6              (1 回)
west
down
down
take ruby
put ruby in red boot
northwest
northwest
northwest
in
examine dial
out
move slider to {DIAL}
raise antenna
turn on rocker switch
southeast
southeast
southeast
southeast
southeast
open gate
southeast
south
open door
east
take knife
north
east
north
close door
open cage
open door
south
search paper
take screwdriver
drop cage
west
south
west
north
northwest
east
east
drop bag
southeast
drop walkie-talkie
drop knife
drop screwdriver
turn on lantern
up
take binoculars
down
take binoculars
take lantern
up
turn off lantern
south
down
northeast
drop lantern
take walkie-talkie
take knife
take screwdriver
northwest
take bag
west
west
northwest
northwest
south
south
south
south
look at shelter through binoculars
@until roadrunner | look | 4                  (1 回)
roadrunner, take key
take key
north
north
north
north
unlock padlock with key
remove padlock
drop padlock
open box
open breaker
close breaker
southwest
southwest
southwest
southwest
drop bag
@until begins to peck | look | 4             (1 回)
northeast
northeast
northeast
northeast
@until sweeps away suddenly | look | 3       (0 回。Base に着いた手に出た)
up
up
east
pull chain
open enclosure with screwdriver
@until Sequencer will assume control in fifteen seconds | look | 30   (15 回)
cut {WIRE} wire with knife
# ===== epilogue =====
north
east
northeast
@until It's time | look | 4                  (1 回)
look                                         (結末画面のキー入力)
```

---

## 7. 補足

- **不要な物**: サッカーボール（傘を落とすだけ）、小銭、クレジットカード、包帯、ジープの財布、Trinity の book、南京錠、経帷子（渡し舟の後）。
- **ヒントの声**: 要所で耳元の声が gnomon の駄洒落を言う（`Gnomon is an island` など）。正しい行動の合図。
- **カササギ**: 鳥かごを取ると大鍋のレシピの一節を口ずさむ。魔女の本（`read book`）は、プレイヤーがこれまで打ったコマンドを表示する仕掛け。
- **Klein の瓶**（Arboretum の彫刻）: 物を入れるとアーチの頂上へ移る。使い道は未確認。
- **時刻**: 腕時計（`examine watch`）。Trinity では walkie-talkie の秒読み（`Zero minus ... minutes`）が目安。
- **旧版（trinity-guide-old.md）からの主な訂正**: 渡し舟は経帷子を着て乗る / ランタンの電池を節約し Trinity に持ち込む / ブーツを履いて重さを減らす / 環礁の扉は `push button` / 割ったココナッツは拾ってから入れる / Trinity の手順（毒蛇は Closet に逃げ込んでレミングを放す、双眼鏡は水底で拾う、袋をロードランナーに食べさせない、塔の登り直しは番犬の陽動、`turn on rocker switch`、`remove padlock`）/ 結末への道は Round Pond の `northeast`。
