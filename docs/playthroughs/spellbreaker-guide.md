# Spellbreaker ゲームプレイ解説（LLM 攻略用リファレンス）

ZilPy で変換した Infocom 版 *Spellbreaker*（1985 年。開始画面の表示は `Release 88 / Serial number 840726`）を、`out/spellbreaker` で `python z6.py` を直接実行して遊ぶときの参考資料としてまとめた攻略メモ。Enchanter 三部作の第 3 作。
読者は「次にこのゲームを直接実行（`python z6.py`）で遊ぶ LLM」。このガイドとゲームの出力だけで 600/600 点のクリアまで進めることを目標にしている。

> 注意: 解き方がすべて書かれています。自分で解きたい人は読まないでください。
> Spellbreaker にはオープンなライセンスがないため、ZilPy のリポジトリにはゲームの元データも変換結果も含めていません。
> この資料は、実際のプレイでの観察と検証をもとに日本語でまとめたものです。ゲームの文章は転載していません（コマンドと、場面を見分けるための短い語句だけを英語のまま書いています）。
> 権利者から申し出があれば、速やかに修正・削除します。

## 何を元に作り、どこまで確かめたか

- 元にしたもの: 実プレイおよび検証実行での観察結果（同梱のヒント冊子・付録情報を含む）。
- 直接実行での検証（手順書の段階 4）: スクラッチパッドのドライバーから Python 版を起動し、第 6 章の手順を流した（2026-11-15）。
  - **乱数の種 1〜200 の 200 回中 200 回、600/600 点でクリア**（553〜679 手、コマンド 443〜519 個）。宝物庫は本来の解き方（jindak 3 回で見分ける。4.19 節）で、200 回とも当たった。
  - ドライバーは出力を読んで分岐している（呪文の失敗、ロック鳥、茶色の岩の動き、宝物庫の明るさなど）。読者も同じ判断をすればよい。判断の仕方は各節に書いた。疲れの判定だけはドライバーがゲームの内部の値を見ているが、読者は疲れの表示（3.2）や `diagnose` で同じことが分かる。
  - 200 回のうち 19 回で死んだ。すべて 4.3 の落下（ロック鳥に拾われない）で、最も多い回は 3 回死んだ（あと 1 回でゲーム終了）。死んだ後は 2.3 の方法で続けられた。
  - 1 回だけ、オブリエットで浮島の tinsot が 2 回続けて失敗した（4.10 の「浮島が作れなかったら」の方法で立て直して 600 点）。
  - 手を直接持てる数の上限（`You're holding too many things`）で拾えなくなることは、0.2 のしまい方に変えてからは 1 回も無かった。
- 直接実行での通しプレイ: **実施済み**（`out/spellbreaker` で `python z6.py` を実行し、600/600 点でクリア）。
- 根拠の印:
  - 「確認済み」= 直接実行で出力を見た内容。
  - 印は節の見出しにまとめて付けている。
- プレイ中にゲームの出力とこのガイドが食い違ったら、**ゲームの出力を正とする**こと。

---

## 0. 最初に読むこと（Python 版固有の落とし穴）

### 0.1 パーサーの落とし穴【確認済み】

| やりたいこと | 通らない書き方 | 通る書き方 |
|---|---|---|
| ラベルを書いた立方体を呼ぶ | `blorple earth cube`（`That sentence isn't one I recognize.`）、`examine earth` | **ラベルを二重引用符で囲む**: `blorple "earth"`、`take "water" from zipper`、`put "life" in zipper` |
| 立方体にラベルを書く | — | `write "earth" on cube`（魔法の burin を持っていること）。書けるのは先頭 6 文字まで（`connectivity` → `"connec"`）。呼ぶときは長いまま書いても通る |
| ラベルの無い立方体を呼ぶ | 手元に立方体が複数あると `take cube` が曖昧になる | `featureless cube`（ラベルを書くと featureless ではなくなるので、未記入の 1 個だけを指せる） |
| 最後に魔法の立方体を取る | `take magic cube`（`You can't see any magic cube here!`） | `take "magic"` |
| 八角形の部屋の北西・北東の壁 | `touch rose to northwest wall`（`You used the word "northwest" ...`） | `touch rose to nw wall`、`touch rose to ne wall`。west・south などはそのまま `west wall` |
| 絨毯で飛び上がる | `fly up`（`That sentence isn't one I recognize.`） | 絨毯に座った状態で `u` |
| 緑の岩に命令する | — | `green rock, north`（方角は north/south/east/west/northeast/southwest） |
| Belboz の質問に答える | — | `answer berknip` のように名前 1 語（4.12） |
| 箱の中・ジッパーの中の物 | — | `take cube from box`、`take book from zipper`（ジッパーは手に持ち、開いていること） |
| 呪文を唱える | — | 呪文名を動詞にする: `lesoch`、`girgol`（目的語なし）、`blorple "earth"`、`liskon me`、`snavig grouper` |
| 呪文を覚える・確かめる | — | `learn blorple`、`spells`（覚えている呪文と回数） |
| 疲れ具合を確かめる | — | `diagnose`（`wide awake` なら眠れない） |

### 0.2 その他の実プレイ上の教訓【確認済み】

- **`wait`（`z`）は 1 回で 1 ターン**。`look` も 1 ターン使う（時間の厳しい場面で `look` を挟まない。雪崩の場面で `look` を挟んで死んだ）。
- `save` は `Okay.` と出る。`restore` は成功しても **何も表示しない**（空の出力になるため、`restore` の後に `look` で場所を確かめる）。**保存先は 1 つだけ**。
- **`save` は乱数の状態も保存する**。`restore` してから同じコマンドを打つと、同じ結果になる（ロック鳥に捕まらない、などの外れは `restore` しても同じ外れが出る）。宝物庫の別解（4.19 の最後）はこれを使う。
- 宝物庫（Outer Vault）の中では `save` できない（`That spell doesn't work here.`）。内側の金庫室（Inner Vault）ではできる。
- 死んでも 3 回までは生き返る（2.3）。
- **手に直接持てるのは 9 個まで**で、**疲れの段階が 1 つ進むごとに 1 個減る**（疲れていると 6〜7 個で `You're holding too many things and can't quite get them all arranged to take it as well.` が出る）。ジッパーの中はいくらでも入り、手持ちの数に数えない。このガイドの手順は次の決まりで手を空けている。出たら、手に持っている要らない物をジッパーに入れてから拾い直せばよい。
  - **burin はジッパーにしまっておき、ラベルを書くときだけ出す**（`take burin from zipper` → `write ...` → `put burin in zipper`）。
  - 金の箱・鍵・羅針盤の薔薇・使い終わった立方体は、手に入れたらすぐジッパーへ。
  - 手に持ち続けるのは、ジッパー・ナイフ（4.17 まで）・呪文書（覚えるとき）・次に blorple する立方体だけ。
- blorple する立方体は **ジッパーから出して手に直接持つ**。呪文書も `learn` のときは手に直接持つ。
- 初期設定は簡易表示で、2 回目以降の部屋は名前しか出ない。

---

## 1. ゲームの目的と全体の流れ【確認済み】

勝利条件: **Castle で、影が超立方体（hypercube）に飛び込もうとした瞬間に girgol で時間を止め、中心の魔法の立方体を抜き取って、魔力を持たない物（燻製の魚）を代わりに入れる。** 時間が動き出すと影が飛び込んで消え、魔法が失われた世界で 600 点満点で終わる。

### 1.1 立方体（13 個）と行き先

立方体はどれも見た目が同じ白い立方体。**拾ったらすぐ `write "名前" on cube` でラベルを書く**（以後 `"名前"` で呼べる）。`blorple "名前"` で、その立方体の部屋（下の表の右端）へ飛べる。

| 立方体（ラベル例） | ある場所 | 取り方（節） | blorple の行き先 | 行き先の出口 |
|---|---|---|---|---|
| earth | Belwit Square | 煙を lesoch で払う（4.1） | Packed Earth | E: Hall of Stone、W: Cave Entrance、S: Cliff Middle、D: 空中（落下） |
| life | Stone Hut（山頂） | 小屋を caskly で直す（4.4） | Soft Room | S: Meadow |
| water | Ogre Lair の金の箱 | 雑草を throck して鬼にくしゃみさせる（4.5） | Water Room | N: Oubliette、S: 海（Mid-Ocean） |
| air | Temple の偶像の口 | malyon → espnis であくびさせる（4.7） | Air Room | N: Glacier、W: Bazaar、S: 空中 |
| change | 水道管の割れ目 | liskon me で小さくなって管を流れる（4.9） | Changing Room | N: Bare Room、W: Carving Room |
| death | Dungeon | オブリエットを凍らせて水で浮かぶ（4.10） | Boneyard | N: Belwit Square |
| connectivity（"connec"） | ロック鳥の巣 | 絨毯で母鳥のいない時に行く（4.11） | String Room | S: Enchanters' Retreat |
| light | 海底の魚の巣 | snavig で魚に化けて潜る（4.13） | Light Room | W: Volcano Base |
| mind | 八角形の迷路の北西の部屋 | 羅針盤の薔薇で迷路を抜ける（4.15） | No Place | E: Inner Vault、S: Plain |
| dark | 平原の茶色い目の岩 | 緑の岩で追い詰める（4.16） | Dark Room | D: Dark Cave |
| fire | 光の池の柱の上 | snavig でグルーに化ける（4.17） | Fire Room | N: Volcano、S: Cliff Top |
| magic | 溶岩の中の岩場 | 金の箱の仕掛け（4.18） | Magic Room | E: Castle（立方体 13 個がそろうと通れる） |
| time | 宝物庫の 12 個の中の 1 個 | 見分けて blorple（4.19） | Sand Room | U: 過去の Ruins Room、D: 過去の Dungeon Cell |

