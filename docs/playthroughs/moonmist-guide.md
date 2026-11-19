# MOONMIST ゲームプレイ解説（LLM 攻略用リファレンス）

対象: `moonmist/`（Infocom *MOONMIST* の ZIL ソース）と、それを ZilPy で変換した Python / Lua 版。

このファイルは原作 ZIL ソース（`moonmist.zil`, `misc.zil`, `colors.zil`, `castle.zil`, `tower.zil`, `people.zil`, `goal.zil`, `things.zil`, `places.zil`, `global.zil`, `verbs.zil`, `syntax.zil`）の読解に基づいて作成した攻略リファレンスである。

- 「確認済み」= 該当 ZIL ルーチンを読んで確かめた仕様
- 「推奨手順」= 確認済み仕様から組んだ最短・安全ルート

---

## 1. ゲームの目的と勝利条件・4 つのバリエーション

*Moonmist* は、冒頭の正門インターホンで答える **「好きな色（`red` / `yellow` / `blue` / `green`）」** によって、`VARIATION` が決まり、**真犯人・動機・幽霊の正体・証拠・ライオネルの財宝の隠し場所・手がかりの連鎖が丸ごと変わる 4 パターン構成**（`colors.zil` の `DO-VARIATION`）。

※上記 4 色以外の色を入力した場合は、先頭文字等から強制的に 4 色のいずれかに割り当てられる（例: `pink` → `blue`）。

### 勝利条件（全バリエーション共通・確認済み）

次の **3 条件すべて** を満たした瞬間（順序不問）に `WRAP-UP` → `FINISH` でクリアとなる（`verbs.zil`: `CONFESSION` / `CONGRATS` / `V-SCORE`）。進捗はいつでも `score` で確認できる。

| # | 条件 | フラグ | 達成方法 |
|---|---|---|---|
| 1 | **真犯人の逮捕・自白** | `CONFESSED` | 決定的証拠（`EVIDENCE-FOUND`）を読んだ／再生した上で、夕食のライオネルの録音終了後（20:40 以降）に犯人と同じ部屋で `arrest <犯人名>` |
| 2 | **幽霊（新しい幽霊）の正体特定** | `FOUND-COSTUME[PLAYER-C]` | **Red**: 深夜 0:00 以降に出現する幽霊（生存していた Deirdre）に友好的な行動をとって話を聞く。<br>**Yellow / Blue / Green**: 隠された `ghost costume` を発見し `examine costume` する（または 0:00 以降に幽霊を無力化して `undress ghost`） |
| 3 | **ライオネルの財宝の発見** | `TREASURE-FOUND` | 各バリエーション固有の隠し場所から `TREASURE` を発見する |

### 4 バリエーション真相・攻略一覧表（確認済み）

| 色 (`VARIATION`) | 真犯人（逮捕対象） | 幽霊の正体 (`VILLAIN-PER`) | 動機・真相の要約 | 決定的証拠 (`EVIDENCE-FOUND`) | 幽霊の正体確認 (`COSTUME`) | 財宝 (`TREASURE`) と隠し場所 |
|---|---|---|---|---|---|---|
| **Red** (`LORD-C` = 2) | **Lord Jack** (`jack`) | **Deirdre Hallam**（生きていた！） | Jack が爵位と城を狙い叔父 Lionel を窒息死させ、脅迫してきた Deirdre も井戸に落として殺そうとした。Deirdre は地下水流で海へ流され生還し、Jack に復讐するため幽霊に変装して夜な夜な城に忍び込んでいた。 | 塔 1 階廊下 (`CORR-2`) の Jack の部屋扉の `family crest` を外し、内蔵の `secret tape recorder` を `play tape` | 0:00 以降に Iris が就寝すると Deirdre が `LOVER-PATH` → `BASEMENT` → `KITCHEN` → `BACKSTAIRS` → `DINING-PASSAGE` → `YOUR-CLOSET` へ移動。出会ったら攻撃せず **`ask ghost about jack` 等の友好的行動**で話を聞く | **war club**（ダイヤ付き棍棒）<br>`FOYER` の `umbrella stand` を調べ `cane` 発見 → `rub cane`（または `remove paint`） |
| **Yellow** (`FRIEND-C` = 1) | **Tamara Lynd** (`tamara`) | **Tamara Lynd**（Iris に罪を着せようとした） | Tamara は Jack の愛を失うことを恐れ、ライバル視していた Iris を陥れるため、Deirdre の幽霊を装って自作自演の襲撃（詐欺）を仕組んだ。Deirdre の死は純粋な事故。 | 塔 1 階 `Tamara's bedroom` のベッドの下 (`look under bed`) → `Tamara's receipt`（毒蛇購入の領収書）を `read receipt` | 秘密通路の `Iris's entrance` (`IRIS-CLOSET`) で `ghost costume` を発見し **`examine costume`**（ウィッグに Tamara の赤毛が付着） | **black pearl necklace**（黒真珠）<br>`BASEMENT` の `loose bricks` を `move bricks` → `in` (`CRYPT`) → `examine skeleton` |
| **Blue** (`PAINTER-C` = 3) | **Vivien Pentreath** (`vivien`) | **Vivien Pentreath** | Vivien は Deirdre に強く執着しており、Deirdre の事故死を Jack に見捨てられた末の自殺と思い込んで逆恨み。Jack に罪を認めさせ、新しい婚約者 Tamara を脅かすため幽霊に変装（殺人未遂）。 | 2 階 `Vivien's bedroom` の `wooden box` を調べる（2 回目）→ `Vivien's diary` を `read diary` | 同 `wooden box` を調べる（3 回目）で `ghost costume` 発見（または 0:00 以降の幽霊を `aerosol device` で気絶させ `undress ghost`） | **fossil skull**（北京原人の頭蓋骨）<br>塔最上階 `fighting deck` (`DECK`) の `bell` を `examine bell` |
| **Green** (`DOCTOR-C` = 4) | **Dr. Wendish** (`wendish`) | **Dr. Wendish** | Deirdre が祖父の死因を Wendish の非人道的な人体実験と疑い Lionel に調査を依頼。気づいた Wendish が 2 人を殺害し、財宝（秘薬 Moonmist）を探し出すため幽霊を装っていた。 | 塔 1 階 `Library` の `bookcase` を調べる (`examine bookcase`) → `lab notebook` を `take notebook` → `read notebook` | 2 階 `Wendish's bedroom` の `medical kit` を調べる（2 回目）で `ghost costume` 発見（または 0:00 以降の幽霊を `aerosol device` で気絶させ `undress ghost`） | **Moonmist**（秘薬）<br>塔 1 階 `Office` の机の上の `inkwell` を `examine inkwell`（**絶対に飲まないこと！**） |

