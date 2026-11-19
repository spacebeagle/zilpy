# Sorcerer ゲームプレイ解説（LLM 攻略用リファレンス）

ZilPy で変換した Infocom 版 *Sorcerer*（1984 年、Release 88 / Serial number 840726）を、`out/sorcerer` で `python sorcerer.py` を直接実行して遊ぶときの参考資料としてまとめた攻略メモ。Enchanter 三部作の第 2 作。
読者は「次にこのゲームを遊ぶ LLM」。このガイドとゲームの出力だけで 400/400 点のクリアまで進めることを目標にしている。

> 注意: 解き方がすべて書かれています。自分で解きたい人は読まないでください。
> Sorcerer にはオープンなライセンスがないため、ZilPy のリポジトリにはゲームの元データも変換結果も含めていません。
> この資料は、実際のプレイでの観察と検証をもとに日本語でまとめたものです。ゲームの文章は転載していません（コマンドと、場面を見分けるための短い語句だけを英語のまま書いています）。
> 権利者から申し出があれば、速やかに修正・削除します。

## 何を元に作り、どこまで確かめたか

- 元にしたもの: 実プレイおよび検証実行での観察結果。
- 直接実行での検証（手順書の段階 4）: スクラッチパッドのドライバーから Python 版を起動し、第 6 章のコマンド列を乱数の種 1〜40 で流した（2026-11-15）。**40 回中 40 回で 400/400 点のクリアに到達**（いずれも 395 手）。変換の不具合を回避する細工は一切していない。
  - 種ごとに変わるのは「暗号の単語」（12 通り）と「炭鉱の扉の番号」（1〜873）だけ。ドライバーは出力に出たそれらを読んで、第 4.2 節の表どおりにボタンを押し、番号を入れている。読者も同じことをすればよい。
- 直接実行による通しプレイ（段階 6）: 実施済み。`out/sorcerer` で `python sorcerer.py` を直接起動し、400/400 点でクリアした。
- 根拠の印:
  - 「確認済み」= 直接実行で出力を見た内容。
  - 印は節の見出しにまとめて付けている。
- プレイ中にゲームの出力とこのガイドが食い違ったら、**ゲームの出力を正とする**こと。

---

## 0. 最初に読むこと（Python 版固有の落とし穴）

### 0.1 パーサーの落とし穴【確認済み】

| やりたいこと | 通らない書き方 | 通る書き方 |
|---|---|---|
| 薬を飲む | 瓶を閉じたまま `drink berzio potion`（`You can't see any berzio potion here!`） | 先に `open ochre vial`、次に `drink ochre potion`（瓶の色で呼ぶ） |
| 呪文を唱える | — | 呪文名を動詞にする: `pulver river`、`malyon dragon`。自分にかけるときは `izyuk me` / `fweep me` / `frotz me` / `vardik me` / `golmac me` |
| 呪文を本に写す | — | `gnusto meef`（巻物を手に持つ。本も持っている必要がある） |
| 呪文を覚える | — | `learn izyuk`（本を持っていること。明るい場所で） |
| 覚えている呪文 | — | `spells` |
| 呪文に呪文をかける | — | `yonk malyon`（malyon を本に写した上で、yonk の巻物を手に持つ） |
| トランクのボタン | — | `push gray button` のように色で呼ぶ |
| 炭鉱の扉の番号 | — | `turn dial to 856`（数字は毎回変わる） |
| 若い自分に番号を教える | — | `younger self, combination 856` |
| 年上の自分に本を渡す | — | `give book to older self` |
| 門番の小人 | — | `wake gnome` → `give coin to gnome` → `search gnome`（硬貨を取り返す） |
| 構造物に巻物を入れる | — | `put parchment scroll in structure` |
| 綱と梁 | — | `tie rope to beam` → `put beam on chute` → `put rope in chute` |

### 0.2 その他の実プレイ上の教訓【確認済み】

- **`wait`（`z`）は 1 回で時計が 3 つ進む**（途中で何か起きると止まる）。1 ターンだけ進めたいときは `look` を使う。タイマーの厳しい場面（4.6 の迷路、4.8 の炭鉱、4.9 の湖）では絶対に `wait` を使わないこと。
- **`save` / `restore` はゲーム内コマンドとして使える**。`save` は `Ok.` と出るが、`restore` は成功しても **何も表示しない**（空の出力が返る）ため、`look` で場所を確かめること。保存先は 1 つだけ。
- **死んだら原則そこで終わり**（`Unfortunately, you made no provisions for your untimely death.`）。Enchanter と違い、自動で生き返ることはない。生き返れるのは、事前に gaspar を唱えていた場合だけ（3.4）。危ない場面の前には必ず `save`。
- 持てる数は 7 個（疲れると減る）。重さの上限もある。不要な物はこまめに捨てる。
- `frotz me` で自分自身を光らせると、以後ずっと明るい。このガイドの手順はこれを前提にしている（暗い部屋が多く、本を手放す場面もあるため）。
- 初期設定は簡易表示で、2 回目以降に入った部屋は名前しか出ない。説明を見たいときは `look`。
- `sleep` すると手数の表示が 50 増える（ゲームの仕様。気にしなくてよい）。

---

## 1. ゲームの目的と全体の流れ【確認済み】

勝利条件: **Belboz's Hideout で、`vardik me`（自分の心を守る）を唱えてから `swanzo belboz`（Belboz に取りついた悪魔 Jeearr を追い出す）を唱える。** これで最後の 25 点が入り、400 点満点でゲームが終わる。

### 依存関係

