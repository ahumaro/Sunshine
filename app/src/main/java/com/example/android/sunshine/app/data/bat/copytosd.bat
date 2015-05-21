@echo off
title DMLizard (by eN-t) - Copy files to your homebrew drive
cls


:copytosd
REM Move files to SD card
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Copy files to your homebrew drive -"
echo  so you don't have to do it on your own
echo.
call %BATS_ECHO% "0E" "DMLizard"
if not exist "%PATH_COPY%\" (
	echo  found no files to copy.
	echo.
	echo You either already copied the files or did not do anything which requires files to be copied.
	goto endfile
)
echo  found the following FAT32 drives - make sure there is enough free space on them:
echo.
call :copytosd_getlist
echo 	[R] Rescan
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_PICK_CONT%)
echo %TEXT_PICK_MENU%
echo.
if "%SDcount%"=="0" (echo Please connect a FAT32 drive and rescan.) else (echo Please type in the number of the drive you choose.)
set copytosd_pick=
set /P copytosd_pick="If your drive is not on the list, please format it to FAT32: "
if /I "%copytosd_pick%"=="R" goto copytosd
if /I "%mainmenu_pick%"=="W" (if /I "%copytosd_pick%"=="C" goto :eof)
if "%copytosd_pick%"=="0" set "mainmenu_pick=0" & goto :eof
set /A SDcount=0
for /F "skip=1 tokens=1,2,* delims= " %%i in ('type "%FILE_DRIV%"') do (
	if /I "%%i"=="FAT32" (
		set /A SDcount=!SDcount!+1
		if "%copytosd_pick%"=="!SDcount!" (
			set SDcard=%%j
			set SDname=%%k
			goto copytosd_work
		)
	)
)
goto copytosd


:copytosd_getlist
REM Get and list all drives with homebrew
set /A SDcount=0
wmic logicaldisk get name,volumename,filesystem>"%FILE_DRIV%"
for /F "skip=1 tokens=1,2,* delims= " %%i in ('type "%FILE_DRIV%"') do (
	if /I "%%i"=="FAT32" (
		set /A SDcount=!SDcount!+1
		echo 	[!SDcount!] %%j\ - %%k
	)
)
if "%SDcount%"=="0" echo 	[x] No FAT32 drives found.
goto :eof


:copytosd_work
REM Now copy the files onto the drive
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Copy files to your homebrew drive -"
echo  so you don't have to do it on your own
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  will copy the files to "%SDcard%\ - %SDname%"...
echo.
echo 1. Copying the apps and USB backup loaders...
if exist "%PATH_APPS%\" xcopy /QCEDY "%PATH_APPS%\*.*" "%SDcard%\apps\" 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑" <nul
if exist "%PATH_COPY%\usb-loader\" xcopy /QCEDY "%PATH_COPY%\usb-loader\*.*" "%SDcard%\usb-loader\" 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑" <nul
if exist "%PATH_COPY%\wiiflow\" xcopy /QCEDY "%PATH_COPY%\wiiflow\*.*" "%SDcard%\wiiflow\" 2>nul >nul
set /P progbar="北北北北卑北北北北卑" <nul
if exist "%PATH_COPY%\NeoGamma\" xcopy /QCEDY "%PATH_COPY%\NeoGamma\*.*" "%SDcard%\NeoGamma\" 2>nul >nul
set /P progbar="北北北北卑 100%%" <nul
echo 2. Copying the WADs incl. forwarder WADs...
if exist "%PATH_WADS%\" xcopy /QCEDY "%PATH_WADS%\*.*" "%SDcard%\wad\" 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
echo 3. Copying the converted savegames and games (can take a while)...
if exist "%PATH_SAVE%\" xcopy /QCEDY "%PATH_SAVE%\*.*" "%SDcard%\saves\" 2>nul >nul
set /P progbar="北北北北卑" <nul
if exist "%PATH_CUBE%\" xcopy /QCEDY "%PATH_CUBE%\*.*" "%SDcard%\games\" 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
echo 4. Moving the copied files to "%PATH_COPD%"...
if not exist "%PATH_COPD%" (
	move /Y "%PATH_COPY%" "%PATH_COPD%" 2>nul >nul
	set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
) else (
	for /F "tokens=* delims=" %%i in ('echo n^|xcopy /TED "%PATH_COPY%" "%PATH_COPD%"') do REM This is just a placeholder
	set /P progbar="北北北北卑北北北北卑" <nul
	for /F "tokens=* delims=" %%i in ('xcopy /LFEDY "%PATH_COPY%" "%PATH_COPD%" ^|findstr "%PATH_COPY%"') do (
		set copytosd_file=%%i
		set "copytosd_file=!copytosd_file: -> =*!"
		for /F "tokens=1,2 delims=*" %%j in ("!copytosd_file!") do move /Y "%%~j" "%%~k" 2>nul >nul
	)
	set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑" <nul
	rmdir /S /Q "%PATH_COPY%" 2>nul >nul
	set /P progbar="北北北北卑" <nul
	rmdir /S /Q "%PATH_COPY%" 2>nul >nul
	set /P progbar="北北北北卑 100%%" <nul
)
echo.
call %BATS_ECHO% "0A" "- Completed -"
echo.
echo.
echo DMLizard has successfully copied the files to your homebrew drive. You can now use it in your Wii.
goto endfile


:endfile
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_ENDF_CONT%) else (echo %TEXT_ENDF_MENU%)
pause >nul
goto :eof