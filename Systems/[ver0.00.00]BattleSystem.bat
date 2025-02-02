@echo off

call "%cd_enemydata%\Enemy_Status_Slime.bat"

:enemyencount
cls
echo %Enemy_Name% a contact!!
echo.
echo.

:speedcheck
if %Player_SPEED% gtr %Enemy_SPEED% (goto :Player_Turn)
if %Enemy_SPEED% gtr %Player_SPEED% (goto :Enemy_Turn)
if %Player_SPEED% equ %Enemy_SPEED% (
    if %Enemy_LUCK% geq %Player_LUCK% (goto :Enemy_Turn)
)

:EnemyBattleMonitor
rem echo. %Enemy_Name% HP: %Enemy_HP% *Statusを常時見れるのは無し、「心眼」というアイテムorスキルで可能にしたい
rem cls


:Player_Turn
pause > nul
echo.
echo. Your turn!
timeout /t 2 /nobreak > nul
echo %Player_Name% attack to %Enemy_Name%!
set /a Enemy_DAM=%Player_ATK% - %Enemy_DEF%
set /a Enemy_HP-=%Enemy_DAM%
for /l %%w in (1,1,200000) do (
    if %%w equ 200000 (
        echo. %Enemy_Name% took %Enemy_DAM% damage.
    )
)
echo.
if %Enemy_HP% leq 0 (goto :Enemy_DEAD)
goto :Enemy_Turn


:Enemy_Turn
echo.
echo. %Enemy_Name% 's turn!
timeout /t 2 /nobreak > nul
echo %Enemy_Name% attack to %Player_Name%!
set /a Player_DAM=%Enemy_ATK% - %Player_DEF%
set /a Player_HP-=%Player_DAM%
for /l %%w in (1,1,200000) do (
    if %%w equ 200000 (
        echo. %Player_Name% took %Player_DAM% damage.
    )
)
echo.
if %Player_HP% leq 0 (goto :Player_DEAD)
goto :Player_Turn


:Enemy_DEAD
set /a Enemy_LIFE-=1
if %Enemy_LIFE% leq 0 (goto :Player_WIN)

:Player_DEAD
set /a Player_LIFE-=1
if %Player_LIFE% leq 0 (goto :Player_GAMEOVER)


:Player_WIN
for /l %%a in (1,1,6) do (
    echo.
)
echo You WIN!!
timeout /t 1 /nobreak > nul
echo.
echo. You get EXP: %Enemy_EXP%
set /a Player_EXP+=%Enemy_EXP%
echo. You get GOLD: %Enemy_GOLD%
set /a Player_GOLD+=%Enemy_GOLD
echo. Your HP left: %Player_HP%
set /a player_exp_to_next_level-=%Player_EXP%
echo.
echo. EXP need to reach the next level: %player_exp_to_next_level%
echo. 
echo. Press any key.
pause > nul
cls
exit /b


:Player_GAMEOVER
cls
echo. Still In Development(SID)
pause