```
swanzo belboz（勝利）← vardik を先に自分へ
 ├ Belboz's Hideout ← Mammoth Cavern の白い扉 ← Grue Lair を grue suit で通る ← 蔓を meef
 │     └ grue suit ← 湖の底の木箱 ← spenseweeds を meef（本と巻物は浜に置いて潜る）
 ├ vardik の巻物（smelly scroll）← Slanted Room のランプの中（golmac で時間をさかのぼった後）
 │     ├ Slanted Room ← Top of Chute から綱で降りる（手ぶら・疲れていない）← 綱と梁
 │     ├ 炭鉱の扉の番号 ← 未来の自分が教えてくれる → 過去に戻ったら若い自分に教え返す
 │     └ 炭鉱の悪い空気 ← vilstu（orange vial）← マッチ箱を受け口に入れておく（起床後 25 ターン以内）
 ├ 炭鉱への道（Sooty Room）← Hall of Carvings の竜の彫刻を yonk した malyon で動かす
 │     ├ malyon（glittering scroll）← 遊園地の Arcade の的当て ← fooble（aqua vial）を飲んで投げる
 │     │     └ 遊園地の入場料 ← zorkmid 硬貨（Toll Gate の小人から取り返したもの）
 │     ├ yonk（ordinary scroll）← 砦の大砲に bat guano を入れる
 │     └ fooble ← 砦の旗の隠しポケット
 ├ swanzo の巻物（parchment scroll）← ガラスの迷路の先の Hollow ← fweep（蝙蝠になって飛ぶ）
 │     ├ fweep（soiled scroll）・bat guano ← Hidden Cave ← 川を pulver で干上がらせる
 │     ├ 迷路の入口 ← Toll Gate を硬貨で通る ← zorkmid ← 谷を izyuk で飛び越えた先の Tree Room
 │     └ Hollow を出た後の dorn beast ← 迷路の床の無い部屋（27 番）へ誘い込む
 └ ギルドの外へ出る ← aimfiz（moldy scroll）で Belboz のもとへ ← トランクを暗号どおりに押す
       └ 暗号 ← Belboz の日記（鍵はタペストリーの裏）+ 4.2 節の表
```

### 進行順（第 6 章のコマンド列の順）

1. **夢**（4.1）: 何もせず 2 手で目が覚める（+5）。
2. **ギルド**（4.2）: frotz me、マッチ箱を受け口へ（時間制限）、berzio を飲む、gaspar・meef を写す、鍵・日記で暗号を知る、vilstu を受け取る、トランクを開けて aimfiz の巻物。
3. **外**（4.3）: aimfiz belboz → 川を pulver → Hidden Cave（fweep、guano）→ 城跡 → izyuk で川岸を越えて砦（fooble、yonk）→ izyuk で戻り、蛇穴から地下へ。
4. **地下 1**（4.4）: 寝る → izyuk で谷を往復して zorkmid → Toll Gate を通る。
5. **ガラスの迷路**（4.5, 4.6）: fweep で Hollow へ → 巻物を煙突に落とし、dorn beast を床の無い部屋で落とす → Stone Hut で swanzo の巻物。
6. **遊園地と竜**（4.7）: fooble を飲んで的当て → malyon → yonk malyon → malyon dragon → Sooty Room で寝る。
7. **炭鉱**（4.8）: vilstu を飲む → 未来の自分に本を渡し番号を聞く → 扉・綱・梁 → Slanted Room で golmac → vardik の巻物 → 過去の自分から本を受け取り番号を教える → 下のシュートで浜へ。
8. **最後**（4.9）: 寝る → 湖で grue suit → 蔓を meef → Grue Lair → 白い扉 → vardik me → swanzo belboz。

### 得点表（400 点満点。全項目の加点を確認済み）

| 行為 | 点 | 節 |
|---|---|---|
| 夢から目覚める | 5 | 4.1 |
| タペストリーの裏から鍵が落ちる | 15 | 4.2 |
| berzio（ochre）を飲む | 10 | 4.2 |
| dusty scroll（meef）を初めて取る | 10 | 4.2 |
| orange vial（vilstu）を初めて取る | 10 | 4.2 |
| トランクが開く | 25 | 4.2 |
| aimfiz で Belboz のもとへ飛ぶ | 20 | 4.3 |
| Hidden Cave に初めて入る | 20 | 4.3 |
| ordinary scroll（yonk）を初めて取る | 10 | 4.3 |
| zorkmid を摘む | 15 | 4.4 |
| 小人に通行料を払う | 20 | 4.4 |
| 迷路を抜けて Hollow に着く | 20 | 4.5 |
| Stone Hut で parchment scroll（swanzo）を取る | 25 | 4.6 |
| 的当てに勝つ（malyon） | 10 | 4.7 |
| Sooty Room に初めて入る | 20 | 4.7 |
| 炭鉱の扉を開ける | 20 | 4.8 |
| 綱を伝って Slanted Room に入る | 20 | 4.8 |
| smelly scroll（vardik）を初めて取る | 25 | 4.8 |
| Lagoon Shore（浜）に初めて着く | 20 | 4.8 |
| 木箱を開ける | 15 | 4.9 |
| Mammoth Cavern に初めて入る | 20 | 4.9 |
| 白い扉を開ける | 20 | 4.9 |
| Jeearr を退ける（勝利） | 25 | 4.9 |
| **合計** | **400** | |

得点の推移（種 7、第 6 章の列）: ギルド開始 5 点（1 手）→ 外へ出る前 75 点（49 手）→ 地下へ入った時 125 点（83 手）→ 迷路の後 205 点（213 手）→ 炭鉱の前 235 点（294 手）→ 浜 320 点（320 手）→ 400 点（395 手）。

減点: 最後に vardik を唱えずに swanzo すると、Jeearr に乗っ取られて得点 −99 で終わる。

---

## 2. 詰み条件の一覧（絶対に避ける）【※印は確認済み】

### 2.1 取り返しがつかないこと

| やってはいけないこと | 結果 |
|---|---|
| ※**トランクのボタンを 1 つでも間違えて押す** | 以後、正しい順で押しても二度と開かない → aimfiz が手に入らず、ギルドから出られない。押す前に必ず `save` |
| **起床後 25 ターン以内にマッチ箱を受け口（receptacle）へ入れない** | 配達人は 1 回しか来ない → vilstu が手に入らない → 炭鉱で窒息して先へ進めない |
| **aimfiz で Twisted Forest へ行く前に眠る** | 悪夢を見て Chamber of Living Death へ送られる（何もできず、事実上の終了） |
| 冒頭の夢の中で `wake up` などで自分を起こす | ギルドが襲われる結末になり、ゲーム終了 |
| aimfiz の巻物を Belboz 以外に使う | 巻物は 1 回きり。ギルドから出られなくなる（Helistar・Frobar などに使うと死ぬ） |
| 硬貨（zorkmid）に frotz をかける | 光る硬貨は受け取ってもらえない → 通行料も入場料も払えない |
| **Hollow に spell book を持って入る** | 大きな鳥に本を奪われ、二度と戻らない。本は迷路の手前に置いていく |
| 下のシュートを、golmac で過去に戻る前に降りる | 綱・梁・巻物などが消え、その後の流れが壊れる |
| Slanted Room を、golmac を唱える前に巻物を持たずに出る／唱えた後に巻物を持って出る | 存在が消えてゲーム終了（`cease to exist`） |
| 過去の若い自分に番号を教えずに浜へ降りる | 浜に着いた瞬間に存在が消えて終了 |
| 本や巻物を持ったまま湖（Surface of Lagoon / Lagoon Floor）に入る | 濡れて読めなくなる（呪文が使えなくなる）。本は浜に置いてから入る |
| Mammoth Cavern の黒い扉・銀の扉を開ける | 永遠の苦痛の部屋へ引き込まれ、何もできなくなる（事実上の終了） |
| Belboz を knife で刺す | 悪夢の結末で終了 |
| vardik を唱えずに `swanzo belboz` | 得点 −99 で終了 |

