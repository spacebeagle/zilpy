# Enchanter ゲームプレイ解説（LLM 攻略用リファレンス）

ZilPy で変換した Infocom 版 *Enchanter*（1983 年、Release 88 / Serial number 840726）を、`out/enchanter` で `python enchanter.py` を直接実行して遊ばせるときの参考資料としてまとめた攻略メモ。
読者は「次にこのゲームを遊ぶ LLM」。このガイドとゲームの出力だけで 400/400 点のクリアまで進めることを目標にしている。

> 注意: 解き方がすべて書かれています。自分で解きたい人は読まないでください。
> Enchanter にはオープンなライセンスがないため、ZilPy のリポジトリにはゲームの元データや変換結果を含めていません。
> この資料は、実際のプレイと動作検証をもとに日本語でまとめたものです。ゲームの文章は転載していません（コマンドと、場面を見分けるための短い語句だけを英語のまま書いています）。
> 権利者から申し出があれば、速やかに修正・削除します。

## 何を元に作り、どこまで確かめたか

- 元にしたもの: 実際のプレイおよび動作検証の結果。
- 直接実行での検証（手順書の段階 4）: スクラッチパッドのドライバーから Python 版を起動し、第 6 章のコマンド列を乱数の種 1〜40 で流した。
  - **40 回中 39 回で 400/400 点のクリアまで到達**した（種 1 で 249 手）。外れた 1 回（種 2）は、冒険者が鏡の向こうで何度も素通りし、待っている間に疲れがたまって呪文を忘れたのが原因（255 点。4.11 の注意点に反映済み）。
  - ドライバーでは、渇き・空腹の表示が出たら `drink water` / `eat bread` を差し込み、`You're holding too many things already.` が出たら同じコマンドをやり直すようにした。ただし 4.11 の zifmia から Map Room に入るまでは何も差し込まない。読者も同じ対処をすること。
  - 4.11 で冒険者が地図か鉛筆を持って行ってしまった場合（40 回中 18 回）は、4.11 の手順 8 のとおり後を追って返してもらった。
- 直接実行での通しプレイ: `out/enchanter` で `python enchanter.py` を直接実行して通しプレイを行い、400/400 点（251 手）でクリアした。
- 根拠の印:
  - 「確認済み」= 直接実行で出力を見た内容。
  - 「未検証」= 挙動の知見としてまとめているが、直接実行では確かめていない内容。
  - 印は節の見出しにまとめて付けている。
- プレイ中にゲームの出力とこのガイドが食い違ったら、**ゲームの出力を正とする**こと。

---

## 0. 最初に読むこと（Python 版固有の落とし穴）

### 0.1 パーサーの落とし穴【確認済み】

| やりたいこと | 通らない書き方 | 通る書き方 |
|---|---|---|
| 亀に方向を指示する | `turtle, go southeast` / `turtle, go northwest`（`I don't know the word "southeast".`） | `turtle, go se` / `turtle, go nw`（方角は略語で書く） |
| 機械室越しに亀に命令する | 亀が向こう側に渡った後で `turtle, take scroll`（騒音で聞こえない） | **1 行にまとめる**: `turtle, go se. take scroll. go nw`（`then` でつないでもよい） |
| 亀について来させる | — | `turtle, follow me` |
| 地図に線を引く | — | `draw line from p to f`（`line` は無視される語） |
| 線を消す | — | `erase line from m to v` |
| 呪文を唱える | — | `rezrov gate` のように呪文名を動詞として使う。自分にかけるときは `ozmoo me` / `melbor me` / `izyuk me` |
| 呪文を本に写す | — | `gnusto rezrov`（巻物を手に持っていること） |
| 呪文を覚える | — | `learn rezrov`（本を持っていて、明るい場所にいること） |
| 覚えている呪文を確かめる | — | `spells` |
| 体調を確かめる | — | `diagnose` |
| ベッドで寝る | — | `get in bed`（十分に疲れていればそのまま眠る）→ 起きたら `get out of bed` |
| 冒険者に扉を開けさせる | — | `point at door` |
| 冒険者が持っている物を返してもらう | — | `take pencil` / `take map`（vaxum で魅了している間だけ渡してくれる） |
| 時間 | — | `time`。空を見る `examine sky` でも分かる |

### 0.2 その他の実プレイ上の教訓【確認済み】

- 元のゲームの表示の癖として、その場にいない冒険者などを呪文の対象にすると `You can't see anyadventurer here.` のように空白が抜けて表示されるが、害はない。

- **`wait`（`z`）は 1 回で時計が 3 つ進む**（途中で何か起きるとそこで止まる）。1 ターンだけ進めたいときは `look` を使う。地図の場面（4.12）では絶対に `wait` を使わないこと。
- **`save` / `restore` はゲーム内コマンドとして使える**（`Ok.` が出る）。保存先は 1 つだけなので、上書きに注意する。
- **持ち物の数が多いと `take` に失敗する**（`You're holding too many things already.`）。疲れているほど失敗しやすい。同じ `take` をもう一度送ればたいてい通る。失敗の確率を下げるために、不要な物はこまめに捨てること。
- **重さの制限もある**（`Your load is too heavy`）。地図（map）は中身の点も含めて非常に重く、他の物を持ったままでは持てない。**地図は持ち歩かずに、地図の部屋の床に置いたまま使う**（4.12）。
- 初期設定は簡易表示で、2 回目以降に入った部屋は名前しか出ない。部屋の説明を見たいときは `look`。
- 外の部屋（Fork、Courtyard など）は昼は明るいが、**夜（`It is night.` の後）は暗くなる**。frotz した lantern を常に持っていれば問題ない。

