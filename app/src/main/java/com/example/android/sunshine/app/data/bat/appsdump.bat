@echo off
title DMLizard (by eN-t) - Download a disc dumper
cls


:appsdump
REM Decide which app to download
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Download a disc dumper -"
echo  to dump your GameCube games to ISO files
echo.
call %BATS_ECHO% "0E" "To be able to play"
echo  your GameCube games via DIOS MIOS (Lite) you have to create ISO or GCM files before
echo by using one of the disc dumpers listed below:
echo.
echo 	[1] Download	%CRIP_TEXT%
echo 	[2] Download	%SUPD_TEXT%
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_PICK_CONT%)
echo %TEXT_PICK_MENU%
echo.
echo Please choose which disc dumper you want to use.
set appsdump_pick=
set /P appsdump_pick="Type in the number in the brackets and confirm with enter: "
if /I "%mainmenu_pick%"=="W" (if /I "%appsdump_pick%"=="C" goto :eof)
if "%appsdump_pick%"=="0" set "mainmenu_pick=0" & goto :eof
if "%appsdump_pick%"=="1" call %BATS_DOWN% %CRIP_VARS%
if "%appsdump_pick%"=="2" call %BATS_DOWN% %SUPD_VARS%
goto appsdump