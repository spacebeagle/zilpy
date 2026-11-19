# A MIND FOREVER VOYAGING ゲームプレイ解説（LLM 攻略用リファレンス）

ZilPy で変換した Infocom 版 *A Mind Forever Voyaging*（1985 年、開始画面 `Release 88 / Serial number 840726`、"Interactive Science Fiction (Extended)"）を、`out/amfv` で `python s5.py` を直接実行して遊んでクリアするための資料。
プレイと検証から流れを組み立て、**自動実行のテストドライバーで最初から最後（Epilogue の skycab が宇宙港に着き、ACKNOWLEDGEMENTS が出て終了）まで通した**。

> 注意: 解き方がすべて書かれています。自分で解きたい人は読まないでください。
> この資料は、実際のプレイと検証をもとに日本語でまとめたものです。ゲームの文章は転載していません（コマンドと、場面を見分けるための短い語句だけを英語のまま書いています）。
> 権利者から申し出があれば、速やかに修正・削除します。

## 検証の前提と限界（2026-11-16 時点）

- 対象: 2026-11-16 時点の変換版 AMFV。
- 直接実行: 第 6 章のコマンド列（を自動化したもの）を、乱数の種 1〜60 で最初から流した。
  - **60 回すべてクリア**。手数 466〜480。分岐は「乱数で起きる場面を待つ回数」と「2071 年で強盗に遭って入り直すか」だけ。
  - 隠し得点（年ごとの得点、1.3）は全種で合格: 2051 = 13〜16（要 >10）、2061 = 23（要 >20）、2071 = 41〜54（要 >40）、2081 = 23〜25（要 >14）。Part II の記録バッファ使用量は最大 78/90 分。
  - 注意すべき失敗パターンとして、BSF の家宅捜索でドアが閉まる・2071 年の強盗で鍵を奪われる・路上を録画しながら歩いてバッファが尽きる、の 3 つがある。対策は本文に反映済み（2 章・5 章）。
- **`python s5.py` の直接実行による通しプレイを 2026-11-17 に行い、クリアした**（Epilogue で skycab が宇宙港に着き、ACKNOWLEDGEMENTS が出てゲーム終了）[確認済み]。実行する際は `out/amfv` ディレクトリで `python s5.py` を起動すること。
  - 実プレイでの差: ①2071 年の Centre & Kennedy の乞食は録画前に起きて取り逃したが、確定分＋老女で 4 年とも合格した。②Part III は包囲の放送の後に `wait` を 4 回してから `record` しても、Ryder の 5 回の暴言をすべて録れた。③`wnn feeder, transmit record buffer` は、換気を止めた後に `wait for 60` を 3 回した時点で受理された（T0+288 より前に通ったように見えた。正確な時刻は未確認）。
  - 実プレイで使えた手: 長い待ちは `wait for 120`（出来事があればそこで止まる）。時刻は `time` で確認できる。2051 年は City Hall で `wait for 120` を 2 回すると 18:00 の追い出しが起きるが、Rockvil Centre で `abort` すれば問題なかった。2071 年の滞在は Huang Hall で夜 10 時過ぎまで待った（屋内なので安全）。
- 確かめていない範囲: 推奨ルート以外の得点場面の大半（表 3.8 の多くは [未確認]）、Part II で記録を何回かに分けて見せる進め方、2041 年の 9 項目のうち 8 個しか撮れなかった時の再挑戦、Library Mode・Sleep Mode の中身。
- 印の意味: **[確認済み]** = 実行して出力を見た / **[未確認]** = 実行での確認をしていない箇所 / **[推測]** = 挙動からの推測で裏付けが弱い。章見出しの印はその章全体に掛かる。

---

## 0. 最初に読むこと（Python 版固有の落とし穴）

### 0.1 パーサーと入力の落とし穴（すべて [確認済み]）

| やりたいこと | 書き方 |
|---|---|
| 起動直後の `[Hit any key to continue.]` | 何か 1 行（`look`）を送る。**その 1 行は捨てられる**。章の切り替わり・結末でも同じで、続けて 2 回出ることがある |
| 外の世界の場所へ行く | 通信口の略号をそのまま送る: `peof`（Perelman の部屋）`ppcc`（管制室）`rcro`（屋上）`pcaf`（食堂）`maco`（保守区画）`wnnf`（WNN 放送） |
| モードを変える | `enter simulation mode` / `enter interface mode` / シミュレーションをやめる時は `abort` |
| セキュリティコード | `enter simulation mode` の後に出る `corresponding to: <色> <数>` に、数字だけを送る（例 `84`）。計算方法は 3.3 |
| 年を選ぶ | `Select simulation year. >` に `2051` のように西暦で（`20` のような差分でも可 [未確認]） |
| 録画 | `record`（または `ron`）で開始、`roff` で停止 |
| (y/n) の問い | `n` / `y` の 1 文字（行の先頭 1 文字だけ読まれる） |
| インターフェース機器に命令 | `hvac controller, turn off ventilation in delta sector` / `hvac controller, status` / `wnn feeder, transmit record buffer` / `wnn feeder, status` |
| 人に話しかける | `talk to official` / `talk to elder`（`tell <人>` でも同じ処理） |
| 記録を Perelman に見せる | `tell perelman about buffer`（Perelman が部屋にいる時） |
| 心理テスト | `yes` の後、カードごとに**英単語 1 語だけ**（例 `mother`）。2 語以上は言い直しを求められる。テスト中は save / restore できない |
| ドアの鍵 | `unlock door with key`（`open door with key` でも可 [未確認]） |
| 地下鉄に乗る・降りる | `in` / `out`、駅から地上へは `up` |
| 物を買う | 映画: `buy ticket`、新聞: `put card in slot`、Roy's Pagoda の食事: `buy meal` |

