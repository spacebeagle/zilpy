# DEADLINE 攻略ガイド(LLM 参照用)

本ガイドは、ゲーム内の進行・時間経過・解法をまとめた攻略リファレンスである。`out/deadline` ディレクトリで `python deadline.py` を実行してプレイする。コマンドの文言がパーサーに弾かれたら言い換えること。乱数で前後する時刻は「頃」と書いてある。

---

## 1. 結論(真相と勝利条件)

### 真相
- 被害者 Marshall Robner は自殺ではなく**他殺**。
- 犯人は共同経営者 **Mr. Baxter** と秘書 **Ms. Dunbar**(二人は恋人同士)の共犯。
- 動機: Baxter は Robner の反対を押し切って会社を Omnidyne に合併させたかった。Robner は Baxter の過去の横領(**Focus スキャンダル**)を暴露すると脅すメモを書いた。
- 手口: Dunbar が自分の降圧剤 **LoBlo** を Robner の紅茶に入れた(Robner の常用薬 Ebullion と併用すると致死的)。Robner の死後、Baxter が物置のはしごで書斎のバルコニーから侵入し、毒入りのカップをきれいなカップとすり替えた。降りる途中でカップを落とし、**破片**がバラ園に残った。
- George(息子)と Mrs. Robner(妻、愛人 Steven がいる)は怪しく見えるが、どちらも**ミスリード**。

### 勝利条件
`arrest baxter and dunbar` を、次の **5 条件すべて**を満たした状態で実行する。

| # | 条件 | 入手方法 |
|---|------|---------|
| 1 | 検査報告書を持っている | 破片を LoBlo について分析させる |
| 2 | Focus の書類を手に取った | George が金庫を開けた瞬間に踏み込む |
| 3 | メモ帳の筆圧跡を読んだ | メモ帳を鉛筆でこする |
| 4 | Dunbar に半券を突きつけて「彼が送ってくれた」と言わせた | 半券を Dunbar に見せる |
| 5 | Dunbar が生きている | 殺される前に逮捕する |

- 時刻が 10:00 より前だと「時期尚早」で逮捕できない。
- 逮捕コマンドは二人がその場にいなくても通る(場所のチェックがない)。
- 条件が欠けたまま逮捕すると、欠けた内容に応じた「不起訴/無罪」の手紙でゲーム終了。**逮捕は一発勝負**なので、直前に `save` すること。

---

## 2. ゲームの基本仕様

- 開始は **8:00**。**20:00** になると時間切れで強制終了。
- 通常のコマンド 1 回 = **1 分**。
- `wait` は既定で **3 分**。`wait for 10`(10 分)、`wait until 11`(11 時まで)、`wait until noon`、`wait for dunbar`(その人が来るまで)、`wait for duffy`(分析結果が来るまで)が使える。
  - 待機中に何か起きると **"Do you want to keep waiting? (Y/N)"** と聞かれる。次の入力で `y` か `n` を答える。
  - 1 分単位で刻みたいときは `wait` ではなく `look` や `examine ...` のような 1 分で済むコマンドを使う。
- 人物への話しかけ方:
  - `ask dunbar about baxter`
  - `show lab report to dunbar`
  - `mcnabb, show me the holes`(命令形)
- 質問や提示をすると相手は数分間立ち止まる(注意持続時間あり)。
- `time` で現在時刻。`save` / `restore` が使える。
- Duffy 巡査部長は常に近くにいる。`analyze X` / `analyze X for Y` / `fingerprint X` で証拠を持って行き、**15〜30 分後**に結果を持って戻る。分析中は次の依頼ができない(同時に 1 件だけ)。

---

## 3. マップ

