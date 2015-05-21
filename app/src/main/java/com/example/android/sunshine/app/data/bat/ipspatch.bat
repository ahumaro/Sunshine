@echo off
title DMLizard (by eN-t) - Patch a game's main.dol
set ipspatch_ipsfile=
cls


:ipspatch
REM Choose main.dol to patch and IPS file
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Patch a game's main.dol -"
echo  by using an IPS file
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  can patch a game's "main.dol" by using an IPS file. To do so you need both required files.
echo.
call %BATS_ECHO% "0E" "Please drag'n'drop"
echo  the IPS file into the DMLizard window now.
echo.
echo 	[ ] Drag'n'drop an IPS file into the DMLizard window
echo %TEXT_PICK_MENU%
echo.
echo Confirm with enter to proceed:
if not defined ipspatch_ipsfile (
	set /P ipspatch_ipsfile=
) else (
	echo "%ipspatch_ipsfile%"
)
if not defined ipspatch_ipsfile goto ipspatch
for /F "tokens=* delims= " %%i in ('echo %ipspatch_ipsfile%') do set ipspatch_ipsfile=%%~i
if "%ipspatch_ipsfile%"=="0" goto :eof
if not exist "%ipspatch_ipsfile%" set "ipspatch_ipsfile=" & goto ipspatch
if /I not "%ipspatch_ipsfile:~-4,4%"==".ips" set "ipspatch_ipsfile=" & goto ipspatch
echo.
call %BATS_ECHO% "0E" "Please drag'n'drop"
echo  the "main.dol" to patch into the DMLizard window now.
echo (You can find the "main.dol" in the "sys"-folder after processing your game with GCReEx/DiscEx.)
echo.
echo 	[ ] Drag'n'drop the "main.dol" into the DMLizard window
echo %TEXT_PICK_MENU%
echo.
echo Confirm with enter to proceed:
set ipspatch_maindol=
set /P ipspatch_maindol=
if not defined ipspatch_maindol goto ipspatch
for /F "tokens=* delims= " %%i in ('echo %ipspatch_maindol%') do set ipspatch_maindol=%%~i
if "%ipspatch_maindol%"=="0" goto :eof
if not exist "%ipspatch_maindol%" goto ipspatch
if /I "%ipspatch_maindol:~-4,4%"==".dol" (
	goto ipspatch_work
)
goto ipspatch


:ipspatch_work
REM Patch the main.dol by using the IPS file
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Patch a game's main.dol -"
echo  by using an IPS file
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  will patch the "main.dol"...
echo.
call :ipspatch_getid
echo 2. Applying the patch for "%GAMEname% [%GAMEid%]"...
copy /Y "%ipspatch_maindol%" "%ipspatch_maindol%.bak" 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑" <nul
%EXEC_IPSP% a "%ipspatch_ipsfile%" "%ipspatch_maindol%" 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
echo.
call %BATS_ECHO% "0A" "- Completed -"
echo.
echo.
echo The patch has been applied and your "main.dol" has been backup up to "main.dol.bak".
goto endfile


:ipspatch_getid
echo 1. Gathering GameID and GameName...
set GAMEid=NONAME
set /P progbar="北北北北卑" <nul
for /F "tokens=* delims=" %%i in ("%ipspatch_maindol%") do set ipspatch_bootbin=%%~dpiboot.bin
set /P progbar="北北北北卑" <nul
for /F "tokens=* delims=" %%i in ('type "%ipspatch_bootbin%"') do (
	set GAMEid_temp=%%i
	set GAMEid=!GAMEid_temp:~0,6!
)
set /P progbar="北北北北卑北北北北卑" <nul
set GAMEname=Game not found (%time:~0,2%-%time:~3,2%-%time:~6,2%)
set /P progbar="北北北北卑" <nul
for /F "skip=1 tokens=1,* delims== " %%i in ('type "%FILE_TIT1%"') do if "!GAMEid!"=="%%~i" set GAMEname=%%j
set /P progbar="北北北北卑北北北北卑北北北北卑" <nul
for /F "tokens=1,* delims==:" %%i in ("%GAMEname%") do if not "%%~j"=="" set GAMEname=%%~i -%%~j
set /P progbar="北北北北卑" <nul
for /F "tokens=1,2,* delims==:*<>?^!" %%i in ("%GAMEname%") do set GAMEname=%%~i%%~j%%~k
set /P progbar="北北北北卑 100%%" <nul
goto :eof


:endfile
echo.
echo %TEXT_ENDF_MENU%
pause >nul
goto :eof