@echo off
setlocal enabledelayedexpansion

FOR /F "tokens=* USEBACKQ" %%F IN (`ver`) DO (
	SET version="%%F"
)
if not x%version:xp=%==x%version% goto :XP

call "%~dp0\.\config.bat"
IF EXIST %1 goto :START
	echo "PHASE,ID,DATE,TIME,ERROR">%1 || timeout 5

:START
2>nul (
  >>%1 (
    echo %2
    echo %3
    %*
    (call ) %= This odd syntax guarantees the inner block ends with success  =%
            %= We only want to loop back and try again if redirection failed =%
  )
) || goto :START

echo Logged
goto :eof