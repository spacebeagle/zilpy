# PLANETFALL ゲームプレイ解説（LLM 攻略用リファレンス）

Infocom の **Planetfall** を、次に遊ぶ LLM がこの資料とゲーム出力だけでクリアできるようにまとめた攻略メモ。

- **対象**: 西のカラモンティー複合施設、東のラワンダ複合施設、宇宙船からの脱出〜エンディングまでの全手順。
- **どこまで確かめたか**: `out/planetfall` ディレクトリで `python planetfall.py` を直接実行して **通しプレイを行い、80/80 点でクリアした**（Release 88 / Serial 840726、2日目の夜に完結）。この版は、その実プレイで分かったことを反映した改訂版。
- **根拠の印**: 【確認済み】＝実プレイで動作を確かめた。【推測】＝推し量った部分。**章ごとの印は、特に断りがなければ【確認済み】に読み替えてよい（下の「実プレイでの訂正」で外れた点を明記した）**。

### 実プレイでの訂正（最優先で読む）【確認済み】

1. **斜め方向は略記**: `ne` `nw` `se` `sw` を使う。`northeast` / `southeast` は `I don't know the word` になる。
2. **カード名に `access` を付けない**: `take shuttle access card` は通らないことがある。`take shuttle card`、`take upper elevator card`、`take kitchen card` と書く。
3. **磁石でカードが壊れる事故が実際に起きた**: `drop card` が「どのカード？」と聞き返されて失敗したのに気付かず `take bar` すると、下のエレベーターカードが壊れ、**ラワンダへ行けず詰む**（壊れた磁気を直す手段はない）。**磁石を取る前に必ず `inventory` でカードを 1 枚も持っていないことを確認する**。下のエレベーターカードは磁石を捨てた後に Floyd から取るのが安全。
4. **空腹**: 警告（`A growl`）が出る前に `eat liquid` / `eat goo` すると `Thanks, but you're not hungry.` と断られる。**睡眠は空腹レベル 0（食べた直後）で入る**。空腹のまま寝ると、起床時にいきなり飢餓レベル 4（約 150 単位で死亡）になる。満腹で寝れば、起床後 400 単位は空腹にならない。
5. **カンティーンの液体は 1 回で飲み切る**（空になる）。補充は台所の dispenser でしかできない。ゴーはキットを**手に持って**から `eat green goo`（床に置いたままだと食べられない）。
6. **所持重量が非常に厳しい**: 病気 1 段ごとに上限が 10 ずつ下がる（2日目には 80 前後）。レーザー・ペンチ・フラスコ・カンティーン・bedistor は同時に持てない。重量オーバー時はカードやフラスコが落ち、**フラスコを落とすと薬液が蒸発する**。ID カード、古い電池、使い終わったカードは捨てる。
7. **制服が 2 着になる場面**（Lab Storage）: `put X in uniform` は曖昧になる。`patrol uniform` / `lab uniform` と指定する。
8. **ID カードは不要**。磁石の被害を受ける優先順位も最後。
9. **今回のタイムラインの目安（時刻）**: 1日目 開始〜7500 で台所まで、眠気の警告は 8000 付近、2日目は 1650 台から。ラワンダ到着 5183、軌道制御・惑星防衛 6300〜6550、Floyd の犠牲 6865、補助ブース 7186、クリア 7553。時刻は 10000 で一周する。

> 注意: 解き方がすべて書かれています。自分で解きたい人は読まないでください。
> ゲームの文章は「出力から探すための短い目印」だけを原文で引用し、全体の解説は日本語でまとめています。

---

## 0. 最初に読むこと

### 0.1 時間の仕組み（最重要）

このゲームの時計は「ターン」ではなく **時間単位（millichron）** で進む。

| 行動 | 消費する時間 |
|---|---|
| 普通のコマンド | 7 |
| `wait` | **40**。1 回で普通のコマンド約 6 回分進む |
| 部屋によっては移動が重い | 例: Dorm Corridor ⇄ Corridor Junction の長い廊下は **160**、斜めの出口の多くは 25、階段 15〜30 |
| シャトル走行中 | 1 コマンド = 600 ÷ 速度 |
| `save` `restore` `score` `time` など | 0 |

タイマーは、この時間単位でカウントを減らしていく。この資料で「50 単位」と書いたら、普通のコマンドなら約 7 回分、`wait` なら 2 回分。

- `score` で得点・日数・時刻が見られる。時間は進まない。
- 1 日目は時刻 **4450〜4630** から始まる。

### 0.2 じわじわ減る資源

| 資源 | 仕組み | 対処 |
|---|---|---|
| **空腹** | 開始から 2000 単位で 1 回目の警告（`A growl from your stomach`）。そのあと 450 → 150 → 100 → 50 単位ごとに悪化し、**5 段目で死ぬ**（警告から約 750 単位）。食べると 0 に戻る。**警告前は食べられない**。**睡眠中は進まず**、起床時に空腹レベルが 0 なら 400 単位、1 以上なら即レベル 4 になる | 救命キットのゴー（3 個。食べると 1450 単位もつ。**1周目の実測では開始後すぐ（Admin Corridor 到着前後）に警告が出る**）、またはカンティーンの高タンパク液（3600 単位もつ。台所で補充。カンティーンは飲むと空になる） |
| **睡眠** | 1 日目は開始から 3600 単位で `You begin to feel weary.`。そのあと 400 → 135 → 60 → 50 単位で悪化し、5 段目でその場に倒れて眠る | 警告が出たら寮（Dorm A〜D）の寝台で `get in bed`（4.4） |
| **病気** | 起床のたびと、ラワンダのホームに初めて着いた時に「悪化の予約」が立ち、その後 700 単位ごとの判定で 1 段ずつ悪化する。**9 段目で死ぬ**。1 段悪化するごとに **運べる重さが 10 減る**（最初は 100） | 診療室（Infirmary）の薬を飲むと 2 段戻り、運べる重さが 20 増える。基本は「急いで解く」 |
| **日数** | 眠るたびに 1 日進む。**9 日目の朝を迎えると死ぬ** | 8 日目の夜までに解く。推奨ルートは 2〜3 日目にクリアする想定 |

### 0.3 眠る時の落とし穴

- **起きると、身に着けていない持ち物はすべて足もとに落ちる**。身に着けている物（Patrol の制服、時計）と、**制服のポケットの中身**は残る。カード類（大きさ 3）はポケット（容量 10）に入れておくと楽。
- 起床時に、**開いているカンティーンの高タンパク液は消える**。フラスコの薬品も消える。高タンパク液を入れたら `close canteen`。
- **寝る前に満腹（空腹レベル 0）にしておく**（0.2、実プレイで確認）。警告後に食べ、その後に眠気の警告が来る順が理想。眠気の警告は日中の `wait` を重ねれば出る（1日目は時刻 8000 付近）。`get in bed` → `wait` 1 回で眠る。起床したら `get out of bed` してから荷物を拾う（寝台の中からは取れない）。
- 寝る場所:
  - 寮の寝台（Dorm A〜D）が安全。
  - **診療室（Infirmary）の寝台に入ると即死**（壊れた医療ロボットに殺される）。
  - 床で寝ると 30% の確率でけものに襲われて死ぬ。1 日目の Crag、3 日目の Balcony、5 日目の Winding Stair の床では溺れ死ぬ。