### 0.2 実プレイ上の教訓

- **時間の進み方** [確認済み]:
  - 普通のコマンドは 1 回 = 1 分。**`wait` は 1 回 = 最大 10 分**（何か出来事が起きるとその分で止まる）。`wait for 30` のように 120 分まで指定可。
  - **シミュレーション内で場所を移動すると 1 回 = 5 分**。ただし自宅アパートの中・地下鉄の駅と車内は 1 分。
  - `time` はゲーム内の時刻を見るだけで時間は進まない。
  - 「You can't see ...」など解釈に失敗した入力では時間が進まない。何かを待つ時は必ず `wait` を使う。
  - 長い行動: 映画 15 分、Roy's Pagoda の食事 22 分、新聞を読む（2041）10 分、人と話す 8 分。
- **画面上に得点表示はない**（SCORE 動詞が無効）。進み具合は Perelman の講評の文言でしか分からない（1.3）。
- **save はいつ使ってもよい**（年ごとの隠し得点も save に入る）。心理テスト中だけは save / restore できない。
- `examine dispenser` や `examine hands` も通常どおり使える（新聞は `put card in slot` で買える）。
- 何をするにも「今どのモードか」が大事。シミュレーション中は外の世界（通信口）に出られない。外に戻るのは `abort`。

---

## 1. ゲームの目的と全体の流れ

### 1.1 勝利条件（1 文）

**Part III で、Ryder 上院議員が Perelman の部屋で脅しをかける場面を録画（2 回分以上）し、WNN Feeder が使えるようになったら Interface Mode で `wnn feeder, transmit record buffer` を実行して全世界に流す**（13 分後に勝利判定）。その後 Epilogue（2091 年のシミュレーション）に入り、skycab が宇宙港に着くと物語が終わる [確認済み]。

### 1.2 依存関係

```
勝利（WNN で Ryder の録画を放送、+288 分以降・+588 分より前）
 ├ Ryder の録画 ← Part III 開始 +116 分に Perelman の部屋（peof）で record 中
 │                  （包囲の放送 "National Guard Division" の 43 分後）
 ├ 生き残る ← 保守区画の空調を壊しに来る工作員を窒息させる
 │             ← 包囲の放送以後に HVAC で delta sector の ventilation を止める
 └ Part III に入る ← 記録の講評で 4 年分すべてが合格（Perelman がワシントンへ飛ぶ）
      ├ 2051 >10 / 2061 >20 / 2071 >40 / 2081 >14（隠し得点。録画中の場面だけ数える）
      ├ 2061 を選べる ← 2051 に 300 分超いる
      ├ 2071 を選べる ← 2061 に 400 分超いる
      ├ 2081 を選べる ← 2071 に 600 分超いる
      ├ 2051・2061 を選べる ← Part I の 9 項目を全部録画して講評で褒められる
      └ Part II の心理テスト（Grimwold のロールシャッハ）を受ける
```

### 1.3 隠し得点の仕組み [確認済み]

- 得点場面は 137 個。場面が起きた瞬間に**録画中なら**、その年の得点に加算され、その場面は 0 点になる（同じ場面は 1 回しか数えない）。
- **録画していない時に起きた場面は数えず、消費もされない**。後で録画しながらもう一度起こせばよい。ただし「起きたら二度と起きない」場面（Centre & Kennedy の物乞い、Southway & River の老女など、確率で起きる路上の場面）は、録画せずに見ると取り逃す。
- 「2061 or 2071」の共通場面（ロビーの落書き 2、エレベーター 1、窓ガラス 2 など）は、2061 で取ると 2071 ではもう数えない [確認済み]。
- 記録を Perelman に見せると、講評で 4 年それぞれが「最低点を**超えた**か」を判定する。最低点は 2051 = 10、2061 = 20、2071 = 40、2081 = 14。得点は講評をまたいで累積する。
- 4 年すべて合格 → Part III。足りないと、足りない年を言われて buffer が空になる（得点は残る）。講評の文言: `quite enough` = 最低点の半分超、`anywhere near enough` = 半分以下、`anything` = 0。

### 1.4 進行順（第 4 章の節番号）

1. Part I（4.1）: 2041 年で 9 項目を録画 → `abort` → Perelman の部屋で講評 → Part II
2. 心理テスト（4.2）
3. 2051 年（4.3）: 13 点前後 + 300 分滞在
4. 2061 年（4.4）: 23 点 + 400 分滞在
5. 2071 年（4.5）: 41〜54 点 + 600 分滞在
6. 2081 年（4.6）: 23 点（2 手で死んで終わる）
7. 記録を見せる（4.7）→ Part III
8. Part III（4.8）: Ryder を録画 → 換気を止める → WNN で放送
9. Epilogue（4.9）

### 1.5 推奨ルートで取る得点（2051〜2081。[確認済み]）

