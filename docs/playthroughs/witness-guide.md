# THE WITNESS ゲームプレイ解説（Claude 攻略用リファレンス）

> **注意（ライセンス・ネタバレ）**
> 本ガイドは *The Witness*（© 1983 Infocom, Inc.）の実行検証をもとに、MCP 経由でプレイする Claude 向けの攻略リファレンスとして作成したものである。MIT ライセンス対象作品ではないため、ゲームの文章やソースコードの転載は行わず、判断の目印となる短い引用と構造・手順の解説にとどめる。ゲームを自力で解きたい場合は読まないこと。

- **対象:** `out/witness`（エントリ `witness`、MCP サーバー名 `witness`）
- **検証範囲と前提:**
  - `out/witness`（Python 版）をテストドライバー経由で最初からエンディング（`EPILOGUE`）まで **乱数シード 5 通り（seed=1〜5）すべてでクリア確認済み**。
  - `ZilMcp.py out/witness` および `ZilMcp.lua lua/witness` 経由でクリア確認済み。
- **根拠の表記:** 各節・項目に **【確認済み】**（実行して出力を確認）を記す。

---

## 0. 最初に読むこと（パーサーの落とし穴・実プレイの教訓）

### 0.1 パーサーの落とし穴 【確認済み】
| 通らない・意図と違う入力 | 通る入力 | 理由 |
|---|---|---|
| `take gun` | （時計の中の銃を取る必要はない） | プレイヤー自身が最初から Colt .32 を持っているため `You already have it.` になる |
| `hide behind desk` | `hide behind lounge` | 執務室で隠れられるのは長椅子（`lounge`）のみ（机は `There's no room to hide behind the desk.`） |
| `wait`（1 分待つつもり） | `look`（1 分） / `wait for 3` | 本作の `wait` は既定で **10 分** 進む |
| `arrest monica and phong` | `arrest monica` | 2 人同時逮捕は共謀の司法取引エンドになり、完全解決（`EPILOGUE`）にならない |

### 0.2 実プレイ上の教訓 【確認済み】
- **待機中の割り込みプロンプト:** `wait` や `wait until ...` の途中でイベントが起きると `Do you want to keep waiting? (Answer YES or NO.)` と聞かれる。続ける場合は **`y`** を送る。
- **`wait for phong` / `wait for duffy`:** 相手が現れるか分析・検死から戻るまで自動で待てる。ただし 30 ターンを超えると継続確認が出る。

---

## 1. ゲームの目的と真相・勝利条件

### 1.1 真相
- 被害者 Freeman Linder は、妻の自殺の原因となった愛人 Ralph Stiles に復讐するため、**狂言の殺人未遂**（執務室の柱時計の中に銃を仕掛け、執事ボタンで窓の爆薬と同時に発火させて Stiles に罪を着せる計画）を企て、執事 **Phong** と娘 **Monica** に手伝わせた。
- しかし母の死を父のせいだと恨んでいた **Monica** が、銃の照準を父の心臓に向けて細工し、計画を利用して父を**殺害**した。時計の鍵（`CLOCK-KEY`）は Monica が持っている。

### 1.2 勝利条件（完全解決 `EPILOGUE`） 【確認済み】
Linder 殺害後（9:00 PM 以降）、Duffy 巡査部長が現場にいる状態で **`arrest monica`** を実行し、確認に `y` と答える。有罪判決と完全解決（`You have reached a complete solution to the story.`）を得るには、以下 **4 条件すべて** を満たす必要がある（`events.py` `ARREST` 関数）。

