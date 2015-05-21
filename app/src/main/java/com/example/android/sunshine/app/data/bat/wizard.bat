@echo off
title DMLizard (by eN-t) - Wizard
cls

:wizard
REM Wizard
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- DMLizard's Wizard -"
echo  will guide you through the DIOS MIOS (Lite) setup
echo.
call %BATS_ECHO% "0E" "The Wizard"
echo  will go through the following steps and explain them to you.
echo.
echo 	- Format	a drive for use with DIOS MIOS (Lite)
echo 	- Download	%DMSW_NAME%	or	%DMLW_NAME%
echo 	- Download	%YAWM_NAME%	or	%WMAN_NAME%
echo 	- Download	%CRIP_NAME%	or	%SUPD_NAME%
echo 	- Download	a USB backup loader	with DIOS MIOS (Lite) support
echo 	- Copy files	to an SD card or a USB drive (FAT32)
echo 	- Optimize	a game ISO or GCM file	for use with DIOS MIOS (Lite)
echo 	- Copy files	to an SD card or a USB drive (FAT32)
echo.
echo %TEXT_PICK_CONT%
echo %TEXT_PICK_MENU%
echo.
set wizard_pick=
set /P wizard_pick="Please choose from one of the options listed above: "
if /I "%wizard_pick%"=="C" goto wizard_work
if "%wizard_pick%"=="0" goto :eof
goto wizard


:wizard_work
REM Call all the bat files for wizard
call %BATS_FORM%
if "%mainmenu_pick%"=="0" goto :eof
call %BATS_DIOS%
if "%mainmenu_pick%"=="0" goto :eof
call %BATS_WMAN%
if "%mainmenu_pick%"=="0" goto :eof
call %BATS_DUMP%
if "%mainmenu_pick%"=="0" goto :eof
call %BATS_USBL%
if "%mainmenu_pick%"=="0" goto :eof
call %BATS_COPY%
if "%mainmenu_pick%"=="0" goto :eof
call %BATS_GAME%
if "%mainmenu_pick%"=="0" goto :eof
call %BATS_COPY%
if "%mainmenu_pick%"=="0" goto :eof
goto wizard_finish


:wizard_finish
REM Finish the wizard
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- DMLizard's Wizard -"
echo  will guide you through the DIOS MIOS (Lite) setup
echo.
call %BATS_ECHO% "0E" "Thank you very much"
echo  for using the DMLizard Wizard.
echo You have just completed the wizard. I hope you did not skip too many steps ;)
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo To submit bug reports, request features, receive tips, tricks and personal support as well as a lot of
echo information about DMLizard such as a full changelog, upcoming features and more visit
echo.
call %BATS_ECHO% "0A" "-                                           DMLizard.eN-t.de                                            -"
echo.
echo You will also find a german tutorial on how to install, setup and use DIOS MIOS or DIOS MIOS Lite there.
echo Not to forget you can give feedback so I can further improve DMLizard.
echo.
goto endfile


:endfile
echo.
echo %TEXT_ENDF_MENU%
pause >nul
goto :eof