### 0.4 操作の基本

| やりたいこと | 書き方 | 備考 |
|---|---|---|
| カードを使う | `slide kitchen card through slot` | `put X in slot` は「浅くて入らない」と断られる。`slide ... with`、`put ... with` の構文もある。通らなければ `slide card in slot` も試す |
| エレベーターのボタン | `push up button` / `push down button` | `push button` だけだと「Up か Down かを指定せよ」 |
| 数字を打つ | `type 384` | ミニチュア化ブースと図書室の端末だけ |
| ダイヤル | `set dial to 384` / `set laser to 1` | |
| レーザー | `fire laser at speck` | `fire <対象> at <標的>` 構文 |
| ペンチで抜く | `take bedistor with pliers` | 良品を持っていると「どちらの bedistor？」と聞かれる。`fused` と答える |
| 磁石 | `put magnet near crevice` | **カードを持たずに**取って使い、すぐ `drop magnet`（0 の訂正 3） |
| 扉 | `open door` | 「どの扉？」と聞かれたら `bio-lock door` / `lab door` のように答える。斜めの扉は `open door`＋`se` |
| はしごを渡す | `put ladder across rift` | 裂け目に架ける |
| 液体 | `pour fluid in hole` / `eat liquid` | 飲むのも `eat`（容器を持っていること） |
| Floyd に命令 | `floyd, go north` | `tell floyd to ...` でもよいはず。複数の命令をつなげると、Floyd は 2 つ目以降を忘れる |

---

## 1. ゲームの目的と全体の流れ

### 1.1 勝利条件

**惑星のコンピューターを直したあと、ProjCon Office の南に現れる冷凍エレベーター（Cryo-Elevator）に乗ってボタンを押し、冷凍室の控え室（Cryo-Anteroom）に着くとクリア**。

エンディングは 3 種類。最良（80 点・救出される・Floyd が復活する）には、次の 3 系統の修理も済ませておく必要がある。

| 直した系統 | 最良 | 惑星の軌道（Course Control）だけ直した | 軌道を直していない |
|---|---|---|---|
| 軌道制御（Course Control）| ○ | ○ | × → 惑星は太陽に落ちる |
| 惑星防衛（Planetary Defense）| ○ | どちらかが × | |
| 通信（Comm Room）| ○ | → 救助船が来ず惑星に取り残される | |

### 1.2 依存関係

```
クリア（Cryo-Elevator で push button → 控え室）
├─ コンピューター修理（Station 384 の塵をレーザーで 2 回撃つ）
│   ├─ ミニチュア化ブースのカード（mini card） ← Bio Lab の中。Floyd が命と引き換えに取ってくる
│   │   ├─ Floyd を起動しておく（Robot Shop）
│   │   └─ Floyd にコンピューターの故障を見せておく（Computer Room に一緒に入る）
│   ├─ レーザー（Tool Room）＋新しい電池（Lab Storage、ラワンダ）、ダイヤルは 1
│   └─ 修理後: 微生物を倒し、200 単位以内に Station 384 へ戻る
├─ 脱出: 補助ブース → Lab Office → 殺菌剤で Bio Lab を霧で満たす（ガスマスク）→ 化け物から逃げて Cryo-Elevator
└─ （最良の結末のために）
    ├─ 惑星防衛: 焼けた fromitz 基板を、Floyd が Repair Room の小穴から取ってくる光った基板に替える
    ├─ 軌道制御: 溶着した bedistor をペンチで抜き、良品（Storage East の箱）を入れる
    └─ 通信: 指示された色の薬品を、Machine Shop の機械でフラスコに作って漏斗の穴に注ぐ（2〜3 回）

移動手段
├─ はしご（Storage West、南京錠の鍵は亀裂の中 → 磁石）→ 裂け目を渡る → 事務所のカード 3 枚
├─ 上のエレベーター（青）: upper elevator card → 塔（通信室）
├─ 下のエレベーター（赤）: lower elevator card（Floyd の中）→ シャトル乗り場
├─ シャトル: shuttle card → ラワンダへ
└─ テレポートブース 1・2・3: teleportation card（ラワンダの白衣のポケット）
```

### 1.3 進行の順番（推奨ルートの概要）【推測】

| # | 日 | やること |
|---|---|---|
| 1 | 1 日目 | 宇宙船の爆発 → 脱出ポッド → 着水 → 崖を登る（4.1〜4.2） |
| 2 | 1 日目 | カラモンティーで道具集め: Floyd（エレベーターカードを抜いてから起動）、Tool Room、鍵、はしご、事務所のカード、台所の食料、良品の bedistor（4.3） |
| 3 | 1 日目 | （時間があれば）通信の修理（4.6）。眠気の警告が出たら寮で寝る（4.4） |
| 4 | 2 日目の朝 | 下のエレベーター → シャトルでラワンダへ（時刻 6000 を過ぎるとシャトルが動かない）（4.5） |
| 5 | 2 日目 | ラワンダ: 白衣（テレポートカード）・電池、惑星防衛、軌道制御、Floyd にコンピューターを見せる（4.7） |
| 6 | 2〜3 日目 | 通信がまだならテレポートで戻って直す。寝るのもカラモンティーの寮で |
| 7 | 最終日 | Floyd の犠牲でミニカード（4.8）→ コンピューター内部（4.9）→ Bio Lab からの脱出（4.10）→ クリア |

### 1.4 得点（満点 80）【合計は 80 で一致】

| 内容 | 点 |
|---|---|
| 脱出ポッドに入る | 3 |
| Crag に着く | 3 |
| Storage West に入る | 4 |
| Kitchen に入る | 4 |
| Admin Corridor North に入る（裂け目を渡る） | 4 |
| Tower Core に入る | 4 |
| Kalamontee Platform に入る | 4 |
| Lawanda Platform に入る | 4 |
| Strip Near Station に入る（コンピューター内部） | 4 |
| Auxiliary Booth に入る（コンピューター内部から戻る） | 4 |
| カード 5 枚を取る（kitchen・upper elevator・shuttle・lower elevator・mini、各 1） | 5 |
| Floyd を起動する（`turn on robot`） | 2 |
| レーザーを初めて撃つ | 2 |
| Floyd がミニカードを持ち帰って死ぬ | 2 |
| 通信を直す | 6 |
| 惑星防衛を直す | 6 |
| 軌道制御を直す | 6 |
| コンピューター修理（塵を 2 回目に撃って消す） | 8 |
| Cryo-Elevator のボタンを押す | 5 |
| **合計** | **80** |

