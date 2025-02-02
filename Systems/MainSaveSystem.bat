@echo on

title Data save system

cd "%cd%\SaveData"

rem 手動セーブしたか判定
if "%manualsave%"=="true" (
    goto :AddSaveData_0
)


rem オートセーブとしてここに来たか判定
if "%autosave%"=="true" (
    goto :AddSaveData_0
) else if "%autosave%"=="false" (
    goto :CreateSaveData_0
)


:CreateSaveData_0
if "%ESD_1%"=="true" (
    goto :CreateSaveData_1
)

if "%ESD_2%"=="true" (
    goto :CreateSaveData_2
)

if "%ESD_3%"=="true" (
    goto :CreateSaveData_3
)



:AddSaveData_0
rem オートセーブ判定で引っかかってしまった初回セーブの民を移送
if %player_save_count% equ 1 (goto :CreateSaveData_0)

if exist "ESD_1.txt" (
    if "%ESD_1%"=="true" (
        goto :AddSaveData_1
    )
)

if exist "ESD_2.txt" (
    if "%ESD_2%"=="true" (
        goto :AddSaveData_2
    )
)

if exist "ESD_3.txt" (
    if "%ESD_3%"=="true" (
        goto :AddSaveData_3
    )
)






if "%ESD_1%"=="false" (goto :CreateSaveData_1)
if "%ESD_2%"=="false" (goto :CreateSaveData_2)
if "%ESD_3%"=="false" (goto :CreateSaveData_3)


::********************************************************
:ERROR_CODE_666
rem 上記の条件どれにも引っかからない場合(重大なエラーとして記録)
COLOR 4f
CLS
ECHO.
ECHO.     ========================
ECHO.     DETECTIVE CRITICAL ERROR
ECHO.     ========================
ECHO.
ECHO.        ERROR CODE : 666
ECHO.    RISK OF CORRUPTED SAVE DATA
ECHO.
CD ".."
CALL "%CD%\Systems\CriticalErrorBeepSounds .bat"
CHCP 65001

ECHO %DATE%-%TIME% >> RECOVERY_FILE_EC666.txt
DIR/S >> RECOVERY_FILE_EC666.txt

PAUSE
COLOR & EXIT /B 666
::********************************************************




:CreateSaveData_1

setlocal enabledelayedexpansion

echo Start recording log SD_1 - %DATE%-%TIME%> ESD_1.txt


echo player_save_count=!player_save_count!> SaveData_1.txt

echo Player_Name=%Player_Name%>> SaveData_1.txt

echo Player_LV=!Player_LV!>> SaveData_1.txt
echo Player_HP=!Player_HP!>> SaveData_1.txt
echo Player_MP=!Player_MP!>> SaveData_1.txt
echo Player_ATK=!Player_ATK!>> SaveData_1.txt
echo Player_DEF=!Player_DEF!>> SaveData_1.txt
echo Player_SPEED=!Player_SPEED!>> SaveData_1.txt

echo Player_LUCK=!Player_LUCK!>> SaveData_1.txt


echo Player_DAM=!Player_DAM!>> SaveData_1.txt
echo Player_LIFE=!Player_LIFE!>> SaveData_1.txt

echo Player_EXP=!Player_EXP!>> SaveData_1.txt
echo player_money=!player_money!>> SaveData_1.txt

echo player_exp_to_next_level=!player_exp_to_next_level!>> SaveData_1.txt

echo Player_LastPlace=!Player_LastPlace!>> SaveData_1.txt

endlocal
goto :END
:CreateSaveData_2

setlocal enabledelayedexpansion

echo echo Start recording log SD_2 - !DATE!-!TIME!> ESD_2.txt

echo player_save_count=!player_save_count!> SaveData_2.txt

echo Player_Name=!Player_Name!>> SaveData_2.txt

echo Player_LV=!Player_LV!>> SaveData_2.txt
echo Player_HP=!Player_HP!>> SaveData_2.txt
echo Player_MP=!Player_MP!>> SaveData_2.txt
echo Player_ATK=!Player_ATK!>> SaveData_2.txt
echo Player_DEF=!Player_DEF!>> SaveData_2.txt
echo Player_SPEED=!Player_SPEED!>> SaveData_2.txt

echo Player_LUCK=!Player_LUCK!>> SaveData_2.txt


echo Player_DAM=!Player_DAM!>> SaveData_2.txt
echo Player_LIFE=!Player_LIFE!>> SaveData_2.txt

echo Player_EXP=!Player_EXP!>> SaveData_2.txt
echo player_money=!player_money!>> SaveData_2.txt

echo player_exp_to_next_level=!player_exp_to_next_level!>> SaveData_2.txt

echo Player_LastPlace=!Player_LastPlace!>> SaveData_2.txt

endlocal
goto :END
:CreateSaveData_3

setlocal enabledelayedexpansion

echo echo Start recording log SD_3 - !DATE!-!TIME!> ESD_3.txt

echo player_save_count=!player_save_count!> SaveData_3.txt

