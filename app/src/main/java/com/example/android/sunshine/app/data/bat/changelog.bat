@echo off
title DMLizard (by eN-t) - Changelog
cls


:changelog
REM View changelog
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Changelog -"
echo  changes made in this version
echo.
call %BATS_ECHO% "0E" "DMLizard"
echo  changelog for version %SELF_VER0%:
echo.
echo 	- added support for 2-disc games (untested - use DMToolbox if there are problems)
echo 	- improved speed of finding the GameName and GameID
echo 	- removed DIOS MIOS Booter and NeoGamma (too old, incompatible with DM features)
echo 	- updated GCReEx, DiscEx, gci2nmm and other executables
echo 	- updated GameTDB titles.txt file as well as DiscEx and GCReEx fallback lists
echo 	- updated main menu, header and credits
echo 	- fixed some wrong texts
echo.
echo Changelog for version v3.0:
echo.
echo 	- DMLizard's overall speed should now be much faster (especially the startup)
echo 	- did many improvements to GCReEx/DiscEx/GCI2NMM feature:
echo 		- added real batch mode
echo 		- improved conversion speed and reliability
echo 	- and MUCH more...
goto endfile


:endfile
echo.
echo %TEXT_ENDF_MENU%
pause >nul
goto :eof