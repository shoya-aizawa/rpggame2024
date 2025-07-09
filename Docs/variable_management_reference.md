# 変数管理設計書（Variable Management Reference Sheet）
作成日: 2025/07/09  
作成者: HedgeHog（Shoya）

---

## 🔧 モジュール定義

| モジュール名 | 変数プレフィックス | 備考                            |
|--------------|------------------|------------------------------|
| MainMenu     | `mm_`            | メインメニュー関連変数         |
| SaveData     | `sd_`            | セーブデータ関連変数           |
| Player       | `player_`        | プレイヤーステータス関連       |
| System       | `cd_`            | システム・パス関連変数         |
| Battle       | `battle_`        | バトルシステム関連変数         |
| Debug        | `debug_`         | デバッグ関連変数               |
| Display      | `esc`            | 表示・UI関連変数               |
| Global       | `while_space_`   | 汎用スペース変数               |

---

## ✅ システム基盤変数

### ◼ パス管理変数（cd_系）

| 変数名 | 値の例 | 意味 | 使用箇所 |
|--------|--------|------|----------|
| `cd_enemydata` | `%cd%\EnemyData` | 敵データフォルダパス | InitializeModule.bat |
| `cd_itemdata` | `%cd%\ItemData` | アイテムデータフォルダパス | InitializeModule.bat |
| `cd_newgame` | `%cd%\NewGame` | 新規ゲームフォルダパス | InitializeModule.bat |
| `cd_playerdata` | `%cd%\PlayerData` | プレイヤーデータフォルダパス | InitializeModule.bat |
| `cd_savedata` | `%cd%\SaveData` | セーブデータフォルダパス | InitializeModule.bat |
| `cd_sounds` | `%cd%\Sounds` | サウンドフォルダパス | InitializeModule.bat |
| `cd_stories` | `%cd%\Stories` | ストーリーフォルダパス | InitializeModule.bat |
| `cd_stories_maps` | `%cd%\Stories\Maps` | マップデータフォルダパス | InitializeModule.bat |
| `cd_systems` | `%cd%\Systems` | システムフォルダパス | InitializeModule.bat |
| `cd_systems_debug` | `%cd%\Systems\Debug` | デバッグツールフォルダパス | InitializeModule.bat |
| `cd_systems_display` | `%cd%\Systems\Display` | 表示システムフォルダパス | InitializeModule.bat |
| `cd_systems_savesys` | `%cd%\Systems\SaveSys` | セーブシステムフォルダパス | InitializeModule.bat |

### ◼ 表示・UI関連変数

| 変数名 | 値の例 | 意味 | 使用箇所 |
|--------|--------|------|----------|
| `esc` | `\033` | ANSIエスケープシーケンス | 全バッチファイル |
| `while_space_1` | ` ` | 1文字分のスペース | WhileSpaceVariable_Initialize.bat |
| `while_space_2` | `  ` | 2文字分のスペース | WhileSpaceVariable_Initialize.bat |
| `while_space_3` | `   ` | 3文字分のスペース | WhileSpaceVariable_Initialize.bat |
| `while_space_40` | `                                        ` | 40文字分のスペース | WhileSpaceVariable_Initialize.bat |
| `while_space_esc_1` | `\033[ ` | エスケープシーケンス付き1文字スペース | WhileSpaceVariable_Initialize.bat |

### ◼ セーブシステム制御変数

| 変数名 | 値の例 | 意味 | 使用箇所 |
|--------|--------|------|----------|
| `autosave` | `true/false` | オートセーブ実行フラグ | InitializeModule.bat |
| `manualsave` | `true/false` | 手動セーブ実行フラグ | InitializeModule.bat |
| `newgame` | `true/false` | 新規ゲーム開始フラグ | InitializeModule.bat |
| `continue` | `true/false` | 継続プレイフラグ | InitializeModule.bat |

---

## ✅ メインメニューモジュール変数