---

## 2. 絶対に守るべきこと・即死／失敗パターン（確認済み）

| 事項・行為 | 結果・理由 |
|---|---|
| **午前 7:00（`PRESENT-TIME > 1139`）を迎える** | `TIMES-UP`: 夜明けとともに警察が到着し捜査を引き継ぐ → **時間切れ終了**（開始は 19:00 = 420、制限時間は 12 時間 = 720 分）。 |
| **Red で幽霊（Deirdre）に攻撃・逮捕・怒鳴る、または 1 ターン放置する** | `GHOST-FLEES` / `I-SHOT`: Deirdre が逃走して `LIMBO` に消え、二度と戻らない → **幽霊特定不能で詰み**。出会う前に必ず `save` し、出会ったら即座に `ask ghost about jack` / `hello ghost` / `smile at ghost` 等の友好的行動をとる。 |
| **Blue / Green で吹き矢 (`blowgun`) を構えられた状態で同じ部屋に留まる** | `I-SHOT`: 次のターンに毒矢で撃たれて（または絞殺されて）**即死**。対策：① 別の部屋へ逃げる（秘密通路等）、② 執事がキッチンに残した **`aerosol device` (`MACE`)** で撃退する（`push button` / `shoot <相手> with spray`）、③ あらかじめ `VIVIEN-BOX` / `WENDISH-KIT` から吹き矢を回収しておく。 |
| **Green で `Moonmist` を飲む (`drink moonmist`)** | 舌→胃→脳と麻痺して**即死**（`colors.zil:429-433`）。また `pour moonmist` すると蒸発して消滅する。 |
| **`fighting deck` (`DECK`) や `path` (`LOVER-PATH`) で `jump` (`V-LEAP`)** | 転落して**即死**（`verbs.zil:2531-2533`）。 |
| **夕食後、他人の寝室に 6 ターン以上長居する** | `ENTER-ROOM` → `I-DISCOVERED` (6 ターン): 部屋の持ち主が戻ってきて通常ドアを塞ぐ。Blue / Green の犯人が吹き矢を持っていればその場で `SETUP-SHOT` → 次ターン即死の危険あり。**夕食前（20:00 前）なら `I-DISCOVERED` は発動しない**ので安全に探索できる。 |
| **夕食のライオネルの録音終了前に `arrest` する** | 失敗終了にはならないが `(Bad form. Wait until after dinner.)` と弾かれる。 |
| **誤認逮捕・証拠不足での `arrest`** | *Deadline* と異なり**ゲームオーバーにはならない**（時間も消費しない）。ただし犯人に証拠を突きつける (`show`/`confront`) のを Blue/Green の自室で 2 人きりの時に行うと、吹き矢で反撃される。 |
| **暗闇での行動** | 秘密通路・地下室・ダンジョン・塔 2 階の一部は暗い（`ONBIT` なし）。**キッチンの `brass lantern` (`LAMP`)** を取って `turn on lantern` すれば永久光源として使える（電池切れなし）。 |