### 屋外
```
                      [North Lawn](湖岸)
                     /       |        \
                   sw        s         se
        [West Lawn]--ne--[Rose Garden]--e--[Orchard]--e/se--[East Lawn]--se/in--[Shed]
             |                 | s                | s              |
             |            [In Roses]----e----[In Orchard]     (hide behind shed
             |             (書斎バルコニー     (主寝室バルコニー     → [Behind Shed])
             |               の真下)            の真下)
        [West Side]                             | s
             |                              [East Side]
   [West of Door]--e--[Front Path]--e--[East of Door]--e--[East Lawn]
                          | s
                     [South Lawn](開始地点。南は敷地外で出られない)
```
- Front Path の北が玄関(Front Door)。最初は `knock on door` で Mrs. Robner が入れてくれる。
- In Roses(バラの中)に勝手に入ると庭師 McNabb が激怒し、約 90 分口をきいてくれなくなる。**入るのは McNabb に案内させてから**。
- はしごを持ったまま家には入れない。

### 1 階
```
        [Kitchen]--e--[Pantry]
            | s
[Dining Room]--e--[Corner]
                     | s
[Living Room]--e--[NFoyer]--e--[Stair Bottom]--up--[Stairs]
                     | s             | s
                  [Foyer]        [SHall-1]--e--[SHall-2]--e--[Rourke Bath]
                     | s             | s            | s
                 (Front Door)   [Rourke Room]   [South Closet]
```

### 2 階
```
              [Library Balcony]                    [Bedroom Balcony]
                    | s                                  | s
               [Library]--e--[Hidden Closet]--e--[Master Bedroom]--e--[Master Bath]
                    | s        (隠し部屋・金庫)           | s
[Corridor-4]--e--[Corridor-3]--e--[Corridor-2]--e--[Corridor-1]--e--[Stair Top]--n--[North Hall]--e--[Guest Room]
 (n=Library)        | s              | n               | s            | s
              [George Room]   [Upstairs Closet]   [Dunbar Room]   [SHall-11]--e--[SHall-12]
                    | e                                              | s             | s
              [George Bath]                                    [Dunbar Bath]    [Closet-11]
```
- Library の北が Corridor-4 ではなく、**Corridor-4 の北が Library**(Library から `south` で Corridor-4)。
- Hidden Closet は Library の本棚の裏。中に赤ボタン(Library 側の扉)と青ボタン(Master Bedroom 側の扉)がある。
- Guest Room の窓から East Lawn と物置が見える。

---

## 4. 登場人物の行動スケジュール

時刻は目安で、±10〜30 分ずれる。イベントが起きるとスケジュールは上書きされる。

| 人物 | 動き |
|------|------|
| **McNabb**(庭師) | 開始時 North Lawn → 10:00 頃 East Lawn → **11:00 頃 Rose Garden** → 12:00 頃 Orchard → 13:00 頃 South Lawn → 15:00 頃 West Lawn |
| **Baxter** | **9:55 に車で到着** → 10:00 頃 Living Room(本を読んでいる) → **16:00 頃に車で帰る(以後は会えない)** |
| **Dunbar** | 開始時 Living Room → 9:00 頃 自分の浴室 → 9:30 頃 自室 → 11:45 頃 Living Room → 14:00 頃 自室 |
| **George** | 開始時 自室 → 9:20 頃 Kitchen → 9:50 頃 Dining Room → 11:00 頃 自室 → 11:45 頃 Living Room → 12:45 頃 East Lawn → 14:00 頃 Living Room → 15:00 頃 自室 |
| **Mrs. Robner** | 開始時 Living Room(玄関で出迎え後 Kitchen) → 8:30 頃 Dining Room → 11:10 頃 Living Room → 12:40 頃 Master Bedroom → 13:50 頃 Living Room |
| **Mrs. Rourke**(家政婦) | 開始時 Kitchen → 10:00 頃 Dining Room → 11:00 頃 Kitchen → 13:00 頃 Living Room → 14:00 頃 自室 |
| **Coates**(弁護士) | 11:50 頃 到着 → Living Room で **12:00 に遺言状の読み上げ** → すぐ帰る |

