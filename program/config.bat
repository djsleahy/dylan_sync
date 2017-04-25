::This is the Setting/Configuration File, by changing the values here, you can
::change how dylan_sync will run.
::
::Do not remove @echo off.
::Edit only the values occuring after the =.
::
::Time format is HH:MM
@echo off
SET scheduledTime=20:00
SET networkDrive=V:\
SET syncUpdateLocation=%networkDrive%updates\dylan_sync
SET excludeFile=%syncUpdateLocation%\exclude.txt
SET uptodateUpdate=%syncUpdateLocation%\program\update.bat

::Do not edit anything below this line
SET dr=%~dp0
SET perm=call "%dr%dylan_perm.bat"
SET updateslog="%dr%logs\dylan_sync_Update_Log.txt"
SET runlog="%dr%logs\dylan_run_log.txt"
SET xcopyerror=0
SET tab=    