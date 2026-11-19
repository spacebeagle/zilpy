# The Hitchhiker's Guide to the Galaxy 攻略メモ

ZilPy で変換した Infocom 版 *The Hitchhiker's Guide to the Galaxy*(1984 年)を、`out/hitchhikersguide` で `python s4.py` を直接実行して遊ぶときの参考資料としてまとめた攻略メモ。
実際に最後までプレイし、**400/400 点でのクリアを確認した**(第 6 章がその手順)。

> 注意: 解き方がすべて書かれています。自分で解きたい人は読まないでください。
> このゲームは Douglas Adams の原作をもとにした作品で、ゲームの文章にも原作の権利が及びます。ZilPy のリポジトリには、このゲームのソースも変換結果も含めていません。
> この資料は、実際のプレイの観察をもとに日本語でまとめたものです。ゲームの文章や公式ヒント集の文章は転載していません(コマンドと、場面を見分けるための短い語句だけを英語のまま書いています)。
> 権利者から申し出があれば、速やかに修正・削除します。

検証について:

- `out/hitchhikersguide` ディレクトリで `python s4.py` を直接実行し、複数回クリアまで到達した。乱数の展開に手順が合わずに失敗した回もあり、その原因は第 4 章・第 5 章の注意点に反映してある。
- プレイ中にゲームの出力とこの文書が食い違ったら、ゲームの出力を正とすること。
- 「確認済み」= 実際のプレイで確かめた内容。「未確認」= 確かめていない内容。

---

## 0. 最初に読むこと

### 0.1 パーサーの落とし穴(確認済み)

| やりたいこと | 通らない書き方 | 通る書き方 |
|---|---|---|
| 人物に命令する | `prosser, lie in the mud` / `guards, drop rifles` / `trillian, shoot rifles` / `marvin, open hatch`(どれも文として認識されない) | `tell prosser to lie in the mud` / `tell guards to drop rifles` / `tell trillian to shoot rifles` / `tell marvin to open hatch` |
| Prosser を寝かせる | `prosser, lie down` | `tell prosser to lie in the mud` |
| 道具箱を開ける | `open toolbox`(鍵を持っていても開かない) | `unlock toolbox with key` |
| ガラスケースの合言葉 | — | `type "thou"` のように引用符つき |
| Beast に名乗る | — | `say my name` |
| 名前を彫る | — | `carve my name on memorial` |
| ボートの舵 | — | `steer boat toward spire` |
| tea substitute から棒を抜く | — | `remove bit from substitute` |

方角は船内用語がそのまま使える: `fore`=north、`aft`=south、`port`=west、`starboard`=east。

### 0.2 その他の実プレイ上の教訓

- **`wait` は 1 回で時計が 3 つ進む**(途中で何か起きるとそこで止まる)。「あと n ターン」を数える場面(Marvin、Beast など)で `wait` を使うと 3 倍速で進む。1 ターンだけ潰したいときは `look` や `inventory` を使う(確認済み: Marvin は `wait` 2 回で来てしまった)。
- **持ち物が多いと `take` に失敗することがある**(持ちすぎと言われる)。7 個程度に抑え、重い物(spare drive など)は特に注意。こまめに Bridge へ置く(確認済み)。
- **`no tea` は最初から持ち物に入っている**(inventory に `no tea` と出る)。これは仕様。
- **パーサーに通らない長め(4 語以上)の入力をすると、地球の破壊後に 1 回だけ「careless words」というイベントが起きる**。害は無く、War Chamber への道が開くだけ(4.9)。ただし開いた後は 5.2 の即死のリスクが生まれるので、いつ開けるかを意識すること。
- **夢の中の死は死ではない。** Ford／Trillian／Zaphod／Lair／War Chamber／鯨の中で死ぬと、Dark に戻るだけ。本当に死ぬのは Earth、Vogon 船、Heart of Gold の船内と、5.2 の場合。
- `save` / `restore` はゲーム内コマンドとして使える。**`turn on drive` の前は毎回 `save`**。
- `the thing your aunt gave you` は捨てても数ターンで勝手に戻ってくる(足元／ポケット／手の中)。これは仕様で、鯨の攻略に使う(4.12)。

---

## 1. ゲームの目的と全体の流れ

勝利条件: **Magrathea に着陸した Heart of Gold の Hatchway から `down` で Ramp に出る**。そのためには Marvin に hatch を開けさせる必要があり、そこから逆算すると全部の謎がつながる。

```
Hatch を開ける ← Marvin に頼む(Pantry の中) ← Pantry に入る
   │                                               ├ screening door を開ける ← tea と no tea を同時に持つ
   │                                               │      ├ tea ← Nutrimat/Computer Interface(Traal の Inner Lair)
   │                                               │      │      + spare drive を Bridge の大きい差込口につないでミサイルを鯨に変える
   │                                               │      └ no tea ← common sense の粒子を取る(脳の迷路 ← War Chamber ← 犬に sandwich)
   │                                               └ 得点 300 以上(tea を飲むと +100)
   └ Marvin が要求する道具を「1 個だけ」持って Access Space で待つ
          └ どの道具かを先に知る ← 果実を食べる ← 鉢植えを sauna に通す
                 ├ flowerpot ← 鯨の中(tea で行き先を選べるようになってから)
                 └ fluff 4 個 ← gown のポケット／Ford の satchel／Arthur の上着(Trillian)／ボートの座席(Zaphod)
```