### ◼ MainMenuModule.bat

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `mm_retcode` | `1000-1099` | メインメニュー返り値格納 | エラーレベル設計書と連携 |
| `current_selected_menu` | `1-4` | 現在選択中のメニュー項目 | 1=NewGame, 2=Continue, 3=Settings, 4=Quit |
| `max_menu_items` | `4` | メニュー項目の最大数 | メニュー項目数制御 |
| `menu_1_color` | `7` | NewGameメニューの色コード | カラーコード値 |
| `menu_2_color` | `32` | Continueメニューの色コード | カラーコード値 |
| `menu_3_color` | `32` | Settingsメニューの色コード | カラーコード値 |
| `menu_4_color` | `32` | Quitメニューの色コード | カラーコード値 |
| `hidden_sequence` | `XYZ` | 隠しコマンドシーケンス | デバッグモード起動用 |

### ◼ デバッグ関連変数（MainMenu）

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `debug_mainmenu` | `0/1` | メインメニューデバッグフラグ | 0=OFF, 1=ON |
| `key_log_count` | `0-999` | キー押下回数カウント | デバッグ用 |
| `key_log_line_1` | `[12:34:56] #1 W(UP)` | キー押下履歴1行目 | デバッグ用 |
| `key_log_line_2` | `[12:34:57] #2 S(DOWN)` | キー押下履歴2行目 | デバッグ用 |
| `key_log_line_3` | `[12:34:58] #3 F(SELECT)` | キー押下履歴3行目 | デバッグ用 |
| `key_log_line_4` | `[12:34:59] #4 Q(BACK)` | キー押下履歴4行目 | デバッグ用 |
| `key_log_line_5` | `[12:35:00] #5 XYZ(DEBUG)` | キー押下履歴5行目 | デバッグ用 |
| `RPG_DEBUG_STATE` | `0/1` | 環境変数デバッグ状態 | モジュール間継承用 |
| `RPG_DEBUG_KEYLOG_COUNT` | `0-999` | 環境変数キーログカウント | モジュール間継承用 |
| `RPG_DEBUG_LOG1` | `[時刻] #回数 キー名` | 環境変数キーログ1 | モジュール間継承用 |
| `RPG_DEBUG_LOG2` | `[時刻] #回数 キー名` | 環境変数キーログ2 | モジュール間継承用 |
| `RPG_DEBUG_LOG3` | `[時刻] #回数 キー名` | 環境変数キーログ3 | モジュール間継承用 |
| `RPG_DEBUG_LOG4` | `[時刻] #回数 キー名` | 環境変数キーログ4 | モジュール間継承用 |
| `RPG_DEBUG_LOG5` | `[時刻] #回数 キー名` | 環境変数キーログ5 | モジュール間継承用 |

---

## ✅ セーブデータモジュール変数

### ◼ SaveDataSelector.bat

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `current_selected_slot` | `1-12` | 現在選択中のセーブスロット | 実働は3つ |
| `max_available_slots` | `3` | 利用可能スロット数 | 現在の仕様 |
| `max_total_slots` | `12` | 総スロット数 | 将来拡張予定 |
| `slots_per_row` | `4` | 1行あたりのスロット数 | UI配置用 |
| `selector_mode` | `CONTINUE/NEWGAME` | セレクターモード | 動作モード識別 |
| `debug_selector` | `0/1` | セレクターデバッグフラグ | 0=OFF, 1=ON |

### ◼ スロット色管理変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `color_selected` | `7` | 選択中スロットの色コード | 白色（選択状態） |
| `color_available` | `32` | 利用可能スロットの色コード | 緑色（通常状態） |
| `color_coming_soon` | `90` | 開発中スロットの色コード | 暗い灰色 |
| `slot_1_color` | `7/32` | スロット1の色コード | 動的に変更 |
| `slot_2_color` | `7/32` | スロット2の色コード | 動的に変更 |
| `slot_3_color` | `7/32` | スロット3の色コード | 動的に変更 |
| `slot_4_color` | `90` | スロット4の色コード | 開発中 |
| `slot_5_color` | `90` | スロット5の色コード | 開発中 |
| `slot_6_color` | `90` | スロット6の色コード | 開発中 |
| `slot_7_color` | `90` | スロット7の色コード | 開発中 |
| `slot_8_color` | `90` | スロット8の色コード | 開発中 |
| `slot_9_color` | `90` | スロット9の色コード | 開発中 |
| `slot_10_color` | `90` | スロット10の色コード | 開発中 |
| `slot_11_color` | `90` | スロット11の色コード | 開発中 |
| `slot_12_color` | `90` | スロット12の色コード | 開発中 |

