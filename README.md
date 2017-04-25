# dylan_sync
A network directory synchronisation program

dylan_sync operates solely off Windows batch scripts as per request.

# Setup
Store the most recent version of dylan_sync in a network location and edit syncUpdateLocation config.bat to match.

Initialise proper permissions so that dylan_sync can access the files/folders it most sync.

Run RunMe.bat

## Schedule dylan_sync - RunMe.bat
Copy the most recent version of dylan_sync to C:\

Run C:\dylan_sync\RunMe.bat

This will automatically schedule dylan_sync to run upon user login.

## Run Once
Copy the most recent version of dylan_sync to a location on the desktop.

In ~/dylan_sync\program\ run the file start.bat.

# How It Works
## config.bat
This is called at the start of each bat file that requires it. It contains constants and variables such as path settings, initial errorlevel and character formatting.

## RunMe.bat
Makes a URL call to C:\dylan_sync\program\schedule_dylan_sync.bat, allowing this file to be stored and run from anywhere for ease of setup.

## schedule_dylan_sync.bat
Checks to see if the Windows OS is XP or something newer.

This is due to XP's SCHTASKS command working differently to newer operating systems.

Schedule start.bat to launch on login of the user.

## start.bat
Checks if network location is connected, reports error if not.

If connected, continues to initialise log files.

Tries to set permissions for files using dylan_perm.bat

Updates update.bat

Check for updates of program from most recent netwrok version as defined in config.bat by calling update.bat

## dylan_perm.bat
Recursively sets full control permissions for all default users and groups on a directory.

Stored in config.bat as %perm% for shorthand access.

## update.bat
Initialises local updates log

Sets permissions for dylan_sync folders

Updates remaining dylan_sync files (all but update.bat which is done by start.bat).

Calls dylan_sync.bat

## dylan_sync.bat
Handles directory synchronization.

Future update will have this doen from an external file. For now this is done through hard code.

First it checks an update path exists.

Then it does permissions on the path.

Then it copies over the updated files/syncs the directory.

At the beginning of execution this logs its start time and at the end of synchronization of all directories it logs it end time using getDateAndTime.bat.

At the end it logs these to the network log using a call to logger.bat

## getDateAndTime.bat
Sets a formatted set of variables that can be accessed for the date and time.

## logger.bat
Logs the start and end time of the machine to the network log.
