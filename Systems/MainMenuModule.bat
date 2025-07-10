title MainMenu

:: デバッグ状態継承
if defined DEBUG_STATE (
    set debug_mainmenu=%DEBUG_STATE%
) else (
    set debug_mainmenu=0
)

:: 隠しシーケンスは各モジュールで独立管理
set hidden_sequence=

:: キーログ初期化
set key_log_count=0
set key_log_line_1=
set key_log_line_2=
set key_log_line_3=
set key_log_line_4=
set key_log_line_5=

:: デバッグ拡張機能：現在ラベル・変数トラッキング
set debug_current_label=MainMenuModule:Initialize
set debug_last_variables=
set debug_breakpoint_enabled=0
set debug_variable_watch_list=current_selected_menu,choice,hidden_sequence



:: ========== 引数判別,初期化 ==========

:: 返り値の初期化
set mm_retcode=

:: ========== カラーシステム初期化 ==========

:: 現在選択中のメニュー項目（1-4対応）
set current_selected_menu=1

:: 表示設定
set max_menu_items=4

:: ========== カラーコード定義 ==========
set color_selected=7
set color_available=32
set color_unavailable=90
set color_normal=0

:: ========== メインループ ==========

:MainMenuLoop
    call :Initialize_Menu_Colors
    call :Display_MainMenu

:MenuInputLoop
    call :Update_Menu_Colors
    call :Quick_Update_Display
    call :GetChoice
    call :HandleKey %choice%
    if %errorlevel% geq 1000 exit /b %errorlevel%
    goto :MenuInputLoop

:: ========== カラー管理システム ==========

:Initialize_Menu_Colors
    :: 全メニュー項目を利用可能色に初期化
    set menu_1_color=%color_available%
    set menu_2_color=%color_available%
    set menu_3_color=%color_available%
    set menu_4_color=%color_available%

    :: 最初のメニュー項目を選択状態にする
    set menu_1_color=%color_selected%
    exit /b 0

:Update_Menu_Colors
    :: 全メニュー項目を通常色にリセット
    set menu_1_color=%color_available%
    set menu_2_color=%color_available%
    set menu_3_color=%color_available%
    set menu_4_color=%color_available%

    :: 選択中のメニュー項目のみ反転表示
    if "%current_selected_menu%"=="1" set menu_1_color=%color_selected%
    if "%current_selected_menu%"=="2" set menu_2_color=%color_selected%
    if "%current_selected_menu%"=="3" set menu_3_color=%color_selected%
    if "%current_selected_menu%"=="4" set menu_4_color=%color_selected%
    exit /b 0

:: ========== 表示・入力システム ==========

