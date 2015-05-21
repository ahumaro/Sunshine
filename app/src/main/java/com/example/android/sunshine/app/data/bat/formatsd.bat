@echo off
title DMLizard (by eN-t) - Format a drive to FAT32
cls


:formatsd
REM Choose drive to format
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Format a drive to FAT32 -"
echo  to make it work with DIOS MIOS (Lite)
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  found the following drives - make sure to backup all stored data before formatting:
echo.
call :formatsd_getlist
echo 	[R] Rescan
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_PICK_CONT%)
echo %TEXT_PICK_MENU%
echo.
echo Please type in the number of the drive you choose.
set formatsd_pick=
set /P formatsd_pick="If your drive is not on the list, please connect it and rescan: "
if /I "%formatsd_pick%"=="R" goto formatsd
if /I "%mainmenu_pick%"=="W" (if /I "%formatsd_pick%"=="C" goto :eof)
if "%formatsd_pick%"=="0" set "mainmenu_pick=0" & goto :eof
set /A SDcount=0
for /F "skip=1 tokens=2,* delims= " %%i in ('type "%FILE_DRIV%"') do (
	set /A SDcount=!SDcount!+1
	if "%formatsd_pick%"=="!SDcount!" (
		set SDcard=%%i
		set SDname=%%j
		goto formatsd_mode
	)
)
goto formatsd


:formatsd_getlist
REM Get and list all drives
set /A SDcount=0
wmic logicaldisk get name,volumename,filesystem>"%FILE_DRIV%"
for /F "skip=1 tokens=2,* delims= " %%i in ('type "%FILE_DRIV%"') do (
	set /A SDcount=!SDcount!+1
	echo 	[!SDcount!] %%i\ - %%j
)
if "%SDcount%"=="0" echo 	[x] No compatible drive found.
goto :eof


:formatsd_mode
REM Choose mode to format drive
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Format a drive to FAT32 -"
echo  to make it work with DIOS MIOS (Lite)
echo.
call %BATS_ECHO% "0E" "Please choose"
echo  what kind of drive "%SDcard% - %SDname%" is.
echo.
echo 	[1] USB drive		- will format for use with DIOS MIOS
echo 	[2] SD card		- will format for use with DIOS MIOS Lite
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_PICK_CONT%)
echo %TEXT_PICK_MENU%
echo.
echo Please choose which kind of drive it is and then proceed to start formatting the drive.
set formatsd_pick=
set /P formatsd_pick="Type in the number in the brackets and confirm with enter: "
if /I "%mainmenu_pick%"=="W" (if /I "%formatsd_pick%"=="C" goto :eof)
if "%formatsd_pick%"=="0" set "mainmenu_pick=0" & goto :eof
if "%formatsd_pick%"=="1" call :formatsd_work 32K 16K 8192 4096 2048
if "%formatsd_pick%"=="2" call :formatsd_work 64K 32K 16K 8192 4096
goto endfile


:formatsd_work
REM Format the drive
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Format a drive to FAT32 -"
echo  to make it work with DIOS MIOS (Lite)
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  will now format "%SDcard% - %SDname%"...
echo.
echo 1. Formatting the drive...
:formatsd_work_try
echo a|format %SDcard% /FS:FAT32 /V:Wii /Q /X /A:%1 2>nul >nul
if errorlevel 4 (
	shift
	goto formatsd_work_try
)
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
echo.
call %BATS_ECHO% "0A" "- Completed -"
echo.
echo.
echo The drive has been successfully formatted.
echo You should now be able to use it on your Wii with DIOS MIOS or DIOS MIOS Lite.
goto :eof


:endfile
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_ENDF_CONT%) else (echo %TEXT_ENDF_MENU%)
pause >nul
goto :eof