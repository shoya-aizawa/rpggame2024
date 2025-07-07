

:: カーソル初期化
set selected_slot_1=7
set selected_slot_2=0
set selected_slot_3=0


:: セーブデータ選択ループ
:SaveDataSelectLoop
    call :Display_SaveDataSelector
    call :GetChoice
    call :HandleKey %choice%




:: ディスプレイ表示関数
:Display_SaveDataSelector
    cls
    for /f "delims=" %%a in (%cd_systems_display%\SelectSaveDataDisplay.txt) do (%%a)
    exit /b 0

:: 選択肢取得関数
:GetChoice
    choice /c WASDFQ >nul
    set choice=%errorlevel%
    exit /b %choice%