- どの立方体の部屋にも「通れない出口」が 1 つある。金の箱にその立方体を入れたことがあると、その出口は **金の箱が置いてある部屋** へつながる（4.18 で使う）。
- **立方体の部屋の中から blorple しても何も起きない**（`Nothing happens.`）。一度部屋を出てから唱える。
- blorple に使った立方体は手から消え、その部屋を出るときに手に戻る（`... reappears in your hand.`）。
- 立方体を持っているほど呪文が成功しやすい（3.1）。ジッパーの中の物も「持っている」に数える。

### 1.2 依存関係

```
Castle で girgol → 魔法の立方体を抜いて魚を入れる（勝利）
 ├ Castle に入る ← Magic Room の東 ← 立方体 13 個
 ├ girgol を写した vellum scroll ← 過去の Ruins Room で flimsy scroll から写す（魔法の立方体と burin が要る）
 │     ├ vellum scroll ← 過去の Dungeon Cell の戸棚（Belboz の鍵で開ける）
 │     └ 過去へ ← Sand Room ← 時の立方体 ← 宝物庫 ← 魔法の立方体（宝物庫の扉の rezrov）
 ├ 魔法の立方体 ← 金の箱 + 火の立方体 ← グルーに化ける（snavig）+ 闇の立方体
 │     └ 闇の立方体 ← 平原 ← 心の立方体（迷路）+ 溶岩のかけら（光の立方体の部屋の先）
 ├ 光の立方体 ← 魚に化ける（snavig）← 黴びた本を caskly（Dungeon Cell）
 ├ Dungeon ← オブリエットを tinsot で凍らせる ← tinsot（Glacier）← 空の立方体
 ├ 空の立方体 ← 偶像 ← 大蛇を liskon ← liskon（海の瓶）← 水の立方体
 ├ 水の立方体 ← 鬼 ← 雑草（Meadow）を throck ← 命の立方体 ← caskly（ロック鳥の巣）+ 雪崩を girgol
 └ Belboz の鍵 ← つながりの立方体（絨毯で巣へ）← 青い絨毯（Bazaar）← 山頂の金貨
```

### 1.3 進行順（第 6 章の列の順）

1. **Borphee**（4.1）: 会議の場面を待つ → パンと魚 → 広場の煙を lesoch → 土の立方体。
2. **土の部屋から**（4.2〜4.4）: 遺跡でジッパーと flimsy scroll（girgol）→ 穴から落ちてロック鳥に巣へ運ばれ caskly → 崖で雪崩を girgol で止めて山頂へ → 小屋を caskly → 命の立方体。
3. **鬼と海**（4.5, 4.6）: 雑草を鬼の洞窟の前で育てる → 水の立方体・金の箱・espnis → 海で瓶（liskon）。
4. **大蛇と偶像**（4.7）: 空の立方体。
5. **空の部屋**（4.8）: Glacier で tinsot、Bazaar で青い絨毯。
6. **水道管**（4.9）: 小さくなって変化の立方体。
7. **地下牢**（4.10, 4.11）: オブリエットを凍らせて Dungeon へ → 死の立方体・黴びた本（snavig）→ 見張り塔から絨毯で巣へ → つながりの立方体。
8. **Belboz**（4.12）: 質問に答えて鍵。
9. **海底**（4.13）: 魚に化けて光の立方体。
10. **溶岩・迷路・平原**（4.14〜4.16）: 溶岩のかけら → 心の立方体 → 闇の立方体。
11. **グルー**（4.17）: 火の立方体。
12. **魔法の立方体**（4.18）。
13. **宝物庫**（4.19）: 時の立方体。
14. **過去**（4.20, 4.21）: 牢屋に呪文書を残す・遺跡にジッパーを残す。
15. **Castle**（4.22）。

### 1.4 得点表（600 点満点。合計はヒント冊子の内訳と一致し、通しプレイで 600 点を確認済み）

| 行為 | 点 | 節 |
|---|---|---|
| 立方体を初めて取る（13 個 × 25） | 325 | 各節 |
| blorple を初めて使う（読む・唱える） | 15 | 4.2 |
| ジッパーを取る | 10 | 4.2 |
| flimsy scroll（girgol）を取る | 10 | 4.2 |
| stained scroll（caskly）を取る | 10 | 4.3 |
| dirty scroll（throck）を取る | 10 | 4.4 |
| 金の箱を取る | 10 | 4.5 |
| dusty scroll（espnis）を取る | 10 | 4.5 |
| damp scroll（liskon）を取る | 10 | 4.6 |
| white scroll（tinsot）を取る | 10 | 4.8 |
| 青い絨毯を手に入れる | 10 | 4.8 |
| 黴びた本を取る | 10 | 4.10 |
| 黴びた本を caskly で直す | 15 | 4.10 |
| 羅針盤の薔薇を取る | 10 | 4.15 |
| Belboz の質問に答えて鍵をもらう | 25 | 4.12 |
| vellum scroll を取る | 10 | 4.20 |
| 過去の Dungeon Cell を確定させる | 25 | 4.20 |
| 過去の Ruins Room を確定させる | 25 | 4.21 |
| 世界を救う（勝利） | 50 | 4.22 |
| **合計** | **600** | |

得点の推移（確認済み。節の終わりの点）: 4.1 で 25 点 → 4.2 で 60 点 → 4.4 で 105 点 → 4.5 で 150 点 → 4.6 で 160 点 → 4.7 で 185 点 → 4.8 で 205 点 → 4.9 で 230 点 → 4.10 で 280 点 → 4.11 で 305 点 → 4.12 で 330 点 → 4.13 で 355 点 → 4.15 で 390 点 → 4.16 で 415 点 → 4.17 で 440 点 → 4.18 で 465 点 → 4.19 で 490 点 → 4.21 で 550 点 → 4.22 で 600 点。

減点: 最後に別の結末になると得点は −99 になって終わる（4.22）。

---

## 2. 詰み条件の一覧（絶対に避ける）【※印は確認済み】

### 2.1 取り返しがつかないこと

| やってはいけないこと | 結果 |
|---|---|
| **flimsy scroll（girgol）を Cliff Top の雪崩より前に使う／雪崩を止めるのに失敗する** | girgol の巻物は 1 枚きり。山頂へ行けず命の立方体が取れない |
| ※**雪崩の場面で `look` などを挟む** | 雪崩が 2 ターン目に入ると押し流されて死ぬ（死ぬと巻物は残っていない）。押した次の 1 手で girgol |
| ※**海で、手を打たずに 2 ターン過ごす** | 魚（grouper）が水の立方体か瓶を飲み込む。立方体を飲まれると取り戻せない。最初の訪問ではパンを落とす、2 回目は真っ先に立方体を拾う |
| 魚に水の立方体を飲まれる | 13 個そろわなくなる |
| 雑草を剪定ばさみ（shears）で切る | 挿し木になり、育たない（鬼を追い払えない） |
| 呪文書・巻物を濡らす | 読めなくなる（濡れた本からは覚えられない）。海・水道管・満水のオブリエットに入る前は、本と巻物をジッパーに入れて閉じる |
| 小屋の立方体に malyon | 小屋が崩れて死ぬ（命の立方体も失う） |
| 宝物庫の宝物（treasure）を持ち込む・持ち出す | 警報までの呪文の数が減る。持ち出すとがらくたになる。取らないこと |
| **時の立方体を取った後に宝物庫へ戻る** | 番兵が常駐していて殺される |
| ※**Belboz の質問に間違えて答える** | 偽の鍵を渡され、過去の戸棚で使った瞬間にゲーム終了（死の回数に関係なく終わる） |
| Belboz に攻撃・espnis・liskon・snavig・tinsot をかける、手から鍵を奪う | その場でゲーム終了 |
| 過去の Dungeon Cell を条件どおりにせずに出る（4.20） | ゲーム終了（`consciousness is wrenched`）。戸棚をこじ開ける（rezrov）のも不可 |
| 過去の Ruins Room を条件どおりにせずに出る（4.21） | ゲーム終了 |
| 過去の Dungeon Cell の扉から外へ出る | 番兵に殺される（ゲーム終了と同じ扱い） |
| 一度目の過去の Ruins Room を出た後、もう一度上へ行く | 水没していて溺れる（ゲーム終了） |
| Castle で影に気づかれたまま最後を迎える（4.22） | 解凍が間に合わず、影が宇宙を作り変えて −99 点で終わる |
| 超立方体に魔力のある物を入れる・何も入れない | 元に戻る／すべてが消える（どちらも負け） |