進行順(確認済みの順):

1. **Earth**: 頭痛薬 → 道具 2 個と junk mail → ブルドーザーの前に寝る → Pub でビール 3 杯と sandwich → 犬に sandwich → Thumb で脱出
2. **Vogon 船**: peanuts → babel fish → 詩を楽しむ → ガラスケースから plotter → エアロックから宇宙へ
3. **Heart of Gold**: Engine Room で spare drive → Bridge に「装置」を組む(drive + plotter + tea substitute)
4. **装置でランダムに飛ぶ**(夢シーン): Traal(interface・chipper)、Ford(satchel fluff)、Trillian(jacket fluff)、Zaphod(seat fluff・wrench)、War Chamber → 迷路(awl・粒子)
5. **tea を作る**(interface を Nutrimat に入れる → ミサイル → drive を大きい差込口につないで起動 → 着陸へ)
6. **tea + no tea** で screening door を開ける
7. **tea で行き先を選んで鯨へ** → flowerpot
8. fluff 4 個を植える → sauna → 果実 → 食べて道具を知る
9. tea を飲む(+100)→ Pantry → Marvin → Access Space で道具を渡す → Hatchway から `down`

### 得点表(400 点満点。確認済み)

| 行為 | 点 |
|---|---|
| 頭痛薬を飲む | 10 |
| ビール 1 杯ごと(3 杯) | 5 × 3 |
| Vogon Hold に着く | 8 |
| babel fish を耳に入れる | 12 |
| 詩を楽しむ | 15 |
| ガラスケースを開ける | 25 |
| Engine Room で 3 回目の look | 25 |
| Ford として最初の 1 杯(Arthur 同席) | 15 |
| Trillian として Phil に連れ出される | 25 |
| Zaphod として Heart of Gold に入る | 25 |
| Nutrimat/Computer Interface を取る | 25 |
| 粒子(common sense)を取る | 25 |
| 鉢植えが sauna で育つ | 25 |
| tea を飲む | 100 |
| Pantry に初めて入る | 25 |
| Marvin に正しい道具を渡す | 25 |

減点: sandwich を食べる −30、tea substitute を飲む −30(2 回目は死ぬ)、drive を大きい差込口につないで**ミサイルが来ていない時に**起動する −30(しかも詰む)。

---

## 2. 詰み条件の一覧(絶対に避ける)

| やってはいけないこと | 結果 |
|---|---|
| Bedroom の toothbrush / screwdriver を置いていく | 道具 10 個が船に揃わない → 果実が「船に無い道具」を名指しする → Marvin に渡せない |
| Front Porch の junk mail を取らない | babel fish が取れない |
| Earth で Ford の差し出す towel を**受け取る** | Ford が去り、Thumb が手に入らず地球と一緒に消える |
| ビールが 3 杯でない(2 杯以下／4 杯目) | 2 杯以下で Thumb を押すと即死、4 杯目は即ゲームオーバー |
| sandwich を買わない／食べる／犬にやり損ねる | War Chamber で艦隊が犬に食われて終わり、迷路に行けない → no tea が取れない |
| Vogon Hold に gown・towel を置いたまま出る | fluff(ポケット)と Beast 対策(towel)を失う |
| dispenser のボタンを押しすぎる | 魚は数匹で打ち止め |
| `type` で間違った単語／詩を楽しまずに `type` | ケースが爆発して死ぬ |
| plotter を取らずにエアロックへ | 装置が組めない |
| **large plug を差込口につないだ状態で、ミサイル警報の前に `turn on drive`** | 差込口と large plug が焼失(−30)。tea が二度と作れない |
| Inner Lair の interface を取る前に Beasthunters が来る(名前を彫ってから約 9 ターン) | Lair は再訪すると即死なので interface が取れない |
| Zaphod で seat fluff・toolbox を**持たずに** Heart of Gold に入る | 再訪できないので fluff と wrench を失う |
| Trillian で fluff を handbag に入れずに終える | 未確認だが失う可能性が高い(handbag に入れた場合のみ確認済み) |
| tea を screening door を開ける前に飲む／こぼす | Nutrimat は tea を 1 回しか作らない |
| 得点 300 未満で Pantry に入る | 致死量の憂鬱で死ぬ |
| 鉢植えに水・tea をやる | 枯れる |
| 果実を船の外で食べる／道具が船に揃う前に食べる | 手元に無い道具を指定される |
| 鯨に荷物を持って行く | thing の中に入れた flowerpot 以外、着ている gown と babel fish を除いて全部消える |
| Access Space に 2 個以上持って入ろうとする／中で物を落とす | 入れない／落とした物は金網から落ちて消える |
| Marvin の要求にすぐ応えない／違う道具を渡す／待ち合わせに遅れる | 二度と頼めない |
| 粒子を取った後に War Chamber へ再び着く | 自分の脳の中に実体化し、数ターン後に本当に死ぬ |
| 脳の迷路で物を `drop` する | 消える(しかも以後ときどき歩けなくなる) |

