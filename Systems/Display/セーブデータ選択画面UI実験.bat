@echo off
set p=^^^|
:: Initialize ANSI escape sequence
for /f %%a in ('cmd /k prompt $e^<nul') do (set "esc=%%a")
mode con: cols=50 lines=20
chcp 65001 >nul

:: デバッグモード判定
echo Please maximize the window size.
echo For debug mode, type: rpggame2024
echo Otherwise, press Enter to continue normally.
set /p debug_input=""

if "%debug_input%" equ "rpggame2024" (
    call :SaveData_Debug_Mode
) else (
    call :SaveData_Normal_Mode
)
exit /b

:SaveData_Normal_Mode
cls
for /f "delims=" %%a in (E:\RPGGAME\Systems\Display\[DEV]SelectSaveDataDisplay.txt) do (%%a)
pause >nul
goto :SaveData_SelectScreen

:SaveData_Debug_Mode
cls
:: 静的UIを表示
for /f "delims=" %%a in (E:\RPGGAME\Systems\Display\[DEV]SelectSaveDataDisplay.txt) do (%%a)

:: 動的要素を座標指定で追加
call :Display_All_SaveSlots
call :Display_SaveData_Info

:: デバッグ情報を左側に表示
call :Display_Debug_Info

echo.
echo %esc%[45;1H%esc%[35mSaveData UI Debug Mode Active - Press any key to continue...%esc%[0m
pause >nul
goto :SaveData_SelectScreen

:Display_Debug_Info
echo %esc%[H
echo.
echo. %esc%[35mSaveData Coordinate Debugging:%esc%[0m
echo. %esc%[32m--------------------------------%esc%[0m

setlocal enabledelayedexpansion
for /l %%i in (1,1,12) do (
    set "slot_num=%%i"
    
    :: 座標計算
    set /a "row_index=(%%i - 1) / 4"
    set /a "col_index=(%%i - 1) %% 4"
    
    call :Calculate_SaveSlot_Position !slot_num! slot_y slot_x
    
    :: デバッグ情報を出力
    echo %esc%[35mSlot:!slot_num!%esc%[0m %esc%[32mrow=!row_index!, col=!col_index! -^>%esc%[0m %esc%[36mx=!slot_x!, y=!slot_y!%esc%[0m
)

echo.
echo. %esc%[33mCalculation Formula:%esc%[0m
echo. %esc%[36my_pos = 23 + (row_index * 9)%esc%[0m
echo. %esc%[36mx_pos = 61 + (col_index * 27) - 5%esc%[0m
echo.
echo. %esc%[35mSaveData UI System [v0.0.30] Debug completed.%esc%[0m

endlocal
exit /b













:SaveData_SelectScreen
@echo off
chcp 65001 >nul
for /f %%a in ('cmd /k prompt $e^<nul') do (set "esc=%%a")

:Display_SaveData_UI
cls
:: 静的UIを表示
for /f "delims=" %%a in (E:\RPGGAME\Systems\Display\[DEV]SelectSaveDataDisplay.txt) do (%%a)

:: 動的要素を座標指定で追加
call :Display_All_SaveSlots
call :Display_SaveData_Info

pause

goto :next

:next
:: 次の処理へ進む
cls
for /f "delims=" %%a in (E:\RPGGAME\Systems\Display\[DEV]SelectSaveDataDisplay.txt) do (%%a)
echo next
pause >nul






















:Display_SaveData_Info
setlocal enabledelayedexpansion

:: 各スロットの詳細情報を表示
for /l %%i in (1,1,3) do (
    call :Calculate_SaveSlot_Position %%i slot_y slot_x
    
    :: プレイヤー名表示位置 (スロット番号の下)
    set /a info_y=!slot_y! + 1
    echo %esc%[!info_y!;!slot_x!Hplayer: TestUser!%%i!
    
    :: 進行状況表示位置
    set /a progress_y=!info_y! + 1
    echo %esc%[!progress_y!;!slot_x!HProgress: Ep.!%%i!
    
    :: プレイ時間表示位置
    set /a time_y=!progress_y! + 2
    echo %esc%[!time_y!;!slot_x!Hplaytime: 1!%%i!:30
)

endlocal
exit /b

:Calculate_SaveSlot_Position
:: 引数: %1=スロット番号(1-12), %2=戻り値用変数名_Y, %3=戻り値用変数名_X
setlocal enabledelayedexpansion

:: スロット番号からグリッド位置を計算
set /a slot_num=%1
set /a row_index=(%slot_num% - 1) / 4
set /a col_index=(%slot_num% - 1) %% 4

:: 座標計算
set /a y_pos=23 + %row_index% * 9
set /a x_pos=61 + %col_index% * 27 - 5

:: 戻り値を設定
endlocal & set "%2=%y_pos%" & set "%3=%x_pos%"
exit /b

:Display_All_SaveSlots
setlocal enabledelayedexpansion

:: 全スロットに番号を表示
for /l %%i in (1,1,12) do (
    call :Calculate_SaveSlot_Position %%i slot_y slot_x
    echo %esc%[!slot_y!;!slot_x!H[%%i]
)

:: 選択可能スロットにハイライト表示
for /l %%i in (1,1,3) do (
    call :Calculate_SaveSlot_Position %%i slot_y slot_x
    echo %esc%[!slot_y!;!slot_x!H%esc%[32m[%%i]%esc%[0m
)

:: 開発中スロット表示
for /l %%i in (4,1,12) do (
    call :Calculate_SaveSlot_Position %%i slot_y slot_x
    echo %esc%[!slot_y!;!slot_x!H%esc%[90m[W.I.P.]%esc%[0m
)

endlocal
exit /b

:: 追加のデバッグ機能
:Display_Coordinate_Grid
:: デバッグ用グリッド線表示
setlocal enabledelayedexpansion
for /l %%i in (1,1,12) do (
    call :Calculate_SaveSlot_Position %%i slot_y slot_x
    
    :: 座標マーカーを表示
    set /a marker_y=!slot_y! + 3
    echo %esc%[!marker_y!;!slot_x!H%esc%[91m(!slot_x!,!slot_y!)%esc%[0m
)
endlocal
exit /b