### 2.2 死ぬ所

| 場所・行為 | 条件 |
|---|---|
| 暗い部屋から暗い部屋へ歩く | 80% でグルーに食われる。Packed Earth は暗いので、先に `frotz knife` |
| ※Packed Earth の穴から落ちる | 落ちて 1〜3 ターンの間にロック鳥が 25%・50%・75% で拾ってくれる（約 9% で拾われず、数ターン後に地面に激突して死ぬ） |
| ※Cliff Top の雪崩 | 石を動かした次のターン（`almost continuous curtain`）に girgol しないと、その次のターンで押し流される。Cliff Top に立っているだけでも、毎ターン 10%（+10% ずつ）で勝手に崩れ始める |
| 雪崩を止めた後、岩（Boulder）の上で時間が動き出す | 押しつぶされる。girgol は 12 ターン。4 回 `u` で山頂へ抜ける |
| ※鬼の洞窟（Cave） | くしゃみが止まる（throck から 10 ターン）と襲われる。洞窟に 12 ターンいても襲われる。明かり無しで入っても死ぬ。寝床（Ogre Lair）から洞窟へ戻るとき、くしゃみ中でなければ死ぬ |
| 洞窟や Ogre Lair で眠る | 鬼に殺される |
| Glacier | 歩くと 75% でクレバスに落ちる。10 ターンいると凍死（5 ターンで警告）。blorple で出る |
| Emporium（絨毯屋） | 呪文を唱えると追い出される（死なない）。50 ターンいても追い出される |
| 海の底 | 魚の姿から戻って 3 ターンで溺れる |
| 水道管 | 3 ターンごとに下流へ押し流される。Ruined Pipe より先へ流されると死ぬ。管の中で liskon が切れる（15 ターン）と押しつぶされる |
| オブリエット | 水に 10 ターン浸かると凍死（氷の浮島の上なら大丈夫）。Dungeon から、水の無いオブリエットへ落ちると死ぬ |
| ※ロック鳥の巣 | 母鳥がいないときに入ると 5 ターン後に卵がかえり、雛に食われる（※確認済み: 4 ターン目にかえった）。雛がいる巣に入ると即死 |
| 絨毯で巣・見張り塔以外に降りる | 荒野で食われる |
| 溶岩の近くで絨毯で飛ぶ | 燃えて落ちる |
| Temple の偶像 | 生きている（malyon 中の）偶像に登る・触る・攻撃する → 押しつぶされる |
| Grue Cave | グルーに化けずに入ると 2 ターンで食われる。明かりを持ったまま化けても食われる。化けた姿が Grue Cave で元に戻ると食われる |
| Light Pool | グルーの姿で 2 ターン以上いると焼け死ぬ（柱に登れば大丈夫） |
| 宝物庫（Outer Vault） | 中で 3 回呪文を唱える（金の箱に立方体を入れるのも 1 回に数える。rezrov を扉にかけると即座に警報）と警報。その 2 ターン後に番兵に殺される |
| 過去の Ruins Room | 水かさが 4 ターンごとに増え、首まで来ると凍死 |
| 過去の Dungeon Cell | 扉を rezrov すると 2 ターン後に番兵が来て殺される |
| 疲れ | 限界を超えるとその場で倒れて眠る。水の中・落下中・ロック鳥の巣・鬼の洞窟で倒れると死ぬ（3.2） |

### 2.3 死んだときの扱い【確認済み】

- 普通の死に方なら **3 回まで生き返る**。生き返ると Boneyard（死の立方体の部屋）にいて、持ち物はそのまま、**覚えていた呪文はすべて忘れる**。北へ出ると Belwit Square。
- 4 回目の死でゲーム終了。過去の部屋や Belboz がらみの終わり方（2.1）は、回数に関係なくその場で終わる。
- ロック鳥に拾われずに落ちて死んだ場合は、`n`（Belwit Square）→ 呪文書から blorple を覚え直して `blorple "earth"` → `d` からやり直せばよい（検証の 200 回で死んだのは 19 回・22 死、すべてこの落下。1 回のプレイで 3 回続けて落ちて死んだこともある。**3 回死んだ後は後が無い**ので、それ以降はどこでも死なないよう慎重に進める）。

---

## 3. 基本システム・共通の仕掛け

### 3.1 呪文の仕組み【確認済み】

- gnusto・frotz・rezrov の 3 つは **覚え直さなくても何度でも唱えられる**。
- それ以外は、呪文書から `learn` で覚え、唱えると 1 回分を忘れる。失敗しても 1 回分を使う。
- 巻物を手に持っていれば、巻物の呪文をそのまま 1 回だけ唱えられる（巻物は消える）。girgol は長すぎて本に写せない（巻物のまま使う）。
- **呪文は失敗することがある**（`The casting feels wrong, and sure enough, ...`）。その場合は覚え直して唱え直す。
  - 成功率 = 50%（gnusto・frotz は 75%）+ 持っている立方体 1 個につき 5% + その呪文と縁の深い立方体 2 種を持っていればそれぞれ +20%。100% 以上なら必ず成功。
  - blorple は必ず成功。**魔法の立方体を持っていると girgol 以外は必ず成功**し、覚えるのも失敗せず、疲れもしない。
  - frotz は Dark Cave・Grue Cave・Light Pool・柱の上では必ず失敗する。平原では blorple 以外は効かない。
  - girgol（巻物）は Council Chamber 以外では必ず成功。

| 呪文 | 効果 | 入手場所 | このガイドでの使い道 | 縁の深い立方体 |
|---|---|---|---|---|
| gnusto | 巻物を本に写す | 最初から | 各所 | change, earth |
| frotz | 物を光らせる | 最初から | `frotz knife`、最後に `frotz me` | change, light |
| rezrov | 開ける | 最初から | 揚げ戸・戸棚・栓・宝物庫の扉・過去の牢の扉 | change, earth |
| yomin | 心を読む | 最初から | 使わない（ヒント） | mind, light |
| jindak | 魔力を見る | 最初から | 宝物庫 | light, connectivity |
| malyon | 命を吹き込む | 最初から | 偶像 | fire, life |
| lesoch | 突風 | 最初から | 広場の煙 | air, fire |
| blorple | 立方体の部屋へ飛ぶ | 会議の後に本に現れる | 移動の基本 | （必ず成功） |
| girgol | 時間を止める | ジッパーの中（flimsy scroll）。写せない | 雪崩、最後の場面（vellum に写したもの） | （特別） |
| caskly | 完全な形に直す | ロック鳥の巣（stained scroll） | 小屋、黴びた本 | change, connectivity |
| throck | 植物を育てる | Cliff Middle（dirty scroll） | 雑草 | life, water |
| espnis | 眠らせる | Ogre Lair（dusty scroll） | 偶像 | mind, death |
| liskon | 縮める | 海の瓶（damp scroll） | 大蛇、自分 | change, earth |
| tinsot | 凍らせる | Glacier（white scroll） | オブリエットの水、溶岩のかけら | water, fire |
| snavig | 近くの生き物に化ける | 黴びた本（caskly で直すと読める） | 魚、グルー | change, dark |

### 3.2 疲れ・睡眠・覚えられる数【確認済み】

- 始まって約 80 ターン、眠ってからは約 150 ターンで疲れ始める（`You are beginning to tire.`）。以後 8 ターンごとに段階が進み（`feeling tired` → `getting more and more tired` → `worn out` → `dead tired` → ... → `about to keel over from exhaustion`）、その次（約 80 ターン後）にその場に倒れて眠る。
- 疲れの段階が進むたびに: **覚えていられる呪文の数が 1 減り**（いっぱいなら 1 つ忘れる: `the spells you've memorized are becoming confused`）、**手に持てる数も 1 減る**。段階が進むほど `learn` が失敗しやすくなり（`can't concentrate well enough`）、`practically asleep` 以降は覚えられない。
- **眠ると覚えていた呪文はすべて消える**。変身・縮小などの効果も切れる。上限は眠るたびに 1 増える（最初 4、最大 8）。
- 疲れていないときに `sleep` しても眠れない（`you really aren't tired`）。`diagnose` で疲れ具合が分かる。
- **やり方: 疲れの表示が出たら、次の安全な場所（下の「眠れない所」以外）で、呪文を覚える前に眠る。眠る → 覚える → 使う、の順を崩さない。** 覚えた後に眠ると全部やり直しになる。検証では全体で 2〜3 回眠れば足りた。
- 眠れない所: 鬼の洞窟と寝床、海・水道管・水のあるオブリエット、落下中、ロック鳥の巣・ロック鳥の爪の中、Castle、戸棚の中。
- 一度に覚えすぎると、古い呪文が 1 つ押し出される（`something may have been forgotten in the shuffle`）。出たら `spells` で確かめて覚え直す。
- 同じ呪文は「覚えていられる数」までしか重ねられない（`You try, but you just can't memorize those complex syllables again.`）。