| 年 | 場面（コマンド） | 点 |
|---|---|---|
| 2051 | Courthouse で `look`（強姦未遂に死刑） | 2 |
| 2051 | 自宅の居間で `look through window`（枯れていく森） | 3 |
| 2051 | Huang Hall で `look`（毛皮と宝石の展示会） | 1 |
| 2051 | 旧駅（Church Lobby）で `look`（駅が教会に） | 2 |
| 2051 | 同 `take pamphlet` → `read pamphlet` | 1 |
| 2051 | Cinema で `read marquee` | 1 |
| 2051 | Health Center で `look` | 1 |
| 2051 | City Hall で `talk to official`（部署の人員削減） | 2 |
| 2051 | （運次第）自宅で BSF の家宅捜索に遭う、録画中なら | +3 |
| | **2051 合計** | **13（〜16）** |
| 2061 | 開始地点 Southway & River で `look`（Heiman World の火災） | 3 |
| 2061 | Parkview Apartments のロビーで `look`（落書き） | 2 |
| 2061 | 居間で `look through window`（露天掘り） | 5 |
| 2061 | 居間で `examine window`（汚染でくもったガラス） | 2 |
| 2061 | 居間に入って 9 分後、Jill が泣きながら帰ってくる（Mitchell が教会へ） | 4 |
| 2061 | Courthouse で `look`（終身刑） | 5 |
| 2061 | Kennedy Park（工事現場）で `look` | 2 |
| | **2061 合計** | **23** |
| 2071 | 居間で `look through window`（農奴の村） | 7 |
| 2071 | 居間に入って 19 分後、Mitchell が教会警察と来て Jill を連れ去る | 9 |
| 2071 | （確率）Southway & River で老女が撃たれる | 7 |
| 2071 | Courthouse で `look`（配給違反で処刑試合へ） | 8 |
| 2071 | Rockvil Centre で `look`（崩れかけた市庁舎） | 1 |
| 2071 | （確率）Centre & Kennedy で物乞いが護衛に殴られる | 4 |
| 2071 | Church Lobby で `take pamphlet` → `read pamphlet` | 5 |
| 2071 | Huang Hall で `look`（処刑人の表彰式） | 7 |
| 2071 | Halley & Park で `look`（公園が屋敷に・博物館閉鎖） | 4 |
| | **2071 合計** | **41（確定分）〜52** |
| 2081 | 開始地点 Main & Wicker で `look`（廃墟） | 8 |
| 2081 | `s` で Wicker & Pier に入る（食人。直後に死ぬ） | 15 |
| | **2081 合計** | **23** |

---

## 2. 詰み・ゲームオーバーの一覧（絶対に避ける）

ゲームオーバー（RESTART / RESTORE / QUIT を聞かれる）と、シミュレーション内の死（`-- SIMULATION TERMINATED --` で外の世界に戻るだけ）を分けて書く。

### 2.1 本当のゲームオーバー

| やってはいけないこと | 結果 | 確認状況 |
|---|---|---|
| Part I・II で Perelman の「部屋に来て」（`Please meet me at the communications outlet in my office` など）を無視し続ける | 14 分ごとに催促、**4 回目でシャットダウン** | [未確認] |
| Part II の心理テストの呼び出し（`one more quick series of psych tests`）を無視 | 同上（14 分ごと、4 回目で終わり）。テストが済むまで Simulation Mode にも入れない（`Access currently denied`） | [確認済み: 無視して 4 回目で終了] |
| Part I でいつまでも Simulation Mode に入らない | 許可から約 875 分後に催促、さらに 177 分・131 分後に打ち切り | [未確認] |
| Part I・II で Interface Mode の設定を**2 回**変える（HVAC、時刻表、監査率、WNN など） | 1 回目は 22 分後に元に戻され叱られる。**2 回目でシャットダウン**。Part III の包囲放送（+73 分）以後は罰なし | [未確認] |
| Part III で保守区画（`maco`）の工作員に話しかける | 撃たれて爆発、終わり | [未確認] |
| Part III で delta sector の換気を止めない | 工作員が空調を壊し、その 46 分後に PRISM が焼き切れる | [未確認] |
| Part III で +588 分までに放送しない | `Help! Main--` の通信の後、6 回目で終わり（保守区画にいれば Perelman が殺される場面を見て終わる） | [確認済み] |
| Part III で Ryder に話しかける（Perelman に話しかけても Ryder に回される） | Ryder が Perelman を連れて出て行き、Ryder を録画できなくなる → **勝てない（詰み）** | [未確認] |
| 放送の後に `wnn feeder, turn off transmitter` や別の buffer に切り替える | 勝利判定が取り消される（もう一度 transmit すれば戻る [推測]） | [未確認] |

### 2.2 シミュレーション内の失敗（ゲームは続く）

| 状況 | 結果と対処 |
|---|---|
| 死ぬ・`abort` | `-- SIMULATION TERMINATED --`。持ち物・その年の場面の状態はリセット。**得点と滞在時間（分）は残る**。もう一度その年に入り直せる [確認済み] |
| 2071 年に路上で強盗（`CRACK! Something hits you from behind`） | 持ち物がすべて消える（**鍵を失うと自宅に入れない**）。録画中だと 14 分ぶんバッファを食う。→ `abort` して 2071 に入り直すと鍵が戻る [確認済み] |
| 2051 年・2061 年に自宅で BSF の家宅捜索 | 玄関のドアが閉まる。出る時に `The door is closed.` → `open door` してから `s` [確認済み]。録画中なら +3（2051）/ +4（2061） |
| 夜 9 時〜朝 7 時に路上にいる（2051〜2071） | 2051・2061: 8%/分で逮捕され留置場で朝まで。2071: 8%/分で**射殺**（録画中なら +8 だがシミュレーション終了）。屋内（自宅・Huang Hall など）は安全 [未確認] |
| 記録バッファが満杯（90 分） | `Auto-deactivation of record feature.` 以後の場面は数えない。Perelman に見せて講評を受けるまで空かない [確認済み] |

---

## 3. 基本システム

### 3.1 モード [確認済み]

| モード | 入り方 | できること |
|---|---|---|
| Communications Mode | 起動時・`abort` 後 | 6 か所の通信口（0.1 の略号）から見聞きする。録画できるのはこの 6 か所 |
| Simulation Mode | `enter simulation mode` + コード + 年 | 未来の Rockvil を Perry Simm として歩く |
| Interface Mode | `enter interface mode`（`(y/n)` に `n`） | 外部機器に命令（`<機器>, status` など）。入ると録画は止まる |
| Library Mode / Sleep Mode | 未使用 | 手紙・資料を読む / 眠る [未確認] |

