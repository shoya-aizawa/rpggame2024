@echo on
if not "%1"=="65001" (call :ENCODING_ERROR)
title Main
chcp %1 >nul

:: 起動準備
call "%cd%\Systems\InitializeModule.bat"


:: セーブスロット初期化・検出
call "%cd_systems%\SaveSys\SaveDataDetectSystem.bat"


:: 起動完了
call "%cd_systems_display%\BootCompleteDisplay.bat"


:: 起動サウンド(未定) 


:: メインメニュー処理全般
:Start_MainMenu
    call "%cd_systems%\MainMenuModule.bat"
    if %errorlevel%==1000 goto :Start_Continue
    if %errorlevel%==1001 goto :Start_NewGame
    if %errorlevel%==1002 goto :Start_Settings
    if %errorlevel%==1099 exit 999
::


:: 以下よりセーブデータ選択画面に遷移
:: コンティニュー処理
:Start_Continue
    call "%cd_systems%\SaveModule.bat" continue
    if %errorlevel%==2031 (goto :Start_MainMenu)
    if %errorlevel%==2032 (call :Start_ContinueGame 1)
    if %errorlevel%==2033 (call :Start_ContinueGame 2)
    if %errorlevel%==2034 (call :Start_ContinueGame 3)
::


:: ニューゲーム処理
:Start_NewGame
    call "Systems\SaveModule.bat" newgame
    if %errorlevel%==2099 (goto :Start_MainMenu)
    if %errorlevel%==2041 (call :Start_NewGameSession 1 CreateNew)
    if %errorlevel%==2042 (call :Start_NewGameSession 2 CreateNew)
    if %errorlevel%==2043 (call :Start_NewGameSession 3 CreateNew)
    if %errorlevel%==2051 (call :Start_NewGameSession 1 Overwrite)
    if %errorlevel%==2052 (call :Start_NewGameSession 2 Overwrite)
    if %errorlevel%==2053 (call :Start_NewGameSession 3 Overwrite)
::


:: オプション処理
    :Start_Settings
    call "Systems\OptionModule.bat"
    goto :Start_Settings
::


:: ゲームセッション開始処理
:Start_ContinueGame
    call :Label_IsSelectedSaveData %1
    call :Label_LoadSaveData %1
    call :JumpToEpisode %player_storyroute%
::

:Start_NewGameSession
    call :Label_IsSelectedSaveData %1
    call :Label_PlayerStatus_Initialize
    if "%2"=="CreateNew" (
        call :JumpToEpisode Prologue
    ) else (
        call :Label_OverwriteSaveAndStartNewGame %1
        call :JumpToEpisode Prologue
    )


::
:Start_Scenario
call :JumpToEpisode %player_storyroute%
goto :Scenario_Return
::



:: ストーリー進行処理
:JumpToEpisode
    if "%~1"=="Prologue"       call "Stories\Prologue_Module.bat"
    if "%~1"=="Episode_1"      call "Stories\Episode_01\EntryPoint.bat"
    if "%~1"=="Episode_2"      call "Stories\Episode_02\EntryPoint.bat"
    :: ...今後も増やせる
    exit /b
::


:Scenario_Return
if %errorlevel%==602 (
    echo セーブ完了、ゲームを終了します。
    exit /b 0
)
if %errorlevel%==603 (
    echo セーブ失敗。緊急停止します。
    exit /b 1
)
if %errorlevel%==604 (
    echo プレイヤーによって中断されました。
    exit /b 2
)
goto :Start_Scenario


:Label_PlayerStatus_Initialize
    for /f "tokens=1,2 delims='='" %%a in (
        %cd_playerdata%\Player_Status_Initialize.txt
    ) do (
        set "%%a=%%b"
    ) & rem ここではplayer_変数が初期化
    exit /b 0

