@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

for /f %%a in ('cmd /k prompt $e^<nul') do (set "esc=%%a")

set module_name=%~1
set current_state=%~2

if "%module_name%"=="MainMenu" (
    set cursor_x=105
    set cursor_y=29
    set picker_title=MainMenu Interactive Picker
) else if "%module_name%"=="SaveData" (
    set cursor_x=56
    set cursor_y=23
    set picker_title=SaveData Interactive Picker
) else (
    set cursor_x=80
    set cursor_y=25
    set picker_title=Generic Interactive Picker
)

:Interactive_Picker_Start
    echo %esc%[1;2H%esc%[43;30m %picker_title% %esc%[0m
    echo %esc%[1;2H%esc%[43;30m %picker_title% %esc%[0m
    echo %esc%[2;2H%esc%[36mUse WASD to move cursor, C to copy coordinates%esc%[0m
    echo %esc%[3;2H%esc%[33mPress Q to quit, R to reset position%esc%[0m
    if "%module_name%"=="SaveData" (
        echo %esc%[4;2H%esc%[35mPress S to snap to nearest slot%esc%[0m
    ) else (
        echo %esc%[4;2H%esc%[35mPress T to test coordinate%esc%[0m
    )
    
    :Picker_Loop

    echo %esc%[!cursor_y!;!cursor_x!H%esc%[91m+%esc%[0m

    echo %esc%[5;2H%esc%[K%esc%[32mPosition: x=!cursor_x!, y=!cursor_y!%esc%[0m
    
    if "%module_name%"=="MainMenu" (
        call :Calculate_MainMenu_Distance !cursor_x! !cursor_y!
    ) else if "%module_name%"=="SaveData" (
        call :Calculate_SaveData_Distance !cursor_x! !cursor_y!
    )
    
    :: キー入力待機
    if "%module_name%"=="SaveData" (
        choice /c WASDQCRST /n >nul 2>&1
        if errorlevel 9 call :Test_Coordinate
        if errorlevel 8 call :Snap_To_Nearest_Slot
    ) else (
        choice /c WASDQCRT /n >nul 2>&1
        if errorlevel 8 call :Test_Coordinate
    )
    
    if errorlevel 7 (
        if "%module_name%"=="MainMenu" (
            set cursor_x=96
            set cursor_y=36
        ) else (
            set cursor_x=56
            set cursor_y=23
        )
        goto :Picker_Loop
    )
    if errorlevel 6 call :Copy_Coordinates
    if errorlevel 5 exit /b 0
    if errorlevel 4 (
        echo %esc%[!cursor_y!;!cursor_x!H 
        set /a cursor_x+=1
        goto :Picker_Loop
    )
    if errorlevel 3 (
        echo %esc%[!cursor_y!;!cursor_x!H 
        set /a cursor_y+=1
        goto :Picker_Loop
    )
    if errorlevel 2 (
        echo %esc%[!cursor_y!;!cursor_x!H 
        set /a cursor_x-=1
        goto :Picker_Loop
    )
    if errorlevel 1 (
        echo %esc%[!cursor_y!;!cursor_x!H 
        set /a cursor_y-=1
        goto :Picker_Loop
    )
    
    goto :Picker_Loop

:Calculate_MainMenu_Distance
    set check_x=%1
    set check_y=%2
    
    set distance_info=
    if %check_y%==36 if %check_x%==96 set distance_info=%esc%[93m[New Game Position]%esc%[0m
    if %check_y%==38 if %check_x%==96 set distance_info=%esc%[93m[Continue Position]%esc%[0m
    if %check_y%==42 if %check_x%==96 set distance_info=%esc%[93m[Settings Position]%esc%[0m
    if %check_y%==44 if %check_x%==96 set distance_info=%esc%[93m[Quit Position]%esc%[0m
    
    echo %esc%[6;2H%esc%[K%esc%[36m!distance_info!%esc%[0m
    exit /b 0

:Calculate_SaveData_Distance
    set check_x=%1
    set check_y=%2
    
    set distance_info=
    

    for /l %%i in (1,1,12) do (
        set /a row_index=(%%i - 1) / 4
        set /a col_index=(%%i - 1) %% 4
        set /a slot_y=23 + !row_index! * 9
        set /a slot_x=56 + !col_index! * 27
        
        if %check_y%==!slot_y! if %check_x%==!slot_x! (
            set distance_info=%esc%[93m[Slot %%i Position]%esc%[0m
        )
    )
    
    echo %esc%[6;2H%esc%[K%esc%[36m!distance_info!%esc%[0m
    exit /b 0

:Snap_To_Nearest_Slot
    set min_distance=9999
    set target_x=%cursor_x%
    set target_y=%cursor_y%
    
    for /l %%i in (1,1,12) do (
        set /a row_index=(%%i - 1) / 4
        set /a col_index=(%%i - 1) %% 4
        set /a slot_y=23 + !row_index! * 9
        set /a slot_x=56 + !col_index! * 27
        
        set /a distance_x=!cursor_x! - !slot_x!
        set /a distance_y=!cursor_y! - !slot_y!
        if !distance_x! lss 0 set /a distance_x=0 - !distance_x!
        if !distance_y! lss 0 set /a distance_y=0 - !distance_y!
        set /a total_distance=!distance_x! + !distance_y!
        
        if !total_distance! lss !min_distance! (
            set min_distance=!total_distance!
            set target_x=!slot_x!
            set target_y=!slot_y!
        )
    )
    
    echo %esc%[!cursor_y!;!cursor_x!H 
    set cursor_x=%target_x%
    set cursor_y=%target_y%
    
    exit /b 0

:Copy_Coordinates
    echo %esc%[7;2H%esc%[K%esc%[93mCoordinates copied: echo %%esc%%[!cursor_y!;!cursor_x!H%esc%[0m
    echo echo %%esc%%[!cursor_y!;!cursor_x!H | clip
    timeout /t 2 >nul
    exit /b 0

:Test_Coordinate
    echo %esc%[!cursor_y!;!cursor_x!H%esc%[95m[TEST]%esc%[0m
    timeout /t 1 >nul
    echo %esc%[!cursor_y!;!cursor_x!H%esc%[K
    exit /b 0