# MainMenu返り値設計書（MainMenu Errorlevel Reference Sheet）
作成日: 2025/07/07  
作成者: HedgeHog（Shoya）

---

## 🔧 モジュール定義

| モジュール名 | モジュールID範囲 | 備考                            |
|--------------|------------------|------------------------------|
| MainMenu     | `1000`〜`1099`   | メインメニューの返り値を管理    |
| SaveData     | `2000`〜`2099`   | セーブスロット選択UIモジュール返り値 |

---

## ✅ 選択肢ごとの返り値定義

### ◼ MainMenu（メインメニュー）

| エラーコード | 意味                     | 実行後ジャンプ先例       | 補足                              |
|--------------|--------------------------|----------------------------|-----------------------------------|
| `1000`       | Continue（続きから）     | `:Start_Continue`          | セーブデータ選択UIへ              |
| `1001`       | New Game（はじめから）   | `:Start_NewGame`           | セーブスロット選択画面へ         |
| `1002`       | Option（オプション）     | `:Label_Option`            | 未実装でもOK                      |
| `1099`       | Exit（ゲーム終了）       | `exit /b`                  | タイトルから直接終了             |

### ◼ SaveDataModule（セーブスロット選択）

#### CONTINUEモードの返り値

| エラーコード | 意味                             | 実行後ジャンプ先例     | 備考                    |
|--------------|----------------------------------|------------------------|-------------------------|
| `2031`       | キャンセルして戻る               | `:Label_MainMenu`      | `Q`キーでのキャンセル    |
| `2032`       | SaveData1 から続きプレイ         | `:ContinueGame 1`      |                         |
| `2033`       | SaveData2 から続きプレイ         | `:ContinueGame 2`      |                         |
| `2034`       | SaveData3 から続きプレイ         | `:ContinueGame 3`      |                         |

#### NEW GAMEモードの返り値

| エラーコード | 意味                             | 実行後ジャンプ先例        | 備考                        |
|--------------|----------------------------------|---------------------------|-----------------------------|
| `2041`       | SaveData1 に新規作成             | `:StartNewGame 1 Create`  | 空きスロット                |
| `2042`       | SaveData2 に新規作成             | `:StartNewGame 2 Create`  |                             |
| `2043`       | SaveData3 に新規作成             | `:StartNewGame 3 Create`  |                             |
| `2051`       | SaveData1 を上書きして新規作成   | `:StartNewGame 1 Overwrite` | セーブデータ上書き確認済 |
| `2052`       | SaveData2 を上書きして新規作成   | `:StartNewGame 2 Overwrite` |                             |
| `2053`       | SaveData3 を上書きして新規作成   | `:StartNewGame 3 Overwrite` |                             |
| `2099`       | キャンセルして戻る               | `:Label_MainMenu`          | `Q`キーなど                |

---

## 🛠 今後の拡張予定

| エラーコード | 想定機能               | 備考例                                      |
|--------------|------------------------|---------------------------------------------|
| `1010`       | DevCommandモード       | 開発中の隠しコマンド起動用（OPTIONから）    |
| `1020`       | Tutorial起動           | チュートリアル分岐用（NewGame前に分岐）     |
| `1080`〜     | ロード・バグ報告など   | ユーザー向けサポートメニュー機能用         |

---

## 🎯 推奨ジャンプ処理テンプレ

```batch
call "%cd_systems%\Display\MainMenu.bat"
if %errorlevel%==1000 goto :Start_Continue
if %errorlevel%==1001 goto :Start_NewGame
if %errorlevel%==1002 goto :Label_Option
if %errorlevel%==1099 exit /b

call "%cd_systems%\SaveSys\SaveDataModule.bat" %1
if %errorlevel%==2031 goto :Label_MainMenu
if %errorlevel%==2032 call :ContinueGame 1
if %errorlevel%==2033 call :ContinueGame 2
if %errorlevel%==2034 call :ContinueGame 3

if %errorlevel%==2041 call :StartNewGame 1 CreateNew
if %errorlevel%==2042 call :StartNewGame 2 CreateNew
if %errorlevel%==2043 call :StartNewGame 3 CreateNew

if %errorlevel%==2051 call :StartNewGame 1 Overwrite
if %errorlevel%==2052 call :StartNewGame 2 Overwrite
if %errorlevel%==2053 call :StartNewGame 3 Overwrite

if %errorlevel%==2099 goto :Label_MainMenu
```

---

## 💬 命名ルール

- **先頭1桁（1xxx）**: MainMenuの返り値
- **先頭2桁（20xx）**: SaveDataModuleの返り値（MainMenuの一部として管理）
- **下2桁（xx00〜xx99）**: 個別アクション識別子
- **特別コード `x099`** は「戻る・キャンセル・終了」に使うこと

---

## 🧩 その他

- この設計書に基づいて `Display\MainMenu.bat` や `SaveSys\SaveDataModule.bat` 側でも `exit /b xxxx` のように **責任を持って返り値を明示すること**
- エラーコードの衝突を避けるため、**番号のセグメント分割（1000台 / 2000台）を厳守すること**

---

## 📁 保存場所案

```
ProjectRoot/
└── Docs/
    └── ErrorCode_MainMenu.md
```