---

## 1. ゲームの目的と全体の流れ【確認済み】

勝利条件: **Krill の塔（Warlock's Tower）で、dragon を `gondar dragon`、monster を `cleesh monster`（または `vaxum monster`）で退けた後、`guncho krill` を唱える。** これで 400 点満点、ゲームは終了する。

### 依存関係

```
guncho krill（勝利）
 ├ powerful scroll（guncho）← 迷路の P の部屋 ← 地図と鉛筆で Terror を閉じ込める（4.12）
 │     ├ 地図・鉛筆 ← Map Room ← Guarded Door を冒険者に開けさせる（4.11）
 │     │     ├ zifmia（冒険者を呼ぶ）← faded scroll ← shredded scroll を krebf で直す
 │     │     │     ├ shredded scroll ← 卵（Jewel Room）を rezrov で開ける
 │     │     │     └ krebf ← crumpled scroll（North Gate の北の Forest。門は rezrov）
 │     │     ├ vaxum（冒険者を魅了する）← gold leaf scroll（寝室のベッドの柱。rezrov）
 │     │     └ 宝物を持っている（冒険者がついて来る条件）← sacrificial dagger
 │     └ Junction を通る ← melbor（自分を守る）← vellum scroll ← 宝石箱の縄を dagger で切る
 ├ Krill の塔に入る ← Winding Stair を kulcad で消す → ornate scroll（izyuk）で飛んで東へ
 │     └ brittle scroll（kulcad）← 機械室の奥（Control Room）← 亀に取ってこさせる（nitfol + exex）
 ├ gondar（dragon）← frayed scroll ← 図書館の鼠の穴
 └ cleesh（monster）← damp scroll ← Swamp の蓮の葉の下
 sacrificial dagger ← 神殿で生贄にされても生き残る ← ozmoo ← black scroll（Gallery の肖像画の裏）
```

### 進行順（第 6 章のコマンド列の順）

1. **外**（4.1）: lantern に frotz、jug・bread、小川で水、老婆から rezrov、鉄の門を rezrov で開けて城へ。
2. **Gallery**（4.2）: 明かりを置いて入り、光る肖像画の裏から ozmoo の巻物を取る。
3. **寝室**（4.3）: bedpost を rezrov → vaxum を本に写す。
4. **神殿**（4.4）: ozmoo を自分にかけてから捕まり、生贄にされて生き残る → dagger。
5. **Closet**（4.5）: dagger で縄を切る → melbor を唱える（以後、怪物に襲われない）。
6. **地下牢**（4.6）: exex の巻物。
7. **亀**（4.7）: nitfol → 機械室へ連れて行く → exex → 1 行の命令で kulcad の巻物を取ってこさせる。
8. **睡眠**（4.8）: 寝室のベッドで寝る。呪文を覚え直す。
9. **卵・森・沼・図書館**（4.9, 4.10）: rezrov egg → krebf で修理（zifmia は本に写す）→ cleesh の巻物 → gondar の巻物。
10. **冒険者と扉**（4.11）: 鏡の間で zifmia → vaxum → Guarded Door で `point at door` → Map Room で鉛筆を手に、地図を床に確保する（冒険者が持って行ったら返してもらう）。
11. **Terror の迷路**（4.12）: Map Room で線を 5 手で描き替え → 迷路で guncho の巻物を取り、入口へ戻る。
12. **階段と塔**（4.13）: Junction 東の階段を kulcad → izyuk → 東へ → gondar → cleesh → guncho。

### 得点表（400 点満点。種 1 で全項目の加点を確認済み）

| 行為 | 点 | 節 |
|---|---|---|
| 鉄の門を rezrov で開ける | 20 | 4.1 |
| 物に frotz をかける（lantern） | 20 | 4.1 |
| 初めて水を飲む | 15 | 4.1 |
| 初めて bread を食べる | 10 | 4.3 |
| 光る肖像画をどける（Gallery） | 25 | 4.2 |
| bedpost を開ける（rezrov か、夢の後にボタン） | 20 | 4.3 |
| 生贄にされて ozmoo で生き残る | 35 | 4.4 |
| 宝石箱の縄をほどく（dagger） | 25 | 4.5 |
| 亀が brittle scroll を持ってくる | 25 | 4.7 |
| 卵を開ける（rezrov） | 5 | 4.9 |
| shredded scroll を krebf で直す | 10 | 4.9 |
| 鼠の穴から frayed scroll を取る | 25 | 4.10 |
| 冒険者を zifmia で呼び出す | 10 | 4.11 |
| 冒険者に Guarded Door を開けさせる | 35 | 4.11 |
| Terror を閉じ込め、guncho の巻物を持って入口の部屋へ戻る | 50 | 4.12 |
| 階段を kulcad で消す | 10 | 4.13 |
| izyuk で飛んで Krill の塔へ着く | 10 | 4.13 |
| Krill に guncho | 50 | 4.13 |
| **合計** | **400** | |

