


:Main_Loop

call :MainDisplay_Echo %current_actmenu%
call :GetChoice
call :Move_Cursor %choice%

:: もし"Q"が押されたら戻る
if %errorlevel%==7 (
    exit /b %choice%
)

goto :Main_Loop


:GetChoice
    echo %esc%[83C"[Use 'WASD' to move and 'Q' to stop moving]"
    choice /n /c WASDFEQ
    set choice=%errorlevel%
    exit /b


:Move_Cursor
    if %1==1 (call :W)
    if %1==2 (call :A)
    if %1==3 (call :S)
    if %1==4 (call :D)
    if %1==5 (call :F)
    if %1==6 (call :E)
    if %1==7 (call :Q)
    exit /b %errorlevel%





















:MainDisplay_Echo
    ::text box reload
    call :Display_TextBox_Reload

    ::act memu
    call :Display_ActMenu_%1_Initialize



    :: ToM sysの座標更新
    for /l %%x in (1,1,5) do (
        for /l %%y in (1,1,3) do (
            for /l %%z in (1,1,3) do (
                if "x%%x_y%%y_z%%z"=="x%player_x%_y%player_y%_z%player_z%" (
                    call set "x%%x_y%%y_z%%z=%player_tom%"
                ) else (
                    call set "x%%x_y%%y_z%%z=%while_space_13%"
                )
                if "x%%x_y%%y_z%%z"=="x%enemy[1]_x%_y%enemy[1]_y%_z%enemy[1]_z%" (
                    call set "x%%x_y%%y_z%%z=%enemy_tom%"
                ) else (
                    if not "x%%x_y%%y_z%%z"=="x%player_x%_y%player_y%_z%player_z%" (
                        call set "x%%x_y%%y_z%%z=%while_space_13%"
                    )
                )
            )
        )
    )

    :: メインディスプレイの表示
    cls & call "%cd_systems_display%\[ver0.00.30]BattleSystemDisplay.bat"

    exit /b




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