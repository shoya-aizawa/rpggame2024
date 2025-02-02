::@echo on

set CSD_color_1=7
set CSD_color_2=0
set CSD_color_3=0

:display
cls
for /f "delims=" %%a in (%cd_systems%\Display\SelectSaveDataDisplay.txt) do (%%a)

choice /c WASDFQ
if %errorlevel%==1 (goto :W)
if %errorlevel%==2 (goto :A)
if %errorlevel%==3 (goto :S)
if %errorlevel%==4 (goto :D)
if %errorlevel%==5 (goto :F)
if %errorlevel%==6 (goto :Q)

:W
if "%CSD_color_1%" equ "7" (goto :display)
if "%CSD_color_2%" equ "7" (set /a CSD_color_1+=7 & set /a CSD_color_2-=7 & goto :display)
if "%CSD_color_3%" equ "7" (set /a CSD_color_2+=7 & set /a CSD_color_3-=7 & goto :display)

:A
goto :display

:S
if "%CSD_color_1%" equ "7" (set /a CSD_color_2+=7 & set /a CSD_color_1-=7 & goto :display)
if "%CSD_color_2%" equ "7" (set /a CSD_color_3+=7 & set /a CSD_color_2-=7 & goto :display)
if "%CSD_color_3%" equ "7" (goto :display)

:D
goto :display

:F
if "%CSD_color_1%" equ "7" (goto :SaveData_1)
if "%CSD_color_2%" equ "7" (goto :SaveData_2)
if "%CSD_color_3%" equ "7" (goto :SaveData_3)

:Q
if %NEWGAME%==true (
    set NEWGAME=false
)
if %CONTINUE%==true (
    set CONTINUE=false
)
exit /b 31

::........................................................................
:SaveData_1

if exist "%CD_SaveData%\ESD_1.txt" (
    if "%NEWGAME%"=="true" (
        goto :Overwrite_SD1
    ) else (goto :Continue_SD1)
)

if not exist "%CD_SaveData%\ESD_1.txt" (
    goto :Create_SD1
)

:Overwrite_SD1
echo. Do you want to overwrite the existing "SaveData:1"?
rem 既存のセーブデータを上書きしますか?
choice /c FQ
if %errorlevel%==1 (exit /b 52)
if %errorlevel%==2 (goto :display)

:Continue_SD1
echo. Do you want to continue from this "SaveData:1"?
rem この「SaveData1」から続行しますか?
choice /c FQ
if %errorlevel%==1 (exit /b 32)
if %errorlevel%==2 (goto :display)

:Create_SD1
if "%CONTINUE%"=="true" (
    echo. This save data is empty.
    timeout /t 1 /nobreak > nul
    goto :display
)
echo. Start a new game in "SaveData:1"?
rem 「セーブデータ1」で新しいゲームを開始しますか?
choice /c FQ
if %errorlevel%==1 (exit /b 42)
if %errorlevel%==2 (goto :display)

::....................................................................



:SaveData_2

if exist "%CD_SaveData%\ESD_2.txt" (
    if "%NEWGAME%"=="true" (
        goto :Overwrite_SD2
    ) else (goto :Continue_SD2)
)

if not exist "%CD_SaveData%\ESD_2.txt" (
    goto :Create_SD2
)

:Overwrite_SD2
echo. Do you want to overwrite the existing "SaveData:2"?
rem 既存のセーブデータを上書きしますか?
choice /c FQ
if %errorlevel%==1 (exit /b 53)
if %errorlevel%==2 (goto :display)

:Continue_SD2
echo. Do you want to continue from this "SaveData:2"?
rem この「SaveData2」から続行しますか?
choice /c FQ
if %errorlevel%==1 (exit /b 33)
if %errorlevel%==2 (goto :display)

:Create_SD2
if "%CONTINUE%"=="true" (
    echo. This save data is empty.
    timeout /t 1 /nobreak > nul
    goto :display
)
echo. Start a new game in "SaveData:2"?
rem 「セーブデータ2」で新しいゲームを開始しますか?
choice /c FQ
if %errorlevel%==1 (exit /b 43)
if %errorlevel%==2 (goto :display)

:SaveData_3

if exist "%CD_SaveData%\ESD_3.txt" (
    if "%NEWGAME%"=="true" (
        goto :Overwrite_SD3
    ) else (goto :Continue_SD3)
)

if not exist "%CD_SaveData%\ESD_3.txt" (
    goto :Create_SD3
)

:Overwrite_SD3
echo. Do you want to overwrite the existing "SaveData:3"?
rem 既存のセーブデータを上書きしますか?
choice /c FQ
if %errorlevel%==1 (exit /b 54)
if %errorlevel%==2 (goto :display)

:Continue_SD3
echo. Do you want to continue from this "SaveData:3"?
rem この「SaveData3」から続行しますか?
choice /c FQ
if %errorlevel%==1 (exit /b 34)
if %errorlevel%==2 (goto :display)

:Create_SD3
if "%CONTINUE%"=="true" (
    echo. This save data is empty.
    timeout /t 1 /nobreak > nul
    goto :display
)
echo. Start a new game in "SaveData:3"?
rem 「セーブデータ3」で新しいゲームを開始しますか?
choice /c FQ
if %errorlevel%==1 (exit /b 44)
if %errorlevel%==2 (goto :display)







