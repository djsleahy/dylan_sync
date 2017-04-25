@echo off
setlocal

call "%~dp0.\config.bat"
IF NOT EXIST %networkDrive% GOTO :DISCONNECTED
SET startlog="%dr%logs\start_log.txt"

echo SETTING LOCAL PERMISSIONS
IF NOT EXIST "%dr%logs" mkdir "%dr%logs"

echo START.BAT %DATE% %TIME%>>%startlog%
echo --------------------------------------->>%startlog%
%perm% "%dr%..">>%startlog%

echo %tab%SET
SET updt="%dr%update.bat"
echo f | xcopy /d /f /y /s %uptodateUpdate% "%dr%">>%startlog%


echo.>>%startlog%
echo ***************************************>>%startlog%
echo ***************************************>>%startlog%
echo.>>%startlog%

IF "%~1"=="-s" %updt% -s
call "%dr%update.bat"
exit

:DISCONNECTED
echo "%networkDrive% disconnected %DATE%">>%dr%logs\disconnected.txt
exit