得点の推移（種 1）: 門を開けた後 55 点（34 手）→ 神殿の後 145 点 → 亀の後 195 点 → 図書館の後 235 点 → 扉の後 280 点 → 迷路の後 330 点 → 400 点（249 手）。

減点: 地図か鉛筆に kulcad をかける、または Terror が迷路の入口に着くと「世界の終わり」となり、得点が −10 になってゲームが終わる（未検証）。

---

## 2. 詰み条件の一覧（絶対に避ける）【未検証。※印は確認済み】

| やってはいけないこと | 結果 |
|---|---|
| **自分に frotz をかける**（`frotz me`） | 自分が永久に光るため、Gallery の光る肖像画が二度と現れない → ozmoo が取れない → 生贄で死ぬ → dagger が手に入らない |
| ozmoo を唱えずに神殿に入る（melbor を唱えた後も含む） | 生贄にされて本当に死ぬ（死亡回数 +1）。melbor を先に唱えると捕まらなくなり、dagger の 35 点が取れない |
| 捕まる・死ぬときに **brittle scroll（kulcad）か powerful scroll（guncho）** を持っている | 没収されて消える → 階段か Krill が解けなくなる |
| **kulcad を Guarded Door に使う** | 扉は開くが 35 点が入らず、巻物も失う → 階段が消せない |
| kulcad / guncho を `gnusto` しようとする | 写せない（巻物は残る）が、Krill に心を探られる回数が増える（下の「探り」の行） |
| 迷路と塔の外で kulcad / guncho を唱える、写そうとする（「探り」） | 1 回ごとに頭痛の表示が出る。合計 4 回目で Krill が現れて殺される（ゲーム終了） |
| ※**巻物から zifmia を、冒険者が見えていない時に唱える** | 巻物だけが消えて効果が無い。faded scroll は **必ず先に `gnusto zifmia`** して本に写す |
| ※**冒険者が鉛筆か地図を持っている時に `blorb adventurer`** | 冒険者と一緒に消える → 迷路が解けない |
| ※地図の線の 5 手（4.12）の順番やターン数を崩す（間に `wait` や食事を挟む） | Terror が迷路の入口に着いて世界の終わり（−10 点で終了） |
| 地図か鉛筆に kulcad | 世界の終わり |
| 自分で Engine Room を南東へ渡る / Control Room から北西へ戻る | 死ぬ（ozmoo も効かない）。戻るときに kulcad の巻物を持っていると、それも消える |
| 亀に exex をかけずに機械室を渡らせる | 亀が死ぬ → kulcad の巻物が取れない |
| 宝石箱の縄に guncho | 箱ごと消える（melbor の巻物も消える） |
| 冒険者を攻撃する | 返り討ちで死ぬ |
| 自分に guncho / blorb / cleesh | ゲーム終了、または死ぬ |
| Krill に zifmia | 死ぬ |
| 塔で dragon / monster に間違った呪文を唱える、2 ターン以内に唱えない | 死ぬ（塔ではやり直しが利かないので、塔に入る前に必ず `save`） |
| 穴に落ちてから 5 ターン以内に izyuk しない / 飛んでから 4 ターン以内に `e` しない | 永遠に落ち続けて終了 |
| 暗い部屋から暗い部屋へ明かり無しで移動する | 85〜90% の確率で食われて死ぬ |
| melbor を唱える前に、外で眠る / 寝る | 外では 20% の確率で襲われる（さらにその 45% で死ぬ）。どこで寝ても、他の夢が出ない夜は 50% の確率で持ち物（spell book を含む）が Krill の塔へ盗まれる |
| 4 回死ぬ | ゲーム終了（3 回までは Eastern Fork で生き返る。2.1 参照） |

### 2.1 死んだときの扱い【未検証】

- 3 回までは Circle に生き返らせてもらい、Eastern Fork に戻される。4 回目の死でゲーム終了。
- 生き返ると、覚えていた呪文はすべて忘れる。持っていた巻物はその場に落ちる。kulcad と guncho の巻物は Belboz に没収されて消える。spell book は手元に戻る。jug と bread は Eastern Fork に置かれる。
- ozmoo が効いている間（唱えてから 8 ターン）に殺されると、多くの場合は生き残る。機械室の罠や渇き・空腹による死は防げない。

---

## 3. 基本システム・共通の仕掛け

### 3.1 呪文の仕組み【確認済み】

- 手に持った巻物の呪文は、**そのまま 1 回だけ唱えられる**（唱えると巻物は消える）。1 回しか使わない呪文はこの使い方で十分。
- `gnusto <呪文>` で巻物を spell book に写すと、巻物は消えて、その呪文を何度でも覚え直せるようになる。kulcad・guncho・filfre は長すぎて写せない（巻物のまま使う）。
- 本の呪文は `learn <呪文>` で覚え、唱えるたびに 1 回分を忘れる。同じ呪文を何回か覚えておくこともできる。
- 一度に覚えられる数には上限がある（最初は 4 程度。眠るたびに 1 増える）。上限を超えて覚えると、他の呪文を 1 つ忘れることがある。**疲れても上限が減り、覚えていた呪文を忘れていく**（`the spells you've memorized are becoming confused` が目印）。`spells` でこまめに確かめること。
- 眠ると覚えていた呪文はすべて忘れる（gnusto だけは常に使える）。
- 最初に本にある呪文は gnusto・frotz・blorb・nitfol。frotz と blorb は 1 回ずつ覚えた状態で始まる。