---

## 3. Dark(感覚のパズル)

装置で飛ぶ・夢シーンが終わる・Thumb を押す、のいずれでも `Dark` という場所に出る。毎ターン「何も聞こえず、匂わず、味がせず、見えず、感じない」という意味の文が出る。
**4 ターン経つと、行き先に対応する感覚が 1 つだけ文から抜ける**。抜けた感覚を使うと出られる(確認済み)。

| 抜ける感覚 | 1 手目 | 返ってくる手がかり | 2 手目 | 行き先 |
|---|---|---|---|---|
| hear | `listen` | 音が `far above` | `aft` | Entry Bay(Heart of Gold) |
| hear | `listen` | 音が `far below` | `aft` | War Chamber |
| smell | `smell` | 何かが鼻の下で「振られている」(受け身の `being waved`) | `examine shadow` | Vogon Hold |
| smell | `smell` | 何かが鼻の下で「振っている」(`waving`) | `examine shadow` | Lair(Traal) |
| see | `examine darkness` | 光が目の `front` | `examine light` | Country Lane(Ford) |
| see | `examine darkness` | 光が目の `back` | `examine light` | Speedboat(Zaphod) |
| feel | `feel darkness` | `cold` で濡れている | `taste liquid` | Living Room(Trillian) |
| feel | `feel darkness` | `warm` で濡れている | `taste liquid` | 鯨の中 |

- `listen` の後に「port に出口がある」と言われるが嘘。**`aft`** が正解(`port` を何度か試すと嘘だと認める)。
- 4 ターン潰すのは `wait` でよい(Dark の中の `wait` は 1 コマンド = 1 カウント)。
- **ランダムモード**(tea substitute が熱源): 行き先は入った時点で決まっていて変えられない。
- **制御モード**(本物の tea が熱源): 入った直後から感覚が抜けていて、**コマンドを 1 つ打つごとに行き先が次へ回る**(Hold → Lane → Party → Entry Bay → Lair → Speedboat → 鯨 → War Chamber → …)。目当ての感覚が抜けた文が出たら 1 手目を打ち、手がかりが違ったら `wait` を数回打ってもう一度同じ感覚が抜けるのを待つ(確認済み: `listen` → above → 数回 `wait` → `listen` → below → `aft` で War Chamber)。

### ランダムモードの行き先の傾向

- 最初の 1 回は Vogon Hold に着く。2 回目以降の Hold は、着いた瞬間に撃たれて Dark に戻るだけ。
- 夢シーンの終了と、Thumb での脱出の直後は、Entry Bay に戻る。
- 最初のうちは Lair(Traal)が出やすい。Lair に一度行くと、Ford・Trillian・Zaphod のシーンが出やすくなる。Zaphod(Speedboat)は Lair に一度行くまで出ない。
- War Chamber は careless words のイベントの後でないと出ない。
- 鯨の中はランダムモードでは出ない。tea の制御モードで行く。

クリア済みの夢シーンに再び着くと、着いた瞬間に死んで Dark → Entry Bay に戻るだけ(**War Chamber だけは 5.2 のとおり致命的**)。

---

## 4. 章別攻略

### 4.1 Earth(確認済み)

開始時の時間制限: 20 ターン目ごろまでに Bedroom／Front Porch にいると家ごと潰される。**50 ターン目ごろに Vogon 艦隊が来る**(それまでにビール 3 杯を飲み終えていないと脱出できない)。

1. `turn on light` → `stand` → `take gown` → `wear gown` → `open pocket` → `take analgesic`(飲んで頭痛が治る。+10。**頭痛が治るまで gown 以外は拾えず、部屋からも出られない**)
2. `take screwdriver` → `take toothbrush`(道具 10 個のうちの 2 個。必須)
3. `south`(Front Porch)→ `take mail`(必須)→ `south`(Front of House)
4. `lie down in front of bulldozer`(Front of House に出てから数ターン以内。寝ないと家が壊れて死ぬ)
5. そのまま `wait` を繰り返す。Ford が来て towel を差し出すが**受け取らない**。Prosser が身代わりに寝て、Ford が country lane へ急ぐ(`hurries toward the country lane`)と出るまで待つ。**自分から `stand` しない**(Prosser が寝る前に立つと即死)。
6. `south`(Country Lane)→ `west`(Pub)
7. `buy sandwich` → `drink beer` × 3(ちょうど 3 回。3 杯目で家が壊れる音がする)
8. `east`(犬が駆け寄る)→ **すぐ** `give sandwich to dog`(遅れると犬が興味を失う)
9. `north`(Front of House。数ターン後に Vogon 艦隊)→ `wait` で Ford が黒い装置を足元に落とすのを待つ → `take device` → `push green button`

艦隊が出ている間は歩けない。thing はここで転がって消えるが後で戻ってくる。