:Label_OverwriteSaveAndStartNewGame
    rem 既存のセーブデータを上書きしNewGameをスタート
    set "selected_save=%1"
    del "%cd_savedata%\ESD_%selected_save%.txt" >nul
    del "%cd_savedata%\SaveData_%selected_save%.txt" >nul
    exit /b 0


::Utility
:Label_IsSelectedSaveData
    rem 今後セーブデータ容量を増やす場合forループ範囲の変更をする 現在:3
    for /l %%i in (1,1,3) do (
        rem selected_savedata_: どのセーブデータを選択しているかを示すフラグ (true/false)
        if %%i==%1 (
            set "selected_savedata_%%i=true"
        ) else (
            set "selected_savedata_%%i=false"
        )
    )
    exit /b 0


::Continue
:Label_LoadSaveData
    rem セーブデータのロード
    for /f "tokens=1,2 delims='='" %%a in (
        %cd_savedata%\SaveData_%1.txt
    ) do (
        set "%%a=%%b"
    )
    exit /b 0

:: =======================================================================================================












set newgame=false
set continue=false
call "%cd_systems_display%\MainMenu.bat"
if %errorlevel%==10 (call :Label_Continue)
if %errorlevel%==11 (call :Label_NewGame)
if %errorlevel%==12 (call :Label_Option)
if %errorlevel%==35 (goto :Main1)
if %errorlevel%==45 (goto :Main2)
if %errorlevel%==55 (goto :Main2)
if %errorlevel%==1991 (exit)

if %errorlevel%==10 (call :Label_MainMenu_SelectSaveData Continue)
if %errorlevel%==11 (call :Label_MainMenu_SelectSaveData NewGame)
if %errorlevel%==12 (call :Label_Option)
::
:Label_MainMenu_SelectSaveData
    call "%cd_systems%\Display\MainMenu_SelectSaveData.bat" %1
















::
:Label_Continue
    set continue=true
    call "%cd_systems%\Display\SelectSaveData.bat"
    if %errorlevel%==31 (goto :Label_MainMenu)
    if %errorlevel%==32 (call :Label_ContinueGame 1)
    if %errorlevel%==33 (call :Label_ContinueGame 2)
    if %errorlevel%==34 (call :Label_ContinueGame 3)
    if %errorlevel%==35 (exit /b 35)



:Label_ContinueGame
    call :Label_IsSelectedSaveData %1
    call :Label_LoadSaveData %1
    exit /b 35

:Label_NewGame
    set newgame=true
    call "%cd_systems%\Display\SelectSaveData.bat"
    if %errorlevel%==31 (goto :Label_MainMenu)
    if %errorlevel%==42 (call :Label_StartNewGame 1 CreateNew)
    if %errorlevel%==43 (call :Label_StartNewGame 2 CreateNew)
    if %errorlevel%==44 (call :Label_StartNewGame 3 CreateNew)
    if %errorlevel%==45 (exit /b 45)
    if %errorlevel%==52 (call :Label_StartNewGame 1 Overwrite)
    if %errorlevel%==53 (call :Label_StartNewGame 2 Overwrite)
    if %errorlevel%==54 (call :Label_StartNewGame 3 Overwrite)
    if %errorlevel%==55 (exit /b 55)



:Label_StartNewGame
    call :Label_IsSelectedSaveData %1
    call :Label_PlayerStatus_Initialize
    if "%2"=="CreateNew" (
        exit /b 45
    ) else if "%2"=="Overwrite" (
        call :Label_OverwriteSaveAndStartNewGame %1
        exit /b 55
    )

::
:Label_Option
    goto :OPTION
    ::call "%cd_systems%\Display\MainMenu_Option.bat"
    ::pause




::
::
::****************************************************************************************************************
:Main1
rem Continue
goto %player_lastplace%
:Main2
rem Newgame
call :Label_KillSoundProcess