呪文の一覧（どこで手に入れ、何に使うか）

| 呪文 | 効果 | 入手場所 | このガイドでの使い道 |
|---|---|---|---|
| gnusto | 巻物を本に写す | 最初から | 各所 |
| frotz | 物を光らせる | 最初から（1 回覚えている） | lantern |
| blorb | 物を強い箱に封じる | 最初から（1 回覚えている） | 使わない（冒険者を消すこともできるが、必要ない） |
| nitfol | 動物と話す（20 ターン） | 最初から | 亀 |
| rezrov | 開ける | 村の老婆（scribbled scroll） | 鉄の門・bedpost・卵・北門 |
| ozmoo | 不自然な死を防ぐ（8 ターン） | Gallery の肖像画の裏（black scroll） | 神殿の生贄 |
| vaxum | 敵を味方にする | 寝室の bedpost（gold leaf scroll） | 冒険者（monster にも効く） |
| melbor | 邪悪な者から身を守る（永続） | 宝石箱（vellum scroll） | Junction・図書館・宴会場を通る |
| exex | 速くする（亀は 15 ターン） | 地下牢の秘密の通路（stained scroll） | 亀 |
| kulcad | 魔法を解く | 機械室の奥の Control Room（brittle scroll） | 階段 |
| krebf | 壊れた物を直す | 北門の北の Forest（crumpled scroll） | shredded scroll |
| zifmia | 見えている者を呼び寄せる | 卵の中の shredded scroll を krebf で直す（faded scroll） | 冒険者 |
| cleesh | 生き物をイモリに変える | Swamp の蓮の葉の下（damp scroll） | monster |
| gondar | 火を消す | 図書館の鼠の穴（frayed scroll） | dragon |
| guncho | 別の世界へ追放する | 迷路の P の部屋（powerful scroll） | Krill |
| izyuk | 飛ぶ | 階段を kulcad で消すと手に入る（ornate scroll） | 穴から塔へ |
| filfre | 花火（何の役にも立たない） | Map Room（purple scroll） | 不要 |

### 3.2 渇き・空腹・疲れ・日数【確認済み（日数の上限は未検証）】

- **渇き**: 41 ターン目から `Your mouth is getting rather dry.` → `quite thirsty` → `very thirsty` → `lips are parched` → `feeling faint` と 10 ターンごとに進み、その次で死ぬ。表示が出たら `drink water`。水は **Shady Brook でしか補給できない**（`fill jug with water`。jug 1 杯で 4 回飲める）。海と沼の水は飲めない。
- **空腹**: 67 ターン目から `Your stomach is starting to grumble.` と始まり、進み方は渇きと同じ。`eat bread`（8 回分）。空腹の表示が出る前に食べても「空腹ではない」と言われることがある（害は無い）。
- **疲れ**: 目覚めてから 86 ターンで `You are beginning to tire.` が出て、以後 10 ターンごとに悪化する。そのたびに持てる重さと覚えられる呪文の数が減り、物を取り落としやすくなる。11 回目の表示の次で倒れて眠ってしまう。寝室のベッドで `get in bed` と寝る（疲れが近づくまでは眠れない。初回は開始から 76 ターン以上、2 回目以降は目覚めてから 34 ターン以上）。
- 階段を kulcad で消すと、渇き・空腹・疲れの時計はすべて止まる。
- **日数の上限**: 1 日（128 ターン。眠ると 42 ターン進む）ごとに夜が 20 ターンずつ早く来る。5 回目に日付が変わると「永遠の夜」でゲーム終了。このガイドの手順は 250 手前後で終わるので、気にしなくてよい。

### 3.3 明かり【確認済み】

- 城の屋内は大半が暗い。frotz した lantern は永久に光るので、常に持ち歩く。
- **Gallery だけは明かりを持って入ってはいけない**（4.2）。

### 3.4 城の怪物（hunched and hairy shapes）【確認済み（melbor 後）・未検証（melbor 前）】

- melbor を唱える前に Junction に入ると、すぐに捕まって神殿へ運ばれる。Library と Banquet Hall でも、近づいてくる一団に捕まることがある。神殿に入れば必ず捕まり、北の独房に入れられて 4 ターン後に生贄にされる。
- 生贄の場面は ozmoo で利用する（4.4）。それ以外では、melbor を唱えるまで Junction・Library・Banquet Hall・神殿に近寄らない。
- **melbor は一度唱えれば永続する**。以後は怪物に無視され、Junction も素通りできる。
- 城の部屋は時間とともに少しずつ荒れていく（`grey and lifeless` などの表示）。攻略には影響しない。

### 3.5 地図（主要部分）【確認済み】

外（スタートは Fork）

```
Fork ─NE→ Outside of Shack ─N→ Inside Shack（lantern・jug・oven の中に bread）
 │            └─E→ Trail ─SE→ Trail Head ─NE→ Shady Brook（水）
 │                              └─SE→ Eastern Fork ─E→ Western Road ─E→ Outside Gate ─E→ Inside Gate（城）
 │                                        └─SW→ Village Outskirts ─SW→ Deserted Village ─S→ 老婆の小屋（入ると外へ放り出される）
 └─W→ Long Road（どこまでも続くだけ。行かない）
```