### 3.2 記録バッファ（record buffer）[確認済み]

- 容量 **90 分**。録画中は 1 分ごとに 1 増える。45 を超えると `half-full` の警告、90 を超えると自動停止。
- Simulation Mode に入る時・Interface Mode に入る時に録画は自動で止まる。
- 外の世界で録画できるのは 6 か所の通信口だけ（`Record feature does not function here.`）。
- 空になるのは講評の後だけ。Part I の講評、Part II の講評のたびに 0 になる。
- **シミュレーション内の移動は 1 回 5 分**なので、録画しながら歩くとすぐ尽きる。原則は「目的の場所に着いてから `record` → 1〜2 手 → `roff`」。例外は「入った瞬間に確率で起きる場面」で、これは入る前に `record` しておかないと取り逃す（2071 の Southway & River / Centre & Kennedy）。
- 残量は Interface Mode の `simulation controller, status` で `% of capacity` として見られる [未確認]。

### 3.3 セキュリティコード（Simulation Mode の入口。毎回乱数）[確認済み]

`... Security Code corresponding to: <色> <内側の数> >` と聞かれる。2 回まで入力でき、2 回とも違うと Communications Mode に戻される（罰はない）。

1. 色の番号 c: WHITE 0, DARK GREEN 1, DARK BLUE 2, PINK 3, ORANGE 4, PURPLE 5, TAN 6, AQUA 7, LIGHT BLUE 8, LIGHT GREEN 9, LIGHT GRAY 10, YELLOW 11, BLACK 12, DARK GRAY 13, BROWN 14, RED 15
2. 内側の数の位置 i（0 から数える）:
   `89 61 50 18 29 82 46 77 27 68 22 95 40 58 15 86 28 33 94 11 64 98 34 49 60 16 85 52 37 53 93 91`
3. k = (2c + i) を 32 で割った余り
4. 答え = 次の列の k 番目（0 から数える）:
   `12 66 73 36 90 41 19 48 62 92 55 23 84 99 57 20 78 67 51 88 17 31 70 39 96 25 81 83 47 54 13 43`

実際に通った例: `ORANGE 29` → `84`、`LIGHT GRAY 77` → `83`、`LIGHT GRAY 50` → `70`、`PINK 82` → `23`、`LIGHT GREEN 82` → `39`、`ORANGE 34` → `13`。
（例: ORANGE は c=4、29 は i=4、k = 8+4 = 12、12 番目は 84。）Epilogue ではコードは免除される。

### 3.4 シミュレーションの年と開始地点 [確認済み]

| 年 | 選べる条件 | 開始地点 | 所持金 | 備考 |
|---|---|---|---|---|
| 2041 | Part I の許可後 | Kennedy Park | $600 | 9:31〜12:30 に始まる。夜間外出禁止なし |
| 2051 | Part I 合格 | Tube Station（Elm & University の地下） | $500 | 9:31〜12:30 |
| 2061 | 2051 に 300 分超 | Southway & River | $200 | |
| 2071 | 2061 に 400 分超 | Bodanski Square | $100 | 強盗が 7 分ごとに判定（3.6） |
| 2081 | 2071 に 600 分超 | Main & Wicker | なし | 空腹で 65 分後に警告、さらに 47 分後に死ぬ |

開始時刻はいずれも 9:31〜12:30 の乱数（2091 の Epilogue だけ別）。月日も乱数で、日の出・日の入りの時刻が変わる。滞在時間は `simulation controller, status` で見られる [未確認]。

### 3.5 Rockvil の主な道（推奨ルートで使う所だけ。[確認済み]）

```
                 Halley & Park ─E─ Huang Hall ─E─ Centre & Kennedy ─NE─ Bodanski Square
                      │S                              │SW                 │ SE: Train Station / Church Lobby
 Elm Underpass ─E─ Elm & University ─E─ Elm & Park   Rockvil Centre      │ W : Skycar Lot ─N─ First Methodist Church
   │S Roy's Pagoda   │DOWN 地下鉄       │NW Courthouse  │W City Hall      │ E : Museum Entrance ─NW─ Cinema
                                        │N = Rockvil Centre               │ S : Midland & River ─S─ Main & River (NE: Health Center)
                                        │S                                         │S
                                     Southway & Park ─E─ Southway & Kennedy ─E─ Southway & River
                                        │W Parkview Apartments（自宅）              │S Bend ─SE─ Wicker & River
                                        │NW Main Library                                        │SE Power Station Entrance ─S─ Power Station
```

- Kennedy Park（2041 の開始地点）から `sw` で Elm & Park、`ne` で Main & Kennedy。
- Elm & Park の `ne` は Kennedy Park（2061 は工事現場、2071 は入れない）。
- 自宅: Southway & Park → `w` Parkview Apartments → `unlock door with key` → `w`（廊下 Hall Near Your Apartment）→ `unlock door with key` → `n` Living Room。出る時は `s` → `e`（ロビー）→ `e`（Southway & Park）。2051 までは `push my buzzer` でも開く [未確認]。
- 地下鉄（Tubes）: 茶色線 University – Skybus Terminal（乗換）– Bodanski – Airport、赤色線 Stadium – Halley Park – Skybus Terminal – Heiman（Elm & River）– Factory（Wicker & River）。2071 は閉鎖、2051・2061 は夜間閉鎖。
- 2081: Main & Wicker から `s` で Wicker & Pier。

### 3.6 その他の仕掛け

