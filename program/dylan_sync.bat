@echo off

SETLOCAL ENABLEEXTENSIONS

call "%~dp0.\config.bat"
call "%dr%getDateAndTime.bat"

set start=START^,%computername%^,%dateStamp%^,%timeStamp%^,0
:ACSTRANS
IF NOT EXIST C:\DB (
	echo C:\DB missing^^!^^!^^! Contact IT.
	GoTo ERROR
)

echo Found C:\DB
echo %tab%Recursively Setting Permissions for C:\DB
echo C:\DB Permissions Set>%runlog%
%perm% C:\DB>>%runlog%
echo %tab%Permissions Set For C:\DB\*

IF NOT EXIST C:\DB\DATA (
	echo C:\DB\DATA missing^^!^^!^^! Contact IT.
	GoTo ERROR
)

echo %tab%%tab%Found C:\DB\DATA

IF NOT EXIST C:\DB\DATA\ACSTRANS (
	echo C:\DB\DATA\ACSTRANS missing^^!^^!^^! Contact IT.
	GoTo ERROR
)

echo %tab%%tab%%tab%Found C:\DB\DATA\ACSTRANS
echo C:\DB\DATA\ACSTRANS Updated Files log>>%runlog%
echo f | xcopy /d /f /y /s V:\updates\acstrans C:\DB\DATA\ACSTRANS>>%runlog%
IF NOT ERRORLEVEL 0 GOTO XCOPYERRORS
echo %tab%%tab%%tab%%tab%Updated C:\DB\DATA\ACSTRANS


:LIB
IF NOT EXIST C:\DB\DATA\ACSTRANS\LIB (
	echo C:\DB\DATA\ACSTRANS\LIB missing^^!^^!^^! Contact IT.
	GoTo ERROR
)
echo %tab%%tab%%tab%Found C:\DB\DATA\ACSTRANS\LIB
echo C:\DB\DATA\ACSTRANS\LIB Updated Files Log>>%runlog%
echo f | xcopy /d /f /y /s V:\updates\lib C:\DB\DATA\ACSTRANS\LIB>>%runlog%
IF NOT ERRORLEVEL 0 GOTO XCOPYERRORS
echo %tab%%tab%%tab%%tab%Updated C:\DB\DATA\ACSTRANS\LIB


:LIB2
IF NOT EXIST C:\DB\DATA\ACSTRANS\LIB2 (
	echo C:\DB\DATA\ACSTRANS\LIB2 missing^^!^^!^^! Contact IT.
	GoTo ERROR
)
echo %tab%%tab%%tab%Found C:\DB\DATA\ACSTRANS\LIB2
echo C:\DB\DATA\ACSTRANS\LIB2 Updated Files Log>>%runlog%
echo f | xcopy /d /f /y /s V:\updates\lib2 C:\DB\DATA\ACSTRANS\LIB2>>%runlog%
IF NOT ERRORLEVEL 0 GOTO XCOPYERRORS
echo %tab%%tab%%tab%%tab%Updated C:\DB\DATA\ACSTRANS\LIB2

:PRUNTIME
IF NOT EXIST C:\DB\PROGRAMS (
	echo C:\DB\PROGRAMS missing^^!^^!^^! Contact IT.
	GoTo ERROR
)

echo %tab%%tab%Found C:\DB\PROGRAMS

IF NOT EXIST C:\DB\PROGRAMS\PRUNTIME (
	echo C:\DB\PROGRAMS\PRUNTIME missing^^!^^!^^! Contact IT.
	GoTo ERROR
)

echo %tab%%tab%%tab%Found C:\DB\PROGRAMS\PRUNTIME
echo C:\DB\PROGRAMS\PRUNTIME Updated Files Log>>%runlog%
echo f | xcopy /d /f /y /s V:\updates\pruntime C:\DB\PROGRAMS\PRUNTIME>>%runlog%
IF NOT ERRORLEVEL 0 GOTO XCOPYERRORS
echo %tab%%tab%%tab%%tab%Updated C:\DB\PROGRAMS\PRUNTIME

:COMEXE
IF NOT EXIST C:\com_exe (
	mkdir C:\com_exe
	echo New com_exe created
)
echo Found C:\com_exe
echo %tab%Recursively Setting Permissions for C:\com_exe
echo C:\com_exe Permissions Set>>%runlog%
%perm% C:\com_exe>>%runlog%
echo %tab%Permissions Set For C:\com_exe\*
echo C:\com_exe Updated Files Log>>%runlog%
echo f | xcopy /d /f /y /s V:\updates\com_exe C:\com_exe>>%runlog%
IF NOT ERRORLEVEL 0 GOTO XCOPYERRORS
echo %tab%%tab%Updated C:\com_exe

GOTO END



:XCOPYERRORS
echo XCopy encountered an error and had to exit...
echo Error Code = ERRORLEVEL
if ERRORLEVEL 5 (
	echo 5 \| Disk write error occurred.
	SET xcopyerror=5
	GOTO ERROR
)
if ERRORLEVEL 4 (
	SET xcopyerror=4 \| Initialization error occurred. There is not enough memory or disk space^, or User of %computername% entered an invalid drive name or invalid syntax on the command line.
	goto ERROR
)
IF ERRORLEVEL 3 (
	SET xcopyerror=3 \| Return Code Doesn't Exist. INEXPLICABLE ERROR.
	goto ERROR
)
IF ERRORLEVEL 2 (
	SET xcopyerror=2 \| The user pressed CTRL\+C to terminate xcopy.
	goto ERROR
)
IF ERRORLEVEL 1 (
	SET xcopyerror=1 \| No files were found to copy. Inspect Directories.
	goto ERROR
)
IF ERRORLEVEL 0 ( 
	SET xcopyerror=0 \| Files were copied without error. Error Thrown Inexplicably.
)
:ERROR

:END
call "%dr%getDateAndTime.bat"
set end=END^,%computername%^,%dateStamp%^,%timeStamp%^,%xcopyerror%
call "%dr%logger.bat" "%networkDrive%dylan_sync\%fileName%_log.csv" "%start%" "%end%"