### 3.3 ジッパー（zipper）【確認済み】

- 遺跡（Ruins Room）にある銀色のジッパー。**中は別の次元で、いくらでも入る**。閉じると防水になる。
- 中の物を出し入れするにはジッパーを手に持ち、開いていること。
- 使い方: 拾った物はすぐジッパーへ。呪文書は濡れる場面の前にジッパーへ入れて閉じる。
- 最後に過去の遺跡へ置いていく（4.21）。

### 3.4 明かり【確認済み】

- Packed Earth・Hall of Stone・Ruins Room・Inner Vault・Outer Vault・Sand Room・過去の Ruins Room などは暗い。最初に `frotz knife`（4.1）。
- Dark Cave でナイフを置いていく（4.17）ので、その後は `frotz me`（4.17 の最後）で自分を光らせる。

---

## 4. 章別攻略【確認済み】

各節の最初の「準備」は、その節で使う呪文。疲れていたら先に `sleep`（3.2）。

### 4.1 Borphee（会議と広場）

1. `z` を 4 回。4 回目に議長たちが蛙や山椒魚に変わり、黒い人影が出て行く（`turned into a frog, salamander`）。この間は部屋から出られない。
2. `s` → `take bread` → `take fish`（パンは海で魚に、魚は最後の超立方体に使う。**絶対に誰にも食べさせない**）。
3. `s`（Belwit Square。オレンジの煙が立ちこめている）。
4. `learn lesoch` → `lesoch`（煙が晴れて立方体が現れる）。出力に `The casting feels wrong` があれば失敗なので、覚え直して唱え直す。**失敗の文にも `dissipates` が出ることがある**（`a huge ball of green light appears, then dissipates.`）ので、`dissipates` だけで成功と判断しない。待っていても約 20 ターンで晴れる。
5. `take cube` → `write "earth" on cube`。
6. `frotz knife`（失敗したら繰り返す）。

### 4.2 遺跡（ジッパーと girgol）

1. `learn blorple` → `blorple "earth"`（Packed Earth）。
2. `e`（Hall of Stone）→ `s`（Ruins Room）。
3. `take zipper` → `open zipper` → `reach into zipper`（何かが手に触れる: `slipped away`）→ `take flimsy scroll from zipper`。
4. `put fish in zipper` → `put bread in zipper` → `put burin in zipper`（以後 burin は書くときだけ出す: 0.2）。
- flimsy scroll は girgol の巻物。**4.4 の雪崩まで使わない**（本には写せない）。

### 4.3 落下とロック鳥の巣（caskly）

1. `learn blorple` → `blorple "earth"` → `d`（初回は踏みとどまる）→ `d`（空中へ。落ち始める）。
2. `In Roc Nest` が出るまで `z`（1 つずつ送る）。普通は 1〜3 回目でロック鳥に捕まり、4 ターン飛んで巣に降ろされる。
   - `You have died` が出たら（2.3）: `n` → `learn blorple` → `blorple "earth"` → `d` → `z`... とやり直す（2 回目以降は `d` 1 回で落ちる）。
3. `take stained scroll` → `gnusto caskly`。
- 巣の立方体は母鳥が守っていて取れない（4.11 で取りに来る）。

### 4.4 崖・雪崩・山頂（命の立方体）

1. `learn blorple` → `blorple "earth"` → `s`（Cliff Middle）。
2. `take dirty scroll` → `gnusto throck`。
3. `u`（Cliff Top）。
4. `push rock` → 出力に `almost continuous curtain` があれば、**次の 1 手で** `girgol`（巻物から唱える。`rocks are no longer falling`）。
   - `u` の時点で `disturbed the rocks` が出ていたら、`push rock` はせず `z` を 1 回 → `continuous curtain` が出たら `girgol`。
5. `u` を 4 回（Boulder ×3 → Mountain Top）。
6. `take coin` → `put coin in zipper`。
7. `w`（Stone Hut）→ `learn caskly` → `caskly hut`（小屋が立派になり、要石だった立方体が床に転がる）。
8. `take cube` → `take burin from zipper` → `write "life" on cube` → `put burin in zipper`。
- 山からは歩いて下りられない（時間が動き出すと雪崩の跡を下れない）。次は blorple で出る。

### 4.5 雑草と鬼（水の立方体・金の箱・espnis）

1. `learn blorple` → `blorple "life"`（Soft Room）→ `s`（Meadow）。
2. `take weed`（半分抜ける）→ `take weed`（根ごと抜ける: `pulls out of the ground`）。剪定ばさみは使わない。
3. `put "life" in zipper` →（疲れていたらここで `sleep`）→ `learn blorple` → `blorple "earth"` → `w`（Cave Entrance）。
4. `put "earth" in zipper`（洞窟で物を拾うので手を空ける。burin はもうジッパーの中）。
5. `plant weed` → `learn throck` → `throck weed`（`spectacular size`。洞窟から激しいくしゃみ）。失敗したら覚え直す。
6. **throck が成功したターンから 10 ターン以内に洞窟を出る**: `n` → `d`（Ogre Lair）→ `take box` → `take dusty scroll` → `open box` → `take cube from box` → `u` → `s`（Cave Entrance。ここまで 8 手）。
7. `gnusto espnis` → `put box in zipper`（4.18 まで使わない）→ `take burin from zipper` → `write "water" on cube` → `put burin in zipper`。

### 4.6 海（瓶 = liskon）

1. （疲れていたら `sleep`）`learn blorple` を 2〜3 回 → `blorple "water"`（Water Room）。
2. `take bread from zipper` → `put book in zipper` → `close zipper`。
3. `s`（Mid-Ocean。水の立方体が手から落ちて浮かんでいる）。
4. **すぐに** `drop bread`（魚がパンを飲み込む）→ `take "water"` → `take bottle`。
5. `blorple "water"`（Water Room）→ `open zipper` → `take book from zipper` → `open bottle`（陸の上で開ける）→ `take damp scroll` → `gnusto liskon`。
6. `put bottle in zipper`（以後不要）。

### 4.7 大蛇と偶像（空の立方体）

1. `take "earth" from zipper` → `n`（Oubliette。水の部屋の中からは blorple できないので一度出る）→ `put "water" in zipper`。
2. `learn blorple` → `blorple "earth"` → `e` → `n`（Smooth Room。大蛇が通路をふさぐ）。
3. `learn liskon` → `liskon serpent`（失敗したら覚え直す）→ `n` → `n`（Temple）。liskon は 15 ターンで切れるので寄り道しない。
4. 呪文書を手に持ち、`learn malyon` → `learn espnis`。
5. `malyon idol` → `z` → `espnis idol` → `z`。最後の `z` で `caught in a cheek-stretching yawn`（あくびのまま石に戻る）が出れば成功。
   - malyon か espnis が失敗したら、`turns back into basalt` が出るまで `z` で待ち、4. からやり直す。**偶像が動いている間は登らない・触らない。**
6. `climb idol` → `take cube` → `take burin from zipper` → `write "air" on cube` → `put burin in zipper` → `climb down` → `put "earth" in zipper`。
- 偶像の目の opal は取らなくてよい（金貨で絨毯が買える）。

### 4.8 空の部屋（tinsot と青い絨毯）

1. `learn blorple` → `blorple "air"` → `n`（Glacier。**歩かない**）→ `take white scroll` → `gnusto tinsot`。
2. `learn blorple` → `blorple "air"` → `w`（Bazaar）→ `e`（Emporium。店の中で呪文を唱えない）。
3. `ask merchant about blue carpet`（青い方が欲しいと伝える）。
4. `offer 100 to merchant`（800 と言う）→ `offer 200 to merchant`（700）→ `offer 300 to merchant`（600）→ `offer 400 to merchant`（`Done at five hundred`）。値は毎回 100 以上、前より 50 以上上げる。500 を超える額で合意すると金貨では払えない。
5. `take coin from zipper` → `give coin to merchant`（赤い安物を渡される）→ `take blue carpet`（`You wanted this one`。青い方に取り替えてくれる）。
6. `w` → `put carpet in zipper`。

