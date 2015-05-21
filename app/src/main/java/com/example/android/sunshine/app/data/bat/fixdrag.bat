@echo off
title DMLizard (by eN-t) - Enable drag'n'drop feature
cls


:fixdrag
REM Fix drag'n'drop issues
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Enable drag'n'drop feature -"
echo  to make drag'n'drop work on your PC
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  sometimes requires you to drag'n'drop files into the DMLizard window.
echo If the drag'n'drop feature is not working for you, this could be caused by erroneous registry values.
echo DMLizard can try to fix these erroneous values for you.
echo.
call %BATS_ECHO% "0E" "Remember to"
echo  run DMLizard with full administratative rights. Otherwise, patching itself may fail.
echo.
echo 	[1] Apply	only safe patches	(may not fix the problem, though)
echo 	[2] Apply	all possible patches	(more likely to work)
echo.
echo %TEXT_PICK_MENU%
echo.
set fixdrag_pick=
set /P fixdrag_pick="Please choose from one of the options listed above: "
if "%fixdrag_pick%"=="1" call :fixdrag_work
if "%fixdrag_pick%"=="2" call :fixdrag_work
if "%fixdrag_pick%"=="0" goto :eof
goto fixdrag


:fixdrag_work
REM Apply the patches to fix drag'n'drop issues
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Enable drag'n'drop feature -"
echo  to make drag'n'drop work on your PC
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  will now try to fix any drag'n'drop related issues...
echo.
echo 1. Applying the safe patches...
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /f /v Start_EnableDragDrop /t REG_DWORD /d 1 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
if "%fixdrag_pick%"=="2" (
	echo 2. Applying all the other patches...
	reg add HKCR\.bat /f /ve /t REG_SZ /d batfile 2>nul >nul
	set /P progbar="北北北北卑北北北北卑" <nul
	reg add HKCR\batfile\shell\open\command /f /ve /t REG_SZ /d "\"%%1\" %%*" 2>nul >nul
	set /P progbar="北北北北卑北北北北卑北北北北卑" <nul
	reg add HKCR\.exe /f /ve /t REG_SZ /d exefile 2>nul >nul
	set /P progbar="北北北北卑北北北北卑" <nul
	reg add HKCR\exefile\shell\open\command /f /ve /t REG_SZ /d "\"%%1\" %%*" 2>nul >nul
	set /P progbar="北北北北卑北北北北卑北北北北卑 100%%" <nul
)
echo.
call %BATS_ECHO% "0A" "- Completed -"
echo.
echo.
echo You may have to restart either DMLizard or even your computer to make the changes work.
if "%fixdrag_pick%"=="1" echo You can also try to apply all possible patches if only applying the safe ones did not work for you.
goto endfile


:endfile
echo.
echo %TEXT_ENDF_MENU%
pause >nul
goto :eof