:EnterPlayerName
call "%cd_newgame%\EntreYourName.bat"
:ReadyForPrologue
call "%cd_newgame%\ReadyForPrologue.bat"
if %errorlevel%==18 (goto :Prologue)
IF %ERRORLEVEL%==666 (GOTO :CRITICAL_ERROR)


:Prologue
call "%cd_stories%\Prologue.bat"
if %errorlevel%==100 (cls& goto :Prologue)& rem エラーコード100予期せぬエラー
if %errorlevel%==602 (exit)& rem 602はセーブして終了のコード



rem 予期しないエラーが発生しました
cls
echo. %ESC%[91mAn unexpected error occurred. [E-100:EOF]
echo. Terminate Systems.%ESC%[0m
call "%cd_systems%\ErrorBeepSounds.bat"
pause >nul
exit /b 100
::****************************************************************************************************************
::
::
::








rem ラベルOPTIONはまだ手を付けなくてok
:OPTION
call :Label_KillSoundProcess
cls
echo.+-------------------------------------------------++-------------------------------------------------+
echo.%P%                                                 %P%%P%                                                 %P%
echo.%P%      (A)        DELETE SAVE DATA                %P%%P%      (C)           NONE                         %P%
echo.%P%                                                 %P%%P%                                                 %P%
echo.+-------------------------------------------------++-------------------------------------------------+
echo.+-------------------------------------------------++-------------------------------------------------+
echo.%P%                                                 %P%%P%                                                 %P%
echo.%P%      (B)           EXIT GAME                    %P%%P%      (D)           SET /P                       %P%
echo.%P%                                                 %P%%P%                                                 %P%
echo.+-------------------------------------------------++-------------------------------------------------+
choice /c ABCDQ
if %errorlevel%==1 (goto :Label_DeleteAllSaveData)
if %errorlevel%==2 (exit /b 1001)
if %errorlevel%==3 (@echo on & goto Label_Main)
if %errorlevel%==4 (goto :Label_DevCommand)
if %errorlevel%==5 (goto :Label_MainMenu)


:Label_DeleteAllSaveData
    echo. 開発段階用緊急停止pause
    echo. 続行しますか？
    pause > nul
    rem これセーブデータ初期化バッチにつき注意（キャンセルできるようにしてます）
    call "%cd_systems%\SaveDataDeleteSystem.bat"
    if %errorlevel%==606 (exit /b 606)
    if %errorlevel%==660 (goto Label_Main)

:Label_DevCommand
    set /p command="command=>"
    %command%
    call :DevCommand





:Label_StartSoundsProcess
    ::start /min %cd_sounds%\SoundsDev.bat
    exit /b 0
:Label_KillSoundProcess
    ::for /f "tokens=2" %%i in ('tasklist /fi "windowtitle eq sounds playing now*" /nh') do (set pid=%%i)
    ::taskkill /f /pid %pid% >nul
    ::exit /b 0

::NewGame




:Exit
    exit
:Label_Exit
    rem 引数によって任意の戻り値設定
    exit /b %1
:Label_Errorlevel_Exit
    exit /b %errorlevel%
::
::
::*******************************************************************************************************
:ENCODING_ERROR
    @ECHO OFF
    CHCP 65001
    COLOR 1F
    CLS
    ECHO.
    ECHO.
    ECHO. Error code: 65001 - A serious encoding error has been detected in the boot sector.
    ECHO.
    ECHO. The system source that is the core of this project is a batch file,
    ECHO.  so if an encoding error occurs, it will cause irreparable problems in the code.
    ECHO.
    ECHO. If this error message appears, the following may be the cause:
    ECHO.
    ECHO. - The game was started by an illegal means other than "Run.bat"
    ECHO. - The source code was rewritten and did not run using the normal startup procedure
    ECHO. - There is a problem with the Windows encoding settings
    ECHO.
    TIMEOUT /T 600
    ECHO.
    ECHO. PRESS ANY KEY TO EXIT.
    PAUSE > NUL

EXIT
::*******************************************************************************************************
::