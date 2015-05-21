@echo off
title DMLizard (by eN-t) - optimize a game ISO or GCM file
cls


:optigame
REM Choose the tool or method to optimize the game
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Optimize a game ISO or GCM file -"
echo  with GCReEx or DiscEx
echo.
call %BATS_ECHO% "0E" "To be able to play"
echo  your GameCube games via DIOS MIOS (Lite) you have to optimize your ISO or GCM files
echo by using one of the methods listed below:
echo.
echo 	[1] GCReEx	to extract the game files	for faster loading 	(recommended)
echo 	[2] DiscEx	to optimize a single iso file	for simplier handling
echo 	[3] 2-Disc	to create two DiscEx iso files	for multidisc games (e.g. Resident Evil)
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_PICK_CONT%)
echo %TEXT_PICK_MENU%
echo.
echo Please choose which method you want to use.
set /A optigame_numa=0
set /A optigame_numb=1
set optigame_pick=
set /P optigame_pick="Type in the number in the brackets and confirm with enter: "
if /I "%mainmenu_pick%"=="W" (if /I "%optigame_pick%"=="C" goto :eof)
if "%optigame_pick%"=="0" set "mainmenu_pick=0" & goto :eof
if "%optigame_pick%"=="1" call :optigame_setfile GCReEx %EXEC_GCRE% -x %FILE_TIT2%
if "%optigame_pick%"=="2" call :optigame_setfile DiscEx %EXEC_DISC% -c %FILE_TIT3%
if "%optigame_pick%"=="3" call :optigame_setfile_multidisc
goto optigame


:optigame_setfile
REM optimize a game ISO or GCM file
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Optimize a game ISO or GCM file -"
echo  with %1
echo.
call %BATS_ECHO% "0E" "Please drag'n'drop"
echo  the ISO or GCM file of your choice into the DMLizard window now.
echo.
echo 	[ ] Drag'n'drop an ISO or GCM file into the DMLizard window
if not defined optigame_file_1 (echo.) else (echo 	[S] Start the conversion)
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_PICK_CONT%)
echo 	[0] Return to method selection
echo.
echo Confirm with enter to proceed (currently !optigame_numa! games in batch):
echo.
set optigame_temp=
set /P optigame_temp=
if not defined optigame_temp goto optigame_setfile
for /F "tokens=* delims=" %%i in ('echo %optigame_temp%') do set optigame_temp=%%~i
if /I "%mainmenu_pick%"=="W" (if /I "%optigame_temp%"=="C" goto :eof)
if "%optigame_temp%"=="0" goto :eof
if /I "%optigame_temp%"=="s" (
	if not defined optigame_file_1 (goto optigame_setfile) else (
		for /F "tokens=2 delims==" %%i in ('set optigame_file_') do call :optigame_work %1 %2 %3 %4 "%%~i"
		if "!optigame_numa!"=="1" (
			echo DMLizard has successfully optimized your !optigame_numa! game.
			echo It should now be ready to use with DIOS MIOS and DIOS MIOS Lite.
		) else (
			echo DMLizard has successfully optimized your !optigame_numa! games.
			echo They should now be ready to use with DIOS MIOS and DIOS MIOS Lite.
		)
	)
	goto endfile
)
if not exist "%optigame_temp%" goto optigame_setfile
if defined optigame_file_1 for /F "tokens=2 delims==" %%i in ('set optigame_file_') do (
	if /I "%optigame_temp%"=="%%~i" goto optigame_setfile
)
for %%i in (".iso" ".gcm") do if /I "%optigame_temp:~-4,4%"=="%%~i" (
	set /A optigame_numa=!optigame_numa!+1
	set optigame_file_!optigame_numa!=%optigame_temp%
)
goto optigame_setfile


:optigame_setfile_multidisc
REM optimize a game ISO or GCM file for multidisc games
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Optimize a game ISO or GCM file -"
echo  for multidisc games
echo.
call %BATS_ECHO% "0E" "Please drag'n'drop"
if not defined optigame_file_1 (echo  the ISO or GCM file of the 1st disc into the DMLizard window now.) else (echo  the ISO or GCM file of the 2nd disc into the DMLizard window now.)
echo.
echo 	[ ] Drag'n'drop an ISO or GCM file into the DMLizard window
echo.
if /I "%mainmenu_pick%"=="W" (echo %TEXT_PICK_CONT%)
echo 	[0] Return to method selection
echo.
echo Confirm with enter to proceed (currently !optigame_numa! of 2 discs given):
echo.
set optigame_temp=
set /P optigame_temp=
if not defined optigame_temp goto optigame_setfile_multidisc
for /F "tokens=* delims=" %%i in ('echo %optigame_temp%') do set optigame_temp=%%~i
if /I "%mainmenu_pick%"=="W" (if /I "%optigame_temp%"=="C" goto :eof)
if "%optigame_temp%"=="0" goto :eof
if not exist "%optigame_temp%" goto optigame_setfile_multidisc
if defined optigame_file_1 for /F "tokens=2 delims==" %%i in ('set optigame_file_') do (
	if /I "%optigame_temp%"=="%%~i" goto optigame_setfile_multidisc
)
for %%i in (".iso" ".gcm") do if /I "%optigame_temp:~-4,4%"=="%%~i" (
	set /A optigame_numa=!optigame_numa!+1
	set optigame_file_!optigame_numa!=%optigame_temp%
)
if defined optigame_file_2 goto optigame_work_multidisc
goto optigame_setfile_multidisc


