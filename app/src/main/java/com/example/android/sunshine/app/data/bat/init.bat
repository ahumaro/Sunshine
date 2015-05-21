@echo off
title DMLizard (by eN-t)
cls

:init_colorecho
REM Enable colored echo (header)
for /F "tokens=1 delims=#" %%i in ('"prompt $H# & for %%i in (1) do rem"') do set "DEL=%%i"


:init_vars
REM Set main variables
cls

set USER_NAME=%USERNAME%

set PATH_COPY=copy-to-sd
set PATH_COPD=copied-to-sd
set PATH_APPS=%PATH_COPY%\apps
set PATH_CUBE=%PATH_COPY%\games
set PATH_SAVE=%PATH_COPY%\saves
set PATH_WADS=%PATH_COPY%\wad
set PATH_MIOS=%PATH_TEMP%\MIOS

set BATS_CHNG=%PATH_BATS%\changelog.bat
set BATS_COPY=%PATH_BATS%\copytosd.bat
set BATS_CRED=%PATH_BATS%\credits.bat
set BATS_DELF=%PATH_BATS%\dmlelf.bat
set BATS_DIOS=%PATH_BATS%\diosmios.bat
set BATS_DOWN=%PATH_BATS%\download.bat
set BATS_DUMP=%PATH_BATS%\appsdump.bat
set BATS_ECHO=%PATH_BATS%\echocol.bat
set BATS_FIXD=%PATH_BATS%\fixdrag.bat
set BATS_FORM=%PATH_BATS%\formatsd.bat
set BATS_GAME=%PATH_BATS%\optigame.bat
set BATS_GCI2=%PATH_BATS%\gci2nmm.bat
set BATS_IPSP=%PATH_BATS%\ipspatch.bat
set BATS_MENU=%PATH_BATS%\mainmenu.bat
set BATS_USBL=%PATH_BATS%\usbloader.bat
set BATS_WMAN=%PATH_BATS%\appswman.bat
set BATS_WZRD=%PATH_BATS%\wizard.bat
set BATS_HEAD=%PATH_BATS%\header.txt

set EXEC_DISC=%PATH_EXEC%\DiscEx.exe
set EXEC_FIXE=%PATH_EXEC%\fixELF.exe
set EXEC_GCI2=%PATH_EXEC%\gci2nmm.exe
set EXEC_GCRE=%PATH_EXEC%\GCReEx.exe
set EXEC_IPSP=%PATH_EXEC%\ips.exe
set EXEC_MD5E=%PATH_EXEC%\md5.exe
set EXEC_NUSD=%PATH_EXEC%\nusd.exe
set EXEC_WADM=%PATH_EXEC%\WadMii.exe

set FILE_MIOS=RVL-mios-v10.wad
set FILE_BCV6=RVL-BC-v6.wad
set FILE_DRIV=%PATH_TEMP%\drives.txt
set FILE_TIT1=%PATH_EXEC%\titles.txt
set FILE_TIT2=%PATH_EXEC%\titles_nx.txt
set FILE_TIT3=%PATH_EXEC%\titles_nc.txt

set TEXT_PICK_CONT=	[C] Continue with the next step
set TEXT_PICK_MENU=	[0] Return to main menu
set TEXT_PICK_EXIT=	[0] Exit DMLizard
set TEXT_ENDF_CONT=- press any key to continue... -
set TEXT_ENDF_MENU=- press any key to return to main menu... -
set TEXT_ENDF_EXIT=- press any key to exit DMLizard... -

set /A CSUM_NUMS=1
set CSUM_MIOS=851C27DAE82BC1C758BE07FA964D17CB
set CSUM_BCV6=D1593A77E24ECC95AF2B393ABE5D92F0

if exist "%PATH_BATS%\checkver.bat" del /F /Q "%PATH_BATS%\checkver.bat"
if exist "%PATH_TEMP%" rmdir /S /Q "%PATH_TEMP%"
if not exist "%PATH_DATA%" mkdir "%PATH_DATA%"
if not exist "%PATH_BATS%" mkdir "%PATH_BATS%"
if not exist "%PATH_EXEC%" mkdir "%PATH_EXEC%"
if not exist "%PATH_TEMP%" mkdir "%PATH_TEMP%"

if exist "%SELF_EXEC%" del /F /Q "%SELF_EXEC%" >nul
if exist "%SELF_ZIPS%" del /F /Q "%SELF_ZIPS%" >nul

move /Y "unzip.exe" "%EXEC_UZIP%"
move /Y "wget.exe" "%EXEC_WGET%"


:main_start
REM Calling main routine
cls
call %BATS_MENU%
goto :eof