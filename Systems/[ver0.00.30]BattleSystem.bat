@echo off
chcp 65001 >nul
cd ..
:: ファイルパス指定変数初期化
set cd_enemydata=%cd%\EnemyData
set cd_itemdata=%cd%\ItemData
set cd_newgame=%cd%\NewGame
set cd_playerdata=%cd%\PlayerData
set cd_savedata=%cd%\SaveData
set cd_sounds=%cd%\Sounds
set cd_stories=%cd%\Stories
set cd_stories_maps=%cd%\Stories\Maps
set cd_systems=%cd%\Systems
set cd_systems_display=%cd%\Systems\Display
cd systems

:: ANSIエスケープシーケンスの準備
for /f %%i in ('cmd /k prompt $e^<nul') do set "esc=%%i"

:: デバッグ用の必要最小限の変数を宣言
set player_name=Hero
set player_speed=10
set player_luck=0
set player_stamina=3

set text1=Your turn^!

:: デバッグメニューに入るためのパスワード
set debug_pass=rpggame2024

:: ディスプレイ用変数宣言
set p=^^^|
set l=^^^<
set r=^^^>

:: スタミナのカラー
set stc=0


:: 空白調整用変数(ToM sysのロードよりも先にする)
call "%cd_systems%\WhileSpaceVariable_Initialize.bat" 

:: ToM上でのプレイヤー(playerdataに遷移してもいいかも)
set "player_tom=%while_space_6%@%while_space_6%"

:: 同じく敵
set "enemy_tom=%while_space_4%(o_o(%while_space_4%"



:: 画面遷移前に唯一echo出力する
rem ---------------------------------------
echo Please maximize the window size.
echo And press "Enter" key.
set /p debug=""
if "%debug%" equ "%debug_pass%" (
    cls& call :Debug
) else (cls& call :SimpleDebug)
rem ---------------------------------------



:: ディスプレイ情報が格納された変数初期化処理
call :Display_TextBox_Initialize
call :Display_ActMenu_Initialize


:: ToM sys座標初期化関連
call :Coordinate_Initialization
call :Player_Coordinate_Initialization
call :Enemy_Coordinate_Initialization



:: 敵のデータ・ステータスの読み込み
call "%cd_enemydata%\Enemy_Status_Slime.bat" 1



:: 0:戦闘処理開始(7 steps)
:Battle_Start
    :: 1:戦闘用ディスプレイの表示
    call :MainDisplay_Echo

    :: 2:エンカウント時のテキストを表示
    call :Encounter_Text

    :: 3:スピードチェック(SC) 引数の1は敵の数に応じて変更
    call :SpeedCheck 1

    :: 4:SCの結果どちらのターン主導権か表示
    call :Turn_Text %errorlevel%
    set turn_owner=%errorlevel%

    :: 5:Turn_Textの戻り値よりターンの判別と開始
    call :Turn_Detection %turn_owner%

    :Battle_Loop
    :: 6:ターン終了処理（死亡判定やステータス更新など）
    ::call :EndOfTurn_Processing

    :: 7:次のターン主導権の表示とターン開始
    call :Turn_Text %turn_owner%
    call :Turn_Detection %turn_owner%

    :: 8:戦闘終了チェック
    ::call :Battle_End_Check
    ::if %errorlevel% neq 0 (goto :Battle_End)

    :: 9:戦闘処理のループ継続
    goto :Battle_Loop
::


::1
:MainDisplay_Echo

    ::act memu
    call :Display_ActMenu_Initialize


    cls & call "%cd_systems_display%\[ver0.00.30]BattleSystemDisplay.bat"
    exit /b