※注意: ダンジョンにある **`iron maiden`（鉄の処女）** は即死罠ではなく、`enter iron maiden` で地下の `secret tomb` (`TOMB`) と行き来する**昇降機（エレベーター）**である（`tower.zil:394-430`）。

---

## 3. 基本システム（確認済み）

### 時間管理とタイムライン
- 開始時刻は **19:00（7:00 PM）**（`PRESENT-TIME = 420`）。通常コマンド 1 回 = **1 分**。
- 制限時刻は **翌朝 7:00（`PRESENT-TIME = 1140`）**。
- `time` で現在時刻を確認。
- `wait`（既定 10 分）、`wait 5` / `wait for 5`（指定分数）、`wait until 8` / `wait until 12`（指定時刻まで）、`wait for <人物名>` / `wait for ghost`（対象が来るまで）が使える。

| 時刻 (`PRESENT-TIME`) | 自動イベント（`misc.zil` / `goal.zil`） |
|---|---|
| **19:00** (`420`) | ゲーム開始（`DRIVEWAY` の車内）。正門の `dragon's eye` を押す（または `honk horn`）と名前・色の入力開始。 |
| **19:50** (`470`) | `I-DINNER`: 夕食 10 分前。全員が `DINING-ROOM` へ向かい始める。 |
| **20:00** (`480`) | 執事 Bolitho がディナーベルを鳴らし、**キッチンに `aerosol device` (`MACE`) を落として**使用人全員と城を去る（`BUTLER-LEAVES`）。全員が揃うと夕食開始（`I-DINNER-SIT`）。 |
| **20:30** (`510`) | `I-LIONEL-SPEAKS`: `DINING-ROOM` のライオネルの胸像から録音メッセージが 6 回に分けて再生される（2 分おき、約 20:40 終了）。この中で `CLUE-1`（パンチボウルの下）と `CLUE-2`（所持者は Red のみ Vivien、他は Jack）の存在が明かされる。終了後 `I-WITHDRAW` で全員が `SITTING-ROOM` へ移動し、**これ以降 `arrest` が可能になる**。 |
| **20:50 頃** | `I-SEARCH`: `SEARCHER`（Red は Jack、他は犯人）が 19 分おきに城内を探索して回る。 |
| **0:00** (`720`) | `I-BEDTIME`: 就寝時刻。全員が自室へ戻り**ドアを施錠**する。ここで Tamara が秘密扉に気づくイベントが起きることがある。また **Red / Blue / Green では幽霊（`GHOST-NEW`）が秘密通路の徘徊を開始する**（Yellow では Tamara は徘徊しない）。 |
| **7:00** (`1140`) | `TIMES-UP`: 警察が到着しゲーム終了。 |

### 冒頭の名前・性別・好きな色と服装システム
- 正門インターホンで `TITLE + FIRST NAME + LAST NAME`（例: `Mr. John Smith` / `Ms. Jane Doe`）を答える。
  - `Mr.` / `Sir` / `Lord` 等なら男性、`Ms.` / `Mrs.` / `Miss` / `Lady` / `Dame` 等なら女性、`Dr.` や敬称なしなら性別不明扱い。
  - 性別によって登場人物のセリフや `CLUE-1` の絵柄の描写が一部変わるが、**4 バリエーションの解法・財宝の場所は共通**。
- 続けて好きな色（`red` / `yellow` / `blue` / `green`）を答えると `DO-VARIATION` が実行され、自分の車・寝室・服の色もその色に変わる。
- 服装・入浴: 自分の寝室 (`YOUR-ROOM`) で `luggage` を開けると `dinner outfit` 等が入っている。浴室 (`YOUR-BATHROOM`) で服を脱いで `bathe` すると清潔 (`WASHED`) になり、`wear dinner outfit` で夕食に出ると好評を得る（クリア必須ではない）。なお服を着ていない状態では `YOUR-ROOM` から出られない。

### 会話・尋問・逮捕コマンド
- 質問: `ask <人物> about <話題/物>`（例: `ask jack about lionel`, `ask vivien about second clue`）
- 提示: `show <物> to <人物>`
- 依頼・命令: `<人物>, <命令>`（例: `jack, give me second clue` / `tamara, follow me`）
- 逮捕・告発: `arrest <人物>`（同義語: `accuse`, `capture`）。同じ部屋にいる必要がある。
- 幽霊の撃退・正体暴き（Blue / Green）: `push button`（`aerosol device` を所持）または `shoot ghost with spray` → 気絶した幽霊に `undress ghost`（同義語: `unmask`, `strip`）。
- 証拠の床探索（任意・補助手がかり）: `DRAWING-ROOM` 等で `search floor` → 「続けますか？」に `y` を答えると `tiny red jewel` や `contact lens` が見つかる（`START-SEARCH` / `I-FOUND-IT`）。