城（`Inside Gate` が入口）

```
                    Jewel Room
                        │U
 Pebbled Path ─N→ NW Tower ─E→ Mirror 1 ─E→ 2 ─E→ 3 ─E→ 4 ─E→ North Gate ─N→ Forest ─E→ Swamp
     │S                                                        │E    │S
 Inside Gate ─E→ Courtyard ─E→ Courtyard ─E→ Temple   Guarded Door  Library
     │S              │S          (中央)      │U Altar   │N(扉の後)    │S
 West Hall        Closet                  N/S 独房   Map Room     Junction ─E→ Landing ─E→ Winding Stair
     │S              │S                                             │S
 SW Tower ─E→ South Hall ─E→ Gallery ─E→ South Gate ─N→ East Hall ─N→ Banquet Hall
     │U              │D                       │E  │S
  Bedroom         Dungeon ─N(扉)→ Cell ─E(石)→ Secret Passage
                     │D               SE Tower    Meadow ─SE→ Beach（亀）
               Translucent Room（迷路）  │U
                                     Engine Room ─SE→ Control Room（自分で渡ると死ぬ）
```

---

## 4. 章別攻略【確認済み】

各節の「手順」は第 6 章のコマンド列と同じ順番。

### 4.1 外: 準備と城の門（34 手、55 点）

1. `ne`、`n`（Inside Shack）。`take lantern`、`take jug`、`open oven`、`take bread`。
2. `frotz lantern`（+20）。frotz は**物にかける**。自分にかけるのは詰み（第 2 章）。
3. `s`、`e`、`se`、`ne`（Shady Brook）。`fill jug with water`、`drink water`（+15）。
4. `sw`、`se`、`sw`、`sw`、`s`（老婆の小屋）。小屋に入ると scribbled scroll を渡されて外へ放り出される。
5. `gnusto rezrov`、`learn rezrov`。
6. `ne`、`ne`、`e`、`e`（Outside Gate）。`rezrov gate`（+20）、`e`。

### 4.2 Gallery: ozmoo の巻物（+25）

1. `s`、`s`、`e`（South Hall）。**`drop lantern`**（明かりを持っていると光る肖像画が現れない）。
2. `e`（Gallery）。`lighted portrait` が見えていることを確かめる（`a single lighted portrait flickers` が目印）。
3. `look behind lighted portrait`（+25）。niche に black candle と black scroll がある。
4. `take black scroll`（candle は要らない）。`w`、`take lantern`。

### 4.3 寝室: vaxum（+20、+10）

1. `w`、`u`（Bedroom）。`learn rezrov`、`rezrov bedpost`（+20）、`take gold leaf scroll`、`gnusto vaxum`。
2. `eat bread`（+10。初回だけ加点）。

### 4.4 神殿: わざと生贄にされる（+35）

このときの持ち物は没収されて南の独房へ運ばれる。brittle scroll と powerful scroll はまだ持っていないので問題ない（持っていたら消える）。

1. `d`、`n`、`n`、`e`、`e`（中央の Courtyard）。
2. **`ozmoo me`**（black scroll から唱える。効き目は 8 ターン）。
3. `e`（Temple）。すぐに捕まり、北の独房へ入れられる。
4. `look` を 1 回、`wait` を 1 回。4 ターン目に祭壇へ運ばれて刺されるが、生き返って sacrificial dagger を手に入れる（+35）。Sacrificial Altar に立っている。
5. `look`、`wait`、`d`（Temple）、`open south door`、`s`、`take all`（持ち物を取り戻す）、`n`、`w`。生き返ってから 10 ターンは神殿にいても捕まらない。

### 4.5 Closet: 宝石箱と melbor（+25）

1. `w`、`s`（Closet）。`cut rope with knife`（+25）、`open box`、`take vellum scroll`。
2. **`melbor me`**。以後、怪物に襲われない（永続）。宝石箱は重いので置いていく。

### 4.6 地下牢: exex の巻物

1. `s`、`d`（Dungeon）。`open door`、`n`、`read wall`（石がゆるんでいるのが分かる）、`take block`、`e`。
2. `take stained scroll`。silver spoon は取らない（荷物の数を増やさないため）。
3. `w`、`s`、`u`（South Hall）。

### 4.7 亀: kulcad の巻物（+25）

nitfol は 20 ターン、亀にかけた exex は 15 ターンで切れる。手順の途中で寄り道しないこと。

1. `e`、`e`、`s`、`se`（Beach。亀がいる）。
2. `learn nitfol`、`nitfol turtle`、`turtle, follow me`。
3. `nw`、`n`、`e`、`u`（Engine Room）。亀がついて来ていること（`follows you`）を毎回確かめる。
4. `exex turtle`（stained scroll から唱える）。
5. **`turtle, go se. take scroll. go nw`**（必ず 1 行で送る）。亀が渡って巻物をくわえて戻り、`The turtle drops a brittle scroll at your feet.` と出れば成功（+25）。
6. `take brittle scroll`（取り落としたらもう一度）。**自分では絶対に南東へ渡らない。**

### 4.8 寝室で眠る

この時点で疲れが出始めている（`You are beginning to tire.`）。