### 時刻で起きるイベント
| 時刻 | 出来事 |
|------|--------|
| 9:00〜9:10 頃 | 電話が鳴る(Steven から Mrs. Robner へ)。任意 |
| 9:10〜10:10 頃 | 郵便が届く(Steven からの手紙)。約 1 時間で Rourke が回収して Mrs. Robner に渡す。任意 |
| 9:55 | Baxter 到着 |
| 10:55〜11:35 頃 | 新聞が Front Path に投げ込まれる。任意 |
| 11:00 過ぎ | McNabb が Rose Garden に着き、2〜12 分後に「穴」に気づいて怒り出す。**必須** |
| 12:00 | 遺言状の読み上げ(Living Room)。**必須級** |
| 16:00 頃 | Baxter が帰る。**これ以前に決着をつける** |
| 20:00 | 時間切れ |

---

## 5. 推奨ルート(勝利までの手順)

### フェーズ A: 入館と書斎(8:00〜)

1. `north` → Front Path。`knock on door` → Mrs. Robner が出迎え、Foyer に入る。
2. 2 階の Library へ: `north`(NFoyer)、`east`(Stair Bottom)、`up`、`up`(Stair Top)、`west` ×4(Corridor-1→2→3→4)、`north`(Library)。
3. Library でやること:
   - `examine notepad carefully`(筆圧跡があると分かる)
   - `take pencil`、`rub notepad with pencil` → Baxter 宛てのメモの跡が読める。**条件 3 達成**。代替: `hold notepad up to light`
   - `take notepad`(後で人に見せられる)
   - `examine calendar` → 7 月 7 日のページ(14 時に Baxter と面会)。
   - `turn calendar` → 1 ページ進んで **7 月 8 日**: 「9AM Call Coates: Will completed(遺言完成)」。**開いたまま** `take calendar`。
   - 任意で調べるもの: `examine carpet`(机の周りに乾いた泥)、`examine cup` / `examine saucer`、`examine tray`、`read ebullion label`、`examine wastebasket` / `read trash`(Baxter 宛てメモは捨てられていない=届いている)、`open window` して `north` でバルコニーへ出て `examine railing`(塗装が剥げている=はしごの跡)、`examine balcony`(泥)。
   - **バルコニーの窓は開けておく**(後で隠れる場所に使う)。

### フェーズ B: George に種をまく(〜11:45 までに)

4. カレンダー(7 月 8 日のページ)を George に見せる: `show calendar to george`。
   - George は 9:20 頃まで自室(Corridor-3 の南。`knock on door` → `open door` → `south`)、その後 Kitchen → Dining Room。
   - 読み上げ**前**に見せた場合: その場ではとぼけるが、**読み上げ直後に George が動揺して動き出す**。
   - 読み上げ**後**に見せた場合: その場で動揺し、すぐ自室へ向かう(フェーズ E が即開始)。
   - カレンダーが 8 日のページでないと反応しない。

### フェーズ C: 午前中の任意調査(時間が余れば)

勝利条件ではないが、話の裏付けになる。
- **Dunbar の浴室**(Stair Top → `south` → SHall-11 → `south`): `open cabinet`、`read loblo label`。LoBlo は「他の薬との併用は危険」。
- **Kitchen**: `examine cups`、`count cups`(6 個)、`count saucers`(7 枚)。カップが 1 個足りない。ここで china を調べておくと、破片を拭いたとき「台所のものと同じ柄」と表示される。
- **電話**(9:00 過ぎ): 鳴ったら `answer phone`。Mrs. Robner が寝室に移って掛け直すので、Library か Living Room の内線で `listen to phone` すると Steven との会話が聞ける。
- **郵便**: 届いた封筒を Mrs. Robner のいない場所で `open envelope`、`read letter`(愛人 Steven からの手紙。Baxter の合併話にも触れている)。
- **新聞**(11 時頃 Front Path): `read second section` → Robner Corp. と Omnidyne の合併記事。Baxter は「Robner も賛成していた」と言っているが嘘。
- 各人に `ask X about Y` で聞き込み(baxter / dunbar / george / mrs robner / rourke / focus / merger / new will / safe / steven など)。

### フェーズ D: 穴と破片(11:00〜11:40 頃)★最重要