---

## 4. マップ構造（Tresyllian Castle・確認済み）

### 屋外・居住棟 1 階（Ground Floor）
```
                     [DRIVEWAY] (開始地点・車)
                         | s (front gate: dragon's eyeを押す)
                    [COURTYARD] -------- e -------- [MAZE] --(任意方向/in)-- [GARDEN] (pond)
                     /       \
                   sw         s (front door)
                  /            \
      (塔1F)[OLD-GREAT-HALL]  [FOYER] (umbrella stand)
                  |             |  \
                  e             s   e
                  |             |    \
             [JUNCTION]      [GREAT-HALL] --- e --- [DRAWING-ROOM]
             /       \       (armor / u:Gallery)    (tapestry→秘密扉)
            d         e       /
           /           \     w
    (塔地下)[BASEMENT]  [CORR-1]
                         /    \
                        n      s
                       /        \
               [DINING-ROOM]   [SITTING-ROOM]
               (punchbowl,     (piano, writing desk,
                bust)           window seat→秘密扉)
                  |
                  w
             [BACKSTAIRS] (w:秘密扉)
                  |
                  d
              [KITCHEN] (brass lantern, 20:00以降 aerosol device)
                  |
                  w
             [BASEMENT] (塔地下へ接続)
```

### 居住棟 2 階（Gallery Floor）
```
  [IAN-ROOM] --e-- [WEST-HALL] --e-- [HYDE-ROOM]      [WENDISH-ROOM] --e-- [EAST-HALL] --e-- [IRIS-ROOM]
                       |                                                       |
                      se/s                                                    sw/s
                        \                                                     /
          [VIVIEN-ROOM] --e-- [GALLERY (ancestor paintings/peephole)] --e-- [YOUR-ROOM] --n-- [YOUR-BATHROOM]
                                         |
                                         d (GREAT-HALLへ)
```
※ `VIVIEN-ROOM` のドアは初期状態で閉じている（施錠なし、`open vivien's door` で開く）。

### 塔（Tower Keep：地下・地上階・1 階・2 階・屋上）
```
[屋上 / Top]     [DECK] (bell)
                   | d/s
[塔 2 階]        [CORR-3] --- n --- [GAME-ROOM] (rhino head, glass eye)
                 /  |   \
                s   se   w/d
               /    |     \
        [CHAPEL] [LUMBER-ROOM]   [CORR-2] (Jack扉にcrest)
        (stained  (chest→handle   /  |  |  \   \
         window)   →peephole)   nw  w  ne  e   se
                                /   |   |   \    \
                           [STUDY] [JACK] [LIB] [OFFICE] [TAMARA]
                                           |    (inkwell) (bed)
                                           | n/d
[塔地上階]                        [OLD-GREAT-HALL] --- e --- [JUNCTION]
                                                               | d/n
[塔地下]      [LOVER-PATH] --se/in(priest hole)-- [DUNGEON] --e-- [BASEMENT] --e-- [KITCHEN]
              (海岸の崖道)                         (iron maiden     (well, wine rack,
                                                    ↓昇降機)         loose bricks→in)
                                                    [TOMB]          [CRYPT] (Yellowのみ)
                                                    (coffin)        (skeleton)
```

### 秘密の通路ネットワーク（Secret Passages）
```
[塔側]
  (JACK-ROOM) ←→ [SECRET-LANDING-JACK] --e/d-- [PASSAGE-1] --e/d-- [SITTING-PASSAGE] (↑SITTING-ROOMからは一方通行落下)
                                                   | u
  (TAMARA-ROOM) ←→ [SECRET-LANDING-TAM] -----------+
                     | n/ne          \ e
  (LIBRARY) ←→ [SECRET-LANDING-LIB]   [SECRET-VIVIEN-PASSAGE] (n:VIVIEN-ROOM)
                 | d           \ e           | e
         [DINING-PASSAGE]   [SECRET-IAN]   [YOUR-CLOSET] (w:YOUR-ROOM / d:DRAWING-CLOSET←n→DRAWING-ROOM)
         (e:BACKSTAIRS)     (s:IAN-ROOM)     | n
                                | e        [IRIS-CLOSET] (w:IRIS-ROOM)
                            [HYDE-CLOSET]    | n
                            (s:HYDE-ROOM)  [WENDISH-CORNER] (s:WENDISH-ROOM)
                                | e          | w
                                +--- [MIDPOINT] ---+
                                         | s
                                  [GALLERY-CORNER] (peephole→GALLERY)
```