1. `d`、`w`、`w`、`w`、`w`、`u`（Bedroom）。
2. `get in bed`。そのまま眠り、夢を 1 つ見て目覚める。`get out of bed`。
3. 目覚めると覚えていた呪文はすべて消えている。`drink water`、`eat bread` をしてから、`learn rezrov` を 2 回、`learn vaxum`、`learn blorb`。`spells` で確かめる。

melbor を唱えた後なので、寝ている間に襲われたり盗まれたりしない。

### 4.9 卵と krebf（+5、+10）

1. `d`、`n`、`n`、`n`、`n`、`u`（Jewel Room）。`take egg`、`rezrov egg`（+5）、`take shredded scroll`、`drop egg`（卵は用済み。荷物を減らす）。
   - 卵のつまみを手で動かすのは避ける。開いた後に動かすと中の巻物が切り刻まれる。
2. `d`、`e`、`e`、`e`、`e`、`e`（North Gate）。`rezrov gate`、`n`（Forest）。
3. `take crumpled scroll`、`krebf shredded scroll`（crumpled scroll から唱える。+10。faded scroll になる）。
4. **`gnusto zifmia`**（faded scroll を本に写す。巻物のまま唱えると失敗しやすい。第 2 章）。

### 4.10 沼と図書館（cleesh、+25）

1. `e`（Swamp）。`look under lily pad` で damp scroll（cleesh）を取る。
2. `w`、`s`、`s`（Library）。`examine tracks`、`reach in hole`（+25。frayed scroll = gondar）。
3. `n`、`w`（Hall of Mirrors Four）。

### 4.11 冒険者と Guarded Door（+10、+35）

**乱数の場面。** 鏡の向こうに冒険者が現れる確率は 1 ターンに 15% ほどで、現れても 25% ほどの確率で立ち去る。

冒険者は自分で城の中を歩き回る。魅了（vaxum）した直後の 1 ターンと、あなたが宝物（dagger）を持って移動したときだけ、その場に残るかついて来る。**それ以外のターンには、たいてい別の部屋へ立ち去る。** そのため、zifmia から Map Room までは 1 手も無駄にしない。

1. 待つ前に `drink water`、`eat bread` を済ませる（手順 4〜7 の途中で食事を挟むと、その 1 手の間に冒険者が立ち去る）。
2. `learn zifmia`（vaxum は 4.8 で覚えたもの）。
3. 鏡の向こうに冒険者が見えるまで `look` を繰り返す。見えている目印は `comes into view` か、部屋の説明の `can be seen through the "mirror"`。同じ出力に `walks off` も出ていたら、もう立ち去っているので待ち続ける。
   - 待ちが長引くと疲れがたまる。`the spells you've memorized are becoming confused` が出たら `spells` で確かめ、zifmia と vaxum を覚え直す（種 2 はこれで失敗した）。
   - 水が尽きたら（`the jug is now empty`）Shady Brook まで汲みに戻る。
4. 冒険者が見えている間に `zifmia adventurer`（+10）。**すぐに** `vaxum adventurer`（魅了は 20 ターン）。
5. **すぐに** `e`、`e`（Guarded Door）。`The adventurer, proceeding cautiously, follows you.` が毎回出ることを確かめる（dagger を持っているのでついて来る）。
   - 冒険者がいなくなっていたら（`leaves the room, heading to the ...`）、その方角へ追いかけ、同じ部屋に入れたら Guarded Door まで連れて行く。
6. **`point at door`**（+35）。冒険者が扉を開けて、先に Map Room へ上がる。
7. `drop dagger`（以後は不要。冒険者がこれに引かれて戻ってくる）、`n`（Map Room）。
8. **鉛筆を手に、地図を Map Room の床に確保する。** 冒険者は先に Map Room に入ったときに、鉛筆・地図・purple scroll を拾って行くことがある（検証では 40 回中 18 回）。
   - 床に `badly worn pencil` と `old parchment map` が両方あれば、`take pencil` だけでよい。
   - 無ければ冒険者が持っている。冒険者は dagger を拾いに Guarded Door へ戻っていることが多いので、`s` で探す。**冒険者と同じ部屋に入ったら、その場ですぐに** `take pencil` / `take map`（魅了されているので `hands it to you gladly` と渡してくれる）。1 手遅れると、また別の部屋へ立ち去る。
   - 冒険者は 1 手ごとに `leaves the room ... heading to the <方角>` と動くので、その方角へ追いかける。追いつけない手が続いても、魅了が続く 20 ターンのうちにたいてい追いつける。
   - 鉛筆と地図がそろったら Map Room へ戻り、`drop map`（地図は重いので床に置いて使う）。
   - 冒険者を blorb する必要はない（以前の版で `**BUG` の表示を止めるために使っていた手順。冒険者が鉛筆か地図を持っているときに blorb すると、それごと消えて詰む。第 2 章）。

### 4.12 Terror の迷路（+50）

地図の 9 つの点は迷路の 9 部屋に対応する。B が入口（Dungeon の下）、P が guncho の巻物と Terror がいる部屋。

```
初期の地図          5 手の後
B       J          B       J
!      / \         !      / \
!     /   \        !     /   \
!    /     \       !    /     \
!   K       V      !   K       V
!          / \     !
!         /   \    !
!        /     \   !
R-------M       F  R-------M       F
 \     /            \     /       /
  \   /              \   /       /
   \ /                \ /       /
    H       P          H-------P
```