### 4.2 Dark → Vogon Hold(確認済み)

`wait` × 4 → `smell` → `examine shadow`。着いた直後に Ford が peanuts をくれる(+8)。

Hold 内の時間制限(着いた時点から): すぐにふらつき始め、6 ターン目ごろに死ぬ(peanuts で防ぐ)／6 ターン目ごろに Ford が居眠りして Guide・satchel・towel が手に入る／しばらくすると艦内放送、さらに後で衛兵が来る。**fish を取ると衛兵が早く来る**。

1. `eat peanuts`(最優先)
2. `take off gown` → `hang gown on hook`
3. `wait` で The Hitchhiker's Guide を受け取るまで待つ
4. `take towel` → `put towel on drain`
5. `take satchel` → `put satchel in front of panel`
6. `put mail on satchel`
7. `push dispenser button` → 魚が gown → towel → 掃除ロボット → satchel → junk mail の雲、と跳ねて耳に入る(+12)
8. `push switch`(ガラスケースの録音。「第 2 連の何番目(first / second / third)の単語を打て」という指示が流れるので、**序数を控える**。fish が無いと意味不明語になる)
9. `take gown` → `wear gown` → `take towel`(satchel は置いたままでよい。後で Ford が持って行き Bridge に現れる)

仕掛けの意味: ボタンを押すと魚が飛び出して壁の穴へ → gown を hook に掛けて穴を塞ぐ → 床の排水溝へ → towel で塞ぐ → 掃除ロボットが小さい panel へ持ち去る → satchel で塞ぐ → 上の階担当のロボットが空中で捕る → satchel の上に junk mail を置いておくと、ロボットが舞った郵便物の回収に追われて魚を逃す。

### 4.3 Captain's Quarters → 再び Hold → Airlock(確認済み)

衛兵に連れて行かれ椅子に縛られる。船長が 1 行ずつ詩を読む。

1. 詩の朗読が始まったら(始まる前だと「まだ始まっていない」と言われる)**`enjoy poetry`**(+15)。第 1 連が終わるまでに 1 回やればよい。やらないとその場でエアロック行き。
2. 第 1 連が終わり、船長が「次の連も読む」と言ったら、第 2 連の**最初の 1 行の、最初の単語を控える**。第 2 連の最初の行は 3 種類のうちのどれかで、毎回違う。
3. 控えた序数と、第 2 連の最初の行の最初の単語から、`type` する単語を決める:

| 第 2 連の最初の行の最初の単語 | first なら | second なら | third なら |
|---|---|---|---|
| Fripping… | `fripping` | `lyshus` | `wimbgunts` |
| Gashee… | `gashee` | `morphousite` | `thou` |
| Bleem… | `bleem` | `miserable` | `venchit` |

4. Hold に戻されたら、衛兵が Ford と話している数ターンの間に: **`type "<単語>"`**(+25。確認例: 録音が third、最初の行が Gashee… → `type "thou"`)→ **`take plotter`**。置き忘れ(gown・towel)があればここで拾う。
5. Airlock に放り込まれたら `wait`。数ターンで宇宙に吸い出され、Heart of Gold に拾われて Dark へ。

### 4.4 Heart of Gold 到着と「装置」の組み立て(確認済み)

Dark: `wait` × 4〜5 → `listen`(above)→ `aft` → Entry Bay Number Two。数ターン `wait` すると Ford に連れられて Bridge へ行き、Zaphod・Trillian・Ford が sauna へ去る(`all head off to port`)。その時点で Bridge に satchel と handbag が残る。

船内図(fore=north):

```
                 Entry Bay Number Two
                        │ aft
   Galley ── port ── Corridor, Fore End ── up ──> Bridge ── port ──> (sauna: 入ると元の Bridge に戻る)
                        │ aft
 Marvin's Pantry ─ port ─ Corridor, Aft End ── down ──> Hatchway ── starboard ──> Access Space
 (screening door)       │ aft                              │ down (hatch)
                    Engine Room                           Ramp(ゴール)
```

物の初期位置: Bridge = pincer、handbag(中に tweezers)、satchel(Arthur は開けられない)／Entry Bay = sales brochure／Galley = Nutrimat(中に circuit board)、pad、carton(中に anti-Beast gun。役に立たない)／Engine Room = spare drive・pliers・rasp(3 回 look するまで見えない)／Pantry = Marvin・chisel。

手順:

1. Bridge で荷物を降ろす: `drop plotter` `drop guide` `drop device` `drop screwdriver` `drop toothbrush`、`open handbag`(tweezers が見える。置いたままでよい)
2. `down` → `aft` → `aft`(Engine Room へ入ろうとすると止められる)→ **`yes` → `yes` → `aft` → `no`** で入れる(しばらく黙っていると最初からやり直し)
3. `look` → `look`(3 回目の描写で +25、drive・pliers・rasp が現れる)→ `take drive`
4. `fore` → `fore` → `port`(Galley)→ `push pad` → `take substitute` → `starboard` → `up`
5. Bridge で: `drop drive` → `plug small plug in plotter` → `drop substitute` → `put bit in substitute`
6. `save` してから `turn on drive` で飛ぶ(Dark へ)

