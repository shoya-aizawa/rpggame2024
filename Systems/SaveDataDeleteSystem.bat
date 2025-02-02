@echo off
cls
title Save data deletion system
timeout /t 2 > nul
echo. Save data deletion system has started.

timeout /t 1 > nul


echo. Loading save data...
timeout /t 1 > nul
title Save data deletion system - Loading progress : 0/100


for /l %%t in (1,1,20000) do (echo > nul)
title Save data deletion system - Loading progress : 10/100
for /l %%t in (1,1,15000) do (echo > nul)
title Save data deletion system - Loading progress : 20/100
for /l %%t in (1,1,10000) do (echo > nul)
title Save data deletion system - Loading progress : 30/100
for /l %%t in (1,1,8000) do (echo > nul)
title Save data deletion system - Loading progress : 50/100
for /l %%t in (1,1,10000) do (echo > nul)
title Save data deletion system - Loading progress : 70/100
for /l %%t in (1,1,1200) do (echo > nul)
title Save data deletion system - Loading progress : 90/100
for /l %%t in (1,1,9000) do (echo > nul)



cd "%CD%\SaveData"


title Save data deletion system - Loading progress : 100/100



if not exist "ESD_1.txt" (
    if not exist "ESD_2.txt" (
        if not exist "ESD_3.txt" (goto :SaveData_NULL)
    )
)


if exist "ESD_1.txt" (
    del "ESD_1.txt"
)
if exist "ESD_2.txt" (
    del "ESD_2.txt"
)
if exist "ESD_3.txt" (
    del "ESD_3.txt"
)

if exist "SaveData_1.txt" (
    del "SaveData_1.txt"
)

if exist "SaveData_2.txt" (
    del "SaveData_2.txt"
)

if exist "SaveData_3.txt" (
    del "SaveData_3.txt"
)

cls
title Save data deletion system - Deletion progress : 100%
echo. Data deleted successfully
echo.
echo.
echo. Press any key.
pause > nul

goto :EXIT

:SaveData_NULL
title Save data deletion system - Save data not found
cls
echo. %ESC%[7mSave data not found. [EC-660:SD_NULL]%ESC%[0m
cd ".."
call "%CD%\Systems\ErrorBeepSounds.bat"
timeout /t 4 /nobreak > nul
exit /b 660



:EXIT
cd ".."
exit /b 606