減点: 直した系統を後で壊すと 6 点ずつ引かれる（通信に違う色を注ぐ、軌道制御の cube や bedistor に酸をかける）。

ランク: 80 = Galactic Overlord、73 以上 Cluster Admiral、65 以上 System Captain、49 以上 Planetary Commodore、37 以上 Lieutenant……。

---

## 2. 詰み条件・死亡の一覧（絶対に避ける）

死ぬと得点が表示され、`RESTART` / `RESTORE` / `QUIT` を聞かれる。回数の制限や減点は無い。

### 2.1 即死

| やってはいけないこと | 結果 |
|---|---|
| 爆発の 5 段目に Deck Nine にいる／ポッドの外にいる | 死亡（4.1） |
| ポッドの着地の時にセーフティウェブに入っていない | 着地の衝撃で死亡。爆発の時は 20% で死亡 |
| 着地後、立ってから 5 コマンド以内にポッドを出ない | 沈んで死亡 |
| Underwater に長くいる／もう一度戻る | 溺死 |
| 裂け目に飛び込む（`jump`） | 死亡 |
| Blather を殴る／大使のセロリを食べる／薬品を飲む・自分にかける | 死亡 |
| **Radiation Lab に入る** | 50 単位後から放射線障害が始まり、**その後 3 コマンドで死ぬ**。外に出ても止まらない |
| **診療室の寝台に入る** | 死亡 |
| 高タンパク液や薬にフラスコの薬品を混ぜる | 爆発して死亡 |
| 軌道制御を直した後に良品 bedistor を取る | 感電死 |
| ミニチュア化ブースで 10〜1024 の 384 以外の番号を打つ | 動いている区画に飛ばされて死亡 |
| コンピューター内部で、修理から 200 単位たっても帯（strip）の上にいる | 感電死 |
| 帯の上で微生物に 3 コマンド続けて何もしない／熱すぎるレーザー（警告「quite hot」の後さらに撃つ）を持っている | 死亡 |
| Bio Lab に霧もマスクも無しで入る／Floyd 抜きで Bio Lab の扉を開ける | 化け物に食われる |
| Floyd が中にいる間、扉を開けっぱなしにする | 化け物に食われる |
| Lab Office で、霧を出さずに扉を開ける | 化け物に食われる |
| 追跡中に化け物と同じ部屋にとどまる／来た部屋へ引き返す | 食われる |
| シャトルを速度 20 以上で駅に突っ込ませる | 死亡 |
| Cryo-Elevator でボタンを **2 回** 押す | 上に戻ってしまい食われる |
| 空腹・病気・日数の限界（0.2） | 死亡 |

### 2.2 取り返しのつかない操作

| 操作 | 結果 | 回復 |
|---|---|---|
| はしごを伸ばさずに裂け目に渡そうとする | はしごが落ちて失われる → 裂け目の向こう（カード 3 枚）へ行けない | `restore` |
| 渡したはしごを縮める（`close ladder`） | はしごが落ちる | `restore` |
| **磁石を持ったままカードを持つ** | 持っているカードのどれか 1 枚の磁気が壊れる（毎ターン 1 枚ずつ） | `restore`。鍵を取ったら磁石はすぐ捨てる |
| 通信室で違う色の薬品を注ぐ | 通信系が完全に止まる → 最良の結末は無理 | `restore`。注ぐ前に `save` |
| レーザーのダイヤルが 1 以外のままリレーを撃つ | リレーが壊れ、塵を撃てなくなる → コンピューターが直らない | `restore` |
| 惑星防衛の panel に割れた基板（cracked）を入れる | 直らない（取り出せば焼けた基板と同じ扱い） | 抜けば戻せる |
| シャトルを速度 5〜15 で駅に突っ込ませる | 自分は無事だが、その車両（Alfie か Betty）は壊れて二度と動かない | もう 1 台を使う |
| Floyd の電源を切る（`turn off floyd`） | 再起動できるが怒る。持ち物を落とす | `turn on floyd` |

---

## 3. 基本システム・共通の仕掛け

### 3.1 所持制限

- 運べる重さは最初 100。病気が 1 段進むごとに 10 減る。薬で 20 増える。
- 主な物の重さ: はしご 80（**ほかの物はほとんど持てない**）、レーザー 25、ペンチ 15、缶 15、カンティーン・フラスコ・磁石・箱・救命キット・白衣・ガスマスク・基板 10、カード・鍵・スプール 3。

### 3.2 Floyd

- Robot Shop にいる止まったロボット（`robot` / `floyd`）。
- **起動する前に `search robot`** すると、下のエレベーターのカードが手に入る（+1）。起動した後は、たまにしかカードを見せてくれない。
- `turn on robot` → `Nothing happens.`（+2）。25 単位ほどで起き上がる（`Hi! I'm B-19-7`）。
- 以後はたいていついて来る。ときどき「探検してくる」と言って離れ、そのうち戻る。大事な場面（Repair Room、Computer Room、Bio Lock East）では、**Floyd が同じ部屋にいることを確かめてから** 進める。
- 診療室に連れて行くと、旧友 Lazarus の胸板を見つけて泣いて出ていく（40 単位ほどで戻る）。連れて行かない方が無難。

### 3.3 カードとスロット

| カード | ある場所 | 使う場所 | 効果 |
|---|---|---|---|
| kitchen access card | Small Office の机（small desk） | Mess Hall のスロット | 台所の扉が 50 単位開く |
| upper elevator access card | Small Office の机 | Upper Elevator のスロット | 180 単位使える |
| shuttle access card | Large Office の机（large desk） | シャトルの運転室のスロット | 80 単位使える（走行中は切れない） |
| lower elevator access card | 止まっている Floyd の中（`search robot`） | Lower Elevator のスロット | 200 単位使える |
| teleportation access card | Lab Storage の白衣（`open uniform`） | Booth 1・2・3 のスロット | 30 単位以内にボタンを押す |
| miniaturization access card | Bio Lock East（Floyd が取ってくる） | Miniaturization Booth のスロット | 30 単位以内に `type 384` |

- 机は `open desk` で開け、`look in desk` で中を見る。
- 磁石を持っている間は、毎ターン 1 枚ずつカードの磁気が壊れる（`Magnetik striip randumiizd` と出たら壊れている）。

### 3.4 エレベーター

