title MainMenu

:: カーソルの色と位置を初期化
set cursor_color=7
set cursor_index=1
call :SetCursor %cursor_index%



:MainMenuLoop
    call :Display_MainMenu
    call :GetChoice
    call :HandleKey %choice%
    if %errorlevel% geq 1000 exit /b %errorlevel%
    goto :MainMenuLoop
:: メインメニューのループ





::　ディスプレイ表示関数
:Display_MainMenu
    cls
    for /f "delims=''" %%a in (%cd_systems%\Display\MainMenuDisplay.txt) do (%%a)
    exit /b 0

:: 選択肢取得関数
:GetChoice
    choice /n /c WASDF >nul
    set choice=%errorlevel%
    exit /b %choice%

:: カーソルの設定関数
:SetCursor
    for /l %%a in (1,1,4) do (
        if %%a == %1 (
            set "select_cursor_%%a=%cursor_color%"
        ) else (
            set "select_cursor_%%a=0"
        )
    )
    exit /b 0

:: 移動・選択関数
:HandleKey
    set key=%1
    if %key%==1 (set /a cursor_index-=1)
    if %key%==2 (exit /b 0)
    if %key%==3 (set /a cursor_index+=1)
    if %key%==4 (exit /b 0)
    if %key%==5 (
        call :HandleSelection
        set retcode=%errorlevel%
        exit /b %retcode%
    )
    if %cursor_index% leq 0 (set cursor_index=1)
    if %cursor_index% geq 4 (set cursor_index=4)
    call :SetCursor %cursor_index%
    exit /b 0

:: 選択肢の処理関数
:HandleSelection
    if %cursor_index%==1 (set retcode=1000)
    if %cursor_index%==2 (set retcode=1001)
    if %cursor_index%==3 (set retcode=1002)
    if %cursor_index%==4 (set retcode=1099)
    exit /b %retcode%