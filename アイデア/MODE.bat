@echo off
set WT=abcde
title=%WT%
for /f "delims=:" %%i in ('type "%~f0" ^| findstr /n /r "^:Mark$"') do (
    set Line=%%i
)
powershell -c "iex ((gc '%~f0' | select -Skip %Line%) -join \"`n\")"
echo 123456
pause
exit /b

:Mark
$w = 1024
$h = 768
$x = 0
$y = 0
Add-Type @"
  using System;
  using System.Runtime.InteropServices;
  public class Win32Api {
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
  }
"@
ps | ? {
    $_.MainWindowTitle -eq $Env:WT
} | % {
    [Win32Api]::MoveWindow($_.MainWindowHandle, $x, $y, $w, $h, $true) | Out-Null
}