- Elevator Lobby の北が青い扉（上のエレベーター）、南が赤い扉（下のエレベーター）。
- **上**: 最初は上の階にある。`push blue button` → 40〜60 単位で `The door at the north end of the room slides open.` → `north` → `slide upper elevator card through slot`（`Elevator enabled.`）→ `push up button` → 50 単位で `The elevator door slides open.` → `south`（Tower Core、+4）。
- **下**: 最初は下の階にある。`push red button` → 80〜120 単位で `The door at the south end of the room slides open.` → `south` → `slide lower elevator card through slot` → `push down button` → 100 単位で開く → `north`（Waiting Area）。
- 待つ時は `wait`（40 単位）を繰り返す。到着の文が出たら止める。

### 3.5 シャトル

- Kalamontee Platform（Waiting Area の東）の南に Alfie、北に Betty の車両。最初、Alfie はカラモンティー側、Betty はラワンダ側にいる。
- 車両の中から `east` / `west` で前後の運転室へ。**出発する側の運転室でしか動かない**（Alfie がカラモンティーにいる時は `east` の運転室。違う方だと `Use other control cabin.`）。
- **【確認済み】カウンターは毎コマンド +1**（`wait` も 1 コマンド）。2 で `Limit 45`、12 で `Hafwaa Mark`、20/21/22 で看板 `"15."` `"10."` `"5."`、23 で `approaching a brightly-lit area`、24 で到着。速度 10 で巡航し、**`"5."` の看板が出た直後に `pull lever` → `wait`** で `glides into the station and comes to rest`（成功）。操作は `push lever` → `wait` → `pull lever`（中央）→ `wait` を約 17 回 → `"5."` で `pull lever` → `wait`。着いたら `west`（車両）→ `north`（Lawanda Platform）。実プレイでは時刻 3200〜5200 に乗って問題なかった（時刻 6000 規制の挙動は未確認）。
- **時刻 6000 を過ぎると動かない**（`using the shuttle car during the evening hours requires special authorization`）。1 日目は開始が 4450〜4630 なので余裕が少ない。**2 日目の朝（時刻 1600 台から）に乗る**のが安全。
- 操作: レバーを上げる（`push lever`）と加速を始め、1 コマンドごとに速度 +5。中央に戻す（上の位置から `pull lever`）と速度は一定。下げる（中央から、走行中に `pull lever`）と 1 コマンドごとに速度 −5。
- 1 コマンドごとに区間カウンターが 1 進み、**24 で駅に着く**。その時の速度が 0 なら無事に着く。5〜15 だと車両が壊れる（自分は無事）。**20 以上だと死ぬ**。
- 推奨の運転（速度 10 で巡航）【推測。1 ずれても速度 5 で突っ込むだけで死なない】:
  1. `slide shuttle card through slot` → `Shuttle controls activated.`
  2. `push lever` → `begins to move forward! The display changes to 5.`
  3. `wait` → 表示が 10 になる。
  4. `pull lever` → `The lever is now in the central position.`
  5. `wait` を繰り返す。看板が `"15."` → `"10."` → `"5."` と出る。
  6. **`"5."` の看板が出たら** `pull lever`（下の位置）→ `approaching a brightly-lit area`。
  7. `wait` → `glides into the station and comes to rest` が出れば成功。
  8. 運転室から車両へ戻り（来た方角の逆）、車両から外へ（Alfie なら `north`）。
- 途中で止まってしまった（`comes to a stop and the lever pops back`）時は、もう一度 `push lever` すれば動き出す。

### 3.6 テレポートブース

- Booth 1: Conference Room の北（Rec Area の北の扉。扉はダイヤルの番号で開く。番号は白衣のポケットの紙）。
- Booth 2: Elevator Lobby の東。
- Booth 3: Library Lobby の東（ラワンダ）。
- ブースの中で `slide teleportation card through slot` → `Redee.` → 30 単位以内に行き先の番号のボタンを押す（`push beige button` / `push 2` など。1 は brown、2 は beige、3 は tan）。
- ブースにいる Floyd と、床に置いた物も一緒に運ばれる。
- **カラモンティー（Booth 2）⇄ ラワンダ（Booth 3）の往復はこれが速い**。シャトルは最初の 1 回だけで済む。

---

## 4. 章別攻略【一部推測含む】

### 4.1 宇宙船 Feinstein（開始〜脱出）

開始地点は Deck Nine。持ち物は掃除ブラシ、時計、制服（ポケットに ID カード）。

- 持ち場を離れると Blather に叱られ、4 回目で営倉（Brig）に入れられる。**Deck Nine から動かない**。
- 開始から 240〜330 単位で爆発が始まる。`wait` で待つ（1 回 40 単位なので 6〜9 回）。
- 爆発は 1 段目のあと **毎コマンド** 1 段ずつ進む。
  1. `A massive explosion rocks the ship.` … `The door to port slides open.` → **すぐ `west`**（脱出ポッド、+3）
  2. 次の段: 隔壁が閉まる（もうポッドにいればよい）
  3. ポッドの扉が閉まる
  4. ポッドが射出管を滑る
  5. 船が爆発する
- ポッドに入ったら **`get in web`**（`climb in web` / `board web`）。`You are now safely cushioned within the web.`
- あとは `wait`。11 段目で着地: `The pod lands with a thud.` … `revealing some emergency provisions, including a survival kit and a towel.`
- 着地したら手早く:
  1. `get out of web`（`stand`）→ `you see water rising past the viewport.`（ここから沈み始める。5 コマンド目にポッド内にいると死ぬ）
  2. `take kit`
  3. `open door` → `cold ocean water rushes in!`
  4. `up`（Underwater）
  5. `up`（Crag、+3）。**Underwater では他のことをしない。** タオルは不要。

### 4.2 崖の上へ

- Crag → `up` Balcony → `up` Winding Stair → `up` Courtyard。
- Courtyard から北が Plain Hall。日がたつと海面が上がり、下の部屋は水没していく（攻略には関係ない）。

### 4.3 カラモンティー複合施設（1 日目の主作業）

**地図（主要部分）**
```
[Courtyard]-n-[Plain Hall]-n-[Rec Area]-e-[Rec Corridor]-e-[Mess Corridor]-e-[Dorm Corridor]==長い廊下(160)==[Corridor Junction]-e-[Elevator Lobby]-e-[Booth 2]
                   \ne___________/  | n(ダイヤルの扉)   n:Dorm B  s:Dorm A    n:Storage West(南京錠)   n:Dorm D  s:Dorm C        | n            | s           n|(青:上)  s|(赤:下)
                           [Conference Room]-n-[Booth 1]         s:Mess Hall-s-[Kitchen]        [Admin Corridor S]  [Mech Corridor N]
                                                                                                 | n (e: SanFac E)   e:Storage East  w:Physical Plant
                                                                                       [Admin Corridor]-w-[Systems Monitors]   | s
                                                                                                 | n（裂け目・はしご）      [Mech Corridor] e:Reactor Control
                                                                                       [Admin Corridor N]                     | s
                                                                         w:[Small Office]-w-[Large Office]  e:Plan Room  [Mech Corridor S]
                                                                                                                 sw:Tool Room  s:Machine Shop  se:Robot Shop
```
- Rec Corridor の南西が Plain Hall。Robot Shop・Machine Shop・Tool Room は互いに東西でもつながる。
- Dorm Corridor の東へ行くと、長い廊下を歩いて Corridor Junction に着く（1 回で 160 単位）。