### 秘密扉の開け方一覧（確認済み）
※秘密通路側からは、どの扉も **`pull lever`**（または `push lever`）で開閉できる（`SITTING-PASSAGE` のみ天井高で上れない）。

| 部屋 | 通路側の接続先 | 部屋側からの開け方 |
|---|---|---|
| `YOUR-ROOM` | `YOUR-CLOSET` (e) | `examine wall mirror` → `push switch` |
| `TAMARA-ROOM` | `SECRET-LANDING-TAM` (se) | `turn bedpost`（または `turn bed`） |
| `JACK-ROOM` | `SECRET-LANDING-JACK` (sw) | `turn telescope`（または `move telescope`） |
| `LIBRARY` | `SECRET-LANDING-LIB` (ne) | `take history book`（または `move history book`） |
| `VIVIEN-ROOM` | `SECRET-VIVIEN-PASSAGE` (s) | `turn figurine` |
| `WENDISH-ROOM` | `WENDISH-CORNER` (n) | `lift candle`（または `turn sconce`） |
| `IAN-ROOM` | `SECRET-IAN-PASSAGE` (n) | `turn andiron` |
| `SITTING-ROOM` | `SITTING-PASSAGE` (落下) | `sit on window seat` → `turn wyvern`（※一方通行） |
| `IRIS-ROOM` / `HYDE-ROOM` / `DRAWING-ROOM` / `BACKSTAIRS` | 各秘密通路 | **部屋側からは開けられない**。秘密通路側から `pull lever` で開く（`DRAWING-ROOM` は `look behind tapestry` で扉の存在だけ確認可）。 |
| `DUNGEON` ↔ `LOVER-PATH` | `PRIEST-DOOR` (nw) | `pull lever`（双方にレバーあり） |
| `BASEMENT` ↔ `CRYPT` | `HOLE-IN-WALL` (in) | Yellow のみ: `move bricks` → `in` |
| `DUNGEON` ↔ `TOMB` | `IRON-MAIDEN` | `enter iron maiden`（乗ると昇降する） |

---

## 5. 共通の導入手順（到着〜夕食・19:00〜20:40）

全 4 バリエーション共通の開幕手順。

```text
> push dragon's eye
  （名前を聞かれる）
> Mr. John Smith        （または Ms. Jane Doe 等、敬称＋姓名）
> y
  （好きな色を聞かれる → 攻略したい色を入力）
> red                   （または yellow / blue / green）
> y
> s                     （車で COURTYARD へ入る。Tamara が出迎える）
> yes                   （または任意の返答。Tamara の質問に答える）
> s                     （FOYER へ。Jack が登場）
```

### 夕食前に済ませておくと便利な準備
- **光源の確保**: `FOYER` → `s` (`GREAT-HALL`) → `w` (`CORR-1`) → `n` (`DINING-ROOM`) → `w` (`BACKSTAIRS`) → `d` (`KITCHEN`) で **`take lantern`** → **`turn on lantern`**。
- **任意（身支度）**: 2 階 `YOUR-ROOM` で着替え・入浴を済ませたい場合は、`GREAT-HALL` → `u` (`GALLERY`) → `e` (`YOUR-ROOM`)。執事 Bolitho が荷物を運んでくれているので、`open luggage` → `wear dinner outfit`（入浴するなら `undress` → `n` → `bathe` → `s` → `wear dinner outfit`）。
- **夕食（20:00〜20:40）**:
  - 19:50 頃に夕食の案内が出るので `DINING-ROOM` へ移動し、`wait` して夕食と **ライオネルの録音メッセージ** を最後まで聞く（終了すると自動で `SITTING-ROOM` へ移動する）。
  - 20:00 に執事 Bolitho が去った後、`KITCHEN` に行くと **`aerosol device` (`MACE`)** が落ちているので、Blue / Green では必ず **`take device`** しておく。
  - なお、夕食の直前に各バリエーションの証拠・財宝を先に回収しておいても問題ない（夕食前は `I-DISCOVERED` が発動しないため、他人の寝室を安全に調べられる）。

---

## 6. バリエーション別 攻略手順

### 6.1 Red（赤）: 真犯人 Lord Jack / 幽霊 Deirdre / 財宝 war club

**手がかりの連鎖（参考）**:
- `CLUE-1`（`DINING-ROOM` パンチボウルの下）: 棍棒を持つ王とダイヤの絵（＝`war club`）
- `CLUE-2`（`Vivien` が所持。`ask vivien about second clue`）: 「禁断の果実、かつて庭にあり今はガラスの中に」→ `CHAPEL` のステンドグラス
- `CLUE-3`（`CHAPEL` の `examine stained-glass window`）: 「リンゴの一口でエヴァは庭園から追われた」→ `GARDEN`
- `CLUE-4`（`GARDEN` で `search garden`）: 「雨の中、カイン (CAIN → cane)」→ `FOYER` の傘立ての杖

