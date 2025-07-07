
set autosave=true
set /a Player_SAVES+=1



set min=10000
set max=70000
set step=1000
set rStep=0
set rV=0
set /a steps=(max-min)/step + 1
set /a rStep=%RANDOM% * steps / 32768
set /a rV=min + rStep * step

:start
@echo off
set A=47
call "%CD%\NewGame\hashtag_moveline_linedata.bat"
rem call "E:\RPGGAME\ロード画面乱数生成ジェネレータ.bat"
rem 上記の乱数コードはこのバッチファイル内にインストール済み20241120

cls
for /l %%a in (0,1,24) do (
    call echo. %%hashtag_A_%%a%%
    for /l %%t in (1,1,%rV%) do (
        if %%t equ %rV% (cls)
        if %%a geq 24 (goto :save)
    )
)


:save
@echo off
call "%CD%\Systems\MainSaveSystem.bat"
IF %ERRORLEVEL%==666 (EXIT /B 666)


:repeat
@echo off

set /a rStep=%RANDOM% * steps / 32768
set /a rV=min + rStep * step

cls
set A=30
call "%CD%\NewGame\hashtag_moveline_linedata.bat"
for /l %%a in (0,1,24) do (
    call echo. %%hashtag_A_%%a%%
    for /l %%t in (1,1,%rV%) do (
        if %%t equ %rV% (cls)
        if %%a geq 24 (goto :AutoSaveEnd)
    )
)

:AutoSaveEnd
set autosave=false
title AUTO SAVE #1 Complete
cls
for /l %%a in (1,1,22) do (
    echo.
    call echo. %%LoadingText_A_%%a%%
    echo.
    for /l %%t in (1,1,20000) do (
        if %%t equ 20000 (cls)
        if %%a equ 22 (goto :LoadingEnd)
    )
)

:LoadingEnd
timeout /t 1 /nobreak > nul 
cls
rem cd ".."
echo. Press any key.
pause > nul
exit /b 601