**手順**【推測。順番は効率で選んだ】
0. **【実プレイの順序】Courtyard から `north` → `ne`（Rec Corridor）→ `east` ×3（Mess Corridor → Dorm Corridor → 長い廊下で Corridor Junction）。Junction から `south` ×3 で Mech Corridor South。Robot Shop は `se`、Tool Room は `sw`、Machine Shop は `south`（Tool Room と Robot Shop の東西も通じる）。まず Tool Room で磁石だけ取り（カード 0 枚を確認）、Admin Corridor South（Junction の `north`）で鍵を取って磁石を捨て、Mess Corridor で鍵を使い、Storage West のはしごを運ぶ。Robot Shop（下エレベーターカード・Floyd）は磁石を捨てた後でよい。**
1. **Robot Shop**（Floyd）: `search robot`（下エレベーターのカード +1）→ `turn on robot`（+2。`Nothing happens.` の後、数手で Floyd が自分で現れる）。
2. **Tool Room**: `take pliers`、`take flask`、`take laser`（レーザー初撃ちの +2 は後で）。磁石（`curved metal bar` = magnet）は、カードを持っていない今のうちに使う。**重量に余裕が無いので、日中に使わない物は置いておき、使う直前に回収する**。
3. **Admin Corridor South**: `take magnet` してから行き、`examine crevice`（`a shiny steel key!`）→ `put magnet near crevice`（`It is a steel key!`）→ **`drop magnet`**（ここで捨てる。カードを壊さないため）。
4. **Mess Corridor**: `unlock padlock with key` → **`take padlock`（取らないと `The door cannot be opened until the padlock is removed.`）** → `open door` → `north`（Storage West、+4）。缶（Spam and Egz）は開けられないので不要。はしご（80）を持つ時は他の物を全部置く。
5. はしごを Admin Corridor まで運ぶ（重さ 80。**ほかの重い物はいったん置く**）: `take ladder` → Admin Corridor で `drop ladder` → `open ladder`（`extends to a length of around eight meters`）→ `put ladder across rift`（`spanning the precipice`）→ `north`（Admin Corridor North、+4）。
   - 狭い部屋（Storage East/West、エレベーター、ブース）では伸ばせない。持ったままでも伸ばせない。
6. **Small Office**: `open desk` → `take kitchen card` → `take upper elevator card`（各 +1）。**Large Office**: `open desk` → `take shuttle card`（+1）。カードは `put card in uniform`（ポケット）に入れておくとよい（0.3）。
7. **Storage East**: 箱（cardboard box）から `take good bedistor`。割れた基板（cracked）とヒューズは不要。
   - 実プレイでは **はしごを渡す直前に `save`**。ここまでの時点で空腹の警告が出る（ゴーを食べるためキットを近くに置くか持つこと。Robot Shop で ravenous、Dorm Corridor で faint まで進んだ例あり。Mess Corridor に置いたキットで助かった）。
8. **Mess Hall / Kitchen**: `take canteen` → `slide kitchen card through slot`（`The kitchen door quietly slides open.`）→ `south`（Kitchen、+4）→ `open canteen` → `put canteen in dispenser` → `push button`（`The canteen fills almost to the brim`）→ `take canteen` → `close canteen`。空腹の警告が出たら `eat liquid`。
9. ここまで済んだら、通信の修理（4.6）に進むか、眠気が来るまで待つ。

**持ち越す物**: ペンチ、フラスコ、レーザー、良品の bedistor、カンティーン、カード 4 枚（kitchen・upper・lower・shuttle）。

### 4.4 寝る

- `You begin to feel weary.` が出たら寮（Dorm A〜D）へ行き、`get in bed`。16 単位ほどで眠る。
- 起きたら、足もとに落ちた荷物を拾い直す（0.3）。Floyd は枕もとに来る。
- `Ahhh...the bed is soft` と出たら、そのまま待つ（寝台から出ようとすると断られる）。

### 4.5 ラワンダへ（2 日目の朝）

1. Elevator Lobby で下のエレベーター（3.4）→ Waiting Area → `east`（Kalamontee Platform、+4）。
2. `south`（Shuttle Car Alfie）→ `east`（Alfie Control East）→ シャトルを運転（3.5）。
3. 着いたら `west`（車両）→ `north`（Lawanda Platform、+4）。ここから病気の悪化が始まる。

**ラワンダの地図**
```
[Lawanda Platform]-e-[Escalator]-e-[Fork]
                                   ne |        \ se
                    [Systems Corridor West]   [Project Corridor West](w: SanFac F)
                    nw:Infirmary  n/down:Repair Room      | e
                           | e                     [Project Corridor]-s-[ProjCon Office]-e-[Computer Room]
                    [Systems Corridor] n:Planetary Defense        | e           (s: Cryo-Elevator 修理後)   | s: Miniaturization Booth
                           | e                     [Project Corridor East]-s-[Computer Room]  ne:Main Lab
                    [Systems Corridor East] n:Course Control  e:Physical Plant        | n          | e
                           | s                         [Library Lobby]          [Main Lab] s:Lab Storage
                    [Library Lobby] w:Library  e:Booth 3                        se:Bio Lock West(扉)  ne:Radiation Lock West(扉・入らない)
```

### 4.6 通信の修理（塔の Comm Room）

- 行き方: 上のエレベーター（3.4）→ Tower Core（+4）→ `northeast`（Comm Room）。
- 部屋に入った直後に `A <色> colored light is flashing on the enunciator panel.` と出る。**この色を控える**。もう一度見たい時は、いったん出て入り直す。
- **【確認済み】通信の色と数は周回によって変わる**（赤 → 茶 の 2 色の回もあれば、茶 → 灰 の 2 色の回もあった。必ず部屋の表示を確かめる）。薬液は「化学液 → 徐々に乳白色になる」と出るが、そのまま `pour fluid in hole` で受理された。1 色ごとに Machine Shop → Lobby → 上のエレベーター → Comm Room を往復する（約 20 コマンド、薬液は往復中も有効）。
- フラスコを持つ時は重量に注意。**落とすと薬液が蒸発する**ので、他の荷物を先に Machine Shop に置いておく。
- 薬品を作る場所は **Machine Shop**（カラモンティーの Mech Corridor South の南）。
  0. 通信の往復は、下のエレベーター（赤）も `push red button` で先に呼んでおくと待ち時間が減る。