**最短クリア手順**:
1. **財宝（`war club`）の回収**（いつでも可）:
   - `FOYER` で `examine umbrella stand` → `take cane` → `rub cane`（または `examine cane` → `remove paint`）。
   - `war club` 発見 → **条件 3 達成**！
2. **決定的証拠（`secret tape recorder`）の再生と Jack 逮捕**（夕食終了後 20:40〜）:
   - `CORR-1` → `w` (`JUNCTION`) → `w` (`OLD-GREAT-HALL`) → `u` (`CORR-2`)。
   - `CORR-2` で **`remove crest`**（または `move crest`）→ `secret tape recorder` が露出。
   - **`play tape`** → ライオネル殺害の録音を再生 → `EVIDENCE-FOUND` 達成！
   - （※この時 Jack が同じ部屋にいれば即座に自白する。いなければ `SITTING-ROOM` 等で Jack を探して **`arrest jack`** → **条件 1 達成**！）
3. **幽霊（Deirdre）と出会い正体を確認**（深夜 0:00 以降）:
   - まずは 23:55 頃まで時間を進める。おすすめ待機場所は **`KITCHEN`** または **`BASEMENT`**（または `YOUR-CLOSET`）。
     - `CORR-2` → `d` (`OLD-GREAT-HALL`) → `e` (`JUNCTION`) → `d` (`BASEMENT`)。`lantern` を点灯しておく。
   - **`wait until 12`** → Iris (`DEB`) が自室に戻り就寝すると、Deirdre (`GHOST-NEW`) が `LOVER-PATH` → `DUNGEON` → `BASEMENT` へ歩いてくる。
   - **ここで `save` を強く推奨。**
   - `wait for ghost`（または `wait 1` / `look` で待機。数分以内に `BASEMENT` に現れる。来なければ `KITCHEN` や `YOUR-CLOSET` へ向かうルート上を確認）。
   - 幽霊が現れたら、**絶対に攻撃・逮捕せず**に友好的に話しかける:
     - **`ask ghost about jack`**（または `hello ghost` / `smile at ghost`）
   - Deirdre が自分の生存と真相を語り、`CONGRATS ,COSTUME` が発動 → **条件 2 達成** → **クリア！**

---

### 6.2 Yellow（黄）: 真犯人 Tamara / 幽霊 Tamara / 財宝 black pearl necklace

**手がかりの連鎖（参考）**:
- `CLUE-1`（パンチボウルの下）: パール・ベイリーの写真（または黒水へ潜るダイバー）→ 黒真珠のネックレス
- `CLUE-2`（`Jack` が所持）: ポー『鐘 (The Bells)』の引用 → 屋上 `DECK` の `bell`
- `CLUE-3`（`DECK` で `examine bell`）: ポー『アナベル・リー』「海辺の墓」→ `DUNGEON` の `enter iron maiden` → `TOMB` の `coffin`
- `CLUE-4`（`TOMB` で `examine coffin`）: ポー『アモンティリャードの樽』→ ワインセラーのある `BASEMENT` の緩んだレンガ

**最短クリア手順**:
1. **光源の確保**:
   - `KITCHEN` で `take lantern` → `turn on lantern`。
2. **財宝（`black pearl necklace`）の回収**（いつでも可）:
   - `KITCHEN` → `w` (`BASEMENT`)。
   - **`move bricks`** → 壁に穴（`brick hole`）が開く。
   - **`in`** (`CRYPT`) → **`examine skeleton`** → `black pearl necklace` 発見 → **条件 3 達成**！
   - `out` (`BASEMENT`) → `u` (`JUNCTION`) → `e` (`CORR-1`) → `e` (`GREAT-HALL`)。
3. **幽霊衣装（`ghost costume`）の発見と確認**（いつでも可）:
   - `GREAT-HALL` → `u` (`GALLERY`) → `e` (`YOUR-ROOM`)。
   - `examine wall mirror` → `push switch` → `e` (`YOUR-CLOSET`) → `n` (`IRIS-CLOSET`)。
   - `IRIS-CLOSET` で **`examine costume`**（**必ず `costume` または `wig` を調べること**。`gown` だけだと赤毛に気づかずフラグが立たない）→ Tamara の赤毛を発見し `CONGRATS ,COSTUME` → **条件 2 達成**！