### 2.2 死ぬ所（gaspar が無ければゲーム終了）

| 場所・行為 | 条件 |
|---|---|
| Twisted Forest | aimfiz で着いた次のターンまでに離れないと hellhound に食われる。木に登ると大蛇（boa） |
| Meadow | 入ってから 3 ターン目の終わりにイナゴに食われる（2 ターンまでは無事） |
| Mine Field（Forest Edge の北） | 北へ進むと爆死、南へ戻るのも 50% で爆死。入らない |
| Snake Pit | 入ってから 2〜4 ターンで死ぬ。すぐ `d` で下へ抜ける |
| River Bank | **川岸にいられるのは通算 3 ターンまで**（それ以後は 1 ターンごとに 75% で川に落ちて死ぬ）。飛んでいる間と、川を pulver した直後は安全 |
| 川の上を飛ぶ | 下降気流で川に落ちて死ぬ |
| River Bed（pulver の後） | pulver から 5 ターン後に鉄砲水。それまでに Hidden Cave へ入る。北西の Stagnant Pool は入ると死ぬ |
| Drawbridge | **初めて立った 1 ターンだけ安全**。2 回目以降は 1 ターンごとに 40% で崩れて堀に落ちて死ぬ（飛んでいれば安全） |
| Toll Gate | 起きている小人の前で `rezrov gate`、門が開いた後に小屋（booth）に入る、苛立たせた小人をもう一度起こす → 死ぬ |
| Edge of Chasm | 谷を `jump` で越えると 75% で死ぬ。izyuk で飛ぶ |
| ガラスの迷路 | 床の無い部屋に歩いて入る／床の無い部屋で飛行が切れる → 落ちて死ぬ。dorn beast に追いつかれる → 死ぬ（4.6） |
| 遊園地 | 乗り物の途中で降りる・飛ぶ → 死ぬ。Arcade の hawker に aimfiz → 死ぬ。Casino のレバーで金の壺が 3 つ揃う → 硬貨に埋もれて死ぬ（レバーは引かない） |
| 2 種類の薬を同時に効かせる | vilstu・blort・fooble のうち 2 つが同時に効くと死ぬ（berzio は対象外） |
| Hall of Carvings | 動いた後の竜にもう一度 malyon → 死ぬ |
| Sooty Room | 支柱（timber）を動かす → 天井が落ちて死ぬ |
| 炭鉱 | vilstu 無しで 4 ターン → 窒息。vilstu が切れる時に炭鉱にいる → 死ぬ。炭鉱で眠る → 死ぬ。扉に rezrov → 死ぬ。vardik の巻物を取った後に Shaft Bottom へ戻る → 息が切れて死ぬ |
| 湖の底 | 潜って 5 ターン目に溺れる。湖で眠る・疲れて倒れる → 死ぬ |
| Mouth of River | 蔓が残ったまま西へ進む、蔓を攻撃する → 死ぬ |
| Grue Lair | grue suit を着ていない（または grue repellent を自分にかけていない）と死ぬ。明かりは効かない |
| Mammoth Cavern | 機械を壊す・動かす → 死ぬ |
| 渇き・空腹 | 起床後 18 ターンで渇き、21 ターンで空腹が始まり、70 ターン前後で倒れて死ぬ。食べ物も水も無いので、**berzio を早めに飲む**（4.2） |
| 疲れ | 限界を超えるとその場で倒れて眠る。危険な場所（上の各所・湖・炭鉱）で倒れると死ぬ（3.3） |

### 2.3 死んだときの扱いと gaspar

- 普通は死んだらゲーム終了（`RESTART / RESTORE / QUIT` を聞かれる）。
- 例外は **gaspar**（Helistar の部屋の shiny scroll）。`gaspar me` を唱えておくと、次に死んだときに **唱えた部屋** で生き返る。1 回使うと効果は消える（もう一度唱え直す必要がある）。
  - 生き返ると、覚えていた呪文は全部消え、持っていた巻物はその場に落ちる（Haunted House・Coal Bin Room・Dial Room では巻物が失われる）。
  - ギルドで唱えていて、すでに外へ出ていた場合は、ギルドではなく Ruins で生き返る。
  - ガラスの迷路の中、干上がっていない川床で唱えていた場合は、生き返ってもすぐ死ぬ。
- このガイドの手順では gaspar は本に写すだけで使っていない。危険な場面の前に `learn gaspar` → `gaspar me` で保険にしてもよいが、呪文の枠を 1 つ使う。`save` / `restore` の方が確実。

---

## 3. 基本システム・共通の仕掛け

### 3.1 呪文の仕組み【確認済み】

- gnusto・frotz・rezrov の 3 つは**覚え直さなくても何度でも唱えられる**。
- それ以外は、本に写した呪文を `learn` で覚え、唱えると 1 回分を忘れる。同じ呪文を 2 回覚えておける（`learn izyuk` を 2 回）。
- 手に持った巻物の呪文は、そのまま 1 回だけ唱えられる（唱えると巻物は消える）。aimfiz と yonk は長すぎて本に写せないので、巻物のまま使う。
- **一度に覚えられる数**: 目覚めた直後は 4。眠るたびに上限が 1 増える。疲れると 8 ターンごとに 1 ずつ減り、覚えていた呪文を忘れることがある（`the spells you've memorized are becoming confused`）。
- **眠ると覚えていた呪文はすべて消え、薬・飛行などの効果も切れる。**
- 最初に本にある呪文: gnusto・frotz・rezrov・yomin・izyuk・pulver・vezza。