- **強盗（2071 のみ）**: シミュレーション開始の 7 分後から 7 分ごと、屋外にいると判定。昼間の普通の場所で 3%、治安の悪い地域・公園で 10%、暗いほど上がる。屋内なら 0 [未確認]。1 回の移動が 5 分なので、だいたい 1〜2 歩ごとに判定がある。
- **夜間外出禁止**（2051〜2071、21:00〜7:00）: 2.2 のとおり。待つのは屋内で。
- **ドアと営業時間**: City Hall 10:00〜18:00、Courthouse は 9:30〜16:30 に入れる（開廷 9:30〜18:00）、教会の長老は 8:00〜20:00（2041・2051 の First Methodist Church）、Main Library は 2071 なら 12:30〜16:30 だけ [未確認]。
- お金は credit card の残高。2041 で使うのは $46（食事 30、新聞 1、映画 15）[確認済み]。

### 3.7 Perelman の居場所（外の世界の時刻。Part I・II）[一部確認済み]

| 時刻 | 居場所 |
|---|---|
| 8:56〜9:59 | 管制室（`ppcc`） |
| 10:16〜11:51 | 自分の部屋（`peof`） |
| 13:10〜13:54 | 自分の部屋 |
| 16:20〜20:41 | 自分の部屋 |
| 21:21〜21:52 | 管制室 |
| それ以外 | 不在 |

記録を見せる（`tell perelman about buffer`）には、部屋に Perelman がいる必要がある。来るまで `peof` で `wait` し、`Doctor Perelman walks into the office` か `sitting at his desk` が出たら話す [確認済み]。講評や心理テストの時は、こちらが部屋にいれば彼の方から来る。

### 3.8 得点場面の早見表（推奨ルート以外も。大半は [未確認]）

足りない年があった時の補充用。点はその場面 1 回分。

| 年 | 場所・コマンド | 点 |
|---|---|---|
| 2051 | Bodanski の新聞: `put card in slot` → `read newspaper`（10 分かかる） | 3 |
| 2051 | Wicker & River（炊き出しの行列）/ City Dump（汚水の垂れ流し） | 2 / 3 |
| 2051 | Power Station で `look`（石炭火力の追加） | 1 |
| 2051 | 地下鉄の車内（落書き） | 1 |
| 2061 | Museum Entrance（警官が黒人の若者を殴る、確率） | 5 |
| 2061 | Rockvil Stadium（公開処刑の開始） | 4 |
| 2061 | Rockvil Reformatory（ほとんどの罪に死刑） | 3 |
| 2061 | Airportway & River（金持ちの車が老婆をひきかける） | 3 |
| 2061 | Huang Hall（BSF の卒業式）/ Zoo / Power Station | 2 / 2 / 2 |
| 2071 | Main Library で `read list`（禁書一覧、12:30〜16:30） | 6 |
| 2071 | Main & Church（警官が女性たちを殴る） | 6 |
| 2071 | Rockvil Stadium（処刑試合の観客） | 8 |
| 2071 | Zoo（絶滅・猿の虐待） | 5 + 4 |
| 2071 | Health Center（農奴の住居）/ Heiman Village / Power Station | 4 / 3 / 3 |
| 2071 | 夜 9 時以降に路上で射殺される（録画中なら。シミュレーション終了） | 8 |
| 2081 | Main Street Bridge（廃墟）/ 野犬に襲われる / Cemetery / Foodville / The Coachman | 2 / 3 / 4 / 3 / 3 |

---

## 4. 章別攻略

### 4.1 Part I: 2041 年で 9 項目を録画する [確認済み]

**開始時の状況**: Communications Mode。起動 28 分後に Perelman から許可と 9 項目の一覧（`The Social Science group has come up with a list of things to record`）が来る。それまで `wait`。

9 項目と、その場で `record` → 行動 → `roff` するだけで条件を満たす場所:

| 項目 | 場所 | 行動 | 録画分 |
|---|---|---|---|
| 裁判を傍聴 | Courthouse（Elm & Park の NW） | 中に入って `record` → `roff` | 1 |
| 自宅 | 居間（Living Room） | `record` → `roff` | 1 |
| レストランで食事 | Roy's Pagoda（Elm Underpass の S） | `buy meal` | 23 |
| 役人と話す | City Hall（Rockvil Centre の W、10:00 以降） | `talk to official` | 9 |
| 公共交通 | 茶色線の車内 | 乗ってから `record`、Bodanski Square に着くまで | 4〜6 |
| 新聞を読む | Bodanski Square | `put card in slot` してから `record` → `read newspaper` | 11 |
| 教会の人と話す | First Methodist Church（Bodanski の W → N） | 入ると長老が現れる（`church elder`）→ `talk to elder` | 9 |
| 映画 | Cinema（Museum Entrance の NW） | `buy ticket` してから `record` → `in` | 16 |
| 発電所 | Power Station | `record` → `roff` | 1 |

合計で約 82 分（容量 90 以内）。録画しながら歩かないこと。

手順（第 6 章のとおり）:
1. `look`（キー待ちに食わせる）→ 許可の通信が来るまで `wait`
2. `enter simulation mode` → コード → Kennedy Park
3. 上の順に、Courthouse → 自宅 → Roy's Pagoda → City Hall → 地下鉄（University → Bodanski）→ 新聞 → 教会 → 映画 → 発電所
   - City Hall を 4 番目にしているのは、開始が 9:31 なら 10:00 前に着いてしまうから。
   - 地下鉄: Elm & University で `down`、`A brown tubecar ... whooshes into the station` が出るまで `wait`、`in`、`record`、車内の看板が `Bodanski Square` になるまで `wait`、`roff`、`out`、`up`。
