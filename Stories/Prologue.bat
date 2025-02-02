@echo off
title Prologue - Location: ~Northern Village~
set Player_LastPlace=Prologue



set U=100
set J=7

set cursor_10=%J%& set TMU_10=%U%
set cursor_9=0& set TMU_9=0
set cursor_8=0& set TMU_8=0
set cursor_7=0& set TMU_7=0
set cursor_6=0& set TMU_6=0
set cursor_5=0& set TMU_5=0
set cursor_4=0& set TMU_4=0
set cursor_3=0& set TMU_3=0
set cursor_2=0& set TMU_2=0
set cursor_1=0& set TMU_1=0
set cursor_0=0& set TMU_0=0

:LoadMAP
title Prologue - Location: ~Northern Village~
cls
for /f "delims=" %%a in (%CD_Stories_MAPS%\MAPDATA.txt) do (%%a)
echo.
choice /c WASDFE /m "What r u do?"
if %errorlevel%==1 (goto :W)
if %errorlevel%==2 (goto :A)
if %errorlevel%==3 (goto :S)
if %errorlevel%==4 (goto :D)
if %errorlevel%==5 (goto :F)
if %errorlevel%==6 (goto :E)


:W
if "%cursor_10%" equ "%J%" (
    set /a cursor_9+=%J%& set /a cursor_10-=%J%& set /a TMU_9+=%U%& set /a TMU_10-=%U%& goto :LoadMAP
)
if "%cursor_9%" equ "%J%" (
    set /a cursor_8+=%J%& set /a cursor_9-=%J%& set /a TMU_8+=%U%& set /a TMU_9-=%U%& goto :LoadMAP
)
if "%cursor_8%" equ "%J%" (
    set /a cursor_7+=%J%& set /a cursor_8-=%J%& set /a TMU_7+=%U%& set /a TMU_8-=%U%& goto :LoadMAP
)
if "%cursor_7%" equ "%J%" (
    set /a cursor_6+=%J%& set /a cursor_7-=%J%& set /a TMU_6+=%U%& set /a TMU_7-=%U%& goto :LoadMAP
)
if "%cursor_6%" equ "%J%" (
    set /a cursor_5+=%J%& set /a cursor_6-=%J%& set /a TMU_5+=%U%& set /a TMU_6-=%U%& goto :LoadMAP
)
if "%cursor_5%" equ "%J%" (
    set /a cursor_4+=%J%& set /a cursor_5-=%J%& set /a TMU_4+=%U%& set /a TMU_5-=%U%& goto :LoadMAP
)
if "%cursor_4%" equ "%J%" (
    set /a cursor_3+=%J%& set /a cursor_4-=%J%& set /a TMU_3+=%U%& set /a TMU_4-=%U%& goto :LoadMAP
)
if "%cursor_3%" equ "%J%" (
    set /a cursor_2+=%J%& set /a cursor_3-=%J%& set /a TMU_2+=%U%& set /a TMU_3-=%U%& goto :LoadMAP
)
if "%cursor_2%" equ "%J%" (
    set /a cursor_1+=%J%& set /a cursor_2-=%J%& set /a TMU_1+=%U%& set /a TMU_2-=%U%& goto :LoadMAP
)
if "%cursor_1%" equ "%J%" (goto :LoadMAP)

:A
goto :LoadMAP

:S
if "%cursor_10%" equ "%J%" (goto :LoadMAP)
if "%cursor_9%" equ "%J%" (
    set /a cursor_10+=%J%& set /a cursor_9-=%J%& set /a TMU_10+=%U%& set /a TMU_9-=%U%& goto :LoadMAP
)
if "%cursor_8%" equ "%J%" (
    set /a cursor_9+=%J%& set /a cursor_8-=%J%& set /a TMU_9+=%U%& set /a TMU_8-=%U%& goto :LoadMAP
)
if "%cursor_7%" equ "%J%" (
    set /a cursor_8+=%J%& set /a cursor_7-=%J%& set /a TMU_8+=%U%& set /a TMU_7-=%U%& goto :LoadMAP
)
if "%cursor_6%" equ "%J%" (
    set /a cursor_7+=%J%& set /a cursor_6-=%J%& set /a TMU_7+=%U%& set /a TMU_6-=%U%& goto :LoadMAP
)
if "%cursor_5%" equ "%J%" (
    set /a cursor_6+=%J%& set /a cursor_5-=%J%& set /a TMU_6+=%U%& set /a TMU_5-=%U%& goto :LoadMAP
)
if "%cursor_4%" equ "%J%" (
    set /a cursor_5+=%J%& set /a cursor_4-=%J%& set /a TMU_5+=%U%& set /a TMU_4-=%U%& goto :LoadMAP
)
if "%cursor_3%" equ "%J%" (
    set /a cursor_4+=%J%& set /a cursor_3-=%J%& set /a TMU_4+=%U%& set /a TMU_3-=%U%& goto :LoadMAP
)
if "%cursor_2%" equ "%J%" (
    set /a cursor_3+=%J%& set /a cursor_2-=%J%& set /a TMU_3+=%U%& set /a TMU_2-=%U%& goto :LoadMAP
)
if "%cursor_1%" equ "%J%" (
    set /a cursor_2+=%J%& set /a cursor_1-=%J%& set /a TMU_2+=%U%& set /a TMU_1-=%U%& goto :LoadMAP
)

:D
goto :LoadMAP


:F
goto :LoadMAP


:E
rem Open Inventory
call "%CD_Systems%\InventorySystem.bat"
if %errorlevel%==17 (goto :LoadMAP)
if %errorlevel%==602 (exit /b 602)
if %errorlevel%==900 (exit /b 900)
rem 想定されていないエラーレベルの値が返されたらエラーコード100を表示
cls
echo. %ESC%[91mAn unexpected error occurred. [E-100:EOF]%ESC%[0m
echo. %errorlevel%
call "%cd_sounds%\ErrorBeepSounds.bat"
pause > nul

exit /b 100