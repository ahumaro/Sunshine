@echo off
title DMLizard (by eN-t) - Download a USB backup loader
set tabl_line=						°
set tabl_cell=					
cls


:usbloader
REM Download a USB backup loader
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Download a USB backup loader -"
echo  to play your GameCube games from SD/USB
echo.
call %BATS_ECHO% "0E" "To be able to play"
echo  your GameCube games via DIOS MIOS (Lite) you have to download a USB backup loader app
echo by choosing at least one of the ones listed below:
echo.
echo %tabl_line%
echo 	No.	do NOT download			°	download
echo %tabl_line%
if "%usbloader_pick_cfg%"=="1" (echo 	[1]%tabl_cell%°%CFG2_TEXT%) else (echo 	[1]%CFG2_TEXT%°)
if "%usbloader_pick_ugx%"=="1" (echo 	[2]%tabl_cell%°%UGX2_TEXT%) else (echo 	[2]%UGX2_TEXT%°)
if "%usbloader_pick_wfl%"=="1" (echo 	[3]%tabl_cell%°%WFL2_TEXT%) else (echo 	[3]%WFL2_TEXT%°)
REM if "%usbloader_pick_dmb%"=="1" (echo 	[4]%tabl_cell%°%DMB2_TEXT%) else (echo 	[4]%DMB2_TEXT%°)
REM if "%usbloader_pick_neo%"=="1" (echo 	[5]%tabl_cell%°%NEO2_TEXT%) else (echo 	[5]%NEO2_TEXT%°)
echo %tabl_line%
echo 	[S] Start the download
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_PICK_CONT%)
echo %TEXT_PICK_MENU%
echo.
echo Please choose which of the USB backup loaders you want to use.
set usbloader_pick=
set /P usbloader_pick="Confirm with enter to proceed: "
if "%usbloader_pick%"=="1" if not "%usbloader_pick_cfg%"=="1" (set /A usbloader_pick_cfg=1) else (set /A usbloader_pick_cfg=0)
if "%usbloader_pick%"=="2" if not "%usbloader_pick_ugx%"=="1" (set /A usbloader_pick_ugx=1) else (set /A usbloader_pick_ugx=0)
if "%usbloader_pick%"=="3" if not "%usbloader_pick_wfl%"=="1" (set /A usbloader_pick_wfl=1) else (set /A usbloader_pick_wfl=0)
REM if "%usbloader_pick%"=="4" if not "%usbloader_pick_dmb%"=="1" (set /A usbloader_pick_dmb=1) else (set /A usbloader_pick_dmb=0)
REM if "%usbloader_pick%"=="5" if not "%usbloader_pick_neo%"=="1" (set /A usbloader_pick_neo=1) else (set /A usbloader_pick_neo=0)
if /I "%mainmenu_pick%"=="W" (if /I "%usbloader_pick%"=="C" goto :eof)
if "%usbloader_pick%"=="0" set "mainmenu_pick=0" & goto :eof
if /I "%usbloader_pick%"=="S" (
	if "%usbloader_pick_cfg%"=="1" call :usbloader_work %CFG2_VARS%
	if "%usbloader_pick_ugx%"=="1" call :usbloader_work %UGX2_VARS%
	if "%usbloader_pick_wfl%"=="1" call :usbloader_work %WFL2_VARS%
REM 	if "%usbloader_pick_dmb%"=="1" call :usbloader_work %DMB2_VARS%
REM 	if "%usbloader_pick_neo%"=="1" call :usbloader_work %NEO2_VARS%
	set /A usbloader_pick_cfg=0
	set /A usbloader_pick_ugx=0
	set /A usbloader_pick_wfl=0
REM 	set /A usbloader_pick_dmb=0
REM 	set /A usbloader_pick_neo=0
	goto usbloader
)
goto usbloader


:usbloader_work
REM Download the selected USB loader
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Download a USB backup loader -"
echo  to play your GameCube games from SD/USB
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  will download "%~1 [%2]"...
echo.
echo 1. Downloading %~1 [%3 + %4]...
%EXEC_WGET% -q -O"%5" "%6"
set /P progbar="±±±±±±±±±°±±±±±±±±±°±±±±±±±±±°±±±±±±±±±°±±±±±±±±±°" <nul
%EXEC_WGET% -q -O"%7" "%8"
set /P progbar="±±±±±±±±±°±±±±±±±±±°±±±±±±±±±°±±±±±±±±±°±±±±±±±±±° 100%%" <nul
echo 2. Unzipping and removing garbage...
%EXEC_UZIP% -q -o "%5" -d "%PATH_COPY%"
set /P progbar="±±±±±±±±±°±±±±±±±±±°±±±±±±±±±°±±±±±±±±±°±±±±±±±±±°±±±±±±±±±°" <nul
%EXEC_UZIP% -q -o "%7" -d "%PATH_COPY%"
set /P progbar="±±±±±±±±±°±±±±±±±±±°" <nul
del /F /Q "%5" >nul
set /P progbar="±±±±±±±±±°" <nul
del /F /Q "%7" >nul
set /P progbar="±±±±±±±±±° 100%%" <nul
echo.
call %BATS_ECHO% "0A" "- Completed -"
echo.
echo.
echo DMLizard has successfully downloaded "%~1 [%2]".
echo You can now use it after copying it onto your homebrew drive.
echo.
echo Hint: You can also install the forwarder WAD to get fast access to the loader from the Wii menu.
echo.
echo %TEXT_ENDF_CONT%
pause >nul
goto :eof