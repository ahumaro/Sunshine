@echo off
title DMLizard (by eN-t) - Download a WAD manager
cls


:appswman
REM Decide which app to download
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Download a WAD manager -"
echo  to install WAD files on your Wii
echo.
call %BATS_ECHO% "0E" "To be able to play"
echo  your GameCube games via DIOS MIOS (Lite) you have to install the DIOS MIOS (Lite) WAD
echo by using one of the WAD managers listed below:
echo.
echo 	[1] Download	%YAWM_TEXT%
echo 	[2] Download	%WMAN_TEXT%
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_PICK_CONT%)
echo %TEXT_PICK_MENU%
echo.
echo Please choose which WAD manager you want to use.
set appswman_pick=
set /P appswman_pick="Type in the number in the brackets and confirm with enter: "
if /I "%mainmenu_pick%"=="W" (if /I "%appswman_pick%"=="C" goto :eof)
if "%appswman_pick%"=="0" set "mainmenu_pick=0" & goto :eof
if "%appswman_pick%"=="1" call %BATS_DOWN% %YAWM_VARS%
if "%appswman_pick%"=="2" call %BATS_DOWN% %WMAN_VARS%
goto appswman