### ◼ セーブデータ存在確認変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `saveexists_ESD_1` | `true/false` | セーブデータ1の存在フラグ | ESD_1.txtの存在確認 |
| `saveexists_ESD_2` | `true/false` | セーブデータ2の存在フラグ | ESD_2.txtの存在確認 |
| `saveexists_ESD_3` | `true/false` | セーブデータ3の存在フラグ | ESD_3.txtの存在確認 |
| `selected_savedata_1` | `true/false` | セーブデータ1選択フラグ | 選択状態管理 |
| `selected_savedata_2` | `true/false` | セーブデータ2選択フラグ | 選択状態管理 |
| `selected_savedata_3` | `true/false` | セーブデータ3選択フラグ | 選択状態管理 |

---

## ✅ プレイヤーステータス変数

### ◼ Player_Status.txt

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `player_lv` | `1-99` | プレイヤーレベル | 成長パラメータ |
| `player_hp` | `1-999` | 現在HP | 戦闘時変動 |
| `player_hp_max` | `1-999` | 最大HP | レベルアップで増加 |
| `player_mp` | `1-999` | 現在MP | 魔法使用で消費 |
| `player_mp_max` | `1-999` | 最大MP | レベルアップで増加 |
| `player_stamina` | `1-10` | スタミナ | 行動力制限 |
| `player_atk` | `1-999` | 攻撃力 | 物理ダメージ計算 |
| `player_def` | `1-999` | 防御力 | ダメージ軽減 |
| `player_speed` | `1-999` | 素早さ | 行動順決定 |
| `player_luck` | `1-999` | 運 | クリティカル率影響 |
| `player_damage` | `0-999` | 受けたダメージ | 戦闘計算用 |
| `player_life` | `1-9` | 残機数 | ゲームオーバー判定 |
| `player_exp` | `0-9999` | 現在経験値 | レベルアップ用 |
| `player_money` | `0-999999` | 所持金 | アイテム購入用 |
| `player_exp_to_next_level` | `1-9999` | 次レベルまでの経験値 | レベルアップ判定 |
| `player_item_slot` | `1-99` | アイテムスロット数 | インベントリ容量 |
| `player_lastplace` | `String` | 最後の場所 | 継続プレイ用 |
| `player_save_count` | `0-999` | セーブ回数 | 統計用 |

### ◼ プレイヤー表示用変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `Player_Name` | `Hero` | プレイヤー名 | 表示・セーブ用 |
| `Player_LV` | `1` | 表示用レベル | 大文字表記 |
| `Player_HP` | `20` | 表示用HP | 大文字表記 |
| `Player_MP` | `10` | 表示用MP | 大文字表記 |
| `Player_ATK` | `4` | 表示用攻撃力 | 大文字表記 |
| `Player_DEF` | `1` | 表示用防御力 | 大文字表記 |
| `Player_SPEED` | `5` | 表示用素早さ | 大文字表記 |
| `Player_LUCK` | `8` | 表示用運 | 大文字表記 |
| `Player_SAVES` | `0` | 表示用セーブ回数 | 大文字表記 |

### ◼ 各セーブデータ別プレイヤー変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `Player_LV_1` | `5` | セーブデータ1のレベル | 表示用 |
| `Player_Name_1` | `Hero1` | セーブデータ1のプレイヤー名 | 表示用 |
| `Player_HP_1` | `45` | セーブデータ1のHP | 表示用 |
| `Player_MP_1` | `25` | セーブデータ1のMP | 表示用 |
| `Player_LV_2` | `10` | セーブデータ2のレベル | 表示用 |
| `Player_Name_2` | `Hero2` | セーブデータ2のプレイヤー名 | 表示用 |
| `Player_HP_2` | `80` | セーブデータ2のHP | 表示用 |
| `Player_MP_2` | `40` | セーブデータ2のMP | 表示用 |
| `Player_LV_3` | `3` | セーブデータ3のレベル | 表示用 |
| `Player_Name_3` | `Hero3` | セーブデータ3のプレイヤー名 | 表示用 |
| `Player_HP_3` | `30` | セーブデータ3のHP | 表示用 |
| `Player_MP_3` | `15` | セーブデータ3のMP | 表示用 |