| # | 条件（内部フラグ） | 満たし方（最短ルート） |
|---|---|---|
| 1 | 事件後、Monica が非表示（`LIMBO` = 映画館）でない | 10:50〜11:10 PM 頃の帰宅後に逮捕する |
| 2 | トリックを暴いた（`MONICA_ADMITTED_HELPING_p` / `PHONG_ADMITTED_HELPING_p` / `PLAYER_PUSHED_BUTTON and (POWDER_ANALYZED or INSIDE_GUN TOUCHBIT)` のいずれか） | 事件後に執務室で `push button` → `examine clock` → `analyze powder`（Duffy が戻るまで待つ）。さらに Phong に `ask phong about button` すると自白も取れる |
| 3 | Monica の動機を掴んだ（`MONICA_HAS_MOTIVE`） | Phong に **`ask phong about suicide`**（または Monica に `ask monica about mother`） |
| 4 | Monica と時計の仕掛けを結びつけた（`SEEN_MONICA_AT_CLOCK` or `USED_CLOCK_KEY`） | 帰宅後の Monica が執務室で時計を開けて銃を回収する場面を **`hide behind lounge`** して目撃する（12:00〜12:25 AM 頃） |

- **重要:** `arrest monica and phong` で 2 人同時に逮捕すると、執行猶予・国外退去の司法取引エンドになり `EPILOGUE` に到達しない。**`arrest monica` 単独** で逮捕すること。
- 本作にはいわゆるスコア加算はなく、ステータス行の `SCORE` は**時（20 = 8:00 PM）**、`MOVES` は**分**を表す。ヒント機能（`ask duffy for hint` 相当）を使った回数（`DUFFY_HINT_NUM`）が `0` だと最高評価の祝辞になる。

---

## 2. 詰み条件・ゲームオーバーの一覧 【確認済み】

| やってはいけないこと | 結果 | 対策 |
|---|---|---|
| **8:52 PM までに玄関を叩かない**（`I_LINDER_TO_OFFICE` が屋外/作業場で発火） | `TOO_LATE` が立ち、家に入れてもらえず追い返され、再訪すると不法侵入で強制終了 | 開始直後に `north` → `north` → `knock on door` で入館する |
| **9:00 PM の発砲時に椅子に座っていない** | 50% の確率で即死（`you should have taken a chair when Linder asked you to.`） | Linder と執務室に入ったら必ず `sit on wooden chair`（または `sit on lounge`）しておく |
| **発砲直前に窓・時計の近くをうろつく**（`PLAYER_NEAR_SHOT`） | 発砲時に巻き込まれて即死 | 9:00 PM 前後は椅子に座って待つ |
| **Monica が執務室で時計を細工する時に隠れていない** | `SEEN_MONICA_AT_CLOCK` が立たず、裁判で無罪（証拠不十分）になる | 11:00 PM 前に `hide behind lounge` で隠れておく |
| **救急車到着後（11:30 PM 頃）に Duffy が検死官同行中に逮捕する** | `Sergeant Duffy isn't around right now.` で逮捕できない | Duffy が戻る（約 69 分後）まで `wait for duffy` で待つ |
| **朝（時間切れ `TIMES_UP`）まで放置する** | Klutz 署長に連れ戻されてゲーム終了 | 1:00 AM 前後には逮捕を完了させる |

---

## 3. 基本システムとマップ

### 3.1 基本コマンド・時刻・Duffy 【確認済み】
- **開始時刻:** 8:00 PM（金曜 1938-02-18）。通常コマンド 1 手 = **1 分**、`wait` = **10 分**、`wait until 9:05` や `wait for duffy` / `wait for phong` も使用可能。
- **Duffy 巡査部長:** 殺人事件発生後（9:03 PM 頃に到着）、Stiles を居間に拘束した後は、いつでも `analyze <物>` / `fingerprint <物>` を呼ぶと即座に現れて持ち帰り、**15〜30 分後**に結果を持って戻る。
- **銃と鍵:** 時計（`CLOCK`）は最初から施錠（`LOCKED`）されており、事件前に `open clock` しても開かない。発砲後に `examine clock` すると鍵穴の火薬（`CLOCK-POWDER`）が見つかり、`analyze powder` で火薬を分析できる。

### 3.2 マップ（屋敷と敷地）