呪文の一覧

| 呪文 | 効果 | 入手場所 | このガイドでの使い道 |
|---|---|---|---|
| gnusto | 巻物を本に写す | 最初から | 各所 |
| frotz | 物を光らせる | 最初から | `frotz me`（自分を光らせる） |
| rezrov | 開ける | 最初から | 使わない（日記・炭鉱の扉・トランクには効かない／危険） |
| izyuk | 飛ぶ（唱えたターン + 2 手） | 最初から | 川岸・谷・迷路 |
| pulver | 液体を干上がらせる | 最初から | 川 |
| yomin | 心を読む | 最初から | 使わない（ヒント） |
| vezza | 未来を見る | 最初から | 使わない（ヒント） |
| gaspar | 死んでも生き返る（1 回） | Helistar's Quarters（shiny scroll） | 保険（2.3） |
| meef | 植物を枯らす | Library（dusty scroll） | 湖の spenseweeds、川口の蔓 |
| aimfiz | 人のいる所へ飛ぶ | Cellar のトランク（moldy scroll）。写せない | `aimfiz belboz` |
| fweep | 蝙蝠になる（唱えたターン + 14 手）。持ち物は全部落とし、物を取れず、呪文も唱えられない | Hidden Cave（soiled scroll） | ガラスの迷路 |
| yonk | 呪文の力を強める | 砦の大砲（ordinary scroll）。写せない | `yonk malyon` |
| malyon | 物に命を吹き込む | Arcade の景品（glittering scroll） | 竜の彫刻 |
| swanzo | 取りついた者を追い出す | Hollow（parchment scroll） | Belboz（勝利） |
| golmac | 時間を移動する | Slanted Room（shimmering scroll） | `golmac me` |
| vardik | 心を悪霊から守る（12 ターン） | Slanted Room のランプの中（smelly scroll） | `vardik me`（勝利の前に） |

薬の一覧（瓶は `open <色> vial` で開けてから `drink <色> potion`）

| 薬 | 瓶 | 効果 | 入手場所 | 使い道 |
|---|---|---|---|---|
| berzio | ochre vial | 飲食が不要になる（実質ゲーム終了まで） | Store Room | 起床直後に飲む |
| vilstu | orange vial | 呼吸が不要になる（約 28 ターン。切れると疲れ果てる） | マッチ箱を受け口に入れると届く | 炭鉱 |
| fooble | aqua vial | 手先が器用になる（17 ターン） | 砦の旗のポケット | 的当て |
| blort | amber vial | 暗闇で見える（24 ターン） | Hidden Cave | 不要（frotz me で足りる） |
| flaxo | indigo vial | 冗談の薬（拷問の場面が出るだけ） | Torture Chamber | 不要 |

### 3.2 明かり【確認済み】

- ギルドの多くの部屋、地下、炭鉱は暗い。**起きてすぐ `frotz me`** を唱えれば、以後ずっと自分が光っている。本を手放す場面（迷路、炭鉱、湖）でも明かりを失わない。
- 暗い部屋から暗い部屋へ明かり無しで移ると、80% で何かに食われて死ぬ。

### 3.3 疲れ・睡眠【確認済み】

- 目覚めてから 80 ターンで `You are beginning to tire.` が出て、以後 8 ターンごとに段階が進む（`feeling tired` → `getting more and more tired` → `worn out` → `dead tired` → `so tired you can barely concentrate` → `moving only on your last reserves of strength` …）。9 段階目で倒れて眠る。
- **`sleep` は、疲れの表示が 1 度でも出た後でないと眠れない**（`you really aren't tired` と言われる）。
- 眠ってよい場所: このガイドでは Crater・Sooty Room・Lagoon Shore で眠る。眠ってはいけない場所は 2.2 の危険な場所すべて（Hollow、炭鉱、湖、川床、川岸、Meadow、Drawbridge なども）。
- **綱を伝って Slanted Room に降りるのは、疲れの表示が 2 回目に出る前でないと失敗する**（手が滑って Coal Bin Room に落ちる）。だから炭鉱の直前（Sooty Room）で眠る。
- vilstu の効果が切れると、いきなり「疲れ果てた」状態になり、8 ターンほどで倒れる。浜（Lagoon Shore）で切れるのを待って、すぐ `sleep` する（4.9）。

### 3.4 渇き・空腹【確認済み】

- 起床後 18 ターンで `You are now a bit thirsty.`、21 ターンで `a bit hungry` が出る。食べ物・水は無い。
- `drink ochre potion`（berzio）を飲むと、以後このガイドの手順の範囲では渇きも空腹も出なかった。

### 3.5 地図【確認済み】

ギルド（脱出は aimfiz だけ。Lobby の南は出られない）

```
Belboz's Quarters ─W─ Hallway(北) ─E─ Your Quarters（スタート：bed）
                         │S        （北の Chamber of the Circle は閉じていて入れない）
Helistar's Quarters ─W─ Hallway(南) ─E─ Frobar's Quarters
                         │S
       Store Room ─W─ Lobby ─E─ Library     （NE Servants' / NW Apprentice Quarters は空）
                         │D
                       Cellar（トランク）
```

外（aimfiz で Twisted Forest に着く）

```
Twisted Forest ─NE→ Forest Edge ─E→ Meadow ─E→ Drawbridge ─E→ Ruins ─U→ Turret
 (U: Tree Branch)      │N Mine Field  │N/NE                    │D
                       │D Snake Pit  River Bank ─SE→ Fort Entrance ─E→ Parade Ground
                       │  └D Slimy Room  │D（pulver 後）         （N Barracks / S Armory / E Gun Emplacement）
                       │      └S Crater  River Bed ─NE→ Hidden Cave ─D→ Pit of Bones ─SW→ Dungeon ─U→ Ruins
                                       （NW Stagnant Pool：死 / SE Top of Falls）       （Dungeon: E Torture Chamber, D Highway）
```

地下

