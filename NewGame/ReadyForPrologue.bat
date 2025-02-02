@echo off

:ReadyForPrologue_1
cls
for /l %%a in (1,1,30) do (
    echo.
    call echo. %%GameText_C_%%a%%
    for /l %%t in (1,1,20000) do (
        if %%t equ 20000 (cls)
        if %%a equ 30 (goto :ReadyForPrologue_2)
    )
)

:ReadyForPrologue_2
timeout /t 2 /nobreak > nul
cls
for /l %%a in (1,1,13) do (
    echo %ESC%[0m
    echo. %GameText_C_30%
    echo %ESC%[35m
    call echo. %%GameText_GotItems_%%a%%
    for /l %%t in (1,1,12000) do (
        if %%t equ 12000 (cls)
        if %%a equ 13 (goto :ReadyForPrologue_3)
    )
)

:ReadyForPrologue_3
timeout /t 1 /nobreak > nul
echo %ESC%[0m
echo. You got the ~Travel guide~
timeout /t 2 /nobreak > nul

echo. Reeding this guide now...

rem チートコード:S903
choice /c 309s /t 2 /d 3 > nul
if %errorlevel%==1 (goto :normal)
if %errorlevel%==2 (goto :normal)
if %errorlevel%==3 (goto :normal)
if %errorlevel%==4 (goto :S903_1)
:S903_1
choice /c s039 /t 1 /d s > nul
if %errorlevel%==1 (goto :normal)
if %errorlevel%==2 (goto :normal)
if %errorlevel%==3 (goto :normal)
if %errorlevel%==4 (goto :S903_2)
:S903_2
choice /c 9s30 /t 1 /d 9 > nul
if %errorlevel%==1 (goto :normal)
if %errorlevel%==2 (goto :normal)
if %errorlevel%==3 (goto :normal)
if %errorlevel%==4 (goto :S903_3)
:S903_3
choice /c s903 /t 1 /d s > nul
if %errorlevel%==1 (goto :normal)
if %errorlevel%==2 (goto :normal)
if %errorlevel%==3 (goto :normal)
if %errorlevel%==4 (cls& goto :cheatmode)
:cheatmode
echo. COMMAND SUCCESS.
echo. Cheat mode request accepted.
for /l %%w in (1,1,100000) do (
    if %%w equ 100000 (
        echo. CODE:S903 been activated.
        echo.
    )
)
call "%CD_NewGame%\Player_Status_DEVELOPER.bat"
timeout /t 1 /nobreak > nul
echo. HP: %Player_HP%
for /l %%w in (1,1,100000) do (
    if %%w equ 100000 (
        echo. MP: %Player_MP%
    )
)
for /l %%w in (1,1,100000) do (
    if %%w equ 100000 (
        echo. Attack: %Player_ATK%
    )
)
for /l %%w in (1,1,100000) do (
    if %%w equ 100000 (
        echo. Defense: %Player_DEF%
    )
)
for /l %%w in (1,1,100000) do (
    if %%w equ 100000 (
        echo. Speed: %Player_SPEED%
    )
)
echo.
echo. Press any Key.
pause > nul

goto :Battle



:normal
    for /f "tokens=1,2 delims='='" %%a in (
        %cd_playerdata%\Player_Status.txt
    ) do (
        set "%%a=%%b"
    )

for /l %%a in (1,1,3) do (
    echo.
)
echo. You notice skills yourself!
echo. 
timeout /t 1 /nobreak > nul
echo. HP: %Player_HP%
for /l %%w in (1,1,100000) do (
    if %%w equ 100000 (
        echo. MP: %Player_MP%
    )
)
for /l %%w in (1,1,100000) do (
    if %%w equ 100000 (
        echo. Attack: %Player_ATK%
    )
)
for /l %%w in (1,1,100000) do (
    if %%w equ 100000 (
        echo. Defense: %Player_DEF%
    )
)
for /l %%w in (1,1,100000) do (
    if %%w equ 100000 (
        echo. Speed: %Player_SPEED%
    )
)
echo.
echo.
echo. Press any Key.
pause > nul



:Battle
call "%cd_Systems%\[ver0.00.00]BattleSystem.bat"



:ReadyForPrologue_4
cls
for /l %%a in (1,1,45) do (
    echo.
    call echo. %%GameText_D_%%a%%
    for /l %%t in (1,1,25000) do (
        if %%t equ 25000 (cls)
        if %%a equ 45 (goto :ReadyForPrologue_5)
    )
)

:ReadyForPrologue_5
timeout /t 3 /nobreak > nul
echo.
echo.
echo. %Player_Name% headed towards the village as he was guided.
echo.
timeout /t 2 /nobreak > nul
echo.                                                    AUTO-SAVE will start soon...
timeout /t 4 /nobreak > nul

title AUTO-SAVE #1
rem 本来はここでラストプレイス設定しないけどsaveがあるためあしからず
rem いったん消してみた20241127
rem set Player_LastPlace=Prologue
call "%CD_Systems%\AutoSaveSequence.bat"
rem オートセーブシーケンスの中にセーブシステム遷移済み20241126
title Prologue
cls
for /l %%a in (1,1,19) do (
    echo.
    call echo. %%GameText_E_%%a%%
    echo.
    for /l %%t in (1,1,20000) do (
        if %%t equ 20000 (cls)
        if %%a equ 19 (break)
    )
)

cls
title Prologue
exit /b 18