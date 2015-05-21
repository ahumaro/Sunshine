@echo off
title DMLizard (by eN-t) - Credits
cls


:credits
REM View credits
cls
type %BATS_HEAD%
call %BATS_ECHO% "0C" "- Thank you for using DMLizard -"
echo  I hope to see you again soon
echo.
call %BATS_ECHO% "0E" "Special thanks"
echo  go to:
echo.
echo 	crediar			for DM, DML, GCReEx, DiscEx, gci2nmm, ...
echo 	FIX94			for DM and DML loader support, WiiFlow Mod, DM Booter, ...
echo 	wiiNinja		for NUSD CLI, ...
echo 	leathl			for WadMii, YAWMM_DE, ...
echo 	dimok			for USB Loader GX, ...
echo 	R2D2199			for cfg USB Loader mod, YAWMM_DE, ...
echo 	WiiPower		for NeoGamma, ...
echo 	feeder			for DMLizard banner graphic and icon
echo 	and all others I forgot - thank you.
echo.
echo.
call %BATS_ECHO% "0A" "-                                 Please consider a donation to crediar                                 -"
echo.
echo This would help to keep up the great work on DIOS MIOS (Lite). Feel free to donate any amount you like.
echo (You will be directed to his donation page upon exit.)
goto endfile


:endfile
echo.
echo %TEXT_ENDF_EXIT%
pause >nul
start www.paypal.com/cgi-bin/webscr?cmd=_donations^&business=info@rypp.net^&item_name=crediar^&lc=US^&currency_code=EUR
exit