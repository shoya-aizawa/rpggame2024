@echo off
for /f %%i in ('cmd /k prompt $e^<nul') do set ESC=%%i

echo --- �X�^�C�� ---
echo %ESC%[0m���Z�b�g
echo %ESC%[1m����%ESC%[0m
echo %ESC%[4m�A���_�[���C��
echo.
echo %ESC%[7m���]
echo %ESC%[0m
echo.
echo --- �����̐F ---
echo %ESC%[30m���F
echo %ESC%[31m�ԐF
echo %ESC%[32m�ΐF
echo %ESC%[33m���F
echo %ESC%[34m�F
echo %ESC%[35m���K���^
echo %ESC%[36m�V�A��
echo %ESC%[37m���F
echo %ESC%[0m
echo.
echo --- �w�i�F ---
echo %ESC%[40m���F%ESC%[0m
echo %ESC%[41m�ԐF%ESC%[0m
echo %ESC%[42m�ΐF%ESC%[0m
echo %ESC%[43m���F%ESC%[0m
echo %ESC%[44m�F%ESC%[0m
echo %ESC%[45m���K���^%ESC%[0m
echo %ESC%[46m�V�A��%ESC%[0m
echo %ESC%[47m���F%ESC%[0m
echo.
echo --- �����̐F�i�����j---
echo %ESC%[90m���F
echo %ESC%[91m�ԐF
echo %ESC%[92m�ΐF
echo %ESC%[93m���F
echo %ESC%[94m�F
echo %ESC%[95m���K���^
echo %ESC%[96m�V�A��
echo %ESC%[97m���F
echo %ESC%[0m
echo.
echo --- �w�i�F�i�����j---
echo %ESC%[100m���F%ESC%[0m
echo %ESC%[101m�ԐF%ESC%[0m
echo %ESC%[102m�ΐF%ESC%[0m
echo %ESC%[103m���F %ESC%[0m
echo %ESC%[104m�F%ESC%[0m
echo %ESC%[105m���K���^%ESC%[0m
echo %ESC%[106m�V�A��%ESC%[0m
echo %ESC%[107m���F%ESC%[0m
echo.
echo --- �~�b�N�X ---
echo %ESC%[31;44m�����̐F �� �w�i�F �F%ESC%[0m
echo.
echo --- �� ---
echo %ESC%[34m�F %ESC%[32m�ΐF %ESC%[33m ���F%ESC%[0m�B%ESC%[33m���F%ESC%[0m�͋�����%ESC%[93m���F%ESC%[0m�ɂ��āA����ɔw�i�F��%ESC%[93;101m�����̐�%ESC%[0m�ɂ��āA%ESC%[4;93;101m�A���_�[���C��%ESC%[0m��t����B
echo.
echo.
echo.
echo.
echo.
echo.

pause
