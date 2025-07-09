@echo off
echo Setting up environment...
set cd_systems=e:\RPGGAME\Systems
set cd_systems_display=e:\RPGGAME\Systems\Display
set cd_systems_savesys=e:\RPGGAME\Systems\SaveSys
set cd_savedata=e:\RPGGAME\SaveData
for /f %%a in ('cmd /k prompt $e^<nul') do (set "esc=%%a")

echo Environment variables set.
echo Starting SaveDataSelector with debug mode...
set RPG_DEBUG_STATE=1

echo Calling SaveDataSelector.bat...
call "e:\RPGGAME\Systems\SaveSys\SaveDataSelector.bat" CONTINUE

echo SaveDataSelector finished with errorlevel: %errorlevel%
pause
