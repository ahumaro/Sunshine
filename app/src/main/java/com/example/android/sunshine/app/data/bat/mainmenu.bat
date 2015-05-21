@echo off
title DMLizard (by eN-t) - Main menu
cls

:check_offline
REM Check if DMLizard is running in offline mode
if "%OFFL_MODE%"=="1" goto mainmenu_offline


:mainmenu_one
REM Main menu page one...
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Main menu (page 1) -"
echo  %USER_NAME%, please select and confirm with Enter
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  lets you choose to do the following:
echo.
echo 	[W] Wizard	will guide you through the DIOS MIOS (Lite) setup
echo.
echo 	[1] Download	%DMSW_NAME%	or	%DMLW_NAME%
echo 	[2] Download	%YAWM_NAME%	or	%WMAN_NAME%
echo 	[3] Download	%CRIP_NAME%	or	%SUPD_NAME%
echo 	[4] Download	a USB backup loader	with DIOS MIOS (Lite) support
echo 	[5] Optimize	a game ISO or GCM file	for use with DIOS MIOS (Lite)
echo 	[6] Convert	a savegame GCI file	for use with NoMoreMemory
echo 	[7] Format	a drive for use with DIOS MIOS (Lite)
echo 	[8] Copy files	to an SD card or a USB drive (FAT32)
echo.
echo 	[9] Next page
echo.
echo 	[C] View Changelog
echo %TEXT_PICK_EXIT%
echo.
set mainmenu_pick=
set /P mainmenu_pick="Please choose from one of the options listed above: "
if "%mainmenu_pick%"=="0" call %BATS_CRED%
if "%mainmenu_pick%"=="1" call %BATS_DIOS%
if "%mainmenu_pick%"=="2" call %BATS_WMAN%
if "%mainmenu_pick%"=="3" call %BATS_DUMP%
if "%mainmenu_pick%"=="4" call %BATS_USBL%
if "%mainmenu_pick%"=="5" call %BATS_GAME%
if "%mainmenu_pick%"=="6" call %BATS_GCI2%
if "%mainmenu_pick%"=="7" call %BATS_FORM%
if "%mainmenu_pick%"=="8" call %BATS_COPY%
if "%mainmenu_pick%"=="9" goto mainmenu_two
if /I "%mainmenu_pick%"=="C" call %BATS_CHNG%
if /I "%mainmenu_pick%"=="W" call %BATS_WZRD%
goto mainmenu_one


:mainmenu_two
REM Main menu page two...
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Main menu (page 2) -"
echo  %USER_NAME%, please select and confirm with Enter
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  lets you choose to do the following:
echo.
echo 	[W] Wizard	will guide you through the DIOS MIOS (Lite) setup
echo.
echo 	[1] Create	a DIOS MIOS Lite wad	by using an ELF file
echo 	[2] Patch	a game's "main.dol"	with an IPS patch file
echo 	[3] Enable	drag'n'drop feature
echo.
echo.
echo.
echo.
echo.
echo 	[9] Previous page
echo.
echo 	[C] View Changelog
echo %TEXT_PICK_EXIT%
echo.
set mainmenu_pick=
set /P mainmenu_pick="Please choose from one of the options listed above: "
if /I "%mainmenu_pick%"=="0" call %BATS_CRED%
if "%mainmenu_pick%"=="1" call %BATS_DELF%
if "%mainmenu_pick%"=="2" call %BATS_IPSP%
if "%mainmenu_pick%"=="3" call %BATS_FIXD%
if /I "%mainmenu_pick%"=="9" goto mainmenu_one
if /I "%mainmenu_pick%"=="C" call %BATS_CHNG%
if /I "%mainmenu_pick%"=="W" call %BATS_WZRD%
goto mainmenu_two


:mainmenu_offline
REM Main menu offline mode...
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Main menu (offline mode) -"
echo  %USER_NAME%, please select and confirm with Enter
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  lets you choose to do the following:
echo.
echo 	[1] Optimize	a game ISO or GCM file	for use with DIOS MIOS (Lite)
echo 	[2] Convert	a savegame GCI file	for use with NoMoreMemory
echo 	[3] Patch	a game's "main.dol"	with an IPS patch file
echo 	[4] Enable	drag'n'drop feature
echo 	[5] Format	a drive for use with DIOS MIOS (Lite)
echo 	[6] Copy files	to an SD card or a USB drive (FAT32)
echo.
echo 	[C] View Changelog
echo %TEXT_PICK_EXIT%
echo.
set mainmenu_pick=
set /P mainmenu_pick="Please choose from one of the options listed above: "
if "%mainmenu_pick%"=="0" call %BATS_CRED%
if "%mainmenu_pick%"=="1" call %BATS_GAME%
if "%mainmenu_pick%"=="2" call %BATS_GCI2%
if "%mainmenu_pick%"=="3" call %BATS_IPSP%
if "%mainmenu_pick%"=="4" call %BATS_FIXD%
if "%mainmenu_pick%"=="5" call %BATS_FORM%
if "%mainmenu_pick%"=="6" call %BATS_COPY%
if /I "%mainmenu_pick%"=="C" call %BATS_CHNG%
goto mainmenu_offline