:Display_MainMenu
    :: 画面を常にクリア
    cls

    :: MainMenuDisplay.txtを表示
    for /f "delims=" %%a in (%cd_systems%\Display\MainMenuDisplay.txt) do (%%a)

    :: デバッグモード時の追加処理
    if defined debug_mainmenu (
        if %debug_mainmenu%==1 (
            :: デバッグタイトルを表示
            echo %esc%[1;1H%esc%[43;30m MainMenuModule: デバッグモード %esc%[0m

            :: 初回のみDebug_Info表示
            if not defined debug_initialized (
                call :Display_Debug_Info
                set debug_initialized=1
            )
            call :Display_Debug_Info
        ) else (
            :: 非デバッグ時は初期化フラグをクリア
            set debug_initialized=
        )
    ) else (
        :: 未定義時は初期化フラグをクリア
        set debug_initialized=
    )

    exit /b 0

:GetChoice
    choice /n /c ABCDEFGHIJKLMNOPQRSTUVWXYZ >nul
    set choice=%errorlevel%
    exit /b 0

:: ========== 入力処理システム ==========

:HandleKey
    set key=%1

    :: Aキー - 左方向（MainMenuでは機能なしだがキーログ記録）
    if %key%==1 (
        call :Debug_Set_Label "HandleKey:A_Left"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        call :Move_Left
        exit /b 0
    )

    :: Bキー - 開発中（BRKシーケンス用）
    if %key%==2 (
        call :Debug_Set_Label "HandleKey:B_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        if "%hidden_sequence%"=="BR" (
            set hidden_sequence=BRK
        ) else (
            set hidden_sequence=B
        )
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Cキー - 開発中（COORDシーケンス用）
    if %key%==3 (
        call :Debug_Set_Label "HandleKey:C_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        if "%hidden_sequence%"=="PI" (
            set hidden_sequence=PIC
        ) else if "%hidden_sequence%"=="" (
            set hidden_sequence=C
        ) else (
            set hidden_sequence=
        )
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Dキー - 右方向（MainMenuでは機能なしだがキーログ記録）
    if %key%==4 (
        call :Debug_Set_Label "HandleKey:D_Right"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        if "%hidden_sequence%"=="COOR" (
            set hidden_sequence=COORD
        ) else (
            set hidden_sequence=
        )
        call :Move_Right
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Eキー - 開発中
    if %key%==5 (
        call :Debug_Set_Label "HandleKey:E_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        set hidden_sequence=E
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Fキー - メニュー選択
    if %key%==6 (
        call :Debug_Set_Label "HandleKey:F_Select"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log 6
            call :Update_All_Debug_Info
            timeout /t 1 >nul
        )
        if "%current_selected_menu%"=="1" exit /b 1000
        if "%current_selected_menu%"=="2" exit /b 1001
        if "%current_selected_menu%"=="3" exit /b 1002
        if "%current_selected_menu%"=="4" exit /b 1099
        exit /b 1000
    )

    :: Gキー - 開発中
    if %key%==7 (
        call :Debug_Set_Label "HandleKey:G_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        set hidden_sequence=
        call :Process_Hidden_Sequences
        exit /b 0
    )
    if %key%==8 (
        call :Debug_Set_Label "HandleKey:H_WIP"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        exit /b 0
    )

    :: Iキー - 開発中（PICKシーケンス用）
    if %key%==9 (
        call :Debug_Set_Label "HandleKey:I_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        if "%hidden_sequence%"=="P" (
            set hidden_sequence=PI
        ) else (
            set hidden_sequence=
        )
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Jキー - 開発中
    if %key%==10 (
        call :Debug_Set_Label "HandleKey:J_WIP"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        exit /b 0
    )

    :: Kキー - 開発中（PICK/BRKシーケンス用）
    if %key%==11 (
        call :Debug_Set_Label "HandleKey:K_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        if "%hidden_sequence%"=="PIC" (
            set hidden_sequence=PICK
        ) else if "%hidden_sequence%"=="BR" (
            set hidden_sequence=BRK
        ) else (
            set hidden_sequence=
        )
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Lキー - 開発中
    if %key%==12 (
        call :Debug_Set_Label "HandleKey:L_WIP"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        exit /b 0
    )

    :: Mキー - 開発中
    if %key%==13 (
        call :Debug_Set_Label "HandleKey:M_WIP"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        exit /b 0
    )

    :: Nキー - 開発中
    if %key%==14 (
        call :Debug_Set_Label "HandleKey:N_WIP"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        exit /b 0
    )

    :: Oキー - 開発中（COORDシーケンス用）
    if %key%==15 (
        call :Debug_Set_Label "HandleKey:O_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        if "%hidden_sequence%"=="C" (
            set hidden_sequence=CO
        ) else if "%hidden_sequence%"=="CO" (
            set hidden_sequence=COO
        ) else (
            set hidden_sequence=
        )
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Pキー - 開発中（PICKシーケンス用）
    if %key%==16 (
        call :Debug_Set_Label "HandleKey:P_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        set hidden_sequence=P
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Qキー - 開発中
    if %key%==17 (
        call :Debug_Set_Label "HandleKey:Q_WIP"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        exit /b 0
    )

    :: Rキー - 開発中（BRK/COORDシーケンス用）
    if %key%==18 (
        call :Debug_Set_Label "HandleKey:R_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        if "%hidden_sequence%"=="B" (
            set hidden_sequence=BR
        ) else if "%hidden_sequence%"=="COO" (
            set hidden_sequence=COOR
        ) else (
            set hidden_sequence=
        )
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Sキー - 下方向移動
    if %key%==19 (
        call :Debug_Set_Label "HandleKey:S_Down"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        call :Move_Down
        exit /b 0
    )

    :: Tキー - 開発中
    if %key%==20 (
        call :Debug_Set_Label "HandleKey:T_WIP"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        exit /b 0
    )

    :: Uキー - 開発中
    if %key%==21 (
        call :Debug_Set_Label "HandleKey:U_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        set hidden_sequence=
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Vキー - 開発中
    if %key%==22 (
        call :Debug_Set_Label "HandleKey:V_WIP"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        exit /b 0
    )

    :: Wキー - 上方向移動
    if %key%==23 (
        call :Debug_Set_Label "HandleKey:W_Up"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        call :Move_Up
        exit /b 0
    )

    :: Xキー - 開発中（XYZシーケンス用）
    if %key%==24 (
        call :Debug_Set_Label "HandleKey:X_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        set hidden_sequence=X
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Yキー - 開発中（XYZシーケンス用）
    if %key%==25 (
        call :Debug_Set_Label "HandleKey:Y_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        if "%hidden_sequence%"=="X" (
            set hidden_sequence=XY
        ) else (
            set hidden_sequence=Y
        )
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: Zキー - 開発中（XYZシーケンス用）
    if %key%==26 (
        call :Debug_Set_Label "HandleKey:Z_Hidden"
        if defined debug_mainmenu if %debug_mainmenu%==1 (
            call :Add_Key_Log %key%
        )
        if "%hidden_sequence%"=="XY" (
            set hidden_sequence=XYZ
        ) else (
            set hidden_sequence=Z
        )
        call :Process_Hidden_Sequences
        exit /b 0
    )

    :: 隠しシーケンス処理を呼び出し
    call :Process_Hidden_Sequences

    :: シーケンス長制限（10文字以上でリセット）
    call :Check_Sequence_Length

    exit /b 0

:Process_Hidden_Sequences
    :: デバッグコード: XYZ
    if "%hidden_sequence%"=="XYZ" (
        set hidden_sequence=
        call :Activate_Debug_Mode
        exit /b 0
    )
    
    :: ブレークポイント切り替え: BRK
    if "%hidden_sequence%"=="BRK" (
        set hidden_sequence=
        call :Debug_Toggle_Breakpoint
        exit /b 0
    )

    :: PICKコマンド発動
    if /i "%hidden_sequence%"=="PICK" (
        set hidden_sequence=
        call "%cd_systems%\Debug\InteractivePicker.bat" "MainMenu" "%current_selected_menu%"
        call :Refresh_Display
        exit /b 0
    )

    :: COORDコマンド発動
    if /i "%hidden_sequence%"=="COORD" (
        set hidden_sequence=
        call "%cd_systems%\Debug\CoordinateDebugTool.bat" "MainMenu"
        call :Refresh_Display
        exit /b 0
    )

    exit /b 0

    :: シーケンス長制限（10文字以上でリセット）
    call :Check_Sequence_Length

    exit /b 0


:Check_Sequence_Length
    :: hidden_sequenceの長さをチェック（10文字以上でリセット）
    if defined hidden_sequence (
        if "%hidden_sequence:~10,1%" neq "" (
            set hidden_sequence=
        )
    )
    exit /b 0


:: ========== 表示更新システム ==========

:Quick_Update_Display
    :: メニュー項目は常に部分更新（チカチカ防止）
    echo %esc%[36;96H%esc%[%menu_1_color%m      New Game      %esc%[0m
    echo %esc%[38;96H%esc%[%menu_2_color%m      Continue      %esc%[0m
    echo %esc%[42;96H%esc%[%menu_3_color%m      Settings      %esc%[0m
    echo %esc%[44;96H%esc%[%menu_4_color%m        Quit        %esc%[0m
    :: デバッグモード時の統合更新
    if defined debug_mainmenu if %debug_mainmenu%==1 (
        call :Update_All_Debug_Info
    )
    exit /b 0

:Update_All_Debug_Info
    :: デバッグタイトル維持（統一形式）
    echo %esc%[1;1H%esc%[K
    echo %esc%[1;1H%esc%[43;30m MainMenuModule: デバッグモード %esc%[0m
    
    :: 動的情報の更新
    set current_time=%time:~0,8%
    echo %esc%[2;1H%esc%[K%esc%[93m [%current_time%] Menu: %current_selected_menu%/%max_menu_items% LastKey: %key% %esc%[0m
    echo %esc%[3;1H%esc%[K%esc%[96m Available: %max_menu_items% KeyCount: %key_log_count% %esc%[0m
    echo %esc%[4;1H%esc%[K%esc%[97m Sequence: [%hidden_sequence%] InheritState: %DEBUG_STATE% %esc%[0m

    :: ステータス行の更新
    set status_line=
    if "%current_selected_menu%"=="1" set status_line=[*1][ 2][ 3][ 4]
    if "%current_selected_menu%"=="2" set status_line=[ 1][*2][ 3][ 4]
    if "%current_selected_menu%"=="3" set status_line=[ 1][ 2][*3][ 4]
    if "%current_selected_menu%"=="4" set status_line=[ 1][ 2][ 3][*4]

    echo %esc%[5;1H%esc%[K%esc%[95m MenuItems: %status_line% %esc%[0m
    echo %esc%[6;1H%esc%[K%esc%[94m Commands: W/S=Move F=Select XYZ=Debug %esc%[0m

    :: 拡張デバッグ情報：現在ラベル・変数ウォッチ
    echo %esc%[8;1H%esc%[K%esc%[92m Current Label: %debug_current_label% %esc%[0m
    echo %esc%[9;1H%esc%[K%esc%[91m Variables: %debug_last_variables% %esc%[0m
    echo %esc%[10;1H%esc%[K%esc%[93m Breakpoint: %debug_breakpoint_enabled% Watch: %debug_variable_watch_list% %esc%[0m

    :: キー押下履歴の更新
    echo %esc%[22;1H%esc%[K%esc%[90m Key History (MainMenuModule): %esc%[0m
    echo %esc%[23;1H%esc%[K
    echo %esc%[24;1H%esc%[K
    echo %esc%[25;1H%esc%[K
    echo %esc%[26;1H%esc%[K
    echo %esc%[27;1H%esc%[K
    if defined key_log_line_1 echo %esc%[23;1H%esc%[97m %key_log_line_1% %esc%[0m
    if defined key_log_line_2 echo %esc%[24;1H%esc%[37m %key_log_line_2% %esc%[0m
    if defined key_log_line_3 echo %esc%[25;1H%esc%[37m %key_log_line_3% %esc%[0m
    if defined key_log_line_4 echo %esc%[26;1H%esc%[37m %key_log_line_4% %esc%[0m
    if defined key_log_line_5 echo %esc%[27;1H%esc%[37m %key_log_line_5% %esc%[0m

    exit /b 0

:Activate_Debug_Mode
    echo %esc%[55;90H%esc%[91m ===== DEBUG MODE ACTIVATED ===== %esc%[0m
    :: キーログを初期化
    set key_log_count=0
    set key_log_line_1=
    set key_log_line_2=
    set key_log_line_3=
    set key_log_line_4=
    set key_log_line_5=
    timeout /t 1 >nul
    call :Toggle_Debug_Mode
    exit /b 0

    
:Toggle_Debug_Mode
    if not defined debug_mainmenu set debug_mainmenu=0

    if %debug_mainmenu%==0 (
        set debug_mainmenu=1
        set debug_initialized=
        echo %esc%[1;1H%esc%[43;30m [DEBUG] FALSE -^> TRUE %esc%[0m
        timeout /t 1 >nul
        echo %esc%[1;1H%esc%[K

        :: 環境変数に状態を保存
        set DEBUG_STATE=1
        set RPG_DEBUG_KEYLOG_COUNT=%key_log_count%
        set RPG_DEBUG_LOG1=%key_log_line_1%
        set RPG_DEBUG_LOG2=%key_log_line_2%
        set RPG_DEBUG_LOG3=%key_log_line_3%
        set RPG_DEBUG_LOG4=%key_log_line_4%
        set RPG_DEBUG_LOG5=%key_log_line_5%

        call :Display_Debug_Info
    ) else (
        set debug_mainmenu=0
        set debug_initialized=
        call :Clear_Debug_Info
        echo %esc%[1;1H%esc%[42;30m [DEBUG] TRUE -^> FALSE %esc%[0m
        timeout /t 1 >nul
        echo %esc%[1;1H%esc%[K

        :: 環境変数をクリア
        set DEBUG_STATE=0
        set RPG_DEBUG_KEYLOG_COUNT=0
        set RPG_DEBUG_LOG1=
        set RPG_DEBUG_LOG2=
        set RPG_DEBUG_LOG3=
        set RPG_DEBUG_LOG4=
        set RPG_DEBUG_LOG5=

        call :Refresh_Display
    )
    exit /b 0





:Display_Debug_Info
    :: 現在時刻を取得
    set current_time=%time:~0,8%

    :: デバッグタイトルを統一形式で表示
    echo %esc%[1;1H%esc%[K
    echo %esc%[1;1H%esc%[43;30m MainMenuModule: デバッグモード %esc%[0m

    :: 初回表示時の固定部分のみ描画
    echo %esc%[2;1H%esc%[93m [%current_time%] Menu: %current_selected_menu%/%max_menu_items% LastKey: %key% %esc%[0m
    echo %esc%[3;1H%esc%[96m Available: %max_menu_items% KeyCount: %key_log_count% %esc%[0m
    echo %esc%[4;1H%esc%[97m Sequence: [%hidden_sequence%] InheritState: %DEBUG_STATE% %esc%[0m

    :: メニュー項目の動的状態表示
    set status_line=
    if "%current_selected_menu%"=="1" set status_line=[*1][ 2][ 3][ 4]
    if "%current_selected_menu%"=="2" set status_line=[ 1][*2][ 3][ 4]
    if "%current_selected_menu%"=="3" set status_line=[ 1][ 2][*3][ 4]
    if "%current_selected_menu%"=="4" set status_line=[ 1][ 2][ 3][*4]

    echo %esc%[5;1H%esc%[95m MenuItems: %status_line% %esc%[0m
    echo %esc%[6;1H%esc%[94m Commands: W/S=Move F=Select XYZ=Debug %esc%[0m

    :: 拡張デバッグ情報：現在ラベル・変数ウォッチ
    echo %esc%[8;1H%esc%[92m Current Label: %debug_current_label% %esc%[0m
    echo %esc%[9;1H%esc%[K%esc%[91m Variables: %debug_last_variables% %esc%[0m
    echo %esc%[10;1H%esc%[K%esc%[93m Breakpoint: %debug_breakpoint_enabled% Watch: %debug_variable_watch_list% %esc%[0m

    :: キー押下履歴の初期表示
    echo %esc%[22;1H%esc%[90m Key History (MainMenuModule): %esc%[0m
    echo %esc%[23;1H%esc%[37m %esc%[0m
    echo %esc%[24;1H%esc%[37m %esc%[0m
    echo %esc%[25;1H%esc%[37m %esc%[0m
    echo %esc%[26;1H%esc%[37m %esc%[0m
    echo %esc%[27;1H%esc%[37m %esc%[0m

    exit /b 0

:Clear_Debug_Info
    :: デバッグ情報とキーログをクリア
    for /l %%i in (1,1,30) do (
        echo %esc%[%%i;1H%esc%[K
    )

    :: キーログ変数をクリア
    set key_log_count=
    set key_log_line_1=
    set key_log_line_2=
    set key_log_line_3=
    set key_log_line_4=
    set key_log_line_5=

    :: 一時ファイルをクリア
    if exist %cd_systems_debug%\DEBUG_STATE.dat del %cd_systems_debug%\DEBUG_STATE.dat >nul 2>&1
    exit /b 0


:Add_Key_Log
    set key_pressed=%1
    set /a key_log_count+=1

    :: 簡単な時刻取得
    set current_time=%time:~0,8%

    ::W A S D F X Y Z P I  C  K  O  R
    ::1 2 3 4 5 6 7 8 9 10 11 12 13 14

    :: キー名を人間が読める形に変換
    set key_name=UNKNOWN
    if "%key_pressed%"=="1" set key_name=A(LEFT-INVALID)
    if "%key_pressed%"=="2" set key_name=B(Hidden)
    if "%key_pressed%"=="3" set key_name=C(Hidden)
    if "%key_pressed%"=="4" set key_name=D(RIGHT-INVALID)
    if "%key_pressed%"=="5" set key_name=E(WIP)
    if "%key_pressed%"=="6" set key_name=F(SELECT)
    if "%key_pressed%"=="7" set key_name=G(WIP)
    if "%key_pressed%"=="8" set key_name=H(WIP)
    if "%key_pressed%"=="9" set key_name=I(Hidden)
    if "%key_pressed%"=="10" set key_name=J(WIP)
    if "%key_pressed%"=="11" set key_name=K(Hidden)
    if "%key_pressed%"=="12" set key_name=L(WIP)
    if "%key_pressed%"=="13" set key_name=M(WIP)
    if "%key_pressed%"=="14" set key_name=N(WIP)
    if "%key_pressed%"=="15" set key_name=O(Hidden)
    if "%key_pressed%"=="16" set key_name=P(Hidden)
    if "%key_pressed%"=="17" set key_name=Q(WIP)
    if "%key_pressed%"=="18" set key_name=R(Hidden)
    if "%key_pressed%"=="19" set key_name=S(DOWN)
    if "%key_pressed%"=="20" set key_name=T(WIP)
    if "%key_pressed%"=="21" set key_name=U(WIP)
    if "%key_pressed%"=="22" set key_name=V(WIP)
    if "%key_pressed%"=="23" set key_name=W(UP)
    if "%key_pressed%"=="24" set key_name=X(Hidden)
    if "%key_pressed%"=="25" set key_name=Y(Hidden)
    if "%key_pressed%"=="26" set key_name=Z(Hidden)
    if "%key_pressed%"=="UNKNOWN_KEY" set key_name=(UNKNOWN)

    :: ログをシフト（最新5件を保持）
    set key_log_line_5=%key_log_line_4%
    set key_log_line_4=%key_log_line_3%
    set key_log_line_3=%key_log_line_2%
    set key_log_line_2=%key_log_line_1%
    set key_log_line_1=[%current_time%] #%key_log_count% %key_name% - Menu:%current_selected_menu%

    :: 隠しコマンド判定（4文字コード）
    if "!hidden_sequence!"=="pick" (
        call "%cd_systems%\Debug\InteractivePicker.bat" "MainMenu" "%current_selected_menu%"
        call :Refresh_Display
        set hidden_sequence=
        set key_log_count=0
        exit /b 0
    )
    if "!hidden_sequence!"=="coord" (
        call "%cd_systems%\Debug\CoordinateDebugTool.bat" "MainMenu"
        call :Refresh_Display
        set hidden_sequence=
        set key_log_count=0
        exit /b 0
    )
    if "!hidden_sequence!"=="xyz" (
        call :Activate_Debug_Mode
        set hidden_sequence=
        set key_log_count=0
        exit /b 0
    )

    exit /b 0

:Refresh_Display
    cls
    call :Display_MainMenu
    exit /b 0
:: ========== デバッグ拡張機能 ==========

:Debug_Set_Label
    :: 現在のラベルを設定
    set debug_current_label=%1
    if defined debug_mainmenu if %debug_mainmenu%==1 (
        call :Debug_Update_Variables
    )
    exit /b 0

:Debug_Update_Variables
    :: 監視対象変数の値を更新
    set debug_last_variables=menu:%current_selected_menu% choice:%choice% seq:%hidden_sequence%
    
    :: ブレークポイントが有効な場合は一時停止
    if %debug_breakpoint_enabled%==1 (
        call :Debug_Breakpoint_Pause
    )
    exit /b 0

:Debug_Breakpoint_Pause
    :: 疑似ブレークポイント動作
    echo %esc%[12;1H%esc%[41;97m === BREAKPOINT HIT === %esc%[0m
    echo %esc%[13;1H%esc%[97m Press any key to continue... %esc%[0m
    pause >nul
    echo %esc%[12;1H%esc%[K
    echo %esc%[13;1H%esc%[K
    exit /b 0

:Debug_Toggle_Breakpoint
    :: ブレークポイントのオン/オフ切り替え
    if %debug_breakpoint_enabled%==0 (
        set debug_breakpoint_enabled=1
        echo %esc%[12;1H%esc%[42;30m Breakpoint ENABLED %esc%[0m
    ) else (
        set debug_breakpoint_enabled=0
        echo %esc%[12;1H%esc%[43;30m Breakpoint DISABLED %esc%[0m
    )
    timeout /t 1 >nul
    echo %esc%[12;1H%esc%[K
    exit /b 0

:Debug_Add_Variable_Watch
    :: 変数監視リストに追加
    set debug_variable_watch_list=%debug_variable_watch_list%,%1
    exit /b 0

:Debug_Clear_Variable_Watch
    :: 変数監視リストをクリア
    set debug_variable_watch_list=
    exit /b 0

:Refresh_Display
    :: 画面を再描画
    cls
    call :Display_MainMenu
    exit /b 0

:: ========== カラーテーマ変更システム ==========

:Set_Color_Theme
    if "%1"=="classic" (
        set color_selected=7
        set color_available=32
        set color_unavailable=90
        set color_normal=0
    )
    if "%1"=="modern" (
        set color_selected=112
        set color_available=96
        set color_unavailable=8
        set color_normal=0
    )
    if "%1"=="neon" (
        set color_selected=207
        set color_available=51
        set color_unavailable=8
        set color_normal=0
    )

    call :Initialize_Menu_Colors
    exit /b 0

:: ========== メニュー項目の有効/無効制御 ==========

:Set_Menu_Availability
    :: 引数: メニュー番号 状態（available/unavailable）
    set menu_num=%1
    set availability=%2

    if "%availability%"=="unavailable" (
        if "%menu_num%"=="1" set menu_1_base_color=%color_unavailable%
        if "%menu_num%"=="2" set menu_2_base_color=%color_unavailable%
        if "%menu_num%"=="3" set menu_3_base_color=%color_unavailable%
        if "%menu_num%"=="4" set menu_4_base_color=%color_unavailable%
    ) else (
        if "%menu_num%"=="1" set menu_1_base_color=%color_available%
        if "%menu_num%"=="2" set menu_2_base_color=%color_available%
        if "%menu_num%"=="3" set menu_3_base_color=%color_available%
        if "%menu_num%"=="4" set menu_4_base_color=%color_available%
    )

    call :Update_Menu_Colors
    exit /b 0

:: ========== 移動処理関数 ==========

:Move_Up
    set /a new_menu=%current_selected_menu% - 1
    if %new_menu% lss 1 set new_menu=%max_menu_items%
    set current_selected_menu=%new_menu%
    call :Update_Menu_Colors
    call :Quick_Update_Display
    exit /b 0

:Move_Left
    :: Aキーは無効なので無視
    exit /b 0

:Move_Down
    set /a new_menu=%current_selected_menu% + 1
    if %new_menu% gtr %max_menu_items% set new_menu=1
    set current_selected_menu=%new_menu%
    call :Update_Menu_Colors
    call :Quick_Update_Display
    exit /b 0

:Move_Right
    :: Dキーは無効なので無視
    exit /b 0
