@echo off
setlocal

call "%~dp0.\config.bat"
FOR /F "tokens=* USEBACKQ" %%F IN (`ver`) DO (
	SET version="%%F"
)
if not x%version:xp=%==x%version% goto :XP

:OTHER
SCHTASKS /Create /SC ONLOGON /TN dylan_sync /TR "%dr%start.bat -s" /F
SCHTASKS /Create /SC DAILY /TN shutdown /TR "shutdown /s" /F /ST 02:00
goto :INITIAL

:XP
SCHTASKS /Query>dylan_sync.tmp
findstr /B /I "dylan_sync" dylan_sync.tmp>nul
if %errorlevel%==0 goto :DELETE
goto :CREATE
:DELETE
echo y>y.txt
SCHTASKS /Delete /TN dylan_sync<y.txt
del y.txt

:CREATE
SCHTASKS /Create /SC ONLOGON /TN dylan_sync /TR "%dr%\start.bat -s" /ru system
del dylan_sync.tmp
goto :INITIAL

:INITIAL
IF NOT %1==-r call "%dr%start.bat"
IF EXIST "C:\Users\%username%\Desktop\RunMe.bat.lnk" DEL "C:\Users\%username%\Desktop\RunMe.bat.lnk"
exit