### 4.9 水道管（変化の立方体）

1. `take "water" from zipper` → `put "air" in zipper` → `learn blorple` → `blorple "water"` → `n`（Oubliette。水路が床を流れている）→ `put "water" in zipper`。
2. `learn liskon` を 3 回 → `put book in zipper` → `close zipper`（ここから水に入る）。
3. `liskon me`（`ten times their former size`。失敗したらもう一度）。
4. `d`（In Channel）→ `w`（In Pipe）→ `w`（割れ目のある In Pipe）→ `take cube` → `w`（Ruined Pipe）→ `u`（Ruins Room）。**途中で止まらない**（3 ターンごとに流され、Ruined Pipe の先は死）。
5. `open zipper` → `take book from zipper` → `take burin from zipper` → `write "change" on cube` → `put burin in zipper`。

### 4.10 オブリエット・地下牢（死の立方体・snavig）

1. `take "water" from zipper` → `put "change" in zipper` → `learn blorple` → `blorple "water"` → `n` → `put "water" in zipper`。
2. 呪文書を手に持ったまま `learn tinsot` → `tinsot water`（`partially blocked`）。失敗したら覚え直す（まだ水は出ていないので安全）。
3. `learn tinsot` を、`spells` で tinsot が `thrice` になるまで繰り返す。
4. `put book in zipper` → `close zipper`。
5. `tinsot water`（`icy cap`。水があふれて満ち始める）。失敗した場合はまだ水は出ていないので、ジッパーを開けて覚え直してよい。
6. `tinsot water`（`ice floe`）。失敗したら予備の tinsot でもう一度。**ここからは水が増えているので絶対にジッパーを開けない**。
   - **浮島が作れなかったら**（2 回とも失敗して `You don't have the tinsot spell memorized!`）: 何もせず `z` を続け、`The oubliette is empty again.`（水が引いて氷も溶ける）を待つ。途中で `becoming numb` が出ても、水が引くまでは凍死しなかった（確認済み）。空になったら `open zipper` → `take spell book from zipper` → 2. からやり直す（水の立方体はジッパーの中のまま）。
7. `climb on floe` → `rezrov trap door`。**どちらかの出力に `The oubliette is full.` が出ていたら、すぐ** `u`（Dungeon）。まだ出ていなければ、出るまで `z` → `u`。満水は 1〜2 ターンで引き始め、引き始めると届かなくなる（`climb on floe` の時点で満水になることがある）。
8. （疲れていたら `sleep`）`take cube`（死の立方体）→ `e` → `n`（Dungeon Cell）→ `rezrov cabinet` → `take moldy book`。
9. `open zipper` → `take burin from zipper` → `write "death" on featureless cube` → `put burin in zipper` → `put "death" in zipper` → `take spell book from zipper`。
10. `learn caskly` → `caskly moldy book`（`The mold and rot retreat`）→ `gnusto snavig`（黴びた本は崩れて消える）。

### 4.11 見張り塔から絨毯で巣へ（つながりの立方体）

1. （疲れていたら `sleep`）`s` → `w`（Dungeon）→ `learn blorple` を 2 回 → `put book in zipper` → `take carpet from zipper`。
2. `u`（Guard Tower。遠くに黒い点。**5 ターン目にロック鳥に捕まる**ので急ぐ）→ `drop carpet` → `sit on carpet` → `u`（絨毯が浮き、ロック鳥は驚いて逃げる: `rising swiftly`）。
3. `w` を 4 回（4 回目に `giant bird's nest`）→ `d`（In Roc Nest。母鳥はいない）。
4. **巣に入ってから 4〜5 ターンで卵がかえる**: `get off carpet` → `take cube` → `blorple featureless cube`（String Room）。絨毯は巣に置いていく（もう要らない）。
5. （String Room では立方体は手に無い）`s`（Enchanters' Retreat。立方体が手に戻る）→ `take burin from zipper` → `write "connectivity" on featureless cube`（`"connec"` になる）→ `put burin in zipper` → `put "connec" in zipper`。

### 4.12 Belboz（鍵）

1. `ask belboz about cube` → 偽者が来たので本物か試す、と言って質問を 1 つ出す（6 問から 1 つ。種で変わる）。
2. 質問の手がかりの語で答えを選び、`answer <名前>`（`hands you a wrought iron key` で成功。+25 点）→ `put key in zipper`（4.20 まで使わない）。

| 質問に含まれる語 | 答え |
|---|---|
| `The hardest trick is making it look easy`（座右の銘） | `answer barsap` |
| `golmac`（golmac の呪文を考案した人） | `answer barbel` |
| `Coconut of Quendor`（の著者） | `answer gustar` |
| `fireworks`（Borphee で花火の名人） | `answer dimithio` |
| `Double Fanucci` | `answer forburn` |
| `necromancers`（Belboz 以外で有名な死霊術師） | `answer berknip` |

- 間違えると偽の鍵をもらい、4.20 で使った瞬間に終わる（2.1）。答える前に `save`。
- Retreat からは歩いて出られない（Belboz に止められる）。

### 4.13 海底（光の立方体）

1. （疲れていたら `sleep`）`take spell book from zipper` → `learn blorple` を 3 回、`learn snavig` を 2 回（`spells` で blorple が 3 回・snavig が 2 回になっていることを確かめる）。
2. `take "water" from zipper` → `blorple "water"`（Water Room）。
3. `put spell book in zipper` → `close zipper`（手には閉じたジッパー・ナイフ・水の立方体だけ。鍵・burin・ほかの立方体・箱はもうジッパーの中）。
4. `spells` で snavig と blorple が 1 回以上残っているか確かめる（疲れで忘れていたら、ジッパーを開けて覚え直してから閉じる）。
5. `s`（Mid-Ocean）→ **すぐに** `take "water"`（放っておくと 2 ターン目に魚が立方体を飲む）→ `snavig grouper`（魚になる。持ち物はすべて海底へ沈む）→ `d`（Ocean Floor）。
6. `You have become yourself again.` が出るまで `z`（数ターン）→ **すぐに** `take all`（ナイフ・ジッパー・水の立方体・巣の中の立方体をまとめて拾う）→ `up`（水面へ。息は 3 ターンしか持たない）。
7. `blorple "water"`（Water Room）。

### 4.14 光の部屋・火山の麓（溶岩のかけら）

1. （疲れていたら `sleep`）`open zipper` → `take book from zipper` → `take burin from zipper` → `write "light" on featureless cube` → `put burin in zipper`。
2. blorple を 2 回分・tinsot を 2 回分覚えた状態にする（`spells` で確かめ、足りない分だけ `learn`）→ `n`（Oubliette）→ `put "water" in zipper`。
3. `blorple "light"`（Light Room）→ `w`（Volcano Base。歩けない）。
4. `drops right at your feet` が出るまで `z`（2 ターン目に溶岩のかけらが飛んでくる）→ `tinsot fragment`（`cool enough to touch`）→ `take fragment`。

### 4.15 変化の部屋と八角形の迷路（羅針盤の薔薇・心の立方体）

1. `take "change" from zipper` → `put "light" in zipper` → `learn blorple` → `blorple "change"`（Changing Room）→ `n`（Bare Room。出口が無い）→ `take rose`。
2. `learn blorple` → `blorple "change"` → `w`（Carving Room）。
3. `put rose in carving`（北の壁に八角形の穴が開く）→ `take rose`（忘れずに取る）→ `n`（迷路の南東の部屋）。
4. 薔薇を壁に当てると、その方角の腕が鉛に変わって穴が開く。**同じ方角は二度と使えない**（北は入口で使用済み）。次の順で進む:
   - `touch rose to west wall` → `w`（南の部屋）
   - `touch rose to nw wall` → `nw`（西の部屋）
   - `touch rose to ne wall` → `ne`（北の部屋。西の壁の印が金色で、穴が雪花石膏の栓でふさがれている: `gold`）
5. `rezrov plug` → `w`（北西の部屋）→ `take cube` → `take burin from zipper` → `write "mind" on cube` → `put burin in zipper`。
6. `put "change" in zipper` → `put rose in zipper`。
- 迷路は 3×3 の部屋。穴をくぐると穴は閉じる。部屋の説明に、鉛になった（もう使えない）方角が出る（例: `The east, northeast, southeast and southwest runes are lead, the rest are of silver.`）。

### 4.16 平原（闇の立方体）

1. （疲れていたら `sleep`）`learn blorple` → `blorple "mind"`（No Place）→ `s`（Plain）。
2. `give fragment to green rock`（緑の目の岩がかけらを食べて機嫌を直す: `Mmm`）→ `climb green rock`。
3. `green rock, <方角>` で岩を動かす。動かすたびに茶色の目の岩が逃げる（`The brown eyed rock slides gracefully <方角>.`）。**緑の岩を茶色の岩と同じ場所に動かす**と、茶色の岩が動けなくなる（`mesmerized`）。
4. 下の表のとおりに動かす（茶色の岩の動きは出力の方角で判断する）。どの分かれ道でも 6 手以内に捕まる（※実行でも 100 回以上通した）。

