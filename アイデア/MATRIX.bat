@echo off
color 02
setlocal enabledelayedexpansion
for /l %%i in (1,0,1) do @set /p x=!random:~-1! <nul