**large plug(長いコード)は 4.10 のミサイル警報が出るまで絶対につながない。** 装置は起動した部屋の床に残り、帰りは必ず Entry Bay に出るので `aft` → `up` で Bridge に戻る。

夢シーンには towel だけ持って行けばよい(Traal で要る)。他人になるシーンでは Arthur の持ち物は預かられて後で戻る。

### 4.5 Traal: Bugblatter Beast(確認済み)

Dark: smell が抜ける → `smell` → `examine shadow` → Lair。Beast が名前を言えと迫る。何度も詰め寄られると死ぬ(夢なのでやり直せる)。

1. `say my name`(Beast が名前を覚える。**これをしておかないと彫っても効かない**)
2. `east`(Outer Lair。Beast が追ってくる)
3. `take stone`
4. `put towel over head`(Beast は「見えない相手は自分を見られない」と思い込む。しばらくの猶予ができる)
5. `carve my name on memorial`(Beast は「もう食べた」と納得して寝る)
6. `take off towel` → `drop stone` → `west` → `southwest`(Inner Lair)→ **`take interface`**(+25)
7. `wait`。名前を彫ってしばらくすると Beasthunters が乱入し、長い後日談のあと Dark → Entry Bay。**このとき number twelve asteroid paint chipper(道具の 1 つ)が持ち物に入る。**

towel を巻いたまま歩くと方向を見失う。寝た Beast を起こす・攻撃すると死ぬ。

### 4.6 Ford(Country Lane。確認済み)

Dark: see が抜ける → `examine darkness`(front)→ `examine light`。自分は Ford で、しばらくすると艦隊が来る。Arthur に towel を返す前に Pub に入ると、数ターンで宇宙が消えてゲームが終わる。

1. `north`(Front of House。Arthur が泥の中に寝ている)
2. `open satchel` → `take satchel fluff`
3. `give towel to arthur` → 何か言うよう求められるので `idiot`
4. `walk around bulldozer`(Prosser に話せる位置へ)
5. **`tell prosser to lie in the mud`**(Prosser が泥に寝る。Arthur がついて来る)
6. `south` → `west`(Pub)→ `buy beer` → `drink beer`(+15)→ `drink beer`(家が壊れる音。Arthur が飛び出す)
7. `east` → `north` → **`give satchel fluff to arthur`**(Arthur がしゃっくりしながら受け取り、ポケットにしまう。家が壊れる前は受け取らない)
8. `wait`。艦隊が来て Arthur が Thumb を押し、Dark → Entry Bay。**satchel fluff は Arthur の gown のポケットに入っている。**

fluff を渡せないまま終わった場合は、もう一度このシーンに来られる。

### 4.7 Trillian(Living Room。確認済み)

Dark: feel が抜ける → `feel darkness`(cold)→ `taste liquid`。自分は Trillian で、handbag・wine・hors d'oeuvres を持っている。**3 個持っていると何も拾えない。**

1. `examine arthur`(上着の fluff が見えるようになる)
2. `drop wine`(数ターン後に hostess が拾って持って来る)
3. `take fluff`(Arthur が話しかけ続けるようになる。しばらくすると Phil が来る)
4. `open handbag` → `put fluff in handbag`
5. `take wine`(**落とした物を拾い直して 3 個とも持っていないと Phil が近寄らない**)
6. `wait` → Phil(Zaphod)に連れ出される(+25)→ Dark → Entry Bay。**jacket fluff は Bridge の handbag の中。**

hostess に話しかける・wine を投げる／こぼすと死ぬ(夢)。

### 4.8 Zaphod(Speedboat → Dais。確認済み)

Dark: see が抜ける → `examine darkness`(back)→ `examine light`。自分は Zaphod でボートを操縦中。そのまま channel へ向かうと数ターンで岩に激突する。**わざと岩か崖へ向けると自動操縦が助けてくれる。**

1. `steer boat toward spire`
2. `look under seat`(small key と seat cushion fluff を拾う)
3. `unlock toolbox with key` → `take toolbox`(中に wrench と magnifying glass)
4. `wait` で ceremonial dais のすぐ南に着いたと出るまで待つ → `stand` → `north`(Dais)
5. 何でもよいので 4 回行動する(確認例: `jump` × 4)。4 回目に Trillian が飛び出して「人質」に取り、衛兵が銃を構える。
6. **`tell guards to drop rifles`**(銃を足元に積む。数ターン以内に次へ)
7. **`tell trillian to shoot rifles`**(銃の山が消える)
8. `east`(+25。Heart of Gold に入って気絶 → Dark → Entry Bay)

**入った瞬間に Zaphod が持っていた物はすべて Hatchway の床に移る**(toolbox・wrench・key・seat cushion fluff)。銃が残っているうちに `east` すると撃たれる。

### 4.9 War Chamber → 脳の迷路(確認済み)

行けるようになる条件: careless words のイベント(0.2。4 語以上の通らない入力を 1 回、または 4.10 で tea に棒を入れる)。

