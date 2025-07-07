@echo off
chcp 65001 >nul
mode con: cols=100 lines=30
cls
echo ====================================================
echo                     戦闘開始！
echo ====================================================
echo プレイヤー: Hero
echo HP: 100/100   MP: 50/50   スタミナ: 10/10
echo ----------------------------------------------------
echo 敵: スライム
echo HP: 30/30
echo ----------------------------------------------------
echo マップ:
echo [P] プレイヤー位置   [E] 敵位置
echo.
echo ######################
echo # P                E #
echo ######################
echo ----------------------------------------------------
echo [1] 攻撃   [2] 防御   [3] アイテム   [4] 逃げる
echo ----------------------------------------------------
echo あなたの行動を選択してください:

setlocal enabledelayedexpansion
:: プレイヤーの体力
set max_hp=100
set current_hp=75

:: グラフィカルバーの長さ
set bar_length=10

:: 体力バーを生成
call :GenerateHealthBar %current_hp% %max_hp% %bar_length%
echo プレイヤー: Hero
echo HP: [%health_bar%] %current_hp%/%max_hp%
pause >nul


:GenerateHealthBar
:: 引数: 現在のHP, 最大HP, バーの長さ
set /a filled=%~1 * %~3 / %~2
set /a empty=%~3 - %filled%
:: 使用する記号を設定
set "filled_char=#"
set "empty_char=."

:: バーを生成
set health_bar=
for /l %%i in (1,1,%filled%) do set health_bar=!health_bar!%filled_char%
for /l %%i in (1,1,%empty%) do set health_bar=!health_bar!%empty_char%
exit /b

pause >nul
start /wait "" "E:\RPGGAME\Systems\New2.bat"
echo %errorlevel%
pause >nul
