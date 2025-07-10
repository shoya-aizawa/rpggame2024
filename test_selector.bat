@echo off
chcp 65001 >nul

:: ???????
call "%~dp0Systems\InitializeModule.bat"

:: ?????????????
set DEBUG_STATE=1

echo Testing SaveDataSelector.bat with debug mode enabled
echo Press XYZ to activate debug mode, then use W/A/S/D to move
echo.

:: SaveDataSelector???
call "%cd_systems_savesys%\SaveDataSelector.bat" CONTINUE

echo.
echo SaveDataSelector returned with errorlevel: %errorlevel%
pause