仕組み（挙動は実行で確認済み）:

- P に線がつながると、Terror は 1 ターンに 1 部屋ずつ B へ向かう。B に着くと世界の終わり。
- B へ向かう道が無くなると Terror は閉じ込められ、隣の部屋にあなたが来たときだけ近づいてくる。
- 鉛筆で引ける線は 2 本、消しゴムで消せる線も 2 本だけ。

手順（**Map Room で、地図を床に置き、鉛筆を持って行う**）:

1. 先に `eat bread`、`drink water` を済ませる。
2. 次の 5 手を、**間に何も挟まずに**この順で送る。2 手目は必ず `look`（`wait` は 3 ターン進むので不可）。
   1. `draw line from p to f` — Terror が動き出す（Belboz が現れて警告する）。
   2. `look` — Terror が V の部屋まで来るのを 1 ターン待つ。
   3. `erase line from m to v` — Terror が V に閉じ込められる。
   4. `erase line from v to f`
   5. `draw line from p to h` — P と H がつながる。Terror は V・J・K の区画に閉じ込められたまま。
3. `read map` で右の図のようになっていることを確かめる。`drop pencil`（用済み）。
4. `s`、`w`、`s`、`s`、`s`、`s`、`s`、`w`、`w`、`d`（Dungeon）。
5. 迷路に入る前に `drink water`、`eat bread` を済ませ、**`drop jug`、`drop bread`、`drop book`**（取り落とし対策。この後は本も水も食べ物も要らない）。
6. `d`（B）、`s`（R）、`se`（H）、`e`（P）、`take powerful scroll`。
7. `w`、`nw`、`n`（B）。`You hear a horrible anguished scream` が出れば +50。
8. `u`、`u`（South Hall）。

### 4.13 階段と Krill の塔（+10、+10、+50）

1. `e`、`e`、`n`、`n`、`n`（Junction。melbor があるので素通りできる）。
2. `inventory` で frayed scroll・damp scroll・brittle scroll・powerful scroll を持っていることを確かめる。**ここで `save`。**
3. `e`、`e`（Winding Stair）。
4. `kulcad stairs`（+10）。階段が消えて穴に落ちる。重い持ち物（lantern など）は落ちて失われる。巻物は残り、ornate scroll（izyuk）が手に入る。
5. **`izyuk me`**（5 ターン以内）。
6. **`e`**（4 ターン以内。+10）。Warlock's Tower に着くと Krill が dragon を呼ぶ。
7. **`gondar dragon`**（2 ターン以内）。次に monster が現れる。
8. **`cleesh monster`**（2 ターン以内。`vaxum monster` でもよい）。Krill が詠唱を始める。
9. **`guncho krill`**（2 ターン以内。+50）。エンディングが表示され、`Your score is 400 of a possible 400` で終了。

塔では、dragon に vaxum・nitfol・guncho、monster に nitfol・guncho を唱えると死ぬ。Krill に cleesh・vaxum は効かない。自分に exex をかけてから塔に入ると、Krill に打ち消される。

---

## 5. 乱数・タイマーまわりの注意

### 5.1 save の置き場所

| 場所 | 理由 |
|---|---|
| 4.4 で `ozmoo me` の直前 | 手順を間違えると本当に死ぬ |
| 4.7 で `exex turtle` の直前 | 亀への命令を間違えると亀が死ぬ |
| 4.11 で `zifmia adventurer` の直前（冒険者が見えている時） | 乱数の場面 |
| 4.12 で 5 手を始める直前 | 1 手でもずれると世界の終わり |
| 4.13 で階段に入る直前 | 塔はやり直しが利かない |

### 5.2 乱数が絡む場面【確認済み】

| 場面 | 何が乱数か | 見分け方と対処 |
|---|---|---|
| 鏡の間の冒険者 | 現れる時機、現れてすぐ立ち去るか | `comes into view` が出て、同じ出力に `walks off` が無ければすぐ `zifmia adventurer`。待ちが長いときは呪文の忘却と水に注意（4.11） |
| 呼び出した後の冒険者 | どの部屋へ歩いて行くか、Map Room の物を拾うか | 魅了の直後は寄り道せずに移動する。鉛筆か地図を持って行かれたら、`heading to the <方角>` を追って、同じ部屋に入ったその手で返してもらう（4.11） |
| `take` の取り落とし | 持ち物の数と疲れで確率が上がる | `You're holding too many things already.` が出たら、同じコマンドを再送するか、不要な物を捨てる |
| 城の怪物・寝ている間の盗難 | 出現する確率 | melbor の後は無関係 |

### 5.3 タイマーの総表【未検証（主要なものは確認済み）】

