@echo off
title DMLizard (by eN-t) - Create a DIOS MIOS Lite wad
set /A dmlelf_badnum=0
set dmlelf_vers=
cls


:dmlelf
REM Convert an elf file
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Create a DIOS MIOS Lite wad -"
echo  by using an ELF file
echo.
call %BATS_ECHO% "0E" "Please enter"
echo  which revision of DIOS MIOS Lite you want to create.
echo.
echo 	[ ] Type in which revision you want to create
echo %TEXT_PICK_MENU%
echo.
if not defined dmlelf_vers (
	set /P dmlelf_vers="Confirm with enter to proceed: "
) else (
	echo Confirm with enter to proceed: %dmlelf_vers%
)
if not defined dmlelf_vers goto dmlelf
for /F "tokens=* delims= " %%i in ('echo %dmlelf_vers%') do set dmlelf_vers=%%~i
if "%dmlelf_vers%"=="0" goto :eof
if not "%dmlelf_vers:~0,1%"=="r" set dmlelf_vers=r%dmlelf_vers%
echo.
call %BATS_ECHO% "0E" "Please drag'n'drop"
echo  the ELF file into the DMLizard window now.
echo.
echo 	[ ] Drag'n'drop an ELF file into the DMLizard window
echo %TEXT_PICK_MENU%
echo.
echo Confirm with enter to proceed:
echo.
set dmlelf_file=
set /P dmlelf_file=
if not defined dmlelf_file goto dmlelf
for /F "tokens=* delims= " %%i in ('echo %dmlelf_file%') do set dmlelf_file=%%~i
if "%dmlelf_file%"=="0" goto :eof
if not exist "%dmlelf_file%" goto dmlelf
if /I "%dmlelf_file:~-4,4%"==".elf" goto dmlelf_work
goto dmlelf


:dmlelf_work
REM Create the DML wad using an elf file
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Create a DIOS MIOS Lite wad -"
echo  by using an ELF file
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  will create the "DML_%dmlelf_vers%[MIOSv10].wad"...
call :dmlelf_bcandmios
echo 2. Creating the DML wad file...
%EXEC_WADM% -in "%PATH_TEMP%\%FILE_MIOS%" -out "%PATH_MIOS%"
set /P progbar="北北北北卑北北北北卑北北北北卑" <nul
%EXEC_FIXE% "%PATH_MIOS%\00000001.app" "%dmlelf_file%" "%PATH_MIOS%\0000001.app" >nul
del /F /Q "%PATH_MIOS%\00000001.app" >nul
ren "%PATH_MIOS%\0000001.app" "00000001.app" >nul
set /P progbar="北北北北卑北北北北卑北北北北卑" <nul
%EXEC_WADM% -in "%PATH_MIOS%" -out "%PATH_TEMP%\DML_%dmlelf_vers%[MIOSv10].wad"
rmdir /S /Q "%PATH_MIOS%" >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
call :dmlelf_verify
if "%dmlelf_badnum%"=="3" goto dmlelf_corrupted
if "%dmlelf_badwad%"=="1" goto dmlelf_work
call :dmlelf_copytosd
goto endfile


:dmlelf_bcandmios
REM Download the BC and MIOS
echo.
echo 1. Downloading the BCv6 [24kB] and MIOSv10 [182kB]...
if not exist "%PATH_WADS%\%FILE_BCV6%" (
	%EXEC_NUSD% "0000000100000100" "6" "packwad" 2>nul >nul
	move /Y "%PATH_EXEC%\0000000100000100\0000000100000100.wad" "%PATH_TEMP%\%FILE_BCV6%" 2>nul >nul
	rmdir /S /Q "%PATH_EXEC%\0000000100000100" 2>nul >nul
)
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑" <nul
%EXEC_NUSD% "0000000100000101" "10" "packwad" 2>nul >nul
move /Y "%PATH_EXEC%\0000000100000101\0000000100000101.wad" "%PATH_TEMP%\%FILE_MIOS%" 2>nul >nul
rmdir /S /Q "%PATH_EXEC%\0000000100000101" 2>nul >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
goto :eof


:dmlelf_verify
REM Verify the created wad files
set dmlelf_badwad=0
echo 3. Verifying the wad files...
if exist "%PATH_TEMP%\%FILE_BCV6%" (
	%EXEC_MD5E% -c"%CSUM_BCV6%" "%PATH_TEMP%\%FILE_BCV6%"
	if errorlevel 1 set dmlelf_badwad=1
)
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑" <nul
%EXEC_MD5E% -c"%CSUM_MIOS%" "%PATH_TEMP%\%FILE_MIOS%"
if errorlevel 1 set dmlelf_badwad=1
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑" <nul
if "%dmlelf_badwad%"=="1" set /A dmlelf_badnum=%dmlelf_badnum%+1
set /P progbar="北北北北卑北北北北卑 100%%" <nul
goto :eof


:dmlelf_copytosd
REM Move all the files to the copy-to-SD folder
if not exist "%PATH_WADS%" mkdir "%PATH_WADS%\" 2>nul >nul
move /Y "%PATH_TEMP%\*.wad" "%PATH_WADS%\" 2>nul >nul
echo.
call %BATS_ECHO% "0A" "- Completed -"
echo.
echo.
echo To install DIOS MIOS (Lite) use "DML_%dmlelf_vers%[MIOSv10].wad" and "%FILE_BCV6%" to overwrite the MIOS.
echo To uninstall DIOS MIOS (Lite) use "%FILE_MIOS%" to install the original MIOS again.
goto :eof


:dmlelf_corrupted
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
echo %TEXT_ENDF_MENU%
pause >nul
goto :eof