| 手 | 緑の岩への命令 | その後の茶色の岩 | 次へ |
|---|---|---|---|
| 1 | `green rock, north` | south に動く | 2 |
| 2 | `green rock, southwest` | south に動く | 3 |
| 3 | `green rock, east` | **west** に動いた → 4a ／ **north** に動いた → 4b | |
| 4a | `green rock, south` | east に動く | 5 |
| 4b | `green rock, east` | south に動く | 5' |
| 5 | `green rock, east` | **west** → 6a ／ **north** → 6b | |
| 5' | `green rock, south` | **west** → 6a ／ **north** → 6b | |
| 6a | `green rock, south` | `mesmerized`（捕まえた） | 5. へ |
| 6b | `green rock, east` | `mesmerized`（捕まえた） | 5. へ |

5. `jump onto brown eyed rock`（目の前に立方体）→ `take cube` → `take burin from zipper` → `write "dark" on cube` → `put burin in zipper`。
- 平原では blorple 以外の呪文は効かない。歩くと滑って転ぶ。

位置の参考: 平原は 4×4 の格子で、北西の隅（0 番）だけが無い。番号 = 行 × 4 + 列。緑の岩は 5、茶色の岩は 7 から始まる。4 と 1 の間だけ斜め（4 から northeast、1 から southwest）に動ける。

### 4.17 闇の部屋とグルー（火の立方体）

1. `learn blorple` → `blorple "mind"`（No Place）→ `e`（Inner Vault。No Place は立方体の部屋なのでここから blorple できない）。
2. （疲れていたら `sleep`）呪文書を手に、blorple を 2 回分・snavig を 2 回分覚えた状態にする（`spells` で確かめる）→ `put "mind" in zipper`。
3. `blorple "dark"`（Dark Room。真っ暗）→ `d`（Dark Cave）→ `drop knife`（**光る物を置いていく**）。
4. `d`（Grue Cave）→ **すぐに** `snavig grue`（グルーに化ける: `changing in a very unpleasant way`）。
5. `d`（Light Pool。グルーには眩しく熱い）→ **すぐに** `climb pillar`（On Pillar）→ `take cube`。
6. 柱の上で `You have become yourself again.` が出るまで `z`（柱の上なら元に戻っても安全）。
7. `take burin from zipper` → `write "fire" on featureless cube` → `put burin in zipper` → `blorple "fire"`（Fire Room）→ `frotz me`（以後は自分が明かり。失敗したら繰り返す）。

### 4.18 火山と金の箱（魔法の立方体）

1. `take box from zipper` → `n`（Volcano。溶岩の湖の中に岩場が見える）。
2. `open box` → `put "fire" in box`（箱の飾りがサラマンダーに変わる）→ `take "fire" from box` → `throw box on outcropping`（箱が岩場に乗る）。
3. **疲れていたらここで `sleep`**（魔法の立方体を持つと疲れが進まなくなる代わりに、その時の「手に持てる数」のまま固定される。眠って 9 個に戻しておく）→ `learn blorple` → `blorple "fire"`（Fire Room）→ `e`（ふだんは通れない東の出口が、箱のある岩場につながる: Outcropping）。
4. `take cube`（`blast of power`。以後、呪文は girgol 以外必ず成功、疲れもしない）→ `take burin from zipper` → `write "magic" on cube` → `put burin in zipper`。
- 魔法の立方体は **以後ずっと手に直接持っておく**（宝物庫の扉、過去の牢の扉、vellum への写しに必要。最後の場面の解凍にも効く）。

### 4.19 宝物庫（時の立方体）

準備: 呪文書を手に `learn jindak` を 3 回、`learn blorple` を 6 回（魔法の立方体があるので失敗しない）。
`put "fire" in zipper` → `put "dark" in zipper` → `put book in zipper`（burin はもうジッパーの中）→ `take "mind" from zipper` → `blorple "mind"` → `e`（Inner Vault。宝物には触らない）→ `put "mind" in zipper` → `rezrov vault door`（魔法の立方体が無いと開かない）。

北の Outer Vault に入るたびに、12 個の立方体（ラベル `"x1"`〜`"x12"`。最初の山に x1〜x6、2 番目の山に x7〜x12）が混ぜ直される。本物は 1 個だけで、jindak を使わずに blorple すると本物でも偽物扱いになる。偽物を blorple すると `Nondescript Room` に飛ばされる。**Outer Vault の中で呪文を 3 回唱えると警報が鳴り、その 2 ターン後に番兵に殺される。**

#### 解き方（jindak 3 回の天秤）【確認済み: 種 1〜200 で全勝】

jindak を唱えると 2 つの山の明るさが比べられる。出力の見分け方:

| 出力 | 意味 |
|---|---|
| `Both piles seem to glow with identical brightness.` | 同じ（以下「=」） |
| `However, the first pile is glowing more brightly.` | 最初の山が明るい（「1 が明るい」） |
| `However, the second pile is glowing more brightly.` | 2 番目の山が明るい（「2 が明るい」） |

本物は偽物より明るいか暗いかのどちらか（どちらかは入るたびに変わる）。12 枚の硬貨の天秤パズルと同じで、3 回で見分ける。ヒント冊子の手順をそのまま使った。手持ちが多くなりすぎないよう、要らない立方体はジッパーに入れる（宝物庫の中でもジッパーの出し入れは呪文に数えない）。

1. `take "x1"` → `take "x2"` → `take "x7"` → `take "x8"` → `jindak`（1 回目。最初の山 x3〜x6、2 番目 x9〜x12）。
2. **1 回目が「=」なら**（本物は手に持っている x1・x2・x7・x8 のどれか）:
   - `take "x3"` → `take "x4"` → `put "x1" in first pile` → `put "x2" in first pile` → `jindak`（2 回目）。
   - `take "x1"` → `put "x7" in first pile` → `jindak`（3 回目）。
   - 2 回目が「=」: 3 回目も「=」なら **x8**、違えば **x7**。2 回目が「=」でない: 3 回目が「=」なら **x1**、違えば **x2**。
3. **1 回目が「=」でなければ**（どちらが明るかったかを覚えておく。これを「1 回目の向き」とする）:
   - `put "x1" in second pile` → `put "x2" in second pile` → `put "x7" in second pile` → `take "x9"` → `take "x10"` → `take "x11"` → `take "x12"` → `put "x9" in first pile` → `take "x6"` → `put "x6" in second pile` → `jindak`（2 回目。最初の山 x3・x4・x5・x9、2 番目 x6・x1・x2・x7）。
   - 3 回目の前に **両方の山を空にし、手の立方体もジッパーへ入れる**: 山にある物は `take "xN"` → `put "xN" in zipper`、手にある物は `put "xN" in zipper`（x1〜x12 の全部）。その後、使う 2 個を `take "xN" from zipper` → `put "xN" in first pile`（または `second pile`）で置く。
   - 2 回目が **「=」**: x10 を最初の山、x11 を 2 番目の山に置いて `jindak`（3 回目）。「=」なら **x12**、1 回目と同じ向きなら **x11**、逆なら **x10**。
   - 2 回目が **1 回目と同じ向き**: x3 を最初の山、x4 を 2 番目の山に置いて `jindak`。「=」なら **x5**、同じ向きなら **x3**、逆なら **x4**。
   - 2 回目が **1 回目と逆向き**: x6 を最初の山、x1 を 2 番目の山に置いて `jindak`。「=」なら **x9**、違えば **x6**。
4. 3 回目の jindak で警報が鳴る。**次の 2 手で** 当たりの立方体を手に取り（山の中なら `take "xN"`、ジッパーの中なら `take "xN" from zipper`、手に持っていれば不要）→ `blorple "xN"`（`Sand Room` に着けば成功）。

- 必ず jindak を唱えた後で blorple する（唱えないと本物でも偽物扱いになる）。
- 別解（予備）: Inner Vault で `save` → `n` → `jindak` → `take "x1"` → `blorple "x1"`、`Nondescript Room` なら外れなので `restore` → `look` → 次は x2 … と 1 個ずつ試しても解ける（save が乱数も保存するので、入り直しても同じ混ぜ方になる）。

### 4.20 過去の Dungeon Cell（vellum scroll。呪文書を置いていく）

Sand Room は時の流れの部屋で、`d` で過去の Dungeon Cell、`u` で過去の Ruins Room へ行ける。過去の部屋は「今の姿になるように」整えてから出ないと、ゲームが終わる（2.1）。

