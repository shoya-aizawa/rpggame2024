@echo off
for /f %%i in ('cmd /k prompt $e^<nul') do set ESC=%%i

echo --- スタイル ---
echo %ESC%[0mリセット
echo %ESC%[1m太字%ESC%[0m
echo %ESC%[4mアンダーライン
echo.
echo %ESC%[7m反転
echo %ESC%[0m
echo.
echo --- 文字の色 ---
echo %ESC%[30m黒色
echo %ESC%[31m赤色
echo %ESC%[32m緑色
echo %ESC%[33m黄色
echo %ESC%[34m青色
echo %ESC%[35mメガンタ
echo %ESC%[36mシアン
echo %ESC%[37m白色
echo %ESC%[0m
echo.
echo --- 背景色 ---
echo %ESC%[40m黒色%ESC%[0m
echo %ESC%[41m赤色%ESC%[0m
echo %ESC%[42m緑色%ESC%[0m
echo %ESC%[43m黄色%ESC%[0m
echo %ESC%[44m青色%ESC%[0m
echo %ESC%[45mメガンタ%ESC%[0m
echo %ESC%[46mシアン%ESC%[0m
echo %ESC%[47m白色%ESC%[0m
echo.
echo --- 文字の色（強調）---
echo %ESC%[90m黒色
echo %ESC%[91m赤色
echo %ESC%[92m緑色
echo %ESC%[93m黄色
echo %ESC%[94m青色
echo %ESC%[95mメガンタ
echo %ESC%[96mシアン
echo %ESC%[97m白色
echo %ESC%[0m
echo.
echo --- 背景色（強調）---
echo %ESC%[100m黒色%ESC%[0m
echo %ESC%[101m赤色%ESC%[0m
echo %ESC%[102m緑色%ESC%[0m
echo %ESC%[103m黄色 %ESC%[0m
echo %ESC%[104m青色%ESC%[0m
echo %ESC%[105mメガンタ%ESC%[0m
echo %ESC%[106mシアン%ESC%[0m
echo %ESC%[107m白色%ESC%[0m
echo.
echo --- ミックス ---
echo %ESC%[31;44m文字の色 赤 背景色 青色%ESC%[0m
echo.
echo --- 例 ---
echo %ESC%[34m青色 %ESC%[32m緑色 %ESC%[33m 黄色%ESC%[0m。%ESC%[33m黄色%ESC%[0mは強調の%ESC%[93m黄色%ESC%[0mにして、さらに背景色を%ESC%[93;101m強調の赤%ESC%[0mにして、%ESC%[4;93;101mアンダーライン%ESC%[0mを付ける。
echo.
echo.
echo.
echo.
echo.
echo.

pause