```
Bare Passage ─E(飛ぶ)→ Edge of Chasm ─E→ Crater ─NE→ Edge of Crater ─NE→ Bend ─E→ Highway ─E→ Toll Gate ─E→ Outside Store ─E→ End of Highway ─E→ Stone Hut
   │W                                    │N Slimy Room                       │U/N Dungeon             （S Store）    │N
Elbow Room ─N→ Tree Room                 │S                                                                    Entrance Hall ─N→ Outside Glass Arch ─E→ ガラスの迷路 … Hollow
                                   Winding Tunnel ─S→ Hall of Carvings ─S(竜の後)→ Sooty Room ─E(一方通行)→ 炭鉱
                                         │SW
                                   Park Entrance ─W→ East End of Midway ─W→ West End of Midway
                                                    （N Haunted House / S Flume）  （N Roller Coaster / S Arcade / W Casino）
```

炭鉱と最後

```
Coal Bin Room ─E→ Dial Room ─E(扉)→ Shaft Bottom ─U→ Shaft Top ─SW→ Coal Mine ─NW→ Coal Mine ─W→ Top of Chute
   │D（下のシュート）                                                                           │D（綱）
   ↓                                                                                       Slanted Room ─E→ Coal Bin Room
Lagoon Shore ─E→ Surface of Lagoon ─D→ Lagoon Floor
   │NE
Ocean Shore North ─N→ Mouth of River ─W(蔓)→ Grue Lair ─W→ Mammoth Cavern ─SW(白い扉)→ Belboz's Hideout
                                                         （NW 黒い扉 / W 銀の扉：入らない）
```

---

## 4. 章別攻略【確認済み】

各節の「手順」は第 6 章のコマンド列と同じ順番。

### 4.1 夢（2 手、5 点）

ゲームは見知らぬ森（Twisted Forest）で始まるが、これは夢。hellhound が来て食われると目が覚める（7 ターン目の雷でも目が覚める）。

1. `look`。次のターンに食われて、自分の部屋のベッドで目覚める（+5）。部屋は真っ暗。

夢の中で `wake up` と自分を起こすのは厳禁（2.1）。

### 4.2 ギルド（48 手、+70 点。累計 75 点）

**時間制限**: 目覚めてから 25 ターン目に配達人が来て、受け口（receptacle）の中身を持っていく。それまでにマッチ箱を入れておかないと vilstu が手に入らない。下の順で進めば 12 ターン目に入れられる。

1. `frotz me`、`get out of bed`。
2. `w`、`s`、`s`（Lobby）、`w`（Store Room）。`take matchbook`、`take ochre vial`（calendar は不要）。
3. `e`、`open receptacle`、`put matchbook in receptacle`。
4. `open ochre vial`、`drink ochre potion`（+10。渇き・空腹が消える）。
5. `n`、`w`（Helistar's Quarters）。`take shiny scroll`、`gnusto gaspar`。
6. `e`、`n`、`w`（Belboz's Quarters）。`move hanging`（+15。鍵が落ちる）、`take key`、`open drawer`、`take journal`、`unlock journal with key`、`read journal`。
   - **日記の最後の `Current code: <単語>` を必ず控える**（種ごとに変わる）。
7. `e`、`s`、`s`、`e`（Library）。`take dusty scroll`（+10）、`gnusto meef`。
8. `w`（Lobby）。25 ターン目に `The Guild Hall doorbell chimes.` が出ているはず（出ていなければ出るまで `look`）。`open receptacle`、`take orange vial`（+10）。**orange vial はまだ開けない**（4.8 の炭鉱の直前まで持ち歩く）。
9. `d`（Cellar）。**ここで `save`。** 暗号の単語に対応する 5 つのボタンを、下の表の順に `push <色> button` で押す。5 つ目で蓋が開く（+25）。
   - 1 つでも間違えたら二度と開かない（2.1）。間違えたら `restore`。
10. `take moldy scroll`（aimfiz）。`learn pulver`、`learn izyuk`、`learn izyuk`。
11. `drop journal`、`drop key`、`drop ochre vial`（荷物を減らす）。

トランクのボタン表（ゲームに付属していた紙の「infotater」の代わり）

| 暗号の単語 | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| bloodworm | white | gray | black | red | black |
| brogmoid | red | purple | red | black | purple |
| dorn | gray | purple | black | gray | white |
| dryad | black | gray | white | red | red |
| grue | black | black | red | black | purple |
| hellhound | purple | white | gray | red | gray |
| kobold | red | purple | black | purple | red |
| nabiz | purple | black | black | black | red |
| orc | red | gray | purple | gray | red |
| rotgrub | gray | red | gray | purple | red |
| surmin | black | black | purple | red | black |
| yipple | gray | purple | white | purple | black |

持ち物（外へ出る時）: spell book、orange vial、moldy scroll。

### 4.3 外: 川・洞窟・砦（34 手、+50 点）

1. `aimfiz belboz`（+20。巻物は消える）。Twisted Forest に着き、hellhound が迫ってくる。**すぐに** `ne`（Forest Edge）。hellhound は森の外まで追ってこない。
2. `e`（Meadow。イナゴの 1 回目の警告）、`n`（River Bank）。
3. `pulver river`（川が干上がる。ここから 5 ターン後に鉄砲水）。`d`（River Bed）、`ne`（Hidden Cave、+20）。
4. `take guano`（下から soiled scroll が出る）、`take soiled scroll`。その間に外で水が戻る（`There is a roar of water` が出る。洞窟の中なら無事）。`gnusto fweep`。amber vial（blort）は取らない。
5. `d`（Pit of Bones）、`sw`（Dungeon）、`u`（Ruins）、`w`（Drawbridge。初めてなので安全）、`w`（Meadow）。
6. **`izyuk me`**（Meadow の 2 ターン目。イナゴの 2 回目の警告が出るが、次の手で出れば無事）、`n`（River Bank、飛んでいる）、`se`（Fort Entrance。ここで着地）。
   - 川岸は通算 3 ターンまでしかいられない。行きの 2 ターンで使い切っているので、以後は必ず飛んで通る。
7. `e`（Parade Ground）。`lower flag`、`examine flag`（aqua vial が落ちる）、`take aqua vial`。
8. `e`（Gun Emplacement）。`put guano in cannon`（大砲の中の「足の生えた巻物」が逃げ出し、1 枚だけ残る）、`take ordinary scroll`（+10。yonk）。
   - 大砲に手を入れると噛まれる。guano を入れるだけでよい。
