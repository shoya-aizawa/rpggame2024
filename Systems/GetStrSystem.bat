set str=%Player_Name%
set len=0

:LOOP
if not "%str%"=="" (
    set str=%str:~1%
    set /a len=%len%+1
    goto :LOOP
)

echo %len%




rem そもそもPlayerNameが24文字までの制限