4. **決定的証拠（`Tamara's receipt`）の入手**（夕食前が安全）:
   - 秘密通路からそのまま行ける: `IRIS-CLOSET` → `s` (`YOUR-CLOSET`) → `s` (`SECRET-VIVIEN-PASSAGE`) → `w` (`SECRET-LANDING-TAM`) → `pull lever` → `w` (`TAMARA-ROOM`)。
   - （通常ルートなら `CORR-2` → `se` (`TAMARA-ROOM`)）
   - `TAMARA-ROOM` で **`look under bed`**（または `search bed`）→ `Tamara's receipt` を自動入手。
   - **`read receipt`** → `EVIDENCE-FOUND` 達成！
   - ※補足: `JEWELRY-CASE` の `earring` と `tiny red jewel` を比較しても「証拠を見つけた」と表示されるが、それだけでは `EVIDENCE-FOUND` にならない。必ず `Tamara's receipt` を読むこと。
5. **夕食の完了と Tamara 逮捕**:
   - `DINING-ROOM` で夕食＆ライオネルの録音を最後まで聞く（20:40 頃、`SITTING-ROOM` へ移動）。
   - Tamara と同じ部屋（`SITTING-ROOM` 等）で **`arrest tamara`** → **条件 1 達成** → **クリア！**

---

### 6.3 Blue（青）: 真犯人 Vivien / 幽霊 Vivien / 財宝 fossil skull

**手がかりの連鎖（参考）**:
- `CLUE-1`（パンチボウルの下）: 中国の官服を着た骸骨 → 北京原人の頭蓋骨（`LUMBER-ROOM` の `magazine` にも記事あり）
- `CLUE-2`（`Jack` が所持）: 3 つの穴埋め（song / maiden / wine）→ `SITTING-ROOM` の `music`（"SUIT" に星）、`DRAWING-ROOM` の `tapestry`（乙女の "ARM" に星）、`BASEMENT` の `bottle`（"OUR" に星）→ 合わせて **SUIT ARMOUR** (`GREAT-HALL` の鎧)
- `CLUE-3`（`GREAT-HALL` で `open armor` / `search armor`）: 穴埋め "alloy / bronze / clamor" → `DECK` の `bell`

**最短クリア手順**:
1. **財宝（`fossil skull`）の回収**（いつでも可）:
   - `CORR-1` → `w` (`JUNCTION`) → `w` (`OLD-GREAT-HALL`) → `u` (`CORR-2`) → `u` (`CORR-3`) → `u` (`DECK`)。
   - `DECK` で **`examine bell`**（または `look in bell`）→ `fossil skull` 発見 → **条件 3 達成**！
2. **決定的証拠（`Vivien's diary`）＆ 幽霊衣装（`ghost costume`）の入手**（**夕食前が最も安全**）:
   - `GREAT-HALL` → `u` (`GALLERY`) → `open vivien's door` → `w` (`VIVIEN-ROOM`)。
   - `VIVIEN-ROOM` で `wooden box` を **3〜4 回調べる**（`SEARCH-KIT-BOX` は 1 回につき 1 アイテムずつ発見する仕様）:
     1. `examine wooden box` → `small plastic box` (`LENS-BOX`) 発見
     2. `examine wooden box` → **`Vivien's diary`** 発見 → `take diary` → **`read diary`**（`EVIDENCE-FOUND` 達成！）
     3. `examine wooden box` → **`ghost costume`** 発見（この時点で `CONGRATS ,COSTUME` → **条件 2 達成**！念のため `examine costume` も可）
     4. （安全策）`examine wooden box` → `blowgun` 発見 → `take blowgun`（Vivien の武器を無力化）
   - ※もし夕食後に `VIVIEN-ROOM` へ入る場合は、6 ターン以内に退室するか、あらかじめ `KITCHEN` で `aerosol device` を取っておくこと。
3. **夕食の完了と Vivien 逮捕**:
   - `DINING-ROOM` で夕食＆ライオネルの録音を最後まで聞く（20:40 頃、`SITTING-ROOM` へ移動）。
   - Vivien と同じ部屋（`SITTING-ROOM` 等）で **`arrest vivien`** → **条件 1 達成** → **クリア！**

---

### 6.4 Green（緑）: 真犯人 Dr. Wendish / 幽霊 Dr. Wendish / 財宝 Moonmist

**手がかりの連鎖（参考）**:
- `CLUE-1`（パンチボウルの下）: 吹き矢を構えるアマゾンの狩人（または霧に包まれた城）→ 秘薬 `Moonmist`（`OFFICE` の `journal` に詳細あり）
- `CLUE-2`（`Jack` が所持）: 「最初の文字は 'I'。見えない 'eye' を探せ」→ `GAME-ROOM` のサイの剥製 (`rhino head`) の義眼 (`glass eye`)
- `CLUE-3`（`GAME-ROOM` で `examine rhino head` → `take glass eye`）: 「2 番目の文字は never にあり ever にない ('N')。隠れた 'end' にある」→ 秘密通路の `GALLERY-CORNER` (`dead end`)
- `CLUE-4`（`GALLERY-CORNER` で `take fourth clue`）: 「3 番目の文字は knight の発音しない文字 ('K')。合わせると毒のある手紙に使うもの (INK)」→ `OFFICE` の `inkwell`