#### 屋外
```
             [Rock Garden] (←w: Linder's bedroom)
                  | s
             [Back Yard]   (←w: Monica's bedroom)
                  | s
[Front Yard] [Office Porch](←w: Office)
  | s             | s
[Front Porch] [Office Path]
  | s             | w
[Driveway]--e--[Garage]--e--[Workshop]
  | s             | n
[Driveway Entrance]--e--[Side Yard]--e--[Office Path]
  (開始地点)
```

#### 屋内（1 階平屋）
```
[Dining Room]--e--[Living Room]--e--[Linder's Room]
     | s               | s               | s
 [Kitchen]----e----[Hall-1]         [Bathroom] (w:Toilet / e:Tub)
                       | s               | s
[Butler's Room]--e--[Hall-2]----e----[Monica's Room]
                       | s
    [Entry]----e----[Hall-3]  (w of Entry: Front Porch)
                       | s
[Storage Closet]--e--[Hall-4]----e----[Office]----e----[Office Porch]
                       | s
                   [Garage]
```
- `Garage` の南ではなく `Hall-4` の南が `Garage`。`Garage` の東が `Workshop`（Monica が帰宅直後に配線を直す場所）。

---

## 4. タイムラインと攻略手順 【確認済み】

### 第 1 幕：到着〜殺人事件（8:00 PM 〜 9:05 PM）
1. **入館する（8:00 PM〜）:**
   - `north` → `north`（`Front Porch`）→ `knock on door`
   - Phong が扉を開けて `Entry` へ案内してくれる。
2. **応対して執務室へ（8:02 PM〜）:**
   - `wait`（約 2 回。`Do you want to keep waiting?` には `y`）。Phong が `Living Room` へ案内し、Linder が挨拶したあと、`Office` へ連れて行ってくれる。
3. **椅子に座って事件を待つ（8:13 PM〜9:00 PM）:**
   - **`sit on wooden chair`**（重要: 立っていると 9:00 PM の発砲で 50% 即死する）。
   - `wait until 9:05`（途中の待機確認はすべて `y`）。
   - 8:30 PM 頃に Monica が映画へ出かけ、9:00 PM に呼び鈴が鳴り Stiles が外に現れる。Linder がボタンを押した瞬間に発砲が起き、Linder が死亡する。

### 第 2 幕：現場検証と Phong への聴取（9:05 PM 〜 9:50 PM）
1. **ボタンと時計を調べる:**
   - `stand`
   - **`push button`**（時計の方向からカチッと音がする → `PLAYER_PUSHED_BUTTON` 達成、同時に約 3 分後に Phong がやって来る）。
2. **Phong から動機と共謀を聞き出す:**
   - `wait for phong`（Phong が執務室に来るまで待つ）。
   - **`ask phong about suicide`**（Monica が母の死で深く落ち込んでいた話 → `MONICA_HAS_MOTIVE` 達成）。
   - **`ask phong about button`**（Linder の狂言計画を手伝ったことを認める → `PHONG_ADMITTED_HELPING_p` 達成）。
3. **時計の火薬を鑑識に出す:**
   - **`examine clock`**（鍵穴が黒ずんでおり `CLOCK-POWDER` が見つかる）。
   - **`analyze powder`**（まだ Duffy に会っていないと言われた場合は `wait` して Duffy の到着を待ってから再度 `analyze powder`）。
   - **`wait for duffy`**（15〜30 分で Duffy が戻り、火薬が銃のものだと判明 → `POWDER_ANALYZED` 達成）。

### 第 3 幕：隠密観察と逮捕（9:50 PM 〜 12:45 AM）
1. **長椅子の陰に隠れて Monica の帰宅を待つ:**
   - 執務室のまま **`hide behind lounge`** を実行。
   - **`wait until 12:35`**（途中の確認はすべて `y`）。
   - 10:50〜11:10 PM 頃に Monica が帰宅し、`Workshop` で配線を直したあと、`Office` で死体を見て驚き、自室やトイレを経て、**12:00〜12:25 AM 頃に再び `Office` に戻る**。隠れて見ていると、彼女がボタンを押して時計を鍵で開け、中の銃を回収して再び施錠する場面を目撃できる（`SEEN_MONICA_AT_CLOCK` 達成）。
   - 途中 11:30 PM 頃に救急車が遺体を運び出し、Duffy も検死官に同行して一時離脱する。