1. Sand Room で `take book from zipper` → `learn blorple` を 2 回（**この先は呪文書を手放すので、残りの blorple をここで覚えておく**。必要なのは 2 回）。
2. `take key from zipper`。
3. `d`（過去の Dungeon Cell。戸棚も扉も閉まっている）→ `take burin from zipper` → `write "time" on "x?"`（時の立方体にラベル。`?` は 4.19 で当たった番号）→ `put burin in zipper`。
4. `unlock cabinet with key` → `open cabinet` → `put spell book in cabinet`（**自分の呪文書を入れる**。これが今の時代の黴びた本になる）→ `take vellum scroll`。
5. `close cabinet` → `lock cabinet with key` → `put key in zipper`。
6. `rezrov cell door`（扉が吹き飛ぶ。今の時代に扉が無いのと合わせる。番兵が 2 ターン後に来る）→ **すぐに** `blorple "time"`（Sand Room。+25 点）。
- 出るときの条件: 戸棚が壊れていない・鍵がかかっている・中は呪文書だけ・部屋には戸棚以外に何も置いていない・扉が開いている。鍵・立方体などは持って出る。

### 4.21 過去の Ruins Room（girgol を vellum に写し、ジッパーを置いていく）

1. `u`（過去の Ruins Room。水があふれ始めている。約 4 ターンごとに水かさが増えるので急ぐ）。
2. `take sack` → `open sack`（中に flimsy scroll）→ `take flimsy scroll from sack`。
3. `take burin from zipper` → `copy girgol to vellum scroll`（`Copied.`。魔法の立方体と burin を持っていること）→ `put burin in zipper`。
4. `take fish from zipper`（最後に使う。手に直接持つ）→ `empty zipper into sack`（残りのジッパーの中身を全部袋へ）→ `put flimsy scroll in zipper` → `close zipper` → `drop zipper`。
5. `blorple "magic"`（Magic Room。+25 点）。
- 出るときの条件: 部屋にはジッパーだけ・ジッパーは閉じていて中は flimsy scroll だけ。袋は持って出る（置いていくと条件を満たさない）。これが今の時代の「ジッパーの中の girgol」になる。

### 4.22 Castle（最後）

持ち物の確認: vellum scroll（girgol）と魚を手に直接持っていること。魔法の立方体は Magic Room を出ると手に戻る。

1. `e`（Castle。立方体 13 個がそろっていないと通れない）。
2. `coalesce`（玉座に影が現れる）が出るまで `z`（1 回で出た）。
3. **すぐに** `attack shadow`（わざと怒らせて先に凍らされる: `frozen in place`）。
   - これをしないと、影は 4 ターン目に勝手にあなたを凍らせ、解けるのが間に合わない。魔法の立方体を持っていると、凍ってから約 6 ターンで解ける。
4. `z` を続ける。途中で `The freeze has worn entirely off!` が出る。**解けても `z` 以外は何もしない**（影に気づかれてまた凍らされる）。影は立方体を並べ、`It ignores you.` の後、`prepares to jump into the hypercube!` が出る（`attack shadow` の後、8 回目の `z`）。
5. `prepares to jump` が出た直後に `girgol`（vellum scroll から唱える。`The shadow freezes in mid-leap!`）。それより早く唱えると効かない。
6. `take "magic"`（`you free it!`）→ `put fish in hypercube`。時間が動き出し、影が飛び込んで消える。600 点で終わる。
- 超立方体に入れるのは魔力の無い物ならよい（魚が確実）。何も入れない・魔法の物を入れると負け（2.1）。
- Castle では `learn` できない。blorple も最後の段階では効かない。`espnis me` すると眠って終わる（−99 点）。

---

## 5. 乱数・タイマーまわりの注意

### 5.1 save の置き場所

- 4.3 の落下の前（ただし乱数も戻るので、外れたら restore ではなく、死んでやり直す方が早い: 2.3）。
- 4.12 の Belboz に答える前。
- 4.19 の Inner Vault（宝物庫に入る前。別解の 1 個ずつ試す方法では必須）。
- 4.20 の Sand Room（過去の部屋の手順を間違えるとゲームが終わる）。
- 4.22 の Magic Room（Castle に入る前）。

### 5.2 乱数で分かれる所

| 場面 | 何が変わるか | 見分け方と対処 |
|---|---|---|
| 呪文全般 | 失敗（3.1 の式） | `The casting feels wrong` → 覚え直して唱え直す。魔法の立方体を取った後は girgol 以外失敗しない |
| 落下（4.3） | ロック鳥に拾われるか | `In Roc Nest` が出なければ `You have died` → 2.3 |
| Cliff Top（4.4） | 着いた時に雪崩が勝手に始まるか | `disturbed the rocks` → `z` を 1 回してから girgol |
| 偶像（4.7） | malyon・espnis の失敗 | `turns back into basalt` が出るまで待ってやり直す（`for former basalt` は動いている最中の文なので間違えない） |
| オブリエット（4.10） | 浮島の tinsot が続けて失敗するか | 水が引くまで `z`（4.10 の 6.） |
| Belboz（4.12） | 6 問のどれが出るか | 4.12 の表 |
| 平原（4.16） | 茶色の岩が north/south・east/west のどちらへ逃げるか | 4.16 の表 |
| 宝物庫（4.19） | 12 個の並び、本物が明るいか暗いか | 天秤の手順（jindak 3 回） |
| 疲れ（3.2） | `learn` の失敗、覚えた呪文を忘れる、手に持てる数が減る | 疲れの表示が出たら先に眠る。`spells` で確かめる。手に持つ物は少なくする（0.2） |

### 5.3 タイマーの総表（※印は確認済み）

| 起点 | ターン数 | 何が起きるか |
|---|---|---|
| ※ゲーム開始 | 4 | 議長たちが両生類に変わる |
| 広場に煙が出る | 20 | 煙が自然に晴れる |
| ゲーム開始／眠った後 | 80／150 | 疲れ始める。以後 8 ターンごとに悪化し、疲れ始めから約 80 ターンで倒れて眠る |
| ※落下を始める | 1〜3 | ロック鳥が拾う（25%・50%・75%）。拾われなければ数ターン後に激突 |
| ※ロック鳥に捕まる | 4 | 巣に降ろされる |
| ※雪崩を起こす | 1／2 | 1 ターン目に `continuous curtain`、2 ターン目に Cliff Top で押し流される |
| ※girgol（雪崩） | 12 | 時間が動き出す |
| ※throck（洞窟の前） | 10 | 鬼のくしゃみが止まる |
| 鬼の洞窟に入る | 12 | 鬼に襲われる |
| ※Mid-Ocean に入る | 2／3 | 魚が何かを飲み込む／水の立方体が沈む |
| ※malyon（偶像） | 4 | 石に戻る（espnis を 2 ターン目に当てるとあくびのまま固まる） |
| liskon | 15 | 元の大きさに戻る |
| 水道管に入る | 3 ごと | 下流へ流される |
| ※オブリエットの 2 回目の tinsot | 1 ごと | 水位が 1/4 ずつ上がり、4 ターンで満水。その数ターン後に引き始める |
| オブリエット・Glacier に浸かる／いる | 5／10 | 警告／凍死 |
| ※Guard Tower に入る | 5 | ロック鳥にさらわれる |
| ※母鳥のいない巣に入る | 4〜5 | 卵がかえり、雛に食われる |
| Emporium に入る | 50 | 追い出される |
| ※snavig | 数ターン（検証では 4〜7） | 元の姿に戻る |
| 魚の姿から戻る（海底） | 3 | 溺れる |
| Grue Cave に入る（化けていない） | 2 | グルーに食われる |
| Light Pool に入る（グルーの姿） | 2 | 焼け死ぬ |
| ※Volcano Base に初めて入る | 2 | 溶岩のかけらが飛んでくる |
| Outer Vault で 3 回目の呪文 | 2 | 番兵に殺される |
| 過去の Ruins Room に入る | 3、以後 4 ごと | 水かさが増え、5 段階目で凍死 |
| 過去の牢の扉を rezrov | 2 | 番兵に殺される |
| ※Castle に入る | 2 | 影が現れる。以後 1 ターンごとに場面が進み、入ってから約 12 ターンで決着 |
| ※影に凍らされる（魔法の立方体あり） | 約 6 | 完全に解ける |
| ※girgol（Castle） | 3 | 時間が動き出す |

---

## 6. 確認済みコマンド列

種 1 での実行例。600/600 点、582 手（コマンド 472 個）。実際に通った列をそのまま写した（`spells` の確認も含む）。乱数で変わる所は【】で注記した。種が違うと、呪文の失敗による覚え直し・待ち回数・眠る場所・宝物庫の分かれ方が変わる（各節の判断どおりにすればよい）。

