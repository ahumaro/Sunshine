@echo off
title DMLizard (by eN-t) - Download DIOS MIOS (Lite) WAD
cls


:diosmios
REM Decide which wad to download
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Download DIOS MIOS (Lite) WAD -"
echo  in a single step
echo.
call %BATS_ECHO% "0E" "To be able to play"
echo  your GameCube games from SD/USB you have to replace the MIOS with DIOS MIOS (Lite)
echo by using one of the WAD files listed below:
echo.
echo 	[1] Download	%DMSW_TEXT%
echo 	[2] Download	%DMLW_TEXT%
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_PICK_CONT%)
echo %TEXT_PICK_MENU%
echo.
echo Please choose which WAD file you want to download.
set /A diosmios_badnum=0
set diosmios_pick=
set /P diosmios_pick="Type in the number in the brackets and confirm with enter: "
if /I "%mainmenu_pick%"=="W" (if /I "%diosmios_pick%"=="C" goto :eof)
if "%diosmios_pick%"=="0" set "mainmenu_pick=0" & goto :eof
if "%diosmios_pick%"=="1" call :diosmios_download %DMSW_VARS%
if "%diosmios_pick%"=="2" call :diosmios_download %DMLW_VARS%
goto diosmios


:diosmios_download
REM Download the wad file
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Download or create DIOS MIOS (Lite) wad -"
echo  in a single step
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  will download the "%~1 [%2]"...
call :diosmios_bcandmios
echo 2. Downloading the %~1 [%3]...
if not exist "%PATH_WADS%\%4" %EXEC_WGET% -q -O"%PATH_TEMP%\%4" "%5"
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
call :diosmios_verify %4 %6
if "%diosmios_badnum%"=="3" goto diosmios_corrupted
if "%diosmios_badwad%"=="1" goto diosmios_download
call :diosmios_copytosd %4
goto :eof


:diosmios_bcandmios
REM Download the BC and MIOS
echo.
echo 1. Downloading the BCv6 [24kB] and MIOSv10 [182kB]...
if not exist "%PATH_WADS%\%FILE_BCV6%" (
	%EXEC_NUSD% "0000000100000100" "6" "packwad" 2>nul >nul
	move /Y "%PATH_EXEC%\0000000100000100\0000000100000100.wad" "%PATH_TEMP%\%FILE_BCV6%" 2>nul >nul
	rmdir /S /Q "%PATH_EXEC%\0000000100000100" 2>nul >nul
)
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑" <nul
if not exist "%PATH_WADS%\%FILE_MIOS%" (
	%EXEC_NUSD% "0000000100000101" "10" "packwad" 2>nul >nul
	move /Y "%PATH_EXEC%\0000000100000101\0000000100000101.wad" "%PATH_TEMP%\%FILE_MIOS%" 2>nul >nul
	rmdir /S /Q "%PATH_EXEC%\0000000100000101" 2>nul >nul
)
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
goto :eof


:diosmios_verify
REM Verify the created wad files
set diosmios_badwad=0
echo 3. Verifying the wad files...
if exist "%PATH_TEMP%\%FILE_BCV6%" (
	%EXEC_MD5E% -c"%CSUM_BCV6%" "%PATH_TEMP%\%FILE_BCV6%"
	if errorlevel 1 set diosmios_badwad=1
)
set /P progbar="北北北北卑北北北北卑北北北北卑" <nul
if exist "%PATH_TEMP%\%FILE_MIOS%" (
	%EXEC_MD5E% -c"%CSUM_MIOS%" "%PATH_TEMP%\%FILE_MIOS%"
	if errorlevel 1 set diosmios_badwad=1
)
set /P progbar="北北北北卑北北北北卑北北北北卑" <nul
if exist "%PATH_TEMP%\%1" (
	%EXEC_MD5E% -c"%2" "%PATH_TEMP%\%1"
	if errorlevel 1 set diosmios_badwad=1
)
if "%diosmios_badwad%"=="1" set /A diosmios_badnum=%diosmios_badnum%+1
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
goto :eof


:diosmios_copytosd
REM Move all the files to the copy-to-SD folder
if not exist "%PATH_WADS%" mkdir "%PATH_WADS%\" 2>nul >nul
move /Y "%PATH_TEMP%\*.wad" "%PATH_WADS%\" 2>nul >nul
echo.
call %BATS_ECHO% "0A" "- Completed -"
echo.
echo.
echo To install DIOS MIOS (Lite) use "%1" and "%FILE_BCV6%" to overwrite the MIOS.
echo To uninstall DIOS MIOS (Lite) use "%FILE_MIOS%" to install the original MIOS again.
goto endfile


:diosmios_corrupted
REM Display this if the wad verification failed three times
echo.
call %BATS_ECHO% "0C" "- Failed -"
echo.
echo.
echo The verification of the downloaded wad files returned bad results three times or more.
echo Please try again later.
goto endfile


:endfile
echo.
echo %TEXT_ENDF_CONT%
pause >nul
goto :eof