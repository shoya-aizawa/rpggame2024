@echo off

for /f %%i in ('cmd /k prompt $e^<nul') do set ESC=%%i
chcp 65001

set I=100

set Inventory_cursor_1=%I%
set Inventory_cursor_2=0
set Inventory_cursor_3=0
set Inventory_cursor_4=0
set Inventory_cursor_5=0

set Player_Head=            {@}            
set Player_Arm_1=           ╱ ^^^| ╲           
set Player_Arm_2=         ╱  ^^^|    ╲          
set Player_Body=             ^^^|             
set Player_Leg_1=            ╱ ╲            
set Player_Leg_2=          ╱     ╲           


::DisplayAdjustAir
rem Systemファイルに遷移済み(2024/11/25)
rem 起動時に読み込みに変更
rem 変数名に変更なし(%DAA_1%)


set str=%Player_Name%
set len=0
:LOOP1
if not "%str%"=="" (
    set str=%str:~1%
    set /a len=%len%+1
    goto :LOOP1
)
set /a DAA_Name_len=24 - %len%
call set DAA_Name=%%DAA_%DAA_Name_len%%%

set str=%Player_LV%
set len=0
:LOOP2
if not "%str%"=="" (
    set str=%str:~1%
    set /a len=%len%+1
    goto :LOOP2
)
set /a DAA_Lv_len=21 - %len%
call set DAA_Lv=%%DAA_%DAA_Lv_len%%%

set str=%Player_HP%
set len=0
:LOOP3
if not "%str%"=="" (
    set str=%str:~1%
    set /a len=%len%+1
    goto :LOOP3
)
set /a DAA_HP_len=5 - %len%
call set DAA_HP=%%DAA_%DAA_HP_len%%%

set str=%Player_MP%
set len=0
:LOOP4
if not "%str%"=="" (
    set str=%str:~1%
    set /a len=%len%+1
    goto :LOOP4
)
set /a DAA_MP_len=8 - %len%
call set DAA_MP=%%DAA_%DAA_MP_len%%%

set str=%Player_ATK%
set len=0
:LOOP5
if not "%str%"=="" (
    set str=%str:~1%
    set /a len=%len%+1
    goto :LOOP5
)
set /a DAA_ATK_len=5 - %len%
call set DAA_ATK=%%DAA_%DAA_ATK_len%%%

set str=%Player_DEF%
set len=0
:LOOP6
if not "%str%"=="" (
    set str=%str:~1%
    set /a len=%len%+1
    goto :LOOP6
)
set /a DAA_DEF_len=7 - %len%
call set DAA_DEF=%%DAA_%DAA_DEF_len%%%

set str=%Player_NEED_NEXT_LEVEL_EXP%
set len=0
:LOOP7
if not "%str%"=="" (
    set str=%str:~1%
    set /a len=%len%+1
    goto :LOOP7
)
set /a DAA_NEED_NEXT_LEVEL_EXP_len=9 - %len%
call set DAA_NEED_NEXT_LEVEL_EXP=%%DAA_%DAA_NEED_NEXT_LEVEL_EXP_len%%%



:LoadInventory
cls
for /f "delims=" %%a in (%CD_Systems_Display%\InventoryDisplay.txt) do (%%a)
choice /c WASDFEQ > nul
if %errorlevel%==1 (goto :W)
if %errorlevel%==2 (goto :A)
if %errorlevel%==3 (goto :S)
if %errorlevel%==4 (goto :D)
if %errorlevel%==5 (goto :F)
if %errorlevel%==6 (goto :E)
if %errorlevel%==7 (goto :Q)

:W
goto :LoadInventory

:A
if "%Inventory_cursor_1%" equ "%I%" (goto :LoadInventory)
if "%Inventory_cursor_2%" equ "%I%" (
    set /a Inventory_cursor_1+=%I%& set /a Inventory_cursor_2-=%I%& goto :LoadInventory
)
if "%Inventory_cursor_3%" equ "%I%" (
    set /a Inventory_cursor_2+=%I%& set /a Inventory_cursor_3-=%I%& goto :LoadInventory
)
if "%Inventory_cursor_4%" equ "%I%" (
    set /a Inventory_cursor_3+=%I%& set /a Inventory_cursor_4-=%I%& goto :LoadInventory
)
if "%Inventory_cursor_5%" equ "%I%" (
    set /a Inventory_cursor_4+=%I%& set /a Inventory_cursor_5-=%I%& goto :LoadInventory
)

:S
goto :LoadInventory

:D
if "%Inventory_cursor_1%" equ "%I%" (
    set /a Inventory_cursor_2+=%I%& set /a Inventory_cursor_1-=%I%& goto :LoadInventory
)
if "%Inventory_cursor_2%" equ "%I%" (
    set /a Inventory_cursor_3+=%I%& set /a Inventory_cursor_2-=%I%& goto :LoadInventory
)
if "%Inventory_cursor_3%" equ "%I%" (
    set /a Inventory_cursor_4+=%I%& set /a Inventory_cursor_3-=%I%& goto :LoadInventory
)
if "%Inventory_cursor_4%" equ "%I%" (
    set /a Inventory_cursor_5+=%I%& set /a Inventory_cursor_4-=%I%& goto :LoadInventory
)
if "%Inventory_cursor_5%" equ "%I%" (set Player_ATK=100& goto :LoadInventory)

:F
if "%Inventory_cursor_4%" equ "%I%" (goto :TEST)
if "%Inventory_cursor_5%" equ "%I%" (goto :SaveSequence)


:E
:Q
goto :close_Inventory



:TEST
exit /b 777


:SaveSequence
cls
for /f "delims=" %%a in (%CD_Systems_Display%\InventoryDisplay.txt) do (%%a)
echo.
echo. u want 2 save?
choice /c FQ
if %errorlevel%==1 (set /a Player_SAVES+=1 & goto :Save)
if %errorlevel%==2 (goto :LoadInventory)

:Save
set MANUALSAVE=true
call "%CD_Systems%\MainSaveSystem.bat"


rem ロード演出


@echo off
cls
for /f "delims=" %%a in (%CD_Systems_Display%\InventoryDisplay.txt) do (%%a)
echo.
echo. Data saving completed.
timeout /t 2 /nobreak > nul

:EXIT_GAME
cls
for /f "delims=" %%a in (%CD_Systems_Display%\InventoryDisplay.txt) do (%%a)
echo.

::for /l %%a in (1,1,6) do (
::    echo.
::)

echo. %ESC%[1mAre you sure you want to exit the game?%ESC%[0m
choice /c FQ
if %errorlevel%==1 (exit /b 602)
if %errorlevel%==2 (goto :LoadInventory)

:close_Inventory
exit /b 17