| タイマー | 起点 | ターン数 | 何が起きるか |
|---|---|---|---|
| 渇き | 開始 / 水を飲んだ時 | 41（飲んだ後は 39 以上）＋ 10 × 5 | 段階的に悪化し、6 段階目で死ぬ |
| 空腹 | 開始 / 食べた時 | 67（食べた後は 47 以上）＋ 10 × 5 | 同上 |
| 疲れ | 開始 / 目覚めた時 | 86 ＋ 10 × 10 | 能力が落ちていき、最後は倒れて眠る |
| ozmoo | 唱えた時 | 8 | 効き目が切れる |
| 神殿の生贄 | 捕まった時 | 4 | 祭壇で刺される |
| 生贄の後の猶予 | 生き返った時 | 10 | 神殿にいても捕まらなくなる時間が終わる |
| nitfol | 唱えた時 | 20 | 動物の言葉が分からなくなる（亀がついて来なくなる） |
| exex（亀） | 唱えた時 | 15 | 亀が元の速さに戻る |
| exex（自分） | 唱えた時 | 45 | 切れると、ひどい空腹・渇き・疲れが来る |
| vaxum（冒険者） | 唱えた時 | 20 | 魅了が解ける |
| 穴に落ちる | kulcad で階段を消した時 | 5 | 永遠に落ちて終了 |
| izyuk | 唱えた時 | 4 | 飛べなくなる（穴の中なら終了） |
| dragon / monster / Krill の詠唱 | それぞれが現れた時 | 2 | 死ぬ（終了） |
| 城が荒れる | 50 ターン目から | 20 ごと | 部屋が 1 つずつ荒れる（攻略には影響しない） |
| 一日 | 開始 | 128（寝ると 42 進む） | 夜が毎日 20 ターン早く来る。5 回目に日付が変わるとゲーム終了 |

---

## 6. 確認済みコマンド列（種 1、400/400 点、249 手）【確認済み】

直接実行で通した列そのまま。（）内は注記で、コマンドではない。【】は乱数で回数や手順が変わる所。

```
ne / n / take lantern / take jug / open oven / take bread / frotz lantern
s / e / se / ne / fill jug with water / drink water
sw / se / sw / sw / s / gnusto rezrov / learn rezrov
ne / ne / e / e / rezrov gate / e
s / s / e / drop lantern / e / look behind lighted portrait / take black scroll / read black scroll / w / take lantern
w / u / learn rezrov / rezrov bedpost / take gold leaf scroll / gnusto vaxum / spells / eat bread
d / n / n / e / e / ozmoo me / e / look / wait / look / wait
d / open south door / s / take all / n / w
w / s / cut rope with knife / open box / take vellum scroll / melbor me
s / d / open door / n / read wall / take block / e / take stained scroll / w / s / u
drink water   （"Your mouth is getting rather dry." が出たため）
e / e / s / se / learn nitfol / nitfol turtle / turtle, follow me
nw / n / e / u / exex turtle / turtle, go se. take scroll. go nw / look / take brittle scroll
d / w / w / w / w / u / get in bed / sleep / get out of bed / spells / diagnose
drink water / eat bread / learn rezrov / learn rezrov / learn vaxum / learn blorb / spells
d / n / n / n / n / u / take egg / rezrov egg / take shredded scroll / drop egg
d / e / e / e / e / e / rezrov gate / n / take crumpled scroll / krebf shredded scroll / gnusto zifmia
e / look under lily pad / w / s / s / examine tracks / reach in hole / n / w
learn zifmia / eat bread / drink water / 【look … 冒険者が見えて "walks off" が無いところまで】
zifmia adventurer / vaxum adventurer / e / e / point at door / drop dagger / n   （この間は何も挟まない）
take pencil   【床に鉛筆と地図が無ければ、冒険者を追って take pencil / take map → Map Room へ戻って drop map（4.11）】
eat bread / drink water
draw line from p to f / look / erase line from m to v / erase line from v to f / draw line from p to h
look / drop pencil / drink water
s / w / s / s / s / s / s / w / w / d / drink water / eat bread / drop jug / drop bread / drop book
d / s / se / e / take powerful scroll / w / nw / n
u / u / e / e / n / n / n / inventory / e / e
kulcad stairs / izyuk me / e / gondar dragon / cleesh monster / guncho krill
```

（`sleep` は `get in bed` で既に眠った後なので、「疲れていない」と言われるだけ。`take brittle scroll` が 2 回あるのは、1 回目の取り落としに備えたもの。どちらも害は無い。）

---

## 7. 補足

### 7.1 攻略に不要な物【未検証】

- purple scroll（filfre）: 花火が出て作者名が表示されるだけ。
- silver spoon、宝石箱、卵: 宝物だが得点は無い（卵は開けた時の 5 点だけ）。冒険者がついて来る条件は dagger だけで足りる。
- Long Road: 西へどこまでも続くだけ。看板の文字を拾い読みできる程度。
- dusty book（図書館）: 迷路と Terror の伝説が読める（ヒント）。
- black candle（Gallery）: 光源になるが、巻物を燃やしてしまう恐れがあるので持たない。
- 鏡を壊すと、その場所では冒険者が現れなくなる（krebf で直せる）。

### 7.2 ヒントになる夢【未検証】

- 寝室で初めてベッドで寝たとき、bedpost にまだ手を付けていなければ、ベッドの柱に巻物を隠す夢を見る。その後で柱のボタン（`push button`）を押しても 20 点が入る。
- Gallery の点を取る前に寝ると、暗闇で 1 枚だけ光る肖像画の夢を見る。
- 扉の夢（第 6 章の列で見る夢）は、Guarded Door の本当の姿が木の扉であることを示している。

### 7.3 エンディング【確認済み】

`guncho krill` の後、Krill が消えて塔が崩れ、Circle に迎えられて終わる。得点は 400/400、称号は `Member of the Circle of Enchanters`。その後 `RESTART / RESTORE / QUIT` を聞かれる。
