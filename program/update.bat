@echo off

SETLOCAL ENABLEDELAYEDEXPANSION

call "%~dp0.\config.bat"

echo UPDATING
echo UPDATE.BAT %DATE% %TIME%>>%updateslog%
echo --------------------------------------->>%updateslog%
echo "%dr%" Updated Files Log>>%updateslog%
echo %tab%Recursively Setting Permissions
%perm% "%dr%\..">>%updateslog%
echo f | xcopy /d /f /y /s V:\updates\dylan_sync "%dr%.." /EXCLUDE:%excludeFile%>>%updateslog%
IF NOT ERRORLEVEL 0 GOTO XCOPYERRORS
echo %tab%%tab%Updated dylan_sync
goto :END

:XCOPYERRORS
echo XCopy encountered an error and had to exit...
echo Error Code = ERRORLEVEL
if ERRORLEVEL 5 (
	echo 5 \| Disk write error occurred.
	SET xcopyerror=5
	GOTO ERROR
)
if ERRORLEVEL 4 (
	echo 4 \| Initialization error occurred. There is not enough memory or disk space, or you entered an invalid drive name or invalid syntax on the command line.
	SET xcopyerror=4
	goto ERROR
)
IF ERRORLEVEL 3 (
	SET xcopyerror=3
	goto ERROR
)
IF ERRORLEVEL 2 (
	echo 2 \| The user pressed CTRL\+C to terminate xcopy.
	SET xcopyerror=2
	goto ERROR
)
IF ERRORLEVEL 1 (
	echo 1 \| No files were found to copy. Inspect Directories.
	SET xcopyerror=1
	goto ERROR
)
IF ERRORLEVEL 0 ( 
	echo 0 \| Files were copied without error. Error Thrown Inexplicably.
	SET xcopyerror=0
)
:ERROR
pause

:END
echo.>>%updateslog%
echo ***************************************>>%updateslog%
echo ***************************************>>%updateslog%
echo.>>%updateslog%

call "%dr%dylan_sync.bat"
::IF "%~1"=="-s" shutdown.exe /s /t 00
exit