:optigame_work
REM Use the selected tool to optimize the game
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Optimize a game ISO or GCM file -"
echo  with %1
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  will now optimize your GameCube game no. !optigame_numb! of !optigame_numa! to make it work with DIOS MIOS (Lite)...
echo.
call :optigame_getid %5
echo 2. Processing "%GAMEname% [%GAMEid%]" (may take a while)...
set /A GAMEprob=0
for /F "tokens=1,* delims== " %%i in ('type "%FILE_TIT3%"') do if "!GAMEid!"=="%%~i" set /A GAMEprob=!GAMEprob!+1
for /F "tokens=1,* delims== " %%i in ('type "%4"') do if "!GAMEid!"=="%%~i" set /A GAMEprob=!GAMEprob!+2
if "%GAMEprob%" geq "3" %EXEC_DISC% %5 2>nul >nul
if "%GAMEprob%"=="2" %EXEC_DISC% -c %5 2>nul >nul
if "%GAMEprob%" leq "1" %2 %3 %5 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑" <nul
if not exist "%PATH_CUBE%" mkdir "%PATH_CUBE%" 2>nul >nul
set /P progbar="北北北北卑" <nul
if exist "%GAMEname% [%GAMEid%]" rmdir /S /Q "%GAMEname% [%GAMEid%]" 2>nul >nul
ren "%GAMEid%" "%GAMEname% [%GAMEid%]" 2>nul >nul
set /P progbar="北北北北卑" <nul
if exist "%PATH_CUBE%\%GAMEname% [%GAMEid%]" rmdir /S /Q "%PATH_CUBE%\%GAMEname% [%GAMEid%]" 2>nul >nul
move /Y "%GAMEname% [%GAMEid%]" "%PATH_CUBE%" 2>nul >nul
set /P progbar="北北北北卑 100%%" <nul
echo.
call %BATS_ECHO% "0A" "- Completed !optigame_numb! of !optigame_numa! -"
set optigame_file_!optigame_numb!=
set /A optigame_numb=!optigame_numb!+1
echo.
echo.
ping -n 2 127.0.0.1 2>nul >nul
goto :eof


:optigame_work_multidisc
REM Create multidisc game iso files
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Optimize a game ISO or GCM file -"
echo  for multidisc games
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  will now optimize your GameCube discs to make them work with DIOS MIOS (Lite)...
echo.
call :optigame_getid %optigame_file_1%
echo 2. Processing disc 1 of "%GAMEname% [%GAMEid%]" (may take a while)...
%EXEC_DISC% %optigame_file_1% 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑" <nul
if not exist "%PATH_CUBE%" mkdir "%PATH_CUBE%" 2>nul >nul
set /P progbar="北北北北卑" <nul
if exist "%GAMEname% [%GAMEid%]" rmdir /S /Q "%GAMEname% [%GAMEid%]" 2>nul >nul
ren "%GAMEid%" "%GAMEname% [%GAMEid%]" 2>nul >nul
set /P progbar="北北北北卑" <nul
if exist "%PATH_CUBE%\%GAMEname% [%GAMEid%]" rmdir /S /Q "%PATH_CUBE%\%GAMEname% [%GAMEid%]" 2>nul >nul
move /Y "%GAMEname% [%GAMEid%]" "%PATH_CUBE%" 2>nul >nul
set /P progbar="北北北北卑 100%%" <nul
echo 2. Processing disc 2 of "%GAMEname% [%GAMEid%]" (may take a while)...
%EXEC_DISC% %optigame_file_1% 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑" <nul
ren "%GAMEname% [%GAMEid%]\game.iso" "disc2.iso" 2>nul >nul
set /P progbar="北北北北卑" <nul
move /Y "%GAMEname% [%GAMEid%]\disc2.iso" "%PATH_CUBE%\%GAMEname% [%GAMEid%]" 2>nul >nul
set /P progbar="北北北北卑 100%%" <nul
echo.
call %BATS_ECHO% "0A" "- Completed -"
set optigame_file_!optigame_numb!=
echo.
echo.
ping -n 2 127.0.0.1 2>nul >nul
goto :eof


:optigame_getid
echo 1. Gathering GameID and GameName...
start /B %EXEC_DISC% -v %1 2>nul >nul
set /P progbar="北北北北卑北北北北卑" <nul
ping 127.0.0.1 -n 2 2>nul >nul
set /P progbar="北北北北卑北北北北卑" <nul
taskkill /F /IM "DiscEx.exe" 2>nul >nul
tskill /A "DiscEx" 2>nul >nul
set /P progbar="北北北北卑" <nul
set GAMEid=NONAME
for /F "tokens=* delims= " %%i in ('dir /B /A:D /O:D') do if exist "%%i\sys\boot.bin" set GAMEid=%%i
set /P progbar="北北北北卑北北北北卑" <nul
set GAMEname=Game not found (%time:~0,2%-%time:~3,2%-%time:~6,2%)
for /F "skip=1 tokens=1,* delims== " %%i in ('type "%FILE_TIT1%"') do if "!GAMEid!"=="%%~i" set GAMEname=%%j
set /P progbar="北北北北卑" <nul
for /F "tokens=1,* delims==:" %%i in ("%GAMEname%") do if not "%%~j"=="" set GAMEname=%%~i -%%~j
for /F "tokens=1,2,* delims==:*<>?^!" %%i in ("%GAMEname%") do set GAMEname=%%~i%%~j%%~k
set /P progbar="北北北北卑" <nul
rmdir /S /Q "%GAMEid%" 2>nul >nul
set /P progbar="北北北北卑 100%%" <nul
goto :eof


:endfile
echo.
echo %TEXT_ENDF_CONT%
pause >nul
goto :eof