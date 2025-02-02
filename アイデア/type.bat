@echo off
setlocal enabledelayedexpansion

for /f %%i in ('cmd /k prompt $e^<nul') do set esc=%%i

call "E:\RPGGAME\Systems\WhileSpaceVariable_Initialize.bat"


rem 表示する文字列を設定
set text=Oops^^! Here comes slime^^! It's sticky^^!

set length=36


rem 1文字ずつ表示
for /l %%i in (0,1,%length%-1) do (
    set "char=!text:~%%i,1!"
    if "!char!"==" " (
        rem スペースの場合
        <nul set /p "=%while_space_esc_1%"
    ) else (
        rem 通常の文字の場合
        if %%i==0 (
            <nul set /p "=%esc%[70C%!char!"
        ) else (
            <nul set /p "=!char!"
        )
        
    )
    call :delay
)

endlocal
echo. 
goto exit

:delay
    for /l %%t in (1,1,20000) do (
        if %%t equ 20000 (exit /b)
        if %%a equ 36 (exit /b)
    )
    exit /b

:exit
exit /b


::rem 文字列の長さを取得
::set /a length=0
:::count_loop
::if "!text:~%length%!" neq "" (
::    set /a length+=1
::    goto count_loop
::)