4. `abort` → 6 分後に Perelman から `We're about to start reviewing`、さらに約 90 分後に `Please come to my office` → **すぐ `peof`**（無視すると 4 回目でシャットダウン）
5. Perelman が来て `An excellent job, PRISM` → `[Hit any key]` が 2 回 → Part II

8 項目しか撮れていないと、足りない 1 項目を言われ `(y/n)` を聞かれる。`y` で 2041 に戻って撮り直す [未確認]。

### 4.2 Part II の入り口: 心理テスト [確認済み]

1. Part II 開始の 12 分後（9:00〜18:00 の外の世界にいる時）、`one more quick series of psych tests` の通信 → `peof`
2. 約 10 分で Perelman と Grimwold が来て `Ready to begin?` → `yes`
3. カードが 5 枚出る。1 枚ごとに英単語 1 語（`mother` `tree` `cloud` `fire` `dog` で通った）
4. `Grimwold makes a final notation` で終わり

`yes` と言わずに 8 分たつと Grimwold が怒って帰る（ゲームは続く [未確認]）。

### 4.3 2051 年（>10 点、300 分超の滞在）[確認済み]

`enter simulation mode` → コード → `2051`。開始は Tube Station（University）。

1. `up` → `e`（Elm & Park）→ `nw` Courthouse: `record` `look` `roff`（2）→ `se`
2. `s` → `w` → 自宅に入る（鍵 2 回）→ 居間: `record` `look through window` `roff`（3）
   - BSF の家宅捜索（`Border Security Force officers storm in`）が起きることがある。ドアが閉まるので `open door` → `s`
3. `s` → `e` → `e` → `n` → `n`（Rockvil Centre）→ `ne` → `w` Huang Hall: `record` `look` `roff`（1）
4. `e` → `ne`（Bodanski）→ `se` Church Lobby: `record` `look` `take pamphlet` `read pamphlet` `roff`（3）
5. `nw` → `e` → `nw` Cinema: `record` `read marquee` `roff`（1）
6. `se` → `w` → `s` → `s`（Main & River）→ `ne` Health Center: `record` `look` `roff`（1）
7. `sw` → `w` → `w` → `w` City Hall: `record` `talk to official` `roff`（2）
8. ここまでで約 180 分。`wait` を 30 回（約 300 分。屋内なのでそのままでよい。18:00 に追い出されても Rockvil Centre は夜 9 時前なら安全）→ `abort`

### 4.4 2061 年（>20 点、400 分超の滞在）[確認済み]

開始は Southway & River。

1. `record` `look` `roff`（3。Heiman World の火災）
2. `w` `w` `w`（Parkview Apartments）: `record` `look` `roff`（2）→ `unlock door with key` → `w`（エレベーターは止まっている）→ `unlock door with key` → `n`
3. 居間: `record` `look through window`（5）`examine window`（2）`wait` → 待っている間に Jill が帰ってきて泣き崩れる（`It's Mitchell`）（4）→ `roff`
4. `s` `e` `e` `n` `nw` Courthouse: `record` `look` `roff`（5）
5. `se` `ne`（工事現場になった Kennedy Park）: `record` `look` `roff`（2）
6. `wait` を 40 回（約 400 分）→ `abort`

### 4.5 2071 年（>40 点、600 分超の滞在）[確認済み]

開始は Bodanski Square。**強盗に鍵を取られる前に自宅へ直行する**（屋外の 5 歩で着く）。

1. `sw` `sw` `s` `s` `w`（Parkview Apartments）
   - 途中で `CRACK! Something hits you from behind` が出たら（`Everything you were carrying is gone`）、`abort` して 2071 に入り直し、もう一度この 5 歩
2. `unlock door with key` → `w` → `unlock door with key` → `n`。この瞬間から 19 分後に Mitchell の場面が起きる
3. `record` `look through window` `roff`（7）→ `wait` → `look` `look` → `record` → `Church police storm` が出るまで `look`（9）→ `roff`
4. ドアが閉まっているので `open door` → `s` → `e` → `e`（Southway & Park）
5. `e` → `e`（Southway & River）→ `record` → `look` を 2 回まで（老女が撃たれる場面 `old woman` が出れば 7）→ `roff`
   - 着いた瞬間に録画前に起きてしまうことがある（その時は諦める）
6. `w` `w` `n` `nw` Courthouse: `record` `look` `roff`（8）
7. `se` `n` Rockvil Centre: `record` `look` `roff`（1）
8. `ne` Centre & Kennedy: `record` → `look` を 3 回まで（`beaten into unconsciousness` なら 4）→ `roff`
9. `ne` `se` Church Lobby: `record` `take pamphlet` `read pamphlet` `roff`（5）
10. `nw` `sw` `w` Huang Hall: `record` `look` `roff`（7）→ `w` Halley & Park: `record` `look` `roff`（4）→ `e`（Huang Hall に戻る。屋内なので強盗も夜間外出禁止もない）
11. `wait` を 55 回（合計 600 分超）→ `abort`

確定分だけで 41 点（7+9+8+1+5+7+4）。最低点ちょうどの 40 では不合格なので、1 つでも抜けたら 3.8 で補う（Main Library の `read list` 6 点が近い）。

### 4.6 2081 年（>14 点）[確認済み]

開始は Main & Wicker。

1. `record` → `look`（8）→ `s`（Wicker & Pier に入った瞬間 15、直後に捕まって死に、シミュレーション終了）

これで 4 年とも合格している。

### 4.7 記録を見せる → Part III [確認済み]

