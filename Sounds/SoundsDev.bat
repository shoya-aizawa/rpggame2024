@echo on

title sounds playing now

cd "%CD%/Sounds"

chcp 65001 > nul

set C2=65.41
set C#2=69.30
set D2=73.42
set D#2=77.78
set E2=82.41
set F2=87.31
set F#2=92.50
set G2=98
set G#2=103.83
set A2=110
set A#2=116.54
set B2=123.47

set C3=130.82
set C#3=138.59
set D3=146.84
set D#3=155.57
set E3=164.82
set F3=174.62
set F#3=185.00
set G3=196
set G#3=207.65
set A3=220
set A#3=233.08
set B3=246.94

set C4=261.63
set C#4=277.18
set D4=293.67
set D#4=311.13
set E4=329.63
set F4=349.23
set F#4=369.99
set G4=392
set G#4=415.30
set A4=440
set A#4=466.16
set B4=493.88

set C5=523.26
set C#5=554.36
set D5=587.34
set D#5=622.26
set E5=659.26
set F5=698.46
set F#5=739.98
set G5=784
set G#5=830.60
set A5=880
set A#5=932.32
set B5=987.76

set C6=1046.52
set C#6=1108.72
set D6=1174.68
set D#6=1244.52
set E6=1318.52
set F6=1396.92
set F#6=1479.96
set G6=1568
set G#6=1661.20
set A6=1760
set A#6=1864.64
set B6=1975.52

set C7=2093.04


set ms=100


goto :SONG_B


rem 注意*コーディングが旧式 改新後は@PowerShell -Command "[console]::Beep(%C4%,%ms%)"
@PowerShell ^&{[console]::Beep(%C4%,%ms%)}
@PowerShell ^&{[console]::Beep(%E4%,%ms%)}
@PowerShell ^&{[console]::Beep(%G4%,%ms%)}
@PowerShell ^&{[console]::Beep(%C5%,%ms%)}

@PowerShell ^&{[console]::Beep(%D4%,%ms%)}
@PowerShell ^&{[console]::Beep(%F4%,%ms%)}
@PowerShell ^&{[console]::Beep(%A4%,%ms%)}
@PowerShell ^&{[console]::Beep(%D5%,%ms%)}

@PowerShell ^&{[console]::Beep(%E4%,%ms%)}
@PowerShell ^&{[console]::Beep(%G4%,%ms%)}
@PowerShell ^&{[console]::Beep(%C5%,%ms%)}
@PowerShell ^&{[console]::Beep(%E5%,%ms%)}

@PowerShell ^&{[console]::Beep(%F4%,%ms%)}
@PowerShell ^&{[console]::Beep(%A4%,%ms%)}
@PowerShell ^&{[console]::Beep(%C5%,%ms%)}
@PowerShell ^&{[console]::Beep(%F5%,%ms%)}

pause
goto :SONG_A

rem 読み込めるかテスト
for /f "tokens=1-4 delims=- " %%a in (E:\RPGGAME\Sounds\sample.txt) do (
    echo.%%a
    echo.%%b
    echo.%%c
    echo.%%d
)


:SONG_A
rem 1小節区切り(1,2,3,4)
setlocal enabledelayedexpansion
for /f "tokens=1-4 delims=- " %%a in (sample.txt) do (
    @PowerShell -Command "[console]::Beep(!%%a!,%ms%)"
    @PowerShell -Command "[console]::Beep(!%%b!,%ms%)"
    @PowerShell -Command "[console]::Beep(!%%c!,%ms%)"
    @PowerShell -Command "[console]::Beep(!%%d!,%ms%)"
)
endlocal


pause


:SONG_B
set ms=70
setlocal enabledelayedexpansion
for /f "tokens=1-4 delims=- " %%a in (The_Prelude_from_Final_Fantasy.txt) do (
    PowerShell -Command "[console]::Beep(!%%a!,%ms%)"
    PowerShell -Command "[console]::Beep(!%%b!,%ms%)"
    PowerShell -Command "[console]::Beep(!%%c!,%ms%)"
    PowerShell -Command "[console]::Beep(!%%d!,%ms%)"
)
endlocal

goto SONG_B


:SONG_C



pause

