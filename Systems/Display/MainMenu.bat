title MainMenu

:: 初期化
set cursor_color=7
set cursor_index=1
call :SetCursor %cursor_index%

:Label_PressAnyKey
    ::for /f "delims=" %%a in (%cd_systems%\Display\MainMenuDisplay.txt) do (%%a)
    ::pause >nul



:Label_MainMenu_Display
    for /f "delims=''" %%a in (%cd_systems%\Display\MainMenuDisplay.txt) do (%%a)
    call :GetChoice

    if %choice%==1 (call :W)
    if %choice%==2 (call :A)
    if %choice%==3 (call :S)
    if %choice%==4 (call :D)
    if %choice%==5 (call :F)
    if %errorlevel%==10 (exit /b 10)
    if %errorlevel%==11 (exit /b 11)
    if %errorlevel%==12 (exit /b 12)
    if %errorlevel%==13 (exit /b 1991)
    goto :Label_MainMenu_Display

:W
    set /a cursor_index-=1
    if %cursor_index% leq 0 (set cursor_index=1)
    call :SetCursor %cursor_index%
    exit /b 0

:A
    exit /b 0

:S
    set /a cursor_index+=1
    if %cursor_index% geq 4 (set cursor_index=4)
    call :SetCursor %cursor_index%
    exit /b 0

:D
    exit /b 0

:F
    if %cursor_index%==1 (goto :ContinueGame)
    if %cursor_index%==2 (goto :StartNewGame)
    if %cursor_index%==3 (goto :Settings)
    if %cursor_index%==4 (exit /b 13)
    if %errorlevel%==10 (exit /b 10)
    if %errorlevel%==11 (exit /b 11)
    if %errorlevel%==12 (exit /b 12)
    if %errorlevel%==20 (exit /b 0)
    if %errorlevel%==21 (exit /b 0)
    if %errorlevel%==22 (exit /b 0)

:: 関数ラベル
:SetCursor
    for /l %%a in (1,1,4) do (
        if %%a == %1 (
            set "select_cursor_%%a=%cursor_color%"
        ) else (
            set "select_cursor_%%a=0"
        )
    )
    exit /b 0

:GetChoice
    choice /n /c WASDF >nul
    set choice=%errorlevel%
    exit /b %errorlevel%

::
:ContinueGame
    for /f "delims=" %%a in (%cd_systems%\Display\MainMenuDisplay.txt) do (%%a)
    echo. Continue?
    choice /n /c FQ
    if %errorlevel%==1 (exit /b 10)
    if %errorlevel%==2 (exit /b 20)

:StartNewGame
    echo. Wanna New Game?
    choice /n /c FQ
    if %errorlevel%==1 (exit /b 11)
    if %errorlevel%==2 (exit /b 21)

:Settings
    echo. Check Settings?
    choice /n /c FQ
    if %errorlevel%==1 (exit /b 12)
    if %errorlevel%==2 (exit /b 22)


:pause
echo NICE PAUSE
pause
exit /b