::2
:Encounter_Text
    setlocal enabledelayedexpansion
    set length=37
    set text_counts+=1
    for /l %%i in (0,1,%length%-1) do (
        set "char=!slime_encounter_text_[1]:~%%i,1!"
        if "!char!"==" " (
            <nul set /p "=%while_space_esc_1%"
        ) else (
            if %%i==0 (
                <nul set /p "=%esc%[10;60H!char!"
            ) else (
                <nul set /p "=!char!"
            )
        
        )
        call :delay %%i
    )
    endlocal & timeout /t 1 >nul
    echo %esc%[H
    set "text_box_[3]= - %slime_encounter_text_[1]%%while_space_58%"
    call :Display_TextBox_Reload
    call :MainDisplay_Echo
    exit /b

::3
:SpeedCheck
    if %player_speed% gtr %enemy_speed_[%1]% (
        exit /b 1
    )
    if %enemy_speed_[%1]% gtr %player_speed% (
        exit /b 2
    )
    if %player_speed% equ %enemy_speed_[%1]% (
        if %player_luck% geq %enemy_luck_[%1]% (
            exit /b 1
        ) else (
            exit /b 2
        )
    )

::4
:Turn_Text
    if %1==1 (
        setlocal enabledelayedexpansion
        set length=10
        set text_counts+=1
        for /l %%i in (0,1,!length!-1) do (
            set "char=!text1:~%%i,1!"
            if "!char!"==" " (
                <nul set /p "=%while_space_esc_1%"
            ) else (
                if %%i==0 (
                    <nul set /p "=%esc%[12;60H!char!"
                ) else (
                    <nul set /p "=!char!"
                )
            )
            call :delay %%i
        )
        endlocal
        echo %esc%[H
        set "text_box_[5]= -- %text1%%while_space_40%%while_space_40%%while_space_3%"
        call :Display_TextBox_Reload
        timeout /t 1 >nul
        call :MainDisplay_Echo
        ::player_turnの"1"を返す
        exit /b 1
    ) else if %1==2 (
        setlocal enabledelayedexpansion
        set length=13
        set text_counts+=1
        for /l %%i in (0,1,!length!-1) do (
            set "char=!slime_encounter_text_[2]:~%%i,1!"
            if "!char!"==" " (
                <nul set /p "=%while_space_esc_1%"
            ) else (
                if %%i==0 (
                    <nul set /p "=%esc%[12;60H!char!"
                ) else (
                    <nul set /p "=!char!"
                )
            )
            call :delay %%i
        )
        endlocal
        echo %esc%[H
        set "text_box_[5]= - %slime_encounter_text_[2]%%while_space_40%%while_space_40%%while_space_1%"
        call :Display_TextBox_Reload
        timeout /t 1 >nul
        call :MainDisplay_Echo
        ::enemy_turnの"2"を返す
        exit /b 2
    )

::5
:Turn_Detection

    if %1==1 (call :Player_Turn)
    if %1==2 (call :Enemy_Turn)
    exit /b %turn_owner%

    :Player_Turn
        :: プレイヤーターン処理モジュール
        call "%cd_systems%\[ver0.00.30]BattleSystem_PlayerModule.bat"
        :: 戻り値1でプレイヤーターン,2で敵のターン
        set turn_owner=%errorlevel%
        exit /b %turn_owner%

    :Enemy_Turn
        :: エネミーターン処理モジュール
        call "%cd_systems%\[ver0.00.10]BattleSystem_EnemyModule.bat"
        :: 返り値1でプレイヤーのターンに回す
        set turn_owner=%errorlevel%
        exit /b %turn_owner%
::

















:: ディスプレイ初期化関連
:Display_TextBox_Initialize
    ::text box
    set "text_box_[1]= %l% TEXT BOX %r%%while_space_84%"
    set "text_box_[2]=%while_space_40%%while_space_40%%while_space_17%" & rem 97 
    set "text_box_[3]=%while_space_40%%while_space_40%%while_space_17%"
    set "text_box_[4]=%while_space_40%%while_space_40%%while_space_17%"
    set "text_box_[5]=%while_space_40%%while_space_40%%while_space_17%"
    set "text_box_[6]=%while_space_40%%while_space_40%%while_space_17%"
    exit /b

:Display_ActMenu_Initialize

    ::act memu left side
    set "actmenu_left_[0]= %l% COMMAND %r%%while_space_13%"
    set "actmenu_left_[1]=%while_space_25%"
    set "actmenu_left_[2]=%esc%[%select_cursor_2%m%while_space_4%ATTACK%while_space_15%%esc%[0m"
    set "actmenu_left_[3]=%while_space_25%"
    set "actmenu_left_[4]=%esc%[%select_cursor_4%m%while_space_4%MOVE ON%while_space_14%%esc%[0m"
    set "actmenu_left_[5]=%while_space_25%"
    set "actmenu_left_[6]=%esc%[%select_cursor_6%m%while_space_4%USE MAGIC%while_space_12%%esc%[0m"
    set "actmenu_left_[7]=%while_space_25%"
    set "actmenu_left_[8]=%esc%[%select_cursor_8%m%while_space_4%USE ITEMS%while_space_12%%esc%[0m"
    set "actmenu_left_[9]=%while_space_25%"
    set "actmenu_left_[10]=%esc%[%select_cursor_10%m%while_space_4%ESCAPE BATTLE%while_space_8%%esc%[0m"

    :: stamina collar update
    call :Stamina_Collar_Update

    ::act menu right side
    set "actmenu_right_[0]= %l% PLAYER STATUS %r%%while_space_53%"
    set "actmenu_right_[1]=%while_space_40%%while_space_31%"
    set "actmenu_right_[2]= [@] %player_name%            Lv: 1   HP: 40/100    █████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   "
    set "actmenu_right_[3]=%while_space_21%ST: %esc%[%stc%m%player_stamina%%esc%[0m   MP: 20/20     █████████████████████████%esc%[40m %esc%[0m  "
    set "actmenu_right_[4]=%while_space_40%%while_space_31%"
    set "actmenu_right_[5]=%while_space_40%%while_space_31%"
    set "actmenu_right_[6]=%while_space_40%%while_space_31%"
    set "actmenu_right_[7]=%while_space_40%%while_space_31%"
    set "actmenu_right_[8]=%while_space_40%%while_space_31%"
    set "actmenu_right_[9]=%while_space_40%%while_space_31%"
    set "actmenu_right_[10]=%while_space_40%%while_space_31%"

    exit /b

:Display_TextBox_Reload
    ::text box
    set "text_box_[1]=%text_box_[1]%"
    set "text_box_[2]=%text_box_[2]%"
    set "text_box_[3]=%text_box_[3]%"
    set "text_box_[4]=%text_box_[4]%"
    set "text_box_[5]=%text_box_[5]%"
    set "text_box_[6]=%text_box_[6]%"
    exit /b
::
:Stamina_Collar_Update
    if %player_stamina% equ 0 (
        set stc=31
    ) else if %player_stamina% equ 1 (
        set stc=33
    ) else (
        set stc=0
    )
    exit /b
::

:: 座標初期化関連
:Coordinate_Initialization
    :: ToM sysの座標初期化
    for /l %%x in (1,1,5) do (
        for /l %%y in (1,1,3) do (
            for /l %%z in (1,1,3) do (
                call set "x%%x_y%%y_z%%z=%while_space_13%"
            )
        )
    )
    exit /b
::
:Player_Coordinate_Initialization
    :: プレイヤー座標の初期化
    set player_x=1
    set player_y=1
    set player_z=2
    set x%player_x%_y%player_y%_z%player_z%=%player_tom%
    ::set /a player_z-=1
    ::set x%player_x%_y%player_y%_z%player_z%=%while_space_4%(you)%while_space_4%
    exit /b
::
:Enemy_Coordinate_Initialization
    :: 敵座標の初期化
    set enemy[1]_x=5
    set enemy[1]_y=2
    ::set enemy[1]_z=1
    ::set x%enemy[1]_x%_y%enemy[1]_y%_z%enemy[1]_z%=%while_space_3%(enemy)%while_space_3%
    set enemy[1]_z=2
    set x%enemy[1]_x%_y%enemy[1]_y%_z%enemy[1]_z%=%enemy_tom%
    ::set enemy[1]_z=3
    ::set x%enemy[1]_x%_y%enemy[1]_y%_z%enemy[1]_z%=%while_space_4%~~~~~%while_space_4%
    exit /b
::



:: ___
::(o_o( < hello world!
:: ~~~





:: テキスト用遅延関数
:delay
    for /l %%t in (1,1,9000) do (
        if %1==5 (for /l %%p in (1,1,45000) do (if %%p==45000 (exit /b)))
        if %1==23 (for /l %%q in (1,1,55000) do (if %%q==55000 (exit /b)))
    )
    exit /b
::








:: 開発途中コード(デバッグコードとして動作中)
:Debug
    @echo off
    :: 各座標の値を設定 (仮)
    setlocal enabledelayedexpansion
    for /l %%z in (1,1,3) do (
        for /l %%y in (1,1,3) do (
            for /l %%x in (1,1,5) do (
                set "local_x=%%x"
                set "local_y=%%y"
                set "local_z=%%z"
            
                :: ローカル座標 - グローバル座標に変換
                call :convert_to_global !local_x! !local_y! !local_z! global_x global_y
            
                :: 各座標に内容を表示
                set "content=Initialized"
                echo %esc%[!global_y!;!global_x!H!content!
            )
        )
    )
    cls
    for /l %%z in (1,1,3) do (
        for /l %%y in (1,1,3) do (
            for /l %%x in (1,1,5) do (
                set "local_x=%%x"
                set "local_y=%%y"
                set "local_z=%%z"
            
                :: ローカル座標 - グローバル座標に変換
                call :convert_to_global !local_x! !local_y! !local_z! global_x global_y
            
                :: 各座標に内容を表示
                set "content=x!local_x!_y!local_y!_z!local_z!"
                echo %esc%[!global_y!;!global_x!H!content!
            )
        )
    )
    echo %esc%[H
    echo.
    echo. %esc%[35mDebugging Output:%esc%[0m
    echo. %esc%[32m-----------------%esc%[0m
    for /l %%z in (1,1,3) do (
        for /l %%y in (1,1,3) do (
            for /l %%x in (1,1,5) do (
                set "local_x=%%x"
                set "local_y=%%y"
                set "local_z=%%z"
            
                :: ローカル座標 - グローバル座標に変換
                call :convert_to_global !local_x! !local_y! !local_z! global_x global_y
            
                :: デバッグ情報を出力
                echo %esc%[35mLocal:%esc%[0m %esc%[32mx=%%x, y=%%y, z=%%z -^>%esc%[0m %esc%[35mGlobal:%esc%[0m %esc%[32mx=!global_x!, y=!global_y!%esc%[0m
            )
        )
    )
    ::echo.%esc%[54;80H ToM system [v0.0.30] Initialization completed.
    call :Debug_text
    echo %esc%[H
    echo.%esc%[55;94H (c) 2024 RPGGAME
    timeout /t -1 >nul
    endlocal
    exit /b

    :convert_to_global
        :: ローカル座標をグローバル座標に変換する関数
        :: %1 = ローカルx, %2 = ローカルy, %3 = ローカルz
        :: 出力: %4 = グローバルx, %5 = グローバルy
        setlocal enabledelayedexpansion

        :: グローバル座標計算
        set /a "global_x=73 + (%1 - 1) * 14"
        set /a "global_y=16 + (%2 - 1) * 4 + (%3 - 1)"

        :: 呼び出し元にグローバル座標を返す
        endlocal & set "%4=%global_x%" & set "%5=%global_y%"
        exit /b

    :Debug_text
        set "debug_text=ToM system [v0.0.30] Initialization completed."
        setlocal enabledelayedexpansion
        set length=46
        set text_counts+=1
        for /l %%i in (0,1,%length%-1) do (
            set "char=!debug_text:~%%i,1!"
            if "!char!"==" " (
                <nul set /p "=%while_space_esc_1%"
            ) else (
                if %%i==0 (
                    <nul set /p "=%esc%[54;80H!char!"
                ) else (
                    <nul set /p "=!char!"
                )
        
            )
            for /l %%t in (1,1,3000) do (
                if %%i==!length! (exit /b)
            )
        )
::
:SimpleDebug
    @echo off
    :: 各座標の値を設定 (仮)
    setlocal enabledelayedexpansion
    for /l %%z in (1,1,3) do (
        for /l %%y in (1,1,3) do (
            for /l %%x in (1,1,5) do (
                set "local_x=%%x"
                set "local_y=%%y"
                set "local_z=%%z"
            
                :: ローカル座標 - グローバル座標に変換
                call :convert_to_global !local_x! !local_y! !local_z! global_x global_y
            
                :: 各座標に内容を表示
                call set "content=Initialized"
                echo %esc%[!global_y!;!global_x!H!content!
            )
        )
    )
    echo.
    echo. ToM system [v0.0.30] Initialization and simple debugging was completed.
    timeout /t 2 >nul
    endlocal
    exit /b
::