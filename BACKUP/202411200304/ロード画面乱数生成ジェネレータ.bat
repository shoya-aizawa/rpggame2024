setlocal enabledelayedexpansion

set min=50000
set max=100000
set step=10000
set rStep=0
set rV=0
set /a steps=(max-min)/step + 1
set /a rStep=%RANDOM% * steps / 32768
set /a rV=min + rStep * step
rem echo Random Value: %rV%