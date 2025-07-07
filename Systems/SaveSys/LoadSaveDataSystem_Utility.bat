@echo on

cd "%CD%\SaveData"



if "%ESD_1%"=="true" (
    for /f "delims=" %%a in (SaveData_1.txt) do (%%a)
    set GOTO=%Player_LastPlace%
    cd ".."
    exit /b 33
)


if "%ESD_2%"=="true" (
    for /f "delims=" %%a in (SaveData_2.txt) do (%%a)
    set GOTO=%Player_LastPlace%
    cd ".."
    exit /b 33
)


if "%ESD_3%"=="true" (
    for /f "delims=" %%a in (SaveData_3.txt) do (%%a)
    set GOTO=%Player_LastPlace%
    cd ".."
    exit /b 33
)