5. **11:00 頃までに Rose Garden へ**(玄関から出て Front Path → `west` → West of Door → `nw` → West Side → `west` → West Lawn → `ne` → Rose Garden)。In Roses には**まだ入らない**。
6. McNabb が来て数分すると、「誰かが穴をあけてバラを潰した」と騒ぎ出す。自分から言ってこなければ `ask mcnabb about roses` または `listen to mcnabb`。
7. `mcnabb, show me the holes` → 「Follow me!」と言って In Roses へ歩く。**すぐ** `south` で付いて行く(到着後 4 ターン以内に行かないと「もう覚えていない」と拒否され、二度と案内してくれない)。
8. 穴が見えるようになる。`examine holes`(はしごの脚の跡)。
9. `search around holes` を **最大 3 回**繰り返す → 指を切って**磁器の破片**(fragment)を拾う。
10. `clean fragment` → 手描きの美しい破片と分かる。
11. **`analyze fragment for loblo`** → Duffy が持って行く。15〜30 分後に「LoBlo が検出された」という**検査報告書(lab report)**を持って戻る。**条件 1 達成**。
    - 単に `analyze fragment` だと「一般的でない薬物が含まれる。Ebullion ではない」としか分からず、報告書はもらえない。必ず `for loblo` を付ける。
    - 結果は自分がどこにいても届く。読み上げに間に合うよう Living Room へ戻る。
- 任意: 物置のはしごを持ってきて `put ladder in holes` → ぴったりはまり、書斎のバルコニーに届く(`up` で登れる)。演出のみ。なお正午頃に McNabb が Orchard に着くと、はしごを回収して行く。

### フェーズ E: 遺言状の読み上げ → George の金庫(12:00〜12:40 頃)★最重要・タイミング勝負

12. **12:00 に Living Room にいる**(`wait until noon` など)。Coates が旧遺言(George と夫人で折半)を読み上げ、「新しい遺言が見つかればこちらは無効」と言う。フェーズ B を済ませていれば、George が青ざめて部屋を出て行く。
13. **`save` する。** ここから先は 1 分単位の勝負。
14. すぐ 2 階の **Library Balcony** へ行く(Library → `north`。窓が閉まっていれば `open window`)。
    - George は自室に入り、プレイヤーが **2 階東西の廊下(Corridor-1〜4、Stair Top)にも Library にもいない**ときだけ動き出す。廊下でうろうろしていると永遠に出てこない。George の部屋に入ると追い出される。
    - 隠れ場所は Library Balcony が最良(Upstairs Closet からは彼が Library に入るところしか見えない)。
15. バルコニーで `look` などの 1 分コマンドを繰り返して待つ。次の順でメッセージが出る:
    1. George が廊下を見回して Library に飛び込む。
    2. George が本棚をいじり、**左端の本棚が回転して暗い部屋が現れ、中に入る**。
    3. 次のターン: 隠し部屋に薄明かりがつき、**本棚が閉まる**。← ここを「0」として数える。
16. 「本棚が閉まる」メッセージの後、**9〜14 個目のコマンドでボタンを押す**。
    - **早すぎる(8 個目以前)**: George はまだダイヤルを回している最中で、突き飛ばして逃げる。金庫は開かない → 失敗、`restore`。
    - **遅すぎる(15 個目以降)**: George は遺言を持って出て行き、湖に捨てる → 失敗、`restore`。
    - 推奨の手順(各 1 分):
      1. `south`(Library に入る)
      2. `examine bookshelves` → 本が 1 冊ずれていて、奥に**黒いボタン**が見える
      3〜9. `look` や `examine desk` などで 7 回時間をつぶす
      10. **`push button`** → 本棚が開き、金庫を開けたばかりの George が紙を抱えて崩れ落ちる。自動的に Hidden Closet に入る。
    - `wait` は 3 分進んでしまうので、ここでは使わない。