**最短クリア手順**:
1. **決定的証拠（`lab notebook`）の入手**（いつでも可）:
   - `OLD-GREAT-HALL` → `u` (`CORR-2`) → `ne` (`LIBRARY`)。
   - `LIBRARY` で **`examine bookcase`** → **`lab notebook`** (`WENDISH-BOOK`) 発見。
   - **`take notebook`** → **`read notebook`** → `EVIDENCE-FOUND` 達成！
2. **財宝（`Moonmist`）の回収**（いつでも可）:
   - `LIBRARY` → `out` (`CORR-2`) → `e` (`OFFICE`)。
   - `OFFICE` で **`examine inkwell`**（または `look in inkwell`）→ **`Moonmist`** 発見 → **条件 3 達成**！
   - **警告**: 絶対に `drink moonmist` / `pour moonmist` しないこと！
3. **幽霊衣装（`ghost costume`）の発見**（**夕食前が最も安全**）:
   - `GREAT-HALL` → `u` (`GALLERY`) → `ne` (`EAST-HALL`) → `w` (`WENDISH-ROOM`)。
   - `WENDISH-ROOM` で `medical kit` を **2〜3 回調べる**:
     1. `examine medical kit` → `small plastic box` (`LENS-BOX`) 発見
     2. `examine medical kit` → **`ghost costume`** 発見（この時点で `CONGRATS ,COSTUME` → **条件 2 達成**！念のため `examine costume` も可）
     3. （安全策）`examine medical kit` → `blowgun` 発見 → `take blowgun`
   - ※もし夕食後に `WENDISH-ROOM` へ入る場合は、6 ターン以内に退室するか、あらかじめ `KITCHEN` で `aerosol device` を取っておくこと。
4. **夕食の完了と Dr. Wendish 逮捕**:
   - `DINING-ROOM` で夕食＆ライオネルの録音を最後まで聞く（20:40 頃、`SITTING-ROOM` へ移動）。
   - Dr. Wendish と同じ部屋（`SITTING-ROOM` 等）で **`arrest wendish`** → **条件 1 達成** → **クリア！**

---

## 7. 重要アイテム早見表（確認済み）

| アイテム | 場所 | 用途 |
|---|---|---|
| `brass lantern` (`LAMP`) | `KITCHEN` | 永久光源（電池切れなし）。秘密通路・地下・塔 2 階の探索に必須 |
| `aerosol device` (`MACE`) | 執事 Bolitho 所持 → 20:00 以降 `KITCHEN` | 吹き矢で襲われた際や幽霊（Blue/Green）を気絶させる護身武器（`push button` / `shoot X with spray`） |
| `family crest` / `secret tape recorder` | `CORR-2`（Jack の部屋扉） | **Red** の決定的証拠。`remove crest` → `play tape` |
| `cane` → `war club` | `FOYER` の `umbrella stand` | **Red** の財宝。`rub cane` で塗装を剥がす |
| `Tamara's receipt` | `TAMARA-ROOM` のベッドの下 | **Yellow** の決定的証拠。`look under bed` → `read receipt` |
| `ghost costume` | Yellow: `IRIS-CLOSET`<br>Blue: `VIVIEN-BOX`<br>Green: `WENDISH-KIT` | 幽霊の正体証明。`examine costume` で髪の毛の色を確認（Red では Deirdre 本人が着用して 0:00 以降に出現） |
| `black pearl necklace` | `CRYPT` の `skeleton` | **Yellow** の財宝。`BASEMENT` で `move bricks` → `in` |
| `Vivien's diary` | `VIVIEN-ROOM` の `wooden box` | **Blue** の決定的証拠。`examine wooden box`（2 回目）→ `read diary` |
| `fossil skull` | `DECK` の `bell` | **Blue** の財宝。`examine bell` |
| `lab notebook` | `LIBRARY` の `bookcase` | **Green** の決定的証拠。`examine bookcase` → `read notebook` |
| `Moonmist` | `OFFICE` の `inkwell` | **Green** の財宝。`examine inkwell`（**飲用厳禁＝即死**） |
| `blowgun` | Yellow: `IRIS-CLOSET` / Blue: `VIVIEN-BOX` / Green: `WENDISH-KIT` | 犯人の武器。先に奪っておくと襲撃を防げる |
| `butler's note` / `maid's note` | 夕食テーブル → Jack / `SITTING-ROOM` の `writing desk` | 執事の置き手紙とメイド Gladys の退職メモ（犯人のヒント） |