1. `put flask under spout`（`The glass flask is now sitting under the spout.`）
  2. 色のボタンを押す。赤・青・緑・黄（KUULINTS 1〜4）、灰・茶・黒（KATALISTS 1〜3）。例: `push green button` → `The flask fills with some green chemical fluid.`
  3. `take flask` → 塔へ運ぶ。
- Comm Room で **`save`** → `pour fluid in hole`。
  - 正しい色なら `The liquid disappears into the hole.` の後、`all go off except one, a <次の色> light.` → 次の色を作りに戻る。
  - 最後の色なら `and then go dark.` … `the help message is now being sent.`（+6）
  - 違う色なら `Shuteeng Down Awl Sistumz` → **`restore`**。
- 白いボタン（BAAS・ASID）は酸。触れた物を溶かす。使わない。
- 往復の時間がかかる。エレベーターのカードは 180 単位で切れるので、そのつど差し直す。
- 高タンパク液や薬を穴に注ぐと、色が合わず止まる。注がない。

### 4.7 ラワンダでの作業

0. **【実際の道順】Lawanda Platform → `east`（Escalator）→ `east`（Fork）→ `se`（Project Corridor West）→ `east`（Project Corridor）→ `east`（Project Corridor East）→ `east`（Main Lab）。Library Lobby は Project Corridor East の `north`、Booth 3 はその `east`、Systems Corridor East は Library Lobby の `north`（`north` に Course Control）。Systems Corridor ⇄ Systems Corridor West は `west`/`east`、Systems Corridor の `north` が Planetary Defense、Systems Corridor West の `north` が Repair Room（`south` で戻る）。Computer Room は Main Lab の `sw`（Computer Room の `north` は Project Corridor East、`west` は ProjCon Office、`south` は Miniaturization Booth）。**
1. **Lab Storage**（Main Lab の南）: `open lab uniform`（`a small piece of paper and a teleportation access card`）→ `take teleportation card`（`take uniform` は不要、重い）。`take new battery`（重量に注意。先にペンチ等を置く）。レーザーの古い電池は先に抜いて捨てておくと軽い。
2. **レーザーの電池を替える**: `take old battery`（レーザーから）→ `put new battery in laser`。古い電池は 3〜5 発、新しい電池は 21〜30 発。
3. **Repair Room**（Systems Corridor West の北）: Floyd が一緒にいることを確かめて `floyd, go north`（`Floyd squeezes through the opening` … `Just a shiny fromitz board.`）→ `floyd, take board`（`He tosses it toward you`）。**【確認済み。書き方はこのままで通る】**
4. **Planetary Defense**: `open panel`（基板 first〜fourth が入っている）→ `take second board`（`slides out of the panel`。実際には持ち物に入らず、`drop` できなかった。気にせず次へ）→ `put shiny board in panel`（`The card clicks neatly into the socket. The warning lights stop flashing.`、+6）。
5. **Course Control**: `open cube` → `take bedistor with pliers`（「どちらの bedistor？」→ `fused`）→ `With a tug, you manage to remove the fused bedistor.` → `put good bedistor in cube`（`Done. The warning lights go out and another light goes on.`、+6）。融けた bedistor は `drop`。以後、良品の bedistor に触らない。
6. **Computer Room**: Floyd と一緒に入る。Floyd が `Uh oh. Computer is broken.` と言えば準備完了。言わなければ `show output to floyd`（印刷物は Computer Room にある）。
7. **入らない所**: Radiation Lab（即死級）。診療室の寝台。
8. 帰りは Booth 3（Library Lobby の東）→ テレポートで Booth 2（3.6）。【確認済み】`slide teleportation card through slot` → `Redee.` → Booth 3 から `push beige button`（2 へ）、Booth 2 から `push tan button`（3 へ）。Floyd も一緒に運ばれる。
9. **日程の実例**: 2日目にラワンダへ行き、同じ日のうちに 4.7〜4.10 を全部終えられた（眠ったのは1日目の夜だけ）。ただし空腹の警告が重なるので、**カンティーンを持って行く（重量は 15）か、Dorm にゴー入りキットを残して食べに戻る**計画を立てる。

### 4.8 Floyd の犠牲（ミニカード）

前提: 4.7 の 6 が済んでいる（Floyd がコンピーターの故障を知っている）。Floyd がついて来ている。**ここで `save`**。

1. Main Lab で `open door`（「どの扉？」→ `bio-lock door`）→ `se`（Bio Lock West）→ `close door`（西の扉。両方の扉を同時には開けられない）→ `east`（Bio Lock East）。【確認済み】
2. Floyd が窓をのぞき（到着後 1 手で台詞が出る。`look` で読める）、`Floyd will get card.` … `When Floyd knocks, open door again.` と言う。言わなければ、出て入り直す。**Floyd がこう言ったら、4 コマンド以内に次へ**（遅れると Floyd はあきらめてすねる）。
3. `open door` → `Floyd ... plunges into the Bio Lab.` … `yells to you to close the door.`
4. **すぐ** `close door`。→ `ferocious growlings`
5. `wait` → `three fast knocks`（ノックの合図）。【1 コマンドの差で結果が変わる。出力を見て 1 手ずつ】
6. `open door` → `Floyd stumbles out of the Bio Lab, clutching the mini-booth card.`
7. **すぐ** `close door` → Floyd が力尽きる（+2）。
8. `take card`（ミニカード、+1）。

- **【確認済み】`open door` → `close door` → `wait`（1 回で `three fast knocks`）→ `open door` → `close door` → `take card` で成功**。Floyd の死でスコアは 54 → 57。
- ノックの後で扉を開けるのが 1 手遅れると、Floyd は Bio Lab の中で壊れてカードは手に入らない（`all is silence from within the Bio Lab`）。→ `restore`。
- 扉を開けたまま 1 手待つと食われる。

### 4.9 コンピューターの中（Station 384）

前提: ミニカード、レーザー（新しい電池）。**`set laser to 1`**（ダイヤル 1 = 赤）。**`save`**。

1. Computer Room の `south`（Miniaturization Booth）→ `slide mini card through slot`（`Please type in damaged sector number.`）→ **`type 384`**（印刷物の `Malfunkshun in Sekshun 384!`）。
2. Station 384 → `east`（Strip Near Station、+4）→ `north`（Middle of Strip）→ `north`（Strip Near Relay）。
3. `examine relay`（中に青い塵 speck が見える）。**`fire laser at speck`** を繰り返す。
   - 最初の 1 発は必ず外れる。外れるたびに命中率が 12% ずつ上がる。
   - 1 回目の命中: `The speck is hit by the beam! It sizzles a little`
   - 2 回目の命中: `vaporizes into a fine cloud of ash` … `Sector 384 will activate in 200 millichrons.`（+8。**ここから 200 単位以内に Station 384 へ戻る**）
   - ダイヤルが 1 以外だとリレーが壊れて詰む（2.2）。