Dark: hear が抜ける → `listen`(**far below**)→ `aft`。

1. `take awl`(道具の 1 つ)
2. `wait` を数回。Earth で犬に sandwich をやっていれば、艦隊は犬を見て和解し、Heart of Gold まで送ってくれる…はずが **Maze**(自分の脳の中)に出る。やっていなければ艦隊ごと犬に飲まれて Dark に戻る。
3. 迷路は全方向が同じ部屋。`north` を繰り返す(ときどき弾かれる)。**何度か移動に成功すると黒い particle が現れる**(確認例: 3 回目。見逃しても歩き続ければまた現れる)。
4. `take particle`(+25。common sense が外れる)→ 感電して Dark → Entry Bay

これ以後 `take no tea` ができるようになる。**以後 War Chamber に着くと本当に死ぬ**(5.2)。

### 4.10 tea を作る(確認済み)

準備: Bridge に装置(small plug を plotter に、棒を substitute に)が組んである。interface を持っている。

1. Galley へ(Bridge から `down` → `port`): `open nutrimat` → `take board` → `drop board` → `put interface in nutrimat` → `push pad`(Eddie の助けが要る、と言われる)
2. すぐ `starboard` → `up`(Bridge)
3. `wait` で **核ミサイルが発射されたという警報の放送**(`Nuclear missiles` で始まる)を待つ(pad を押して数ターン後。この時 Thumb も壊れる)
4. **放送の後で** `plug large plug in large receptacle` → `turn on drive`
   → ミサイルが鯨と鉢植えに変わり、船は Magrathea へ着陸態勢に入る。放送から数ターン以内にやらないと船ごと蒸発する。
5. `down` → `port` → `take tea`(`no tea` を落としたと出る)→ `starboard` → `up`
6. `remove bit from substitute` → `drop tea`(`no tea` を拾ったと出る)→ `put bit in tea`
   (まだ careless words が起きていなければここで起きる)

以後、装置は**制御モード**(第 3 章)になる。Magrathea への着陸の放送は、鯨の出来事からしばらく後、船内にいる時に流れる。

### 4.11 tea と no tea → screening door(確認済み)

粒子を取ってあること(4.9)。まだなら制御モードで War Chamber へ行く(`turn on drive` → `wait` を挟みつつ hear が抜けたら `listen`、below なら `aft`)。

1. Bridge で `take tea`(`no tea` を落とす)→ `take no tea`(拾える)
2. `down` → `aft`(Corridor, Aft End)→ `open door`
   → tea と no tea を同時に持っていることを褒められて開く(開いたままになる)
3. `fore` → `up` → `drop tea` → `put bit in tea`(鯨へ行くためにもう一度組む)

**まだ tea を飲まない。Pantry にもまだ入らない**(300 点未満だと死ぬ)。

### 4.12 鯨の中 → flowerpot(確認済み)

鯨の中でしばらくすると地面に激突する(夢)。その際**持ち物は全部消える**。残るのは、着ている gown(ポケットの中身ごと)、babel fish、そして **thing の中に入れた flowerpot**(thing 自体は消えるが、いつものように数ターンで戻ってくる)。

1. Bridge で `drop all` → `take thing` → `inventory` で thing を持っていることを確認(無ければ数ターン待って `take thing`)
2. `save` → `turn on drive` → Dark で `wait` しながら feel が抜けるのを待つ → `feel darkness` → **warm** なら `taste liquid`(cold は Trillian のパーティーなので `wait` × 4 で回す)
3. `take flowerpot` → `put flowerpot in thing`
4. `wait` で激突 → Dark → `listen` → `aft` → `aft` → `up`
5. `inventory` を見ながら thing が戻るのを待つ(足元に出たら `take thing`)→ `take flowerpot`

別解(未確認): 鯨の中で Thumb の緑ボタンを押すと持ち物ごと脱出できるらしい。ただし Thumb は 4.10 で壊れているので、赤ボタンで修理ロボットを呼び、保証書を見せて直してからになる。

### 4.13 木を育てて道具を知る(確認済み)

fluff 4 個の在り処: pocket fluff・satchel fluff = gown のポケット／jacket fluff = Bridge の handbag／seat cushion fluff = Hatchway の床。

1. `put pocket fluff in flowerpot` → `put satchel fluff in flowerpot`
2. `take jacket fluff` → `put jacket fluff in flowerpot`
3. `down` → `aft` → `down`(Hatchway)→ `take seat cushion fluff` → `put seat cushion fluff in flowerpot`
4. `up` → `fore` → `up`(Bridge)。4 個目を植えてしばらくすると芽が出る(`examine flowerpot` で小さな芽が見える)
5. 芽が出た鉢を持って `port`(sauna)→ 植物が変化する(+25)→ `take fruit`
6. **道具 10 個が全部船内にある状態で、船内で** `eat fruit`
   → 未来の光景が見え、Marvin がある道具を求めている。**この道具が本番で要求される。**

道具 10 個と所在(ここまでの手順どおりなら):

| 道具 | 呼び方 | 所在 |
|---|---|---|
| flathead screwdriver | `screwdriver` | Bridge(Bedroom から持参) |
| toothbrush | `toothbrush` | Bridge(Bedroom から持参) |
| molecular hyperwave pincer | `pincer` | Bridge |
| pair of tweezers | `tweezers` | Bridge の handbag の中 |
| ultra-plasmic vacuum awl | `awl` | War Chamber で拾って Bridge |
| number twelve asteroid paint chipper | `chipper` | Traal の結末で入手して Bridge |
| pair of hypersonic pliers | `pliers` | Engine Room |
| ionic diffusion rasp | `rasp` | Engine Room |
| laser-assisted monkey wrench | `wrench` | Hatchway の toolbox の中 |
| thermo-fusion chisel | `chisel` | Pantry |

果実は「船内に無い道具」を優先して選ぶ(全部船内にあれば 10 個のどれか)。果実を食べずに Marvin に頼むと、Marvin は「その時あなたが持っていない道具」を要求するので必ず失敗する。

### 4.14 Marvin と脱出(確認済み)

着陸の放送が済んでいること(まだなら船内で待つ)。**ここで `save`。**

1. Bridge で `take tea` → `drink tea`(+100。350 点になる)
2. 指定された道具を取りに行く(Engine Room は 2 回目以降そのまま `aft` で入れる)
3. Corridor, Aft End から `port`(Pantry。+25)。道具が chisel ならここで `take chisel`
4. **`tell marvin to open hatch`**(Marvin が、しばらく後に Hatchway の Access Space で会おう、正しい道具を忘れるな、と言う)
5. `starboard` → `down`(Hatchway)→ `take off gown` → `drop all` → `take <道具>` → `inventory`
   → **持ち物が道具 1 個だけ**(`no tea` と babel fish は数えない)であることを確認。thing が gown のポケットに入り込んでいると `drop all` では落ちないので、gown ごと脱いで置く(確認済みの失敗例: ポケットの thing のせいで入口が狭すぎると弾かれ、Marvin に見限られた)。
6. `starboard`(Access Space)。ここでは何も `drop` しない。
7. 頼んでから 12 ターンほどで Marvin が来て、次のターンに道具を渡せ(`Hand me`)と言う。**その直後の 1 手で** `give <道具> to marvin`(+25。hatch が開く)
   - 待つのは `wait` でよいが、1 回で 3 ターン進むことを忘れない。早く着く分には問題ない。
8. `port` → `down` → Ramp に出てエンディング(400 点)。

---

## 5. 乱数・時間制限まわりの注意

### 5.1 `turn on drive` の前に必ず `save`

ランダムモードでは行き先を選べないので、必要なシーン(Traal・Ford・Trillian・Zaphod)が出るまで何度も飛ぶことになる。検証では 5〜12 回かかった。済んだシーンや Vogon Hold に着いたら数ターンで Dark → Entry Bay に戻るだけ。

### 5.2 War Chamber の再訪は本当に死ぬ

粒子を取った後は、Dark で hear が抜けたら**必ず `listen` で above / below を確かめる**。below(War Chamber)だったら `aft` せずに `restore`。ランダムモードのまま飛び続けると、ときどきこれを引く(検証で失敗した原因の大半)。

安全策は 2 つ:
- careless words をわざと起こさず(4 語以上の打ち間違いをしない)、War Chamber は tea の制御モードになってから行く。ランダムモードでは War Chamber が出ない。
- 既に起こしてしまったら、粒子を取った後のランダム飛行は毎回 `save` して below なら `restore`。

### 5.3 夢シーンの直後は Entry Bay に戻ることを確認する

夢シーンが終わった直後の Dark は Entry Bay(hear が抜け、`listen` で above)になるのが正常。検証で 1 回だけ、Trillian のシーン直後に Lair へ着き、その後 Beast が迫ってくる文が船内まで付いて来て、最後に本当に殺された。原因は特定していない。**夢シーン直後に above 以外が出たら `restore`。**

### 5.4 主な時間制限の目安

| 場面 | 起点 | 期限 |
|---|---|---|
| Bedroom／Porch に居残る | 開始 | 20 ターン目ごろに死 |
| Vogon 艦隊 | 開始 | 50 ターン目ごろ(家が壊れた後に Front of House に入ると数ターン後) |
| ブルドーザー | Front of House に出る | 数ターンで死(寝れば止まる) |
| peanuts | Hold 到着 | 6 ターン目ごろに死 |
| 衛兵 | Hold 到着 | 数十ターン後(fish を取ると早まる) |
| type と plotter | 詩の後 Hold に戻る | 数ターン |
| Engine Room の問答 | 質問 | 黙っていると最初から |
| Beast | 着く／追いつかれる | 何度も詰め寄られると死。towel で猶予、彫ってからしばらくで hunters |
| ボート | 開始 | 数ターンで激突。岩へ向けると自動操縦 |
| 衛兵の銃 | 銃を捨てさせる | 数ターン以内に撃たせる |
| Phil | fluff を取る | しばらく後(落とし物が残っていると遅れる) |
| ミサイル | `push pad` | 数ターン後に警報、その後しばらくで死 |
| 着陸 | 鯨のイベント | しばらく後(船内にいる時) |
| 芽 | 4 個目の fluff | 10 ターンほど後 |
| 鯨 | 鯨の中に着く | 10 ターンほどで激突 |
| Marvin | 頼む | 12 ターンほどで Access Space に来て、次のターンに要求、その次に去る |

---

## 6. 確認済みコマンド列(400 点・407 手)

乱数で変わる箇所は【】で示す。`wait…` は条件が満たされるまで `wait` を繰り返す意味。

```
turn on light / stand / take gown / wear gown / open pocket / take analgesic
take screwdriver / take toothbrush / south / take mail / south
lie down in front of bulldozer
wait…(Ford が country lane へ急ぐまで)
south / west / buy sandwich / drink beer / drink beer / drink beer / east
give sandwich to dog / north
wait…(Ford が device を落とすまで) / take device / push green button

wait ×4 / smell / examine shadow
eat peanuts / take off gown / hang gown on hook
wait…(Guide を受け取るまで)
take towel / put towel on drain / take satchel / put satchel in front of panel
put mail on satchel / push dispenser button / push switch【序数を控える】
take gown / wear gown / take towel
wait…(Captain's Quarters で詩の朗読が始まるまで) / enjoy poetry
wait…(第 2 連の最初の行の最初の単語を控える。Hold に戻されるまで)
type "<単語>" / take plotter
wait…(宇宙に吸い出されるまで)

wait ×5 / listen / aft
wait…(all head off to port まで)
drop plotter / drop guide / drop device / drop screwdriver / drop toothbrush / open handbag
down / aft / aft / yes / yes / aft / no / look / look / take drive
fore / fore / port / push pad / take substitute / starboard / up
drop drive / plug small plug in plotter / drop substitute / put bit in substitute

【以下、4 シーンが済むまで繰り返す】 save / turn on drive / (第 3 章で Dark を抜ける)
  Lair   : say my name / east / take stone / put towel over head / carve my name on memorial
           take off towel / drop stone / west / southwest / take interface / wait…
  Lane   : north / open satchel / take satchel fluff / give towel to arthur / idiot
           walk around bulldozer / tell prosser to lie in the mud / south / west
           buy beer / drink beer / drink beer / east / north / give satchel fluff to arthur / wait…
  Party  : examine arthur / drop wine / take fluff / open handbag / put fluff in handbag / take wine / wait…
  Boat   : steer boat toward spire / look under seat / unlock toolbox with key / take toolbox
           wait…(dais に着くまで) / stand / north / jump ×4
           tell guards to drop rifles / tell trillian to shoot rifles / east
  帰り   : (Dark)listen / aft / aft / up

drop towel / drop chipper / down / port / open nutrimat / take board / drop board
put interface in nutrimat / push pad / starboard / up
wait…(ミサイルの警報まで) / plug large plug in large receptacle / turn on drive
down / port / take tea / starboard / up
remove bit from substitute / drop tea / put bit in tea

turn on drive / (制御モードで War Chamber: listen が below になるまで) / aft
take awl / wait…(Maze まで) / north…(particle が出るまで) / take particle
(Dark)listen / aft / aft / up

take tea / take no tea / down / aft / open door / fore / up / drop tea / put bit in tea

drop all / take thing / turn on drive / (制御モードで鯨: feel darkness が warm) / taste liquid
take flowerpot / put flowerpot in thing / wait…(激突)
(Dark)listen / aft / aft / up / (thing が戻るまで) take thing / take flowerpot

put pocket fluff in flowerpot / put satchel fluff in flowerpot
take jacket fluff / put jacket fluff in flowerpot / down / aft / down
take seat cushion fluff / put seat cushion fluff in flowerpot / up / fore / up
wait…(芽が出るまで) / port / take fruit / eat fruit【道具を控える。例: rasp】

take tea / drink tea
【道具を取りに行く。例: down / aft / aft / take rasp / fore】
port / tell marvin to open hatch / starboard / down
take off gown / drop all / take rasp / inventory / starboard
wait…(Marvin が道具を求めるまで) / give rasp to marvin / port / down
```

---

## 7. 補足

- **The Hitchhiker's Guide**: `consult guide about <もの>` でヒントが読める(fluff、improbability、tea と no tea、Beast、Thumb の保証書など)。攻略には必須ではない。
- **footnote**: 文中に脚注の番号が出たら `footnote <番号>` で読める。得点には無関係。
- **anti-Bugblatter Beast gun**(Galley の carton の中)は Beast を怒らせるだけ。
- **circuit board の dipswitch** には何の機能も無い。
- **Thumb**: 船が近くに無い時に緑ボタンを押すと壊れる。壊れたら赤ボタンで修理ロボットを呼び、保証書を見せると直るらしい(未確認)。本書の手順では Earth 以外で使わない。
- **エンディング**: Ramp に 1 歩出た所で「続きは次作で」と終わり、スコアが表示される。