2. **Duffy の帰還を待って逮捕する:**
   - **`stand`**
   - **`wait for duffy`**（Duffy が検死結果を持って戻るまで待つ。12:40 AM 頃に戻る）。
   - **`arrest monica`** → 確認に **`y`** → 事件解説（`EPILOGUE`）を見るなら **`y`**。

---

## 5. 乱数・タイマー総表

| イベント / 要素 | 発生タイミング / 確率 | 攻略への影響 |
|---|---|---|
| `I_LINDER_TO_OFFICE` | 開始から 52 分後（来客応対後は 1〜10 分後） | この時点で屋外にいると `TOO_LATE` で詰み |
| `I_STILES_ARRIVE` | 開始から 60 分後（9:00 PM） | Linder 殺害発生。立っていると 50% 即死 |
| `I_DUFFY_ARRIVE` | 殺人から 3 分後 | Duffy 登場。以後 `analyze` が可能になる |
| `I_FINGERPRINT`（分析時間） | `15 + RANDOM(15)` 分 | 16〜30 分で Duffy が結果を届ける |
| `I_MONICA_RETURN` | `670 - PRESENT_TIME - RANDOM(20)` 分後 | 10:50〜11:10 PM 頃に帰宅（乱数で最大 20 分前後） |
| `I_AMBULANCE` | 殺人から 150 分後（11:30 PM 頃） | 遺体搬出。Duffy が分析中でなければ 69 分間検死官へ同行 |
| `I_DUFFY_RETURNS` | `I_AMBULANCE` から 69 分後（12:40 AM 頃） | Duffy 帰還。以後は `arrest monica` 可能 |

---

## 6. 確認済みコマンド列 【確認済み】

Python 版（`out/witness`）にて乱数シード 1〜5 のすべてで完全解決（`You have reached a complete solution to the story.`）まで到達したコマンド列。待機中に `Do you want to keep waiting?` が出た場合はすべて `y` を答える。

```text
north
north
knock on door
wait
wait
sit on wooden chair
wait until 9:05
stand
push button
wait for phong
ask phong about suicide
ask phong about button
examine clock
analyze powder
wait for duffy
hide behind lounge
wait until 12:35
stand
wait for duffy
arrest monica
y
y
```

> **補足:** `analyze powder` の時点でまだ Duffy が到着していない場合（シードや手数によって 1〜2 分ずれた場合）は、`wait` で Duffy 到着のメッセージが出てから `analyze powder` を実行すること。

---

## 7. 補足（エンディング分岐と不要要素）

- **評価分岐（`DUFFY_HINT_NUM`）:** Duffy にヒントを聞かなければ（`0` 回）`"Congratulations on your fine detective work."`、1〜2 回ならチームワーク賞賛、3 回以上なら Duffy 昇進ジョークになる。
- **不完全な逮捕エンド:**
  - `arrest monica and phong`（銃の領収書・動機・時計目撃あり）→ 両者とも司法取引で執行猶予/保護観察（`EPILOGUE` にはならない）。
  - `arrest stiles`（仕掛け未解明時）→ Stiles 誤認逮捕・後日再審で釈放。仕掛け解明後 → 無罪。
  - `arrest linder` → 自殺説として処理。
- **攻略上なくても完全解決できる要素:** `OUTSIDE-GUN`（裏庭の銃）、`GUN-RECEIPT`（Phong の部屋の本の挟み紙）、`MEDICAL-REPORT`（Monica の部屋の診断書）、足跡の石膏型（`SIDE-FOOTPRINTS` / `BACK-FOOTPRINTS`）、電線・パテの分析は物語の理解を深める手がかりだが、上記 4 条件を満たす最短ルートでは必須ではない。
