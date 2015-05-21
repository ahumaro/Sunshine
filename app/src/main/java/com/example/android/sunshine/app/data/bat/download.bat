@echo off
title DMLizard (by eN-t) - Download %~1
cls


:download
REM Download the file
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Download %~1 -"
echo  please wait until the download finishes
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  will download "%~1 [%2]"...
echo.
echo 1. Downloading %~1 [%3]...
%EXEC_WGET% -q -O"%4" "%5"
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
echo 2. Unzipping and removing garbage...
%EXEC_UZIP% -q -o "%4" -d "%PATH_COPY%"
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑" <nul
del /F /Q "%4" >nul
set /P progbar="北北北北卑北北北北卑北北北北卑北北北北卑北北北北卑 100%%" <nul
echo.
call %BATS_ECHO% "0A" "- Completed -"
echo.
echo.
echo DMLizard has successfully downloaded "%~1 [%2]".
echo You can now use it after copying it onto your homebrew drive.
goto endfile


:endfile
echo.
echo %TEXT_ENDF_CONT%
pause >nul
goto :eof