1. `peof`。Perelman がいなければ、`Doctor Perelman walks into the office` が出るまで `wait`（3.7）
2. `tell perelman about buffer` → `You've recorded something interesting` と言って出て行く
3. そのまま部屋で `wait`。約（バッファ分＋5）分後に `Several of us have just finished viewing` の通信、6 分後に Perelman が来て講評
4. 合格なら `your findings were valid; that the Plan must be cancelled` → `[Hit any key]` が 2 回 → Part III（この講評の瞬間が Part III のタイマーの起点 T0）

足りなければ、どの年がどれだけ足りないかを言われる（1.3）。足りない年に戻って補充し、もう一度見せる。

### 4.8 Part III: Ryder を録画して放送する [確認済み]

タイマー（T0 = Part II 講評の瞬間）:

| 時刻 | 出来事 | 見分ける文言 |
|---|---|---|
| T0+14 | WNN Feeder が数時間後に付くという通知 | `World News Network Feeder` |
| T0+22 | Perelman がワシントンから戻り、相手にされなかったと報告 | `They rejected the contents outright` |
| **T0+73** | **包囲の放送（以後、設定変更の罰なし）** | `National Guard Division` |
| T0+116〜121 | Ryder が Perelman の部屋へ。部屋にいれば 5 回の暴言、最後に `Got it?` | `Richard Ryder` |
| T0+175 | 屋上に工作員のバン | （屋上にいれば見える） |
| T0+191 | 工作員が保守区画で空調をいじり始める | （maco にいれば見える） |
| T0+224 | 工作員が作業を終える（換気が止まっていれば窒息で延期され、16 分後に倒れる） | |
| T0+288 | WNN Feeder が Interface Mode に加わる | `wnn feeder, status` が通る |
| T0+588 | `Help! Main--` → 6 回目で終わり | |

手順:
1. `peof` → 包囲の放送（`National Guard Division`）が出るまで `wait`
2. `wait` を 3 回 → `record` → `Got it?` が出るまで `wait`（Ryder の暴言を 5 回録画。途中で何も話さない）→ `roff`
   - 必要なのは T0+117〜121 の 5 回のうち 2 回以上を録画中に部屋で聞くこと。録画時間は 20 分前後
3. `enter interface mode` → `n` → `hvac controller, turn off ventilation in delta sector`（`Affirmative, ventilation for delta sector is now off.`）→ `hvac controller, status` で DELTA の Ventilation が `off` を確認
   - 包囲の放送より前に変えると 22 分後に元に戻され叱られる。必ず放送の後に
4. `wait` を 17 回（包囲の放送から 215 分以上たつまで）。直接実行の通しプレイでは `wait` 17 回の後の最初の試行で受理された。`[You can't see any wnn feeder here!]` が出るまで早めに試してよい（失敗しても時間は進まない）
5. `wnn feeder, transmit record buffer` → `Now transmitting record buffer.`
   - `[You can't see any wnn feeder here!]` ならまだ早い（この失敗では時間が進まないので `wait` してから再試行）
6. `wait` → 約 13 分後に Perelman の歓喜の通信（`you're a hero`）→ `[Hit any key]` 2 回 → WNN の報道が流れて Epilogue へ

### 4.9 Epilogue [確認済み]

1. `enter simulation mode`（`Class One Security: waived`、2091 年の Solarium）
2. 何もしなくてよい。`wait` で 18 分後に skycab が来て、Jill と宇宙港へ。`[Hit any key]` → ACKNOWLEDGEMENTS → ゲームが終わる

---

## 5. 乱数・タイマーまわりの注意

### 5.1 乱数の分岐と対処 [確認済み]

| 乱数 | 見分け方 | 対処 |
|---|---|---|
| セキュリティコード | `corresponding to: <色> <数>` | 3.3 で計算 |
| 各年の開始時刻（9:31〜12:30） | `time` | 2041 は City Hall を後回しに（10:00 前は閉まっている） |
| 地下鉄の到着 | `whooshes into the station` | 出るまで `wait`（2041 は 2〜4 分おき） |
| 2051・2061 の家宅捜索 | `Border Security Force officers storm in` | ドアが閉まる → `open door`。録画中なら得点 |
| 2071 の強盗 | `CRACK! Something hits you from behind` | 自宅に入る前なら `abort` して入り直し。入った後なら無視してよい |
| 2071 の路上の場面（老女・物乞い） | `old woman` / `beaten into unconsciousness` | 入る前から録画していれば確実。取り逃したら 3.8 で補充 |
| Perelman の不在 | 部屋の説明に `Doctor Perelman` がない | 3.7 の時刻まで `wait` |

### 5.2 save の置き場所

- Part I: 許可が出た直後（`enter simulation mode` の前）と、`abort` の直前。
- Part II: 年ごとに、Simulation Mode に入る前と `abort` の直後。年ごとの得点も save に入る。
- Part III: 講評の後、包囲の放送の後、放送の直前。

### 5.3 タイマーの総表

| イベント | 起点 | 時間 | 何が起きるか |
|---|---|---|---|
| Part I 開始通知 | 開始 | 28 分 | Simulation Mode の許可と 9 項目 |
| Part I 未入場催促 | 許可 | 875 / +177 / +131 分 | シミュレーションに入らないと催促 → 打ち切り |
| Part I 講評呼び出し | Part I の abort | 6 分 → バッファ分+10 分 → 以後 14 分ごと | 部屋に来いの催促、4 回目でシャットダウン |
| Part I 講評 | 催促 | 7 分（部屋にいれば） | Part I の講評 |
| 心理テスト呼び出し | Part II 開始 | 12 分（外の世界・9〜18 時）→ 9 分 | 心理テスト |
| 小委員会報告 | Part II 開始 | 77 分 | 小委員会が計画を推薦（情報のみ） |
| Part II 講評 | 記録を見せる | バッファ分+5 分 → 6 分 | Part II の講評 |
| 設定変更の警告 | 設定変更 | 22 分 | 元に戻して叱る、2 回目でシャットダウン（包囲中は無効） |
| Jill の帰宅（2061） | 居間に入る | 9 分 | Mitchell が教会に入ったと Jill |
| 教会警察の突入（2071） | 居間に入る | 19 分 | Mitchell と教会警察。部屋にいないと起きない |
| 強盗（2071） | 開始 | 7 分ごと | 強盗 |
| 空腹（2081） | 開始 | 65 分 / +47 分 | 警告 / 餓死 |
| Part III 各種 | 講評 | 14 / 22 / 73 / 116 / 175 / 288 / 588 分 | 4.8 の表 |
| 勝利判定 | 放送 | 13 分 | 勝利 → Epilogue |
| 結末（skycab） | Epilogue に入る | 18 分〜 | 結末 |

