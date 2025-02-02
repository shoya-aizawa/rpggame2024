title New Game
:GameText_A
cls
for /l %%a in (1,1,28) do (
    echo.
    call echo. %%GameText_A_%%a%%
    for /l %%t in (1,1,15000) do (
        if %%t equ 15000 (cls)
        if %%a equ 28 (break)
    )
    break
)

:EnterPlayerName
cls
echo.
echo. %GameText_A_28%
echo.

timeout /t 1 /nobreak > nul
set /p Player_Name="-->"

set str=%Player_Name%
set len=0
:LOOP
if not "%str%"=="" (
    set str=%str:~1%
    set /a len=%len%+1
    goto :LOOP
)

if %len% geq 24 (
    echo. Your name too long!!
    rem echo %len%
    timeout /t 2 /nobreak > nul
    goto :EnterPlayerName
)

echo.
echo your name is %Player_Name% ?
choice /c FQ
if %errorlevel%==1 (goto :GameText_B)
if %errorlevel%==2 (goto :EnterPlayerName)

:GameText_B
rem 名前入力によるリログ
call "%cd_newgame%\TextFile.bat"
cls
for /l %%a in (1,1,42) do (
    echo.
    call echo. %%GameText_B_%%a%%
    for /l %%t in (1,1,50000) do (
        if %%t equ 50000 (cls)
        if %%a equ 42 (break)
    )
    break
)


exit /b 28