9. `w`、`w`（Fort Entrance）。**`izyuk me`**、`nw`（River Bank、飛んでいる）、`sw`（Meadow で着地。イナゴの 1 回目）、`w`（Forest Edge）。
   - 帰りの Drawbridge は 2 回目なので危ない。だから城には戻らず、蛇穴から地下へ降りる。
10. `d`（Snake Pit）、**すぐ** `d`（Slimy Room）、`s`（Crater）。

この辺りで `You are beginning to tire.` が出る（種 7 では 82 手目前後）。

### 4.4 地下 1: 睡眠・谷・通行料（+35 点）

1. `sleep`（Crater で眠る。疲れの表示が出る前なら `aren't tired` と言われるので、出るまで先に進めてから眠る）。
2. `learn izyuk`、`learn izyuk`。
3. `w`（Edge of Chasm）、`izyuk me`、`w`（谷を飛び越えて Bare Passage）、`w`（Elbow Room で着地）、`n`（Tree Room）。
4. `take zorkmid`（+15。木は消えて硬貨が 1 枚残る）。**硬貨に frotz をかけない**（2.1）。
5. `s`、`e`（Bare Passage）、`izyuk me`、`e`（谷を越えて Edge of Chasm）、`e`（Crater で着地）。
6. `ne`、`ne`、`e`、`e`（Toll Gate。小人が寝ている）。
7. `wake gnome`、**すぐに** `give coin to gnome`（+20。門が開き、小人はまた眠る）、`search gnome`（払った硬貨を取り返す。遊園地の入場料に使う）。
   - 起こしたまま 5 ターン放っておくと小人は不機嫌に寝てしまい、もう一度起こすと殺される。

### 4.5 ガラスの迷路: 行き（+20 点）

迷路は 3×3×3 の 27 部屋。床の無い部屋があり、歩いて入ると落ちて死ぬ。上下の移動と床の無い部屋は飛ぶしかない。fweep（蝙蝠）は唱えたターン + 14 手飛べる。Hollow では大きな鳥が spell book を奪うので、本は手前に置いていく。

1. `e`、`e`（End of Highway）、`n`（Entrance Hall）、`n`（Outside Glass Arch）。
2. `learn fweep`、`learn fweep`、`learn izyuk`、`learn izyuk`（迷路の往復に必要な 4 つ。`spells` で確かめてよい）。
3. **`drop all`**（本・瓶・巻物・硬貨をここに置く）。**ここで `save`。**
4. `e`（迷路の入口の部屋。床がある）、**`fweep me`**。
5. 次の 14 手を**間に何も挟まずに**送る。1 手でも余計に使うと、床の無い部屋で蝙蝠が解けて死ぬ。
   `n` `e` `s` `s` `w` `d` `e` `e` `n` `n` `u` `u` `s` `e`
   - 14 手目の `e` で Hollow に着き、同時に蝙蝠が解ける（`the fweep spell has worn off`）。+20。
   - `BONK!` が出たら道を間違えている（壁にぶつかっても 1 ターン使う）。すぐ `restore`。

### 4.6 Hollow と迷路: 帰り・dorn beast（+25 点）

巻物を取ると迷路の配置が変わる。巻物を煙突（brick structure）に落とすと Stone Hut の暖炉に届くが、その 2 ターン後に dorn beast が現れて追ってくる。dorn beast は 1 ターンごとにあなたのいた部屋へ移ってくる。**同じ部屋に留まる・来た部屋へ戻る → 追いつかれて死ぬ。** 床の無い 27 番の部屋へ誘い込むと落ちて死ぬ（迷路を出ても追ってくるので、必ず落とす）。

1. `take parchment scroll`（迷路が組み変わる音がする）、`put parchment scroll in structure`。
2. **`fweep me`**（dorn beast が現れる）。
3. 次の 14 手を**間に何も挟まずに**送る（1 手目の `w` は Hollow から迷路に入る手）。
   `w` `w` `s` `e` `d` `d` `w` `w` `u` `u` `n` `n` `d` `e`
   - 4 手目の `e` で `dorn beasts do not so much fly as plummet` が出れば成功。
   - 14 手目で蝙蝠が解けて床のある部屋に降りる。
4. ここからは dorn beast はいない。`s`、`e`、`izyuk me`、`n`、`d`（着地）、`w`、`s`、`w`、`izyuk me`、`u`、`w`（Outside Glass Arch で着地）。
5. `take all`、`s`、`s`、`e`（Stone Hut）。暖炉の中の `take parchment scroll`（+25）、`gnusto swanzo`。

### 4.7 遊園地と竜（+30 点）

1. `w`、`w`、`w`、`w`、`w`（Bend）、`sw`、`sw`（Crater）、`s`（Winding Tunnel）、`sw`（Park Entrance）。
2. `w`（見えない壁に弾かれ、小人が現れる）、**すぐ** `give coin to gnome`（6 ターンで消える）。
3. `w`、`w`、`s`（Arcade）。`open aqua vial`、`drink aqua potion`（fooble。17 ターン）。
4. `take ball`、`throw ball at bunny`（+10。glittering scroll をもらう）、`gnusto malyon`。
   - fooble 無しで投げると必ず外れる。
5. `n`、`e`、`e`、`ne`（Winding Tunnel）、`s`（Hall of Carvings）。
6. `learn malyon`、`yonk malyon`（ordinary scroll から。巻物は消える）、`malyon dragon`（竜が動いて壁が崩れ、南への通路が開く）。
   - yonk 無しの malyon では竜は身震いするだけ。動いた後にもう一度 malyon すると死ぬ。
7. `s`（Sooty Room、+20）。**`sleep`**（炭鉱の綱を降りる前に疲れを取るため。ここで眠ると fooble も切れる）。
8. `drop aqua vial`、`open orange vial`（炭鉱に入ってから開けると 1 手遅れる）。

持ち物（炭鉱に入る時）: spell book、orange vial（開けてある）。

### 4.8 炭鉱: 時間の輪（+85 点）

**最も危ない場面。** 東へ入ると後ろの天井が崩れて戻れなくなり、空気が悪い。vilstu を飲むと呼吸が要らなくなるが、**飲んだターンから数えて 28 ターン目の終わりに効果が切れ、その時に炭鉱にいると死ぬ**（18 ターン目と 22 ターン目に予告が出る）。下の手順は飲んでから 24 手で炭鉱を出る。余裕は 4 手しかないので、**手順の間に何も挟まない**。入る前に `save`。