---

## ✅ バトルシステム変数

### ◼ [ver0.00.30]BattleSystem.bat

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `player_name` | `Hero` | バトル時プレイヤー名 | 表示用 |
| `player_speed` | `10` | バトル時素早さ | 行動順決定 |
| `player_luck` | `0` | バトル時運 | クリティカル計算 |
| `player_stamina` | `3` | バトル時スタミナ | 行動力制限 |
| `turn_owner` | `1/2` | ターン所有者 | 1=プレイヤー, 2=敵 |
| `text_counts` | `0-999` | テキスト表示回数 | アニメーション制御 |
| `stc` | `0/31/33` | スタミナ色コード | 0=通常, 31=赤, 33=黄 |

### ◼ バトル表示用変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `slime_encounter_text_[1]` | `String` | スライムエンカウントテキスト1 | 戦闘開始時 |
| `slime_encounter_text_[2]` | `String` | スライムエンカウントテキスト2 | 戦闘開始時 |
| `text_box_[1]` | `String` | テキストボックス1行目 | 戦闘メッセージ |
| `text_box_[2]` | `String` | テキストボックス2行目 | 戦闘メッセージ |
| `text_box_[3]` | `String` | テキストボックス3行目 | 戦闘メッセージ |
| `text_box_[4]` | `String` | テキストボックス4行目 | 戦闘メッセージ |
| `text_box_[5]` | `String` | テキストボックス5行目 | 戦闘メッセージ |
| `text_box_[6]` | `String` | テキストボックス6行目 | 戦闘メッセージ |

### ◼ 座標管理変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `local_x` | `1-5` | ローカルX座標 | 戦術マップ用 |
| `local_y` | `1-3` | ローカルY座標 | 戦術マップ用 |
| `local_z` | `1-3` | ローカルZ座標 | 戦術マップ用 |
| `global_x` | `1-999` | グローバルX座標 | 画面座標 |
| `global_y` | `1-999` | グローバルY座標 | 画面座標 |

---

## ✅ インベントリシステム変数

### ◼ InventorySystem.bat

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `I` | `100` | インベントリ基準値 | カーソル位置計算 |
| `Inventory_cursor_1` | `100` | インベントリカーソル1 | 装備タブ |
| `Inventory_cursor_2` | `0` | インベントリカーソル2 | アイテムタブ |
| `Inventory_cursor_3` | `0` | インベントリカーソル3 | スキルタブ |
| `Inventory_cursor_4` | `0` | インベントリカーソル4 | システムタブ |
| `Inventory_cursor_5` | `0` | インベントリカーソル5 | セーブタブ |

### ◼ プレイヤーアバター表示変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `Player_Head` | `{@}` | プレイヤーの頭部表示 | ASCII アート |
| `Player_Arm_1` | `╱ \| ╲` | プレイヤーの腕部1 | ASCII アート |
| `Player_Arm_2` | `╱  \|    ╲` | プレイヤーの腕部2 | ASCII アート |
| `Player_Body` | `\|` | プレイヤーの胴体表示 | ASCII アート |
| `Player_Leg_1` | `╱ ╲` | プレイヤーの脚部1 | ASCII アート |
| `Player_Leg_2` | `╱     ╲` | プレイヤーの脚部2 | ASCII アート |

### ◼ 装備管理変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `player_equipped_weapon` | `Iron Sword` | 装備中の武器 | 戦闘力計算 |
| `player_equipped_armor` | `Leather Armor` | 装備中の防具 | 防御力計算 |
| `player_equipped_helmet` | `Leather hat` | 装備中のヘルメット | 防御力計算 |
| `player_equipped_accessory` | `Silver Ring` | 装備中のアクセサリー | 特殊効果 |

