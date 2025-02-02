cls
for /l %%a in (25,-1,1) do (
    call echo %%hashtag_%%a%%
    echo.
    echo.
    echo.
    call echo %%hashtag_%%a%%
    for /l %%t in (1,1,20000) do (
        if %%t equ 20000 (cls)
        if %%a leq 1 (goto NEXT)
    )
)

:NEXT
cls

rem EOF