仕組み（挙動は実行で確認済み）: 炭鉱に入ると、少し未来の自分（older self）がシュートから滑り落ちてきて、扉の番号を教え、本を受け取って下のシュートへ飛び込む。後であなたが Slanted Room で golmac を唱えて過去に戻ると、今度はあなたが「未来の自分」になり、若い自分（younger self）から本を返してもらい、番号を教える役をする。若い自分は、1 回目にあなたがしたことをそのまま繰り返す。

1回目（若い自分として）
1. `e`（Coal Bin Room。天井が崩れる）。
2. `drink orange potion`（ここが 0 手目）。未来の自分が滑り落ちてくる。
3. `give book to older self`。未来の自分が `"The combination is <番号>."` と言う。**番号を控える。**
4. `look`（未来の自分が本を持って下のシュートへ飛び込む）。
5. `e`（Dial Room）、`turn dial to <番号>`（`You hear a click`）、`open door`（+20）。
6. `e`（Shaft Bottom）、`take rope`、`u`（Shaft Top）、`sw`（Coal Mine）、`take beam`、`nw`（Coal Mine）、`w`（Top of Chute）。
   - troglodyte が石炭を捨てに来ることがあるが、無害。
7. `tie rope to beam`、`put beam on chute`、`put rope in chute`（綱が梁から垂れる）。
8. `drop all`（手ぶらでないと降りられない）、`d`（綱を伝って Slanted Room に入る、+20）。
   - `lose your grip` と出て Coal Bin Room に落ちたら、疲れているか何か持っている。ここからは立て直しにくいので `restore`。

Slanted Room
9. `take shimmering scroll`、**`golmac me`**（巻物は消え、ランプの小物入れが閉じる）。
10. `open lamp`、`take smelly scroll`（+25。vardik）。
11. `e`（シュートを滑って、少し過去の Coal Bin Room へ。若い自分が本を持って立っている）。
    - golmac の前に巻物を持たずに出る、golmac の後に巻物を持って出る → 存在が消えて終了（2.1）。このガイドの順なら起きない。

2回目（未来の自分として）
12. `younger self, combination <番号>`（このターンの終わりに `Your younger self hands you your spell book!` が出る）。
13. `d`（下のシュートで Lagoon Shore へ、+20）。この手で vilstu が切れても、もう炭鉱の外なので無事。

### 4.9 最後: 湖・蔓・Grue Lair・Belboz（+80 点）

1. `gnusto vardik`（本が乾いているうちに写す）。
2. `You feel the final effects of the vilstu potion vanish` が出るまで `look`（出たら疲れ果てた状態になる）。出たら**すぐ** `sleep`（浜は安全。湖の中で倒れると死ぬ）。
3. `learn meef`、`learn meef`、`learn vardik`、`learn swanzo`。
4. **`drop book`**（湖に入ると本も巻物も濡れて読めなくなる）。
5. `e`（Surface of Lagoon）、`d`（Lagoon Floor）。潜ってから 5 ターン目に溺れるので、次の 3 手で上がる。
   - `meef weeds`（木箱が現れる）、`open crate`（+15）、`take suit`（自動で着る）、`u`。
6. `w`（Lagoon Shore）、`take book`。
7. `ne`（Ocean Shore North）、`n`（Mouth of River）。`meef vines`（蔓が枯れる。蔓が残ったまま西へ行くと死ぬ）。
8. `w`（Grue Lair。grue suit を着ているので無視される）、`w`（Mammoth Cavern、+20）。
9. `open white door`（+20。Belboz's Hideout へ引き込まれる）。8 ターン後に Belboz（Jeearr）が目覚めて攻撃してくるので、すぐ次へ。
10. **`vardik me`**、**`swanzo belboz`**（+25）。エンディングが表示され、`Your score is 400 of a possible 400` で終了。

---

## 5. 乱数・タイマーまわりの注意

### 5.1 save の置き場所

| 場所 | 理由 |
|---|---|
| 4.2 で Cellar のボタンを押す直前 | 1 つでも間違えると詰む |
| 4.3 で `aimfiz belboz` の直前 | 外は死ぬ所だらけ。ここからはギルドに戻れない |
| 4.5 で迷路に入る直前（`drop all` の後） | fweep の 14 手は 1 手もずらせない |
| 4.6 で `take parchment scroll` の直前 | dorn beast の場面 |
| 4.7 で Sooty Room から東へ入る直前 | 炭鉱は戻れず、時間が厳しい |
| 4.9 で湖に入る直前 | 溺れる・濡れる |

### 5.2 乱数が絡む場面【確認済み】

| 場面 | 何が乱数か | 見分け方と対処 |
|---|---|---|
| 暗号の単語 | 12 通り | 日記の `Current code:` を読み、4.2 の表で押す |
| 炭鉱の扉の番号 | 1〜873 | 未来の自分が言う番号を控え、扉と若い自分の両方に使う |
| Snake Pit | 死ぬまで 2〜4 ターン | 入ったら次の手で `d` |
| 川岸・Drawbridge | 落ちる確率 75%・40% | ガイドの手順は危ないターンに居ないか、飛んでいる。出力に頼らず手順どおりに |
| 鳥のさえずり・troglodyte・石炭がこぼれる | 表示だけ | 無害 |

### 5.3 タイマーの総表【主要なものは確認済み】

