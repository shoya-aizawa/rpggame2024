cls
for /l %%a in (1,1,25) do (
    call echo %%hashtag_%%a%%
    echo.
    echo.
    echo.
    call echo %%hashtag_%%a%%
    for /l %%t in (1,1,20000) do (
        if %%t equ 20000 (cls)
        if %%a geq 25 (goto :NEXT)
    )
)

:NEXT
cls

echo %hashtag_25%
echo.
echo %maintitle%
echo.
echo %hashtag_25%

rem pause > nul


for /l %%t in (1,1,2000000) do (exit /b)