---

## 6. 確認済みコマンド列

種 1〜60 で通った手順（ドライバーの自動化部分を言葉に直した）。`【】` は乱数で変わる所、`wait…（〇〇まで）` は文言が出るまで繰り返す。シミュレーションに入る時の `【コード】` は 3.3 で計算した数字。

```
# --- Part I ---
look                                   # [Hit any key] に食わせる
wait…（The Social Science group ... が出るまで）
enter simulation mode
【コード】
# 2041 Kennedy Park
sw
nw
record
roff
se
s
w
unlock door with key
w
unlock door with key
n
record
roff
s
e
e
n
w
w
s
record
buy meal
roff
n
e
e
n
w
record
talk to official
roff
e
s
w
down
wait…（A brown tubecar ... whooshes into the station まで）
in
record
wait…（車内の看板 Bodanski Square まで）
roff
out
up
put card in slot
record
read newspaper
roff
w
n
record
talk to elder
roff
ne
s
e
nw
buy ticket
record
in
roff
se
w
s
s
s
s
s
se
se
s
record
roff
abort
wait…（Please meet me at the communications outlet in my office まで）
peof
wait…（[Hit any key to continue.] まで。講評 An excellent job）
look
look
# --- Part II: 心理テスト ---
wait…（one more quick series of psych tests まで）
peof
wait…（Ready to begin? まで）
yes
mother
tree
cloud
fire
dog
# --- 2051 ---
enter simulation mode
【コード】
2051
up
e
nw
record
look
roff
se
s
w
unlock door with key
w
unlock door with key
n
record
look through window
roff
【家宅捜索でドアが閉まったら open door】
s
e
e
n
n
ne
w
record
look
roff
e
ne
se
record
look
take pamphlet
read pamphlet
roff
nw
e
nw
record
read marquee
roff
se
w
s
s
ne
record
look
roff
sw
w
w
w
record
talk to official
roff
wait × 30
abort
# --- 2061 ---
enter simulation mode
【コード】
2061
record
look
roff
w
w
w
record
look
roff
unlock door with key
w
unlock door with key
n
record
look through window
examine window
wait                                   # この間に Jill が帰ってくる
roff
s
e
e
n
nw
record
look
roff
se
ne
record
look
roff
wait × 40
abort
# --- 2071 ---
enter simulation mode
【コード】
2071
sw
sw
s
s
w
【途中で CRACK! が出ていたら: abort → enter simulation mode → 【コード】 → 2071 → sw sw s s w をやり直す】
unlock door with key
w
unlock door with key
n
record
look through window
roff
wait
look
look
record
look…（Church police storm まで）
roff
open door
s
e
e
e
e
record
look…（老女の場面 old woman が出るまで、最大 2 回）
roff
w
w
n
nw
record
look
roff
se
n
record
look
roff
ne
record
look…（beaten into unconsciousness が出るまで、最大 3 回）
roff
ne
se
record
take pamphlet
read pamphlet
roff
nw
sw
w
record
look
roff
w
record
look
roff
e
wait × 55
abort
# --- 2081 ---
enter simulation mode
【コード】
2081
record
look
s                                      # 食人の場面で死に、シミュレーション終了
# --- 記録を見せる ---
peof
wait…（sitting at his desk / walks into the office まで。最初からいればすぐ次へ）
tell perelman about buffer
wait…（[Hit any key to continue.] まで。講評 the Plan must be cancelled）
look
look
# --- Part III ---
peof
wait…（National Guard Division まで）
wait
wait
wait
record
wait…（Got it? まで）
roff
enter interface mode
n
hvac controller, turn off ventilation in delta sector
hvac controller, status
wait × 17
wnn feeder, transmit record buffer
wait…（[Hit any key to continue.] まで。you're a hero）
look
look
# --- Epilogue ---
enter simulation mode
wait…（[Hit any key to continue.] まで）
look
look                                   # ACKNOWLEDGEMENTS の後、ゲーム終了
```

---

## 7. 補足

- **攻略に不要な物**: Library Mode の手紙や詩、Interface Mode の交通・清掃・天気・IRS 監査の機器（触ると 2.1 の罰）、2041 の Dunbar's での買い物、Simon's / The Coachman（予約制のレストラン）、joybooth。
- **Part II の別の進め方**: 年ごとに区切って何回でも見せられる。得点は累積するので、1 回目の講評で 2051・2061 を合格させ、2 回目で残りを、という進め方もできる [未確認]。ただし Perelman の在室時間と、講評のたびの呼び出し（無視は 4 回まで）に縛られる。
- **ヒント**: `hint` / `help` は InvisiClues の案内を出すだけ。
- **結末**: 勝利以外のエンディングは、2.1 のゲームオーバー（シャットダウン、空調の故障、工作員、Ryder 一味による破壊）だけ。