echo Player_Name=!Player_Name!>> SaveData_3.txt

echo Player_LV=!Player_LV!>> SaveData_3.txt
echo Player_HP=!Player_HP!>> SaveData_3.txt
echo Player_MP=!Player_MP!>> SaveData_3.txt
echo Player_ATK=!Player_ATK!>> SaveData_3.txt
echo Player_DEF=!Player_DEF!>> SaveData_3.txt
echo Player_SPEED=!Player_SPEED!>> SaveData_3.txt

echo Player_LUCK=!Player_LUCK!>> SaveData_3.txt


echo Player_DAM=!Player_DAM!>> SaveData_3.txt
echo Player_LIFE=!Player_LIFE!>> SaveData_3.txt

echo Player_EXP=!Player_EXP!>> SaveData_3.txt
echo player_money=!player_money!>> SaveData_3.txt

echo player_exp_to_next_level=!player_exp_to_next_level!>> SaveData_3.txt

echo Player_LastPlace=!Player_LastPlace!>> SaveData_3.txt

endlocal
goto :END
:FullofData
cls
echo. Empty SaveData Slots.
rem ここで上書き保存を選択する
echo.
echo. Press any key.
pause > nul
goto :END





:AddSaveData_1

setlocal enabledelayedexpansion

echo AddSaveData in !DATE!-!TIME!>> ESD_1.txt

echo player_save_count=!player_save_count!> SaveData_1.txt

echo Player_Name=!Player_Name!>> SaveData_1.txt

echo Player_LV=!Player_LV!>> SaveData_1.txt
echo Player_HP=!Player_HP!>> SaveData_1.txt
echo Player_MP=!Player_MP!>> SaveData_1.txt
echo Player_ATK=!Player_ATK!>> SaveData_1.txt
echo Player_DEF=!Player_DEF!>> SaveData_1.txt
echo Player_SPEED=!Player_SPEED!>> SaveData_1.txt

echo Player_LUCK=!Player_LUCK!>> SaveData_1.txt


echo Player_DAM=!Player_DAM!>> SaveData_1.txt
echo Player_LIFE=!Player_LIFE!>> SaveData_1.txt

echo Player_EXP=!Player_EXP!>> SaveData_1.txt
echo player_money=!player_money!>> SaveData_1.txt

echo player_exp_to_next_level=!player_exp_to_next_level!>> SaveData_1.txt

echo Player_LastPlace=!Player_LastPlace!>> SaveData_1.txt

endlocal
goto :END
:AddSaveData_2

setlocal enabledelayedexpansion

echo AddSaveData in !DATE!-!TIME!>> ESD_2.txt

echo player_save_count=!player_save_count!> SaveData_2.txt

echo Player_Name=!Player_Name!>> SaveData_2.txt

echo Player_LV=!Player_LV!>> SaveData_2.txt
echo Player_HP=!Player_HP!>> SaveData_2.txt
echo Player_MP=!Player_MP!>> SaveData_2.txt
echo Player_ATK=!Player_ATK!>> SaveData_2.txt
echo Player_DEF=!Player_DEF!>> SaveData_2.txt
echo Player_SPEED=!Player_SPEED!>> SaveData_2.txt

echo Player_LUCK=!Player_LUCK!>> SaveData_2.txt


echo Player_DAM=!Player_DAM!>> SaveData_2.txt
echo Player_LIFE=!Player_LIFE!>> SaveData_2.txt

echo Player_EXP=!Player_EXP!>> SaveData_2.txt
echo player_money=!player_money!>> SaveData_2.txt

echo player_exp_to_next_level=!player_exp_to_next_level!>> SaveData_2.txt

echo Player_LastPlace=!Player_LastPlace!>> SaveData_2.txt

endlocal
goto :END
:AddSaveData_3

setlocal enabledelayedexpansion

echo AddSaveData in !DATE!-!TIME!>> ESD_3.txt

echo player_save_count=!player_save_count!> SaveData_3.txt

echo Player_Name=!Player_Name!>> SaveData_3.txt

echo Player_LV=!Player_LV!>> SaveData_3.txt
echo Player_HP=!Player_HP!>> SaveData_3.txt
echo Player_MP=!Player_MP!>> SaveData_3.txt
echo Player_ATK=!Player_ATK!>> SaveData_3.txt
echo Player_DEF=!Player_DEF!>> SaveData_3.txt
echo Player_SPEED=!Player_SPEED!>> SaveData_3.txt

echo Player_LUCK=!Player_LUCK!>> SaveData_3.txt


echo Player_DAM=!Player_DAM!>> SaveData_3.txt
echo Player_LIFE=!Player_LIFE!>> SaveData_3.txt

echo Player_EXP=!Player_EXP!>> SaveData_3.txt
echo player_money=!player_money!>> SaveData_3.txt

echo player_exp_to_next_level=!player_exp_to_next_level!>> SaveData_3.txt

echo Player_LastPlace=!Player_LastPlace!>> SaveData_3.txt


endlocal
goto :END




:END
::cls
cd ".."
exit /b 120