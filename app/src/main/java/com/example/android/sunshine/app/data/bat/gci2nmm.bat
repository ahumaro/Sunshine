@echo off
title DMLizard (by eN-t) - Convert a savegame GCI file
set /A gci2nmm_numa=0
set /A gci2nmm_numb=1
cls


:gci2nmm
REM Convert a savegame file
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Convert a savegame GCI file -"
echo  for use with NMM
echo.
call %BATS_ECHO% "0E" "Please drag'n'drop"
echo  the GCI file of your choice into the DMLizard window now.
echo.
echo 	[ ] Drag'n'drop a GCI file into the DMLizard window
if not defined gci2nmm_file_1 (echo.) else (echo 	[S] Start the conversion)
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_PICK_CONT%)
echo %TEXT_PICK_MENU%
echo.
echo Confirm with enter to proceed (currently !gci2nmm_numa! savegames in batch):
echo.
set gci2nmm_temp=
set /P gci2nmm_temp=
if not defined gci2nmm_temp goto gci2nmm
for /F "tokens=* delims= " %%i in ('echo %gci2nmm_temp%') do set gci2nmm_temp=%%~i
if /I "%mainmenu_pick%"=="W" (if /I "%gci2nmm_temp%"=="C" goto :eof)
if "%gci2nmm_temp%"=="0" set "mainmenu_pick=0" & goto :eof
if /I "%gci2nmm_temp%"=="s" (
	if not defined gci2nmm_file_1 (goto gci2nmm) else (
		for /F "tokens=2 delims==" %%i in ('set gci2nmm_file_') do call :gci2nmm_work "%%~i"
		if "!gci2nmm_numa!"=="1" (
			echo DMLizard has successfully converted your !gci2nmm_numa! savegame.
			echo It should now be ready to use with NoMoreMemory.
		) else (
			echo DMLizard has successfully converted your !gci2nmm_numa! savegames.
			echo They should now be ready to use with NoMoreMemory.
		)
	)
	goto endfile
)
if not exist "%gci2nmm_temp%" goto gci2nmm
if defined gci2nmm_file_1 for /F "tokens=2 delims==" %%i in ('set gci2nmm_file_') do (
	if /I "%gci2nmm_temp%"=="%%~i" goto gci2nmm
)
if /I "%gci2nmm_temp:~-4,4%"==".gci" (
	set /A gci2nmm_numa=!gci2nmm_numa!+1
	set gci2nmm_file_!gci2nmm_numa!=%gci2nmm_temp%
)
goto gci2nmm


:gci2nmm_work
REM Use gci2nmm to convert the savegame
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Convert a savegame GCI file -"
echo  for use with NMM
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  will now convert your GameCube savegame no. !gci2nmm_numb! of !gci2nmm_numa! to make it work with NoMoreMemory...
echo.
call :gci2nmm_getid %1
echo 2. Processing "%GAMEname% [%GAMEid%]"...
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑" <nul
if not exist "%PATH_SAVE%" mkdir "%PATH_SAVE%" 2>nul >nul
set /P progbar="北北北北卑" <nul
if exist "%GAMEname% [%GAMEid%]" rmdir /S /Q "%GAMEname% [%GAMEid%]" 2>nul >nul
ren "%GAMEid%" "%GAMEname% [%GAMEid%]" 2>nul >nul
set /P progbar="北北北北卑" <nul
if exist "%PATH_SAVE%\%GAMEname% [%GAMEid%]" rmdir /S /Q "%PATH_SAVE%\%GAMEname% [%GAMEid%]" 2>nul >nul
move /Y "%GAMEname% [%GAMEid%]" "%PATH_SAVE%" 2>nul >nul
set /P progbar="北北北北卑 100%%" <nul
echo.
call %BATS_ECHO% "0A" "- Completed !gci2nmm_numb! of !gci2nmm_numa! -"
set gci2nmm_file_!gci2nmm_numb!=
set /A gci2nmm_numb=!gci2nmm_numb!+1
echo.
echo.
ping -n 2 127.0.0.1 2>nul >nul
goto :eof


:gci2nmm_getid
echo 1. Gathering GameID and GameName...
%EXEC_GCI2% %1 2>nul >nul
set /P progbar="北北北北卑北北北北卑" <nul
ping 127.0.0.1 -n 2 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑" <nul
set GAMEid=NONAME
for /F "tokens=* delims= " %%i in ('dir /B /A:D /O:D') do if exist "%%i\stats.bin" set GAMEid=%%i
set /P progbar="北北北北卑北北北北卑" <nul
set GAMEname=Game not found (%time:~0,2%-%time:~3,2%-%time:~6,2%)
for /F "skip=1 tokens=1,* delims== " %%i in ('type "%FILE_TIT1%"') do if "!GAMEid!"=="%%~i" set GAMEname=%%j
set /P progbar="北北北北卑" <nul
for /F "tokens=1,* delims==:" %%i in ("%GAMEname%") do if not "%%~j"=="" set GAMEname=%%~i -%%~j
for /F "tokens=1,2,* delims==:*<>?^!" %%i in ("%GAMEname%") do set GAMEname=%%~i%%~j%%~k
set /P progbar="北北北北卑北北北北卑 100%%" <nul
goto :eof


:endfile
echo.
echo %TEXT_ENDF_MENU%
pause >nul
goto :eof