### ◼ 所持品管理変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `player_inventory_equip_1` | `Steel Sword` | 所持装備1 | インベントリ内 |
| `player_inventory_equip_2` | `Iron Shield` | 所持装備2 | インベントリ内 |
| `player_inventory_equip_3` | `Magic Ring` | 所持装備3 | インベントリ内 |
| `player_inventory_equip_count` | `3` | 所持装備数 | 管理用 |
| `player_inventory_item_1` | `Heal Potion` | 所持アイテム1 | インベントリ内 |
| `player_inventory_item_2` | `Strength-enhancing drugs` | 所持アイテム2 | インベントリ内 |
| `player_inventory_item_count` | `2` | 所持アイテム数 | 管理用 |

---

## ✅ 表示調整変数（DAA系）

### ◼ Display Adjust Air（DAA）変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `DAA_1` | ` ` | 表示調整用スペース1 | UI整列用 |
| `DAA_2` | `  ` | 表示調整用スペース2 | UI整列用 |
| `DAA_3` | `   ` | 表示調整用スペース3 | UI整列用 |
| `DAA_Name_1` | `      ` | 名前表示調整用スペース1 | セーブデータ1用 |
| `DAA_Name_2` | `      ` | 名前表示調整用スペース2 | セーブデータ2用 |
| `DAA_Name_3` | `      ` | 名前表示調整用スペース3 | セーブデータ3用 |
| `DAA_LV_1` | `   ` | レベル表示調整用スペース1 | セーブデータ1用 |
| `DAA_LV_2` | `   ` | レベル表示調整用スペース2 | セーブデータ2用 |
| `DAA_LV_3` | `   ` | レベル表示調整用スペース3 | セーブデータ3用 |
| `DAA_HP_1` | `   ` | HP表示調整用スペース1 | セーブデータ1用 |
| `DAA_HP_2` | `   ` | HP表示調整用スペース2 | セーブデータ2用 |
| `DAA_HP_3` | `   ` | HP表示調整用スペース3 | セーブデータ3用 |
| `DAA_MP_1` | `     ` | MP表示調整用スペース1 | セーブデータ1用 |
| `DAA_MP_2` | `     ` | MP表示調整用スペース2 | セーブデータ2用 |
| `DAA_MP_3` | `     ` | MP表示調整用スペース3 | セーブデータ3用 |

### ◼ 表示用テキスト変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `SaveDataText_A` | `プレイヤー名 Lv:1 HP=20 MP=10` | セーブデータ1表示テキスト | UI用 |
| `SaveDataText_B` | `Location:Northern Village` | セーブデータ1場所表示 | UI用 |
| `SaveDataText_C` | `AUTO-SAVE Playtime - 01:23` | セーブデータ1時間表示 | UI用 |
| `SaveDataText_D` | `プレイヤー名 Lv:5 HP=45 MP=25` | セーブデータ2表示テキスト | UI用 |
| `SaveDataText_E` | `Location:Cave Entrance` | セーブデータ2場所表示 | UI用 |
| `SaveDataText_F` | `AUTO-SAVE Playtime - 03:45` | セーブデータ2時間表示 | UI用 |
| `SaveDataText_G` | `プレイヤー名 Lv:10 HP=80 MP=40` | セーブデータ3表示テキスト | UI用 |
| `SaveDataText_H` | `Location:Final Dungeon` | セーブデータ3場所表示 | UI用 |
| `SaveDataText_I` | `AUTO-SAVE Playtime - 12:34` | セーブデータ3時間表示 | UI用 |

---

## ✅ ユーティリティ変数

### ◼ 文字列処理変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `str` | `Hero` | 文字列処理用一時変数 | 長さ計算等 |
| `len` | `4` | 文字列長さ格納変数 | 文字数カウント |
| `char` | `H` | 1文字処理用変数 | 文字単位処理 |
| `length` | `36` | 文字列総長度 | 表示制御用 |
| `text` | `Hello World` | 表示テキスト | アニメーション用 |