```
# 4.1 Borphee
z / z / z / z / s / take bread / take fish / s / learn lesoch / lesoch / take cube /
write "earth" on cube / frotz knife
# 4.2 遺跡
learn blorple / blorple "earth" / e / s / take zipper / open zipper / reach into zipper /
take flimsy scroll from zipper / put fish in zipper / put bread in zipper / put burin in zipper
# 4.3 落下 【z の回数は In Roc Nest が出るまで】
learn blorple / blorple "earth" / d / d / z / z / z / z / z / take stained scroll / gnusto caskly
# 4.4 崖と山頂
learn blorple / blorple "earth" / s / take dirty scroll / gnusto throck / u / push rock / girgol /
u / u / u / u / take coin / put coin in zipper / w / learn caskly / caskly hut / take cube /
take burin from zipper / write "life" on cube / put burin in zipper
# 4.5 雑草と鬼
learn blorple / blorple "life" / s / take weed / take weed / put "life" in zipper /
learn blorple / blorple "earth" / w / put "earth" in zipper / plant weed / learn throck /
throck weed / n / d / take box / take dusty scroll / open box / take cube from box / u / s /
gnusto espnis / put box in zipper / take burin from zipper / write "water" on cube /
put burin in zipper
# 4.6 海 【疲れていたので最初に sleep】
sleep / spells / learn blorple / spells / learn blorple / spells / blorple "water" /
take bread from zipper / put book in zipper / close zipper / s / drop bread / take "water" /
take bottle / blorple "water" / open zipper / take book from zipper / open bottle /
take damp scroll / gnusto liskon / put bottle in zipper
# 4.7 大蛇と偶像
take "earth" from zipper / n / put "water" in zipper / learn blorple / blorple "earth" / e / n /
learn liskon / liskon serpent / n / n / learn malyon / learn espnis / malyon idol / z /
espnis idol / z / climb idol / take cube / take burin from zipper / write "air" on cube /
put burin in zipper / climb down / put "earth" in zipper
# 4.8 空の部屋
learn blorple / blorple "air" / n / take white scroll / gnusto tinsot / learn blorple /
blorple "air" / w / e / ask merchant about blue carpet / offer 100 to merchant /
offer 200 to merchant / offer 300 to merchant / offer 400 to merchant / take coin from zipper /
give coin to merchant / take blue carpet / w / put carpet in zipper
# 4.9 水道管
take "water" from zipper / put "air" in zipper / learn blorple / blorple "water" / n /
put "water" in zipper / spells / learn liskon / spells / learn liskon / spells / learn liskon /
spells / put book in zipper / close zipper / liskon me / d / w / w / take cube / w / u /
open zipper / take book from zipper / take burin from zipper / write "change" on cube /
put burin in zipper
# 4.10 オブリエットと地下牢
take "water" from zipper / put "change" in zipper / learn blorple / blorple "water" / n /
put "water" in zipper / learn tinsot / tinsot water / spells / learn tinsot / spells /
learn tinsot / spells / learn tinsot / spells / put spell book in zipper / close zipper /
tinsot water / tinsot water / climb on floe / rezrov trap door / u / take cube / e / n /
rezrov cabinet / take moldy book / open zipper / take burin from zipper /
write "death" on featureless cube / put burin in zipper / put "death" in zipper /
take spell book from zipper / learn caskly / caskly moldy book / gnusto snavig
# 4.11 見張り塔から巣へ
s / w / learn blorple / learn blorple / put book in zipper / take carpet from zipper / u /
drop carpet / sit on carpet / u / w / w / w / w / d / get off carpet / take cube /
blorple featureless cube / s / take burin from zipper /
write "connectivity" on featureless cube / put burin in zipper / put "connec" in zipper
# 4.12 Belboz 【質問は種で変わる。種 1 は "The hardest trick is making it look easy"】
ask belboz about cube / answer barsap / put key in zipper
# 4.13 海底 【疲れていたので最初に sleep。z は become yourself が出るまで】
sleep / take spell book from zipper / spells / learn blorple / spells / learn blorple / spells /
learn blorple / spells / spells / learn snavig / spells / learn snavig / spells /
take "water" from zipper / blorple "water" / put spell book in zipper / close zipper /
spells / spells / s / take "water" / snavig grouper / d / z / z / z / z / take all / up /
blorple "water"
# 4.14 溶岩のかけら
open zipper / take book from zipper / take burin from zipper / write "light" on featureless cube /
put burin in zipper / spells / learn blorple / spells / spells / learn tinsot / spells /
learn tinsot / spells / n / put "water" in zipper / blorple "light" / w / z / tinsot fragment /
take fragment
# 4.15 迷路
take "change" from zipper / put "light" in zipper / learn blorple / blorple "change" / n /
take rose / learn blorple / blorple "change" / w / put rose in carving / take rose / n /
touch rose to west wall / w / touch rose to nw wall / nw / touch rose to ne wall / ne /
rezrov plug / w / take cube / take burin from zipper / write "mind" on cube /
put burin in zipper / put "change" in zipper / put rose in zipper
# 4.16 平原 【3 手目の後 north に逃げたので 4b → 5' → 6b】
learn blorple / blorple "mind" / s / give fragment to green rock / climb green rock /
green rock, north / green rock, southwest / green rock, east / green rock, east /
green rock, south / green rock, east / jump onto brown eyed rock / take cube /
take burin from zipper / write "dark" on cube / put burin in zipper
# 4.17 グルー
learn blorple / blorple "mind" / e / spells / learn blorple / spells / spells / learn snavig /
spells / put "mind" in zipper / blorple "dark" / d / drop knife / d / snavig grue / d /
climb pillar / take cube / z / z / z / take burin from zipper / write "fire" on featureless cube /
put burin in zipper / blorple "fire" / frotz me
# 4.18 魔法の立方体 【疲れていなかったので sleep なし】
take box from zipper / n / open box / put "fire" in box / take "fire" from box /
throw box on outcropping / learn blorple / blorple "fire" / e / take cube /
take burin from zipper / write "magic" on cube / put burin in zipper
# 4.19 宝物庫 【1 回目は「2 が明るい」、2 回目は「1 が明るい」（逆向き）、3 回目は違う → x6】
learn jindak / learn jindak / learn jindak / learn blorple ×6 / put "fire" in zipper /
put "dark" in zipper / put book in zipper / take "mind" from zipper / blorple "mind" / e /
put "mind" in zipper / rezrov vault door / n /
take "x1" / take "x2" / take "x7" / take "x8" / jindak /
put "x1" in second pile / put "x2" in second pile / put "x7" in second pile / take "x9" /
take "x10" / take "x11" / take "x12" / put "x9" in first pile / take "x6" /
put "x6" in second pile / jindak /
take "x1" / put "x1" in zipper / take "x2" / put "x2" in zipper / take "x3" / put "x3" in zipper /
take "x4" / put "x4" in zipper / take "x5" / put "x5" in zipper / take "x6" / put "x6" in zipper /
take "x7" / put "x7" in zipper / put "x8" in zipper / take "x9" / put "x9" in zipper /
put "x10" in zipper / put "x11" in zipper / put "x12" in zipper /
take "x6" from zipper / put "x6" in first pile / take "x1" from zipper / put "x1" in second pile /
jindak / take "x6" / blorple "x6"
# 4.20 過去の牢
take book from zipper / learn blorple / learn blorple / take key from zipper / d /
take burin from zipper / write "time" on "x6" / put burin in zipper / unlock cabinet with key /
open cabinet / put spell book in cabinet / take vellum scroll / close cabinet /
lock cabinet with key / put key in zipper / rezrov cell door / blorple "time"
# 4.21 過去の遺跡
u / take sack / open sack / take flimsy scroll from sack / take burin from zipper /
copy girgol to vellum scroll / put burin in zipper / take fish from zipper /
empty zipper into sack / put flimsy scroll in zipper / close zipper / drop zipper /
blorple "magic"
# 4.22 Castle
e / z / attack shadow / z / z / z / z / z / z / z / z / girgol / take "magic" / put fish in hypercube
```

（`/` はコマンドの区切り。実際には 1 つずつ送る。`learn blorple ×6` は `learn blorple` を 6 回。）

---

## 7. 補足

- **攻略に不要な物**: 剪定ばさみ（使うと雑草が育たなくなる）、opal の目（500 を超える額で絨毯を買うときだけ使う）、赤い絨毯、宝物、パンは海で魚に食べさせる。
- `hint` / `help` は「ヒント冊子を注文して」と言うだけ。
- **開始画面**: 最初の行に `*** MAGE: Interactive Fantasy ***` と出る（開発時の題名の名残。気にしなくてよい）。
- **エンディング**: 影が消え、Belwit Square で Belboz たちに迎えられる。魔法の時代が終わったので、肩書きは `Scientist` になる。
- 先の作品（Enchanter・Sorcerer）と違い、呪文の失敗・疲れ・手持ちの数の三つが常に足を引っ張る。迷ったら「ジッパーにしまう」「疲れていたら先に眠る」「唱える直前に覚える」。