4. **`set laser to 2`**（1 のままだと微生物に効かない）。`south` → Middle of Strip で巨大な微生物が現れる。
5. 微生物との戦い:
   - **毎コマンド撃つ**: `fire laser at microbe`。撃たないコマンドが 3 回続くと飲み込まれる。
   - 撃つたびにレーザーが熱くなる。`slightly warm now` → `somewhat warm now` → `very warm now`。
   - **`very warm now` が出たら `throw laser off strip`**（`Both the laser and the microbe plummet into the void.`）。`quite hot` の後に撃ち続けると死ぬ。
   - 別解: 熱が 11 以上（`quite hot` が出た直後）で `throw laser at microbe`。
6. `south`（Strip Near Station）→ `west`（Station 384）→ 自動で補助ブースへ（`switching to Auxiliary Booth`、+4）。

- **【確認済み】実績**: 塵に 6 発（外・外・命中・外・外・命中）、微生物に 5 発（`very warm now`）→ `throw laser off strip` で成功。`set laser to 1` → `save` → `slide mini card through slot` → `type 384`。`west` で Station 384 に戻ると自動で Auxiliary Booth へ（+4、スコア 75）。
- 塵を撃っている間にレーザーは熱くなる。撃つのをやめると 1 コマンドごとに冷める。
- 弾数は新しい電池で 21〜30 発。塵に 3〜8 発、微生物に 8〜10 発ほどかかる見込み【推測】。

### 4.10 Bio Lab からの脱出（最終盤）

補助ブース（Auxiliary Booth）の北が Lab Office。出口は Bio Lab を抜けるしかない。**着いたらすぐ `save`**。

1. `north`（Lab Office）。
2. `examine desk`（メモ）→ `open desk` → `take gas mask` → **`wear gas mask`**。
3. **`push red button`**（`You hear a hissing from beyond the door to the west.`）。殺菌剤の霧は **50 単位**（普通のコマンド 7 回ほど）しかもたない。ここから急ぐ。
4. `open door` → `west`（Bio Lab。霧で化け物はふらついている。マスクが無いと死ぬ）。
5. `open door`（Bio Lab の西の扉）→ `west`（Bio Lock East）→ `close door` → `west`（Bio Lock West）→ `open door` → `west`（Main Lab）→ `southwest`（Computer Room）→ `west`（ProjCon Office）→ `south`（Cryo-Elevator）→ **`push button`**（`The elevator door closes just as the monsters reach it!`、+5）。
6. あとは `wait`。100 単位で `The elevator door opens onto a room to the north.` → `north` → エンディング。**ボタンをもう一度押さない。**

- 霧が晴れると（`The mutants, recovering quickly`）、化け物が毎コマンド追ってくる（`burst into the room right on your heels!`）。追われている間の決まり:
  - 化け物と同じ部屋で **移動以外のことをしない**。次のコマンドでは必ず別の部屋へ動く。
  - **1 つ前にいた部屋へ引き返さない**（`You stupidly run right into the jaws`）。
  - 猶予は 2 回だけある。Bio Lock West に初めて入った時（`The monsters gallop toward you`）と、Cryo-Elevator に入った時（`storming straight toward the elevator door!`）。この 1 手で扉を開ける／ボタンを押す。
- **【確認済み】実績（このコマンド列で脱出できた）**: `north` → `examine desk` → `open desk` → `take gas mask` → `wear gas mask` → `read memo` → `push red button` → `open door` → `west`（Bio Lab）→ `open door`（「lab door か office door か？」→ `lab door`）→ `west`（Bio Lock East。「mutants burst into the room」）→ `west`（Bio Lock West。「monsters gallop toward you」）→ **`open door`**（猶予の 1 手）→ `west`（Main Lab）→ `sw` → `west`（ProjCon Office）→ `south` → **`push button`**（+5）→ `wait` ×3 → `north`。Bio Lock East の扉は自動で閉まるので `close door` は不要だった。
- 扉の順番と、霧の 50 単位で足りるかは確かめていない【推測】。危ないと思ったら `restore` して、マスクを先に着けておく、机を先に開けておくなど、ボタンを押してからの手数を減らす。

---

## 5. 乱数・タイマーまわりの注意

### 5.1 乱数

| 乱数 | 影響 | 対処 |
|---|---|---|
| 爆発の開始（240〜330 単位） | 待つ回数が変わる | `The door to port slides open.` が出るまで `wait` |
| 通信に必要な色と数（2〜3 色） | 作る薬品が変わる | 通信室で表示される色に従う |
| 会議室のダイヤル番号（0〜999） | Booth 1 を使う時だけ必要 | 白衣のポケットの紙を読む（`read paper`） |
| 電池の弾数（古 3〜5、新 21〜30） | 足りないと撃てない | 新しい電池に替える |
| 塵への命中（最初は 0%、外れるたび +12%） | 撃つ回数 | 撃ち続ける |
| エレベーターの到着（上 40〜60、下 80〜120 単位） | 待つ回数 | 到着の文まで `wait` |
| Floyd の離脱（6%）、同行（80%） | 大事な場面にいないことがある | いなければ待つ／部屋を出入りする |
| 床で寝た時の死（30%） | 死亡 | 寮の寝台で寝る |
| 爆発の時ウェブの外（20% 死亡） | 死亡 | 必ずウェブに入る |

### 5.2 save の置き場所

| 場面 | 理由 |
|---|---|
| 爆発の 1 段目が出る直前 | ポッドへの移動と着地が一発勝負 |
| はしごを裂け目に渡す前 | 失敗するとはしごを失う |
| 通信室で薬品を注ぐ前（毎回） | 違う色だと通信が止まる |
| シャトルの運転前 | 速度を誤ると死ぬか車両が壊れる |
| Bio Lock に Floyd と入る前 | 扉を開け閉めする 1 手の差で失敗する |
| ミニチュア化ブースに入る前 | 番号・ダイヤル・微生物・200 単位の時限 |
| 補助ブースに着いた直後 | 最後の追跡 |

### 5.3 タイマーの総表

| 起点 | 時間（単位） | 何が起きるか |
|---|---|---|
| 開始 | 240〜330 | 爆発が始まる。以後毎コマンド 1 段（5 段目で船が爆発） |
| 船の爆発 | 毎コマンド | ポッドの旅。11 段目で着地 |
| 立ち上がる（着地後） | 毎コマンド | ポッドが沈む。5 コマンド目に中にいると死ぬ |
| 開始 | 2000 | 空腹の警告 1 段目（以後 450・150・100・50 で 5 段目に死ぬ） |
| 食事 | 1450（ゴー）／3600（高タンパク液） | 次の空腹の警告 |
| 開始 | 3600 | 眠気の警告 1 段目（以後 400・135・60・50 で倒れる） |
| 起床 | 2 日目 5800、3 日目 5550、4 日目 5200、5 日目 4800、6 日目 4300、7 日目 3700、8 日目 3000 | 次の眠気の警告 |
| 起床時刻 | 2 日目 1600、3 日目 1750、4 日目 1950、5 日目 2150、6 日目 2450、7 日目 2800、8 日目 3200（＋0〜80） | 9 日目の起床で死ぬ |
| 開始 | 1000、以後 700 ごと | 病気の判定（予約が立っていれば 1 段悪化） |
| 時刻 6000 以降 | — | シャトルが動かない |
| 台所のカード | 50 | 台所の扉が閉まる（中にいる間は閉まらない） |
| 上のエレベーターのカード | 180 | 使えなくなる |
| 下のエレベーターのカード | 200 | 使えなくなる |
| テレポートカード | 30 | 使えなくなる |
| ミニカード | 30 | 使えなくなる |
| シャトルのカード | 80（走行中は延長） | 使えなくなる |
| Bio Lock の扉を開ける | 30 | 自動で閉まる |
| Radiation Lab に初めて入る | 50、以後毎コマンド | 3 段目で死ぬ |
| Floyd を起動 | 25 | 起き上がる |
| Floyd に胸板を見せる | 40 | 戻ってくる |
| 塵を消す | 200 | 帯の上にいると死ぬ |
| 補助ブースに着く | 130 | 「冷凍室への道が開いた」という放送（飾り） |
| 殺菌剤のボタン | 50 | 霧が晴れて化け物が動き出す |
| Cryo-Elevator のボタン | 100 | 扉が開く |

---

## 6. コマンド列（推奨ルートの下書き）

**注意**: これは最初の下書きのまま。実際にクリアした手順とは次の点が違う: 移動は `ne` 等の略記、磁石はカードを持たずに先に使う、`take padlock` が必要、通信は赤 → 茶の 2 色、2日目のラワンダでは Course Control → Planetary Defense → Floyd の犠牲の順、`close door` の位置、ほか重量と空腹の管理（本書冒頭の「実プレイでの訂正」）。

元の下書き（未検証の部分を含む）:`…まで wait` は、その文が出るまで `wait` を繰り返す。【】は乱数や状況で変わる所。

```
（Deck Nine）
  …「The door to port slides open」まで wait
west
get in web
  …「The pod lands with a thud」まで wait
get out of web
take kit
open door
up
up
up
up
up
（Courtyard → カラモンティー。Robot Shop へ）
search robot
turn on robot
（Tool Room）
take pliers
take flask
take laser
take magnet
（Admin Corridor South）
examine crevice
put magnet near crevice
drop magnet
（Mess Corridor）
unlock padlock with key
take padlock
open door
north
take ladder
（Admin Corridor。重い物は先に置いておく）
drop ladder
open ladder
put ladder across rift
north
west
open desk
take kitchen card
take upper elevator card
west
open desk
take shuttle card
（Storage East）
take good bedistor
（Mess Hall）
take canteen
slide kitchen card through slot
south
open canteen
put canteen in dispenser
push button
take canteen
close canteen
（通信: 4.6 を色が尽きるまで繰り返す）
put flask under spout
push 【色】 button
take flask
  （Elevator Lobby）push blue button … north … slide upper elevator card through slot … push up button … south … northeast
save
pour fluid in hole
（寮で寝る）
get in bed
（2 日目: 下のエレベーター → シャトル）
push red button
  …「The door at the south end of the room slides open」まで wait
south
slide lower elevator card through slot
push down button
  …「The elevator door slides open」まで wait
north
east
south
east
slide shuttle card through slot
push lever
wait
pull lever
  …看板「"5."」まで wait
pull lever
wait
west
north
（ラワンダ: 4.7）
open uniform
take teleportation card
take new battery
take old battery
put new battery in laser
floyd, go north
floyd, take board
open panel
take second board
put shiny board in panel
open cube
take bedistor with pliers
put good bedistor in cube
（Computer Room に Floyd と入る。4.8）
save
（Main Lab）
open door
southeast
close door
east
  （Floyd の「When Floyd knocks, open door again.」を確かめる）
open door
close door
  …「three fast knocks」まで wait（1 回ずつ）
open door
close door
take card
（4.9）
set laser to 1
save
slide mini card through slot
type 384
east
north
north
fire laser at speck
  …「vaporizes into a fine cloud of ash」まで繰り返す
set laser to 2
south
fire laser at microbe
  …「very warm now」まで繰り返す
throw laser off strip
south
west
（4.10）
save
north
open desk
take gas mask
wear gas mask
push red button
open door
west
open door
west
close door
west
open door
west
southwest
west
south
push button
  …「The elevator door opens onto a room to the north」まで wait
north
```

---

## 7. 補足

- **攻略に不要な物**: 掃除ブラシ、タオル、大使のパンフレット、缶詰（開けられない）、オイル缶（Floyd に差すと喜ぶだけ）、割れた基板、メガヒューズ、スプール 3 本（症状・ヘリコプター・修理ロボットの説明。図書室の microfilm reader で読める）、Library Lobby の端末（惑星の歴史など）、ヘリコプター（操縦盤は鍵がかかっている）、Radiation Lab のランプ。
- **Transportation Supply**（Admin Corridor North の北）は暗い部屋。入らなくてよい。
- **Systems Monitors**（Admin Corridor の西）で、直した系統がどれかを確かめられる（緑になる）。
- **Floyd の台詞**: `save` すると「何か危ないことをするの？」、`restore` すると残念そうにする。攻略には関係ない。
- **エンディング（最良）**: Veldina が目覚め、救助船の一行が現れて昇進を告げられる。最後に Floyd が修理されて戻ってくる。

---

## 8. 未確認事項（次の作業者へ）

通しプレイで次は **確認済み** になった: カードの書き方（`slide X through slot`）、`floyd, go north` / `floyd, take board`、Floyd のノック、Bio Lab 脱出、シャトルのカウンター、Release 番号（88 / 840726）。進行不能になるバグは確認されなかった。

まだ未確認:

1. 通信の色と数・順番が周回やセーブ復元で変わるか（赤 → 茶 の回と 茶 → 灰 の回が確認されたため、周回で変化する）。
2. 時刻 6000 以降にシャトルが本当に止まるか（今回は 6000 前にしか乗っていない）。
3. 1日目のうちにシャトルでラワンダへ行けるか（今回は 2日目に乗った）。
4. Radiation Lab、診療室、図書室、ヘリコプターなど、攻略に不要とした部分の挙動。
5. 80 点以外のエンディング（軌道制御だけ直す、通信を直さない、など）。
6. 薬品・酸（`BAAS` / `ASID`）の挙動。
