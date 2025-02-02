@echo off

:: 現在の装備状態を管理する変数
set player_equipped_weapon=Iron Sword
set player_equipped_armor=Leather Armor
set player_equipped_helmet=Leather hat
set player_equipped_accessory=Silver Ring

:: 所持品リスト
set player_inventory_equip_1=Steel Sword
set player_inventory_equip_2=Iron Shield
set player_inventory_equip_3=Magic Ring
set player_inventory_equip_count=3

set player_inventory_item_1=Heal Potion
set player_inventory_item_2=Strength-enhancing drugs
set player_inventory_item_count=3


:: ACT menuカーソルのカラーコードと初期位置
set cursor_color=7
set cursor_index=2

:: 増減幅の初期設定
set cursor_step=2

:: カーソル起動
call :SetCursor %cursor_step%



:Actmenu_Index
    set current_actmenu=Index
    set cursor_step=2

    call :MainDisplay_Echo %current_actmenu%
    call :GetChoice
    call :Move_Cursor %choice%

    if %errorlevel%==12 (goto :Actmenu_Index_F)
    if %errorlevel%==13 (goto :Actmenu_Index_E)
    if %errorlevel%==14 (goto :Actmenu_Index_Q)

    :: Fで決定されるまで Actmenu_Index をループ
    goto :Actmenu_Index






:Actmenu_Index_F
    if %cursor_index%==2 (call :Actmenu_Attack)
    if %cursor_index%==4 (call :Actmenu_MoveOn)
    if %cursor_index%==6 (call :Actmenu_UseMagic)
    if %cursor_index%==8 (call :Actmenu_UseItems)
    if %cursor_index%==10 (call :Actmenu_EscapeBattle)

    :: Qを押されたらひとつ前の画面へ("14"は被らないよう注意)
    if %errorlevel%==14 (goto :Actmenu_Index)

    :: プレイヤーターン終了--敵にターン譲渡
    if %errorlevel%==99 (exit /b 2)



    :Actmenu_Attack
        call "%cd_systems%\[ATK]PlayerAttackSystem_Utility.bat"
        :: "Q"を検知したらexitする為"14"で値を返す
        if %errorlevel%==7 (
            exit /b 14
        )

    :Actmenu_MoveOn
        call "%cd_systems%\[ToM]TacticsOnMapSystem_Utility.bat"
        :: "Q"を検知したらexitする為"14"で値を返す
        if %errorlevel%==7 (
            exit /b 14
        )
    
    :Actmenu_UseMagic
        echo UseMagicMenu
        pause

    :Actmenu_UseItems
        echo UseItemsMenu
        pause

    :Actmenu_EscapeBattle
        echo EscapeBattleMenu
        pause
        exit



:Actmenu_Index_E
    echo you select "E" Open inventory
    echo %cursor_index%
    echo デバッグコマンド：スタミナをインクリメント
    echo ST: %player_stamina%
    pause
    goto :Actmenu_Index

:Actmenu_Index_Q
    echo Turn end?
    choice
    if %errorlevel%==1 (goto :Turn_End)
    if %errorlevel%==2 (goto :Actmenu_Index)
::







:MainDisplay_Echo
    ::text box reload
    call :Display_TextBox_Reload

    ::act memu
    call :Display_ActMenu_%1_Initialize


    cls & call "%cd_systems_display%\[ver0.00.30]BattleSystemDisplay.bat"
    exit /b




:: カーソル移動用関数群
:GetChoice
    echo %esc%[76C"[Select with 'WASD' and enter with 'F',and 'Q' to cancel.]"
    choice /n /c WASDFEQ >nul
    set choice=%errorlevel%
    exit /b

::
:SetCursor
    for /l %%a in (%1,%1,10) do (
        if %%a == %cursor_index% (
            set "select_cursor_%%a=%cursor_color%"
        ) else (
            set "select_cursor_%%a=0"
        )
    )
    exit /b 0

::
:Move_Cursor
    if %1==1 (call :W)
    if %1==2 (call :A)
    if %1==3 (call :S)
    if %1==4 (call :D)
    if %1==5 (call :F)
    if %1==6 (call :E)
    if %1==7 (call :Q)
    exit /b %errorlevel%

    :W
        set /a cursor_index-=%cursor_step%
        if %cursor_index% leq 0 (set cursor_index=%cursor_step%)
        call :Update_Cursor
        exit /b %cursor_index%

    :A
        call :Update_Cursor
        exit /b %cursor_index%

    :S
        set /a cursor_index+=%cursor_step%
        if %cursor_index% geq 10 (set cursor_index=10)
        call :Update_Cursor
        exit /b %cursor_index%

    :D
        call :Update_Cursor
        exit /b %cursor_index%

    :F
        exit /b 12

    :E
        set /a player_stamina+=1
        exit /b 13

    :Q
        exit /b 14


    :Update_Cursor
        call :SetCursor %cursor_step%
        exit /b
::








::
:Display_ActMenu_Index_Initialize

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
    set "actmenu_right_[3]=%while_space_21%ST: %esc%[%stc%m%player_stamina%%esc%[0m   MP: 20/20     █████████████████████████   "
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

:Display_ActMenu_MoveOn_Initialize

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

    ::act menu right side
    set "actmenu_right_[0]=   %l% MOVE AROUND THE AREA %r%%while_space_44%"
    set "actmenu_right_[1]=%while_space_40%%while_space_31%"
    set "actmenu_right_[2]=%while_space_40%%while_space_31%"
    set "actmenu_right_[3]=%while_space_40%%while_space_31%"
    set "actmenu_right_[4]=%while_space_40%%while_space_31%"
    set "actmenu_right_[5]=%while_space_40%%while_space_31%"
    set "actmenu_right_[6]=%while_space_40%%while_space_31%"
    set "actmenu_right_[7]=%while_space_40%%while_space_31%"
    set "actmenu_right_[8]=%while_space_40%%while_space_31%"
    set "actmenu_right_[9]=%while_space_40%%while_space_31%"
    set "actmenu_right_[10]=%while_space_40%%while_space_31%"

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





echo.36%
echo.█████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒





:Turn_End
    set "text_box_[3]=%text_box_[5]%"
    set "text_box_[5]=%text_box_[6]%"

    cls & call "%cd_systems_display%\[ver0.00.30]BattleSystemDisplay.bat"

    exit /b 2