| タイマー | 起点 | ターン数 | 何が起きるか |
|---|---|---|---|
| 夢の終わり | 開始 | 7（hellhound なら 2） | 目覚める |
| 配達人 | 目覚めた時 | 25 | 受け口のマッチ箱が vilstu に変わる（1 回だけ） |
| 渇き / 空腹 | 目覚めた時 | 18 / 21 から段階的に | 約 70 ターンで死ぬ（berzio で解消） |
| 疲れ | 目覚めた時 | 80 + 8 × 8 | 能力が落ち、最後はその場で倒れて眠る |
| hellhound | Twisted Forest に着いた時 | 2 | 食われる |
| イナゴ | Meadow に入った時 | 3 | 食われる |
| Snake Pit | 入った時 | 2〜4 | 噛まれる |
| 鉄砲水 | pulver river | 5（3 で予兆） | 川床にいると死ぬ。Hidden Cave の出口がふさがる |
| izyuk | 唱えた時 | 唱えたターン + 2 手 | 着地する |
| fweep | 唱えた時 | 唱えたターン + 14 手 | 人に戻る |
| 小人（Toll Gate） | 起こした時 | 5 | 不機嫌になって寝る（以後起こすと死ぬ） |
| 遊園地の小人 | 現れた時 | 6 | 消える（また西へ行けば現れる） |
| dorn beast | 巻物を煙突に入れた時 | 2 | 現れ、以後毎ターン追ってくる |
| fooble | 飲んだ時 | 17 | 効果が切れる |
| 炭鉱の悪い空気 | Coal Bin Room に入った時 | 2 で警告、4 で死ぬ | vilstu で止まる |
| vilstu | 飲んだ時 | 18（予告）→ 22（予告）→ 28 | 炭鉱にいれば死ぬ。外なら疲れ果てる |
| 湖の底 | 潜った時 | 5 | 溺れる |
| Belboz が目覚める | 白い扉を開けた時 | 8 | 永遠の苦痛の部屋へ（事実上の終了） |
| vardik | 唱えた時 | 12 | 心の盾が消える |

---

## 6. 確認済みコマンド列（400/400 点、395 手。種 1〜40 すべてで通過）【確認済み】

直接実行で通した列そのまま。（）内は注記で、コマンドではない。【】は種によって変わる所。

```
look
frotz me / get out of bed / w / s / s / w / take matchbook / take ochre vial
e / open receptacle / put matchbook in receptacle / open ochre vial / drink ochre potion
n / w / take shiny scroll / gnusto gaspar
e / n / w / move hanging / take key / open drawer / take journal / unlock journal with key / read journal   （暗号の単語を控える）
e / s / s / e / take dusty scroll / gnusto meef
w / open receptacle / take orange vial
d / 【push <色> button × 5：4.2 の表】 / take moldy scroll
learn pulver / learn izyuk / learn izyuk / drop journal / drop key / drop ochre vial
aimfiz belboz / ne / e / n / pulver river / d / ne / take guano / take soiled scroll / gnusto fweep
d / sw / u / w / w / izyuk me / n / se / e / lower flag / examine flag / take aqua vial
e / put guano in cannon / take ordinary scroll / w / w / izyuk me / nw / sw / w / d / d / s
sleep / learn izyuk / learn izyuk
w / izyuk me / w / w / n / take zorkmid / s / e / izyuk me / e / e
ne / ne / e / e / wake gnome / give coin to gnome / search gnome
e / e / n / n / learn fweep / learn fweep / learn izyuk / learn izyuk / drop all
e / fweep me / n / e / s / s / w / d / e / e / n / n / u / u / s / e   （この 14 手は何も挟まない）
take parchment scroll / put parchment scroll in structure
fweep me / w / w / s / e / d / d / w / w / u / u / n / n / d / e   （この 14 手は何も挟まない）
s / e / izyuk me / n / d / w / s / w / izyuk me / u / w
take all / s / s / e / take parchment scroll / gnusto swanzo
w / w / w / w / w / sw / sw / s / sw / w / give coin to gnome / w / w / s
open aqua vial / drink aqua potion / take ball / throw ball at bunny / gnusto malyon
n / e / e / ne / s / learn malyon / yonk malyon / malyon dragon / s
sleep / drop aqua vial / open orange vial
e / drink orange potion / give book to older self / look   （番号を控える。ここから 24 手は何も挟まない）
e / turn dial to 【番号】 / open door / e / take rope / u / sw / take beam / nw / w
tie rope to beam / put beam on chute / put rope in chute / drop all / d
take shimmering scroll / golmac me / open lamp / take smelly scroll / e
younger self, combination 【番号】 / d
gnusto vardik / 【look … "final effects of the vilstu potion vanish" が出るまで】 / sleep
learn meef / learn meef / learn vardik / learn swanzo / drop book
e / d / meef weeds / open crate / take suit / u / w / take book
ne / n / meef vines / w / w / open white door / vardik me / swanzo belboz
```

（`sleep` の 1 回目〈Crater〉と 2 回目〈Sooty Room〉は、検証ではどの種でも疲れの表示が出た後だった。もし `aren't tired` と言われたら、疲れの表示が出るまで進めてから、安全な部屋で眠ること。2 回目は必ず炭鉱に入る直前に眠る。）

---

## 7. 補足

### 7.1 攻略に不要な物

- infotater（Belboz の机）: 「付属の紙の infotater を見よ」と出るだけ。中身は 4.2 の表。
- magic amulet（机の tiny box）: Belboz に近づくほど明るく光る。目安になるだけ。
- calendar、Popular Enchanting（配達物）、scribbled note（Frobar のメモ）: 読み物。
- encyclopedia（Library）: Library で `look up <物>` / `read about <物>` とすると、多くの物の説明が読める（ヒント）。
- amber vial（blort）、indigo vial（flaxo）、brass lantern・grue repellent（木箱）、floor waxer（Store）、diamond-studded knife（Hideout）: 不要。knife で Belboz を刺すと悪い結末。
- Haunted House・Flume・Roller Coaster・Casino: 見物だけ（Flume と Roller Coaster からは炭鉱や Haunted House が少し見える）。乗ったら途中で降りないこと。
- morgia plant（Belboz の部屋）: meef で枯らせるが、エンディングで Belboz に怒られる。

### 7.2 ヒント機能

- 鸚鵡（parrot）の言葉: `Now where can I hide this key?` は鍵の隠し場所のヒント。
- `vezza me`: これから行く場所（川床、砦、Tree Room、遊園地、迷路、Slanted Room、白い扉など）がランダムに見える。
- `yomin <人物>`: 相手の考えが分かる。若い自分に使うと「SAVE しようか迷っている」と出る。

### 7.3 エンディング【確認済み】

`swanzo belboz` の後、Jeearr は心の盾に阻まれて消え、Belboz が目覚める。Chamber of the Circle で次の Circle の長に指名され、得点は 400/400、称号は `Leader of the Circle of Enchanters`。その後 `RESTART / RESTORE / QUIT` を聞かれる。
