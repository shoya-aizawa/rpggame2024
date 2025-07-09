@echo:: ANSI?????????????
for /f %%a i:: ????????????
for /f :: ???????::: ???????:: ????????????:: ??????
endloc:: ?????????????:: ?????????
set     :: ?????????????
    e:: ??????
echo %esc%[!cursor_y!;!cursor_x!H%esc%[91m+%e:: ???????:: 10x10?:: ???????????
echo %esc%[20;80H%esc%[91m[CENTER]%esc%[0m
echo %esc%[10;20H%esc%[92m[TOP-LEFT]%esc%[0m
echo %esc%[40;140H%esc%[93m[BOTTOM-RIGHT]%esc%[0m???
for /l %%y in (10,5,40) do (
call :Display_Coordinate_Grid%[0m

:: ??????
echo %esc%[4;2H%esc%[K%esc%[32mCurrent Position: x=!cursor_x!, y=!cursor_y!%esc%[0m

:: ??????c%[!item_y!;%menu_x%H%esc%[91m!item_name!%esc%[0m
    
    :: ??????????_items[1]=New Gameor /f "delims=" %%a in (E:\RPGGAME\Systems\Display\[DEV]MainMenuDisplay.txt) do (%%a)

:: ???????????exit /b???
set /a slot_y=23 + !row_index! * 9
set /a slot_x=61 + !col_index! * 27 - 5
:: ?????????????
echo %esc%[!slot_y!;!slot_x!H%esc%[91m[%slot_num%]%esc%[0m
:: ??????????
set /a info_line=4 + %slot_num%
echo %esc%[!info_line!;1H%esc%[36mSlot %slot_num%: %esc%[33mx=!slot_x!, y=!slot_y!%esc%[0m
:: ?????? /l %%i in (1,1,12) do (call :Calculate_SaveSlot_Position %%i)??????????????????
set /a :: ?????????????
for /f "delims=" %%a in (E:\RPGGAME\Systems\Display\[DEV]MainMenuDisplay.txt) do (%%a)

:: ???????????_y=23 + !row_index! * 9
set /a slot_x=61 + !col_index! * 27 - 5
:: ?????????????
echo %esc%[!slot_y!;!slot_x!H%esc%[91m[%slot_num%]%esc%[0m
:: ??????????
set /a info_line=4 + %slot_num%
echo %esc%[!info_line!;1H%esc%[36mSlot %slot_num%: %esc%[33mx=!slot_x!, y=!slot_y!%esc%[0m
:: ?????? /l %%i in (1,1,12) do (call :Calculate_SaveSlot_Position %%i)elims=" %%a in (E:\RPGGAME\Systems\Display\[DEV]SelectSaveDataDisplay.txt) do (%%a)

:: ?????????????
call :Calculate_SaveData_Slots

:: ?????????? /k prompt $e^<nul') do (set "esc=%%a")

:: ???????????
chcp 65001 >nul
call "E:\RPGGAME\Systems\InitializeModule.bat"
setlocal enabledelayedexpansion

:: ANSI ã‚¨ã‚¹ã‚±ãƒ¼ãƒ—ã‚·ãƒ¼ã‚±ãƒ³ã‚¹ã‚’åˆ�æœŸåŒ–
for /f %%a in ('cmd /k prompt $e^<nul') do (set "esc=%%a")

:: ã‚¦ã‚£ãƒ³ãƒ‰ã‚¦ã‚’æœ€å¤§åŒ–
mode con: cols=160 lines=50
title RPGGame - Coordinate Debug Tool v1.0

:MainMenu
cls
echo %esc%[1;1H%esc%[46;30m RPGGame Coordinate Debug Tool v1.0 %esc%[0m
echo.
echo %esc%[36m1. SaveData Selector Coordinates%esc%[0m
echo %esc%[36m2. MainMenu Coordinates%esc%[0m
echo %esc%[36m3. General UI Coordinates%esc%[0m
echo %esc%[36m4. Interactive Coordinate Picker%esc%[0m
echo %esc%[36m5. Exit%esc%[0m
echo.
echo %esc%[33mSelect option (1-5):%esc%[0m
set /p choice=""

if "%choice%"=="1" call :SaveData_Coordinates
if "%choice%"=="2" call :MainMenu_Coordinates
if "%choice%"=="3" call :General_UI_Coordinates
if "%choice%"=="4" call :Interactive_Picker
if "%choice%"=="5" exit /b
goto :MainMenu

:SaveData_Coordinates
cls
echo %esc%[1;1H%esc%[43;30m SaveData Selector - Coordinate Analysis %esc%[0m

:: å®Ÿéš›ã�®ãƒ‡ã‚£ã‚¹ãƒ—ãƒ¬ã‚¤ã‚’è¡¨ç¤º
for /f "delims=" %%a in (E:\RPGGAME\Systems\Display\[DEV]SelectSaveDataDisplay.txt) do (%%a)

:: ã‚¹ãƒ­ãƒƒãƒˆåº§æ¨™ã‚’è¨ˆç®—ã�—ã�¦è¡¨ç¤º
call :Calculate_SaveData_Slots

:: åº§æ¨™æƒ…å ±ã‚’å·¦å�´ã�«è¡¨ç¤º
call :Display_SaveData_Info

echo.
echo %esc%[45;1H%esc%[35mPress any key to continue...%esc%[0m
pause >nul
goto :MainMenu

:Calculate_SaveData_Slots
echo %esc%[2;1H%esc%[35mSaveData Slot Coordinates:%esc%[0m
echo %esc%[3;1H%esc%[32m--------------------------%esc%[0m

:: å�„ã‚¹ãƒ­ãƒƒãƒˆã�®åº§æ¨™ã‚’è¨ˆç®—
for /l %%i in (1,1,12) do (call :Calculate_SaveSlot_Position %%i)

:Calculate_SaveSlot_Position

setlocal enabledelayedexpansion
set "slot_num=%1"
set /a row_index=(%slot_num% - 1) / 4
set /a col_index=(%slot_num% - 1) %% 4
:: åº§æ¨™è¨ˆç®—ï¼ˆå®Ÿéš›ã�®ä½�ç½®ã�«å�ˆã‚�ã�›ã�¦èª¿æ•´ï¼‰
set /a slot_y=23 + !row_index! * 9
set /a slot_x=61 + !col_index! * 27 - 5
:: åº§æ¨™ã�«è‰²ä»˜ã��ãƒžãƒ¼ã‚«ãƒ¼ã‚’è¡¨ç¤º
echo %esc%[!slot_y!;!slot_x!H%esc%[91m[%slot_num%]%esc%[0m
:: åº§æ¨™æƒ…å ±ã‚’å·¦å�´ã�«è¡¨ç¤º
set /a info_line=4 + %slot_num%
echo %esc%[!info_line!;1H%esc%[36mSlot %slot_num%: %esc%[33mx=!slot_x!, y=!slot_y!%esc%[0m
:: æˆ»ã‚Šå€¤ã‚’è¨­å®š
endlocal
exit /b

:Display_SaveData_Info
echo %esc%[17;1H%esc%[35mCalculation Formula:%esc%[0m
echo %esc%[18;1H%esc%[36my = 20 + (row_index * 9)%esc%[0m
echo %esc%[19;1H%esc%[36mx = 30 + (col_index * 25)%esc%[0m
echo %esc%[20;1H%esc%[32mRow: 0-2 (3 rows), Col: 0-3 (4 cols)%esc%[0m
exit /b

:MainMenu_Coordinates
cls
echo %esc%[1;1H%esc%[43;30m MainMenu - Coordinate Analysis %esc%[0m

:: å®Ÿéš›ã�®ãƒ¡ã‚¤ãƒ³ãƒ¡ãƒ‹ãƒ¥ãƒ¼ã‚’è¡¨ç¤º
for /f "delims=" %%a in (E:\RPGGAME\Systems\Display\[DEV]MainMenuDisplay.txt) do (%%a)

:: ãƒ¡ãƒ‹ãƒ¥ãƒ¼é …ç›®åº§æ¨™ã‚’è¡¨ç¤º
call :Display_MainMenu_Items

echo.
echo %esc%[45;1H%esc%[35mPress any key to continue...%esc%[0m
pause >nul
goto :MainMenu

:Display_MainMenu_Items
echo %esc%[2;1H%esc%[35mMainMenu Item Coordinates:%esc%[0m
echo %esc%[3;1H%esc%[32m-------------------------%esc%[0m

:: ãƒ¡ãƒ‹ãƒ¥ãƒ¼é …ç›®ã�®åº§æ¨™
set menu_items[1]=New Game
set menu_items[2]=Continue
set menu_items[3]=Settings
set menu_items[4]=Quit

set menu_y[1]=36
set menu_y[2]=38
set menu_y[3]=42
set menu_y[4]=44

set menu_x=96

for /l %%i in (1,1,4) do (
    set item_name=!menu_items[%%i]!
    set item_y=!menu_y[%%i]!
    
    :: åº§æ¨™ã�«è‰²ä»˜ã��ãƒžãƒ¼ã‚«ãƒ¼ã‚’è¡¨ç¤º
    echo %esc%[!item_y!;%menu_x%H%esc%[91m!item_name!%esc%[0m
    
    :: åº§æ¨™æƒ…å ±ã‚’å·¦å�´ã�«è¡¨ç¤º
    set /a info_line=4 + %%i
    echo %esc%[!info_line!;1H%esc%[36m!item_name!: %esc%[33mx=%menu_x%, y=!item_y!%esc%[0m
)

exit /b

:Interactive_Picker
:: ???????????
set /p clear_screen="Clear screen before starting? (Y/N): "
if /i "%clear_screen%"=="Y" (
    cls
)
echo %esc%[1;2H%esc%[43;30m Interactive Coordinate Picker %esc%[0m
echo %esc%[2;2H%esc%[36mClick or use arrow keys to select coordinates%esc%[0m
echo %esc%[3;2H%esc%[33mPress 'Q' to quit, 'C' to copy coordinates%esc%[0m

set cursor_x=1
set cursor_y=1

:Picker_Loop
:: ã‚«ãƒ¼ã‚½ãƒ«è¡¨ç¤º
echo %esc%[!cursor_y!;!cursor_x!H%esc%[91m+%esc%[0m

:: åº§æ¨™æƒ…å ±è¡¨ç¤º
echo %esc%[4;2H%esc%[K%esc%[32mCurrent Position: x=!cursor_x!, y=!cursor_y!%esc%[0m

:: ã‚­ãƒ¼å…¥åŠ›å¾…æ©Ÿ
choice /c WASDQC /n >nul 2>&1
REM choice returns 1 for W, 2 for A, 3 for S, 4 for D, 5 for Q, 6 for C
if errorlevel 6 call :Copy_Coordinates
if errorlevel 5 exit /b
if errorlevel 4 (
    echo %esc%[!cursor_y!;!cursor_x!H 
    set /a cursor_x+=1
    goto :Picker_Loop
)
if errorlevel 3 (
    echo %esc%[!cursor_y!;!cursor_x!H 
    set /a cursor_y+=1
    goto :Picker_Loop
)
if errorlevel 2 (
    echo %esc%[!cursor_y!;!cursor_x!H 
    set /a cursor_x-=1
    goto :Picker_Loop
)
if errorlevel 1 (
    echo %esc%[!cursor_y!;!cursor_x!H 
    set /a cursor_y-=1
    goto :Picker_Loop
)







goto :Picker_Loop

:Copy_Coordinates
echo %esc%[5;1H%esc%[K%esc%[93mCoordinates copied: echo %%esc%%[!cursor_y!;!cursor_x!H%esc%[0m
echo echo %%esc%%[!cursor_y!;!cursor_x!H | clip
timeout /t 2 >nul
goto :Picker_Loop

:General_UI_Coordinates
cls
echo %esc%[1;1H%esc%[43;30m General UI - Coordinate Grid %esc%[0m

:: åº§æ¨™ã‚°ãƒªãƒƒãƒ‰ã‚’è¡¨ç¤º
call :Display_Coordinate_Grid

echo.
echo %esc%[45;1H%esc%[35mPress any key to continue...%esc%[0m
pause >nul
goto :MainMenu

:Display_Coordinate_Grid
:: 10x10ã�®ã‚°ãƒªãƒƒãƒ‰ã‚’è¡¨ç¤º
for /l %%y in (10,5,40) do (
    for /l %%x in (20,10,140) do (
        echo %esc%[%%y;%%x H%esc%[90m+%esc%[0m
        echo %esc%[%%y;%%x H%esc%[36m%%x,%%y%esc%[0m
    )
)

:: é‡�è¦�ã�ªåº§æ¨™ã‚’ãƒ�ã‚¤ãƒ©ã‚¤ãƒˆ
echo %esc%[20;80H%esc%[91m[CENTER]%esc%[0m
echo %esc%[10;20H%esc%[92m[TOP-LEFT]%esc%[0m
echo %esc%[40;140H%esc%[93m[BOTTOM-RIGHT]%esc%[0m

exit /b