17. Hidden Closet で:
    - **`look in safe`**(これをしないと書類が見えない)
    - **`take papers`** → **条件 2 達成**。`read papers` → Baxter が Focus 社の資金を横領し、もみ消した証拠。
    - 任意: `ask george for will` / `take will` → 新しい遺言(George を廃嫡、全財産を夫人へ)。George の動機に見えるが、彼は犯人ではない。
    - 出るときは `push red button`(Library 側)。

### フェーズ F: Dunbar を追い詰めて半券を得る(13:00〜15:30 頃)★最重要

前提: 検査報告書・書類・メモの 3 つが揃っていること。**Baxter が帰る 16:00 より十分前**に始める。

18. **`save` する。**
19. Dunbar に報告書を見せる: `show lab report to dunbar`(読み上げ後は Living Room、14:00 頃以降は自室)。彼女は動揺し「LoBlo は私の薬だが、やっていない。George が盗んだのでは」と言う。
    - これで 5〜20 分後に自動で次の展開が始まる。すぐ始めたければ続けて `accuse dunbar`。
20. **Baxter と Dunbar が二人きりになれるよう、その部屋から出る。** プレイヤーが同じ部屋にいると、Dunbar は Baxter をちらちら見るだけで話が進まない。
21. 二人が短く話した 5 分後、Dunbar は **物置(Shed)**へ向かって家を出る(玄関 → Front Path → East of Door → East Lawn → Shed)。10 分後に Baxter も North Lawn 経由で物置へ向かう。
22. **屋外で Dunbar が見える位置にいる**こと(同じ場所か、見通しのきく直線上。East Lawn か Front Path 付近で待つのがよい。`follow dunbar` も可)。
    - プレイヤーに気づくと Dunbar は立ち止まり、煙草を出そうとして**チケットの半券(ticket stub)を落とす**。
23. その場所へ行って `take stub`、`read stub` → 7 月 7 日 20 時、Hartford Philharmonic のコンサート。
24. **立ち止まっている Dunbar に、Baxter のいないところで** `show stub to dunbar` → 「Baxter さんとコンサートに行った。**そのあと彼が家まで送ってくれた**」と白状する。**条件 4 達成**。
    - Baxter は警察に「一人でコンサートに行った」と証言しており、半券を見せると「Dunbar は休憩時間に具合が悪くなり一人で車を呼んで帰った」と言う。二人の話が食い違う=Baxter は事件の夜、屋敷に来ていた。
    - **注意**: Dunbar のいる前で先に Baxter に半券を見せると、Dunbar は「Baxter さんの言うとおり」としか言わなくなり、条件 4 が永久に取れない。**必ず Dunbar に先に、単独で見せる。**
25. **`save` してから、ただちに `arrest baxter and dunbar`。** → 9 月 5 日付の祝福の手紙が出れば勝利。作者による事件のまとめを読むか聞かれる。

---

## 6. やってはいけないこと(失敗・死亡パターン)

| 行動 | 結果 |
|------|------|
| フェーズ F で逮捕せずに放置する | 物置で密談 → Baxter がはしごで Master Bedroom のバルコニーから侵入し、**Dunbar を射殺して自殺に偽装**。条件 5 が永久に失われ、最良の結末は不可能になる |
| 上の状況で Master Bedroom か Bedroom Balcony に入る | 潜んでいる Baxter に**撃たれて死亡** |
| Dunbar の前で先に Baxter に半券を見せる | 条件 4 が取れなくなる |
| McNabb の案内前に In Roses に入る | McNabb が激怒し約 90 分無視される(11 時過ぎに重なると致命的) |
| McNabb に案内を頼んで付いて行かない | 二度と案内してくれない |
| Hidden Closet のボタンを押すのが早すぎ/遅すぎ | 金庫が開かない/遺言が湖に捨てられる。書類が取れない |
| 証拠が揃う前に誰かを `arrest` する | 不起訴・無罪の手紙でゲーム終了 |
| Baxter が帰る 16:00 を過ぎる | Dunbar の展開が起こせなくなる |
| 20:00 を過ぎる | 時間切れで終了 |
| Baxter の持っている本の結末を読む(`read ending`) | 自殺エンド |
| 台所の china を壊す(`break cups`) | 25% の確率で逮捕されて終了 |
| 郵便を Mrs. Robner の前で開ける | 取り上げられる |

---

## 7. Dunbar が殺されてしまった場合(次善の結末)

`restore` できないときの逃げ道。Robner 殺害については完全な立証にならないが、Baxter を有罪にはできる。

- 銃声の後、Dunbar の部屋に死体・拳銃・遺書(「私が Robner 氏を殺しました」。**青いインク**で書かれているが、部屋にペンがない)。
- 銃声の直後に 2 階の廊下(Corridor-1 付近)にいれば、Baxter が Dunbar の部屋から Master Bedroom へ走るのを目撃できる。Upstairs Closet などに隠れて見張る手もある。**Master Bedroom には入らない。**
- しばらくすると Baxter が何食わぬ顔で Dunbar の部屋に現れ、「彼女が自白した」と泣き崩れる。
- `ask baxter for pen` → 反射的に上着からペンを出しかけて固まる。
- `arrest baxter` → Dunbar 殺害で有罪。さらに書類を取得済みかつメモを読了済みなら「2 件の第一級殺人で有罪」の結末になる。

---

## 8. 証拠と証言の早見表

| 物 | 場所 | 意味 |
|----|------|------|
| notepad | Library の机 | 鉛筆でこすると Baxter 宛ての脅しのメモ(合併をやめろ、さもないと Focus の書類を…) |
| desk calendar | Library の机 | 7/8「遺言完成、Coates に電話」。George を動かす引き金 |
| cup / saucer | Library | すり替えられたきれいなカップ。分析しても紅茶だけ |
| sugar bowl | Library の盆 | ただの砂糖(ミスリード) |
| Ebullion | Library | Robner の抗うつ薬。死因とされた薬 |
| LoBlo | Dunbar の浴室の戸棚 | Dunbar の降圧剤(カナダ製)。真の凶器 |
| Sneezo / Allergone | Master Bath | Mrs. Robner の薬(ミスリード) |
| holes | In Roses | はしごの脚の跡。McNabb に案内させる |
| fragment | In Roses の穴の周り | 毒入りカップの破片。`analyze fragment for loblo` |
| lab report | Duffy から | LoBlo 検出。他殺の証明 |
| ladder | Shed | 侵入に使われたはしご |
| Baxter papers | Hidden Closet の金庫 | Focus 横領の証拠。Baxter の動機 |
| new will | 同上(George が持ち出す) | George 廃嫡。ミスリードだが George を動かす鍵 |
| ticket stub | Dunbar が屋外で落とす | Baxter のアリバイ崩し |
| envelope / letter | 郵便 | Steven から Mrs. Robner へ(ミスリード) |
| newspaper | Front Path | 第 2 面に合併記事 |
| pen | Baxter(Dunbar 死亡後のみ) | 偽の遺書を書いたペン |

---

## 9. 最短手順チェックリスト

1. [ ] 入館 → Library: `rub notepad with pencil`、`turn calendar`(7/8)、`take calendar`、`open window`
2. [ ] `show calendar to george`(読み上げ前)
3. [ ] 11:00 頃 Rose Garden で待機 → `mcnabb, show me the holes` → `south`
4. [ ] `search around holes`(最大 3 回)→ `clean fragment` → `analyze fragment for loblo`
5. [ ] 12:00 Living Room で遺言の読み上げ → `save`
6. [ ] Library Balcony に隠れる → George が隠し部屋に入り本棚が閉まる → 9〜14 コマンド後に `push button`
7. [ ] `look in safe` → `take papers` → `read papers`
8. [ ] 検査報告書を受け取っていることを確認 → `save`
9. [ ] `show lab report to dunbar` → 部屋を出る → 屋外で Dunbar を見張る
10. [ ] 半券を落としたら `take stub` → `show stub to dunbar`(Baxter 不在で)
11. [ ] `save` → **`arrest baxter and dunbar`**