### ◼ 時間・カウント関連変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `current_time` | `12:34:56` | 現在時刻 | デバッグ・ログ用 |
| `ms` | `100` | ミリ秒単位時間 | サウンド再生用 |
| `rV` | `45000` | 乱数値 | ロード画面用 |
| `min` | `10000` | 乱数最小値 | 乱数生成用 |
| `max` | `70000` | 乱数最大値 | 乱数生成用 |

### ◼ 選択・入力関連変数

| 変数名 | 値の例 | 意味 | 備考 |
|--------|--------|------|------|
| `choice` | `1-9` | ユーザー選択値 | choice コマンド結果 |
| `key` | `1-9` | 押下キー番号 | 入力処理用 |
| `key_name` | `W(UP)` | キー名（人間可読） | デバッグ表示用 |
| `key_pressed` | `1` | 押下キー番号 | ログ用 |
| `retcode` | `1000-9999` | 処理返り値 | エラーレベル格納 |

---

## 🛠 今後の拡張予定

### ◼ 新規追加予定の変数系統

| 変数系統 | 想定用途 | 備考例 |
|----------|----------|--------|
| `sound_` | サウンド管理 | BGM、効果音の制御 |
| `map_` | マップシステム | 座標、移動制御 |
| `enemy_` | 敵データ管理 | 敵ステータス、AI制御 |
| `item_` | アイテム管理 | アイテム効果、使用制御 |
| `config_` | 設定管理 | ゲーム設定、オプション |
| `story_` | ストーリー管理 | イベントフラグ、進行制御 |

### ◼ 最適化予定の変数

| 現在の変数名 | 最適化案 | 理由 |
|-------------|----------|------|
| `while_space_XX` | `sp_XX` | 短縮でメモリ効率化 |
| `Player_Name_X` | `save_X_name` | 一貫性向上 |
| `DAA_XX` | `ui_spacing_XX` | 意味の明確化 |

---

## 🎯 変数命名規則

### ◼ 基本ルール

- **システム変数**: `cd_` プレフィックス（Current Directory）
- **プレイヤー変数**: `player_` プレフィックス
- **デバッグ変数**: `debug_` プレフィックス
- **表示変数**: `display_` または `ui_` プレフィックス
- **一時変数**: `temp_` プレフィックス（推奨）

### ◼ 大文字・小文字の使い分け

- **内部処理用**: 小文字（例：`player_hp`）
- **表示用**: 大文字（例：`Player_HP`）
- **環境変数**: 大文字（例：`RPG_DEBUG_STATE`）

### ◼ 配列風変数

- **インデックス付き**: `変数名_[番号]`（例：`text_box_[1]`）
- **セーブデータ別**: `変数名_番号`（例：`Player_Name_1`）

---

## 💬 メンテナンス指針

### ◼ 変数追加時の注意事項

1. **プレフィックス統一**: 機能別のプレフィックスを必ず使用
2. **用途明記**: 変数の意味と使用箇所を明確に記載
3. **型・範囲指定**: 取りうる値の範囲を明記
4. **依存関係**: 他の変数との関係性を記載

### ◼ 廃止予定変数の管理

- **段階的廃止**: 直接削除せず、コメントで廃止予定を明記
- **代替案提示**: 新しい変数への移行手順を記載
- **影響調査**: 変更による他モジュールへの影響を調査

---

## 📁 保存場所

```
ProjectRoot/
└── Docs/
    ├── error_code_main_menu.md
    └── variable_management_reference.md  ← このファイル
```

---

## 🔄 更新履歴

| 日付 | 更新者 | 更新内容 |
|------|--------|----------|
| 2025/07/09 | HedgeHog | 初版作成 |
| | | 各モジュールの変数整理完了 |
| | | デバッグ変数系統追加 |
| | | 表示調整変数（DAA系）追加 |

---

## 🎮 使用方法

1. **新規変数追加時**: 該当するモジュールの章に追加
2. **変数変更時**: 値の例と意味を更新
3. **廃止時**: 🚫 マークを付けて廃止日を記載
4. **確認時**: Ctrl+F でプレフィックスや変数名を検索

このドキュメントは **生きた仕様書** として、開発と同時に更新することを推奨します。
