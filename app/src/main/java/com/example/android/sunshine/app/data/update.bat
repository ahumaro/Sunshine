REM For updates just update the VERS and SIZE values!
REM SIZE always shows the size in KiloBytes!
REM These are the details for DMLizard update packages:
set SELF_VER1=v3.5
set SELF_SIZE=597kB
set SELF_LINK=%DOWN_SERV%/update_%SELF_VER1%.zip

set BATS_VER1=v3.5
set BATS_SIZE=20kB
set BATS_LINK=%DOWN_SERV%/bat_%BATS_VER1%.zip

set EXEC_VER1=v3.5
set EXEC_SIZE=1206kB
set EXEC_LINK=%DOWN_SERV%/exe_%EXEC_VER1%.zip


REM These are the details for DMS and DML wad:
set DMSW_VERS=v2.8
set DMSW_SIZE=1571kB
set DMSW_LINK=%DOWN_SERV%/DIOSMIOS_%DMSW_VERS%.wad
set DMSW_FILE=DIOSMIOS_%DMSW_VERS%.wad
set DMSW_CSUM=B28D9B46BFFAF9F002D261B8F56B6D44
set DMSW_NAME=DIOS MIOS wad
set DMSW_TEXT=%DMSW_NAME%		to play GameCube games from USB
set DMSW_VARS="%DMSW_NAME%" %DMSW_VERS% %DMSW_SIZE% %DMSW_FILE% %DMSW_LINK% %DMSW_CSUM%

set DMLW_VERS=v2.8
set DMLW_SIZE=1566kB
set DMLW_LINK=%DOWN_SERV%/DIOSMIOSLite_%DMLW_VERS%.wad
set DMLW_FILE=DIOSMIOSLite_%DMLW_VERS%.wad
set DMLW_CSUM=1D86A5FEE78350A02CD7D9E480EA6F26
set DMLW_NAME=DIOS MIOS Lite wad
set DMLW_TEXT=%DMLW_NAME%	to play GameCube games from SD
set DMLW_VARS="%DMLW_NAME%" %DMLW_VERS% %DMLW_SIZE% %DMLW_FILE% %DMLW_LINK% %DMLW_CSUM%


REM USB backup loaders: xyz1 is the base pack, xyz2 the DML dol, length of TEXT must be 40 characters (tabstop = 8 chars)
set CFG1_SIZE=7322kB
set CFG1_LINK=%DOWN_SERV%/cfgusbloadermod_base.zip
set CFG1_FILE=%PATH_TEMP%\cfgusbloadermod_base.zip
set CFG2_VERS=r51
set CFG2_SIZE=1108kB
set CFG2_LINK=%DOWN_SERV%/cfgusbloadermod_%CFG2_VERS%.zip
set CFG2_FILE=%PATH_TEMP%\cfgusbloadermod_%CFG2_VERS%.zip
set CFG2_NAME=cfg USB Loader Mod
set CFG2_TEXT=  %CFG2_NAME% [%CFG2_VERS%]		
set CFG2_VARS="%CFG2_NAME%" %CFG2_VERS% %CFG1_SIZE% %CFG2_SIZE% %CFG1_FILE% %CFG1_LINK% %CFG2_FILE% %CFG2_LINK%

set UGX1_SIZE=2943kB
set UGX1_LINK=%DOWN_SERV%/usbloadergx_base.zip
set UGX1_FILE=%PATH_TEMP%\usbloadergx_base.zip
set UGX2_VERS=r1209
set UGX2_SIZE=2920kB
set UGX2_LINK=%DOWN_SERV%/usbloadergx_%UGX2_VERS%.zip
set UGX2_FILE=%PATH_TEMP%\usbloadergx_%UGX2_VERS%.zip
set UGX2_NAME=USB Loader GX
set UGX2_TEXT=  %UGX2_NAME% [%UGX2_VERS%]		
set UGX2_VARS="%UGX2_NAME%" %UGX2_VERS% %UGX1_SIZE% %UGX2_SIZE% %UGX1_FILE% %UGX1_LINK% %UGX2_FILE% %UGX2_LINK%

set WFL1_SIZE=1835kB
set WFL1_LINK=%DOWN_SERV%/wiiflow_base.zip
set WFL1_FILE=%PATH_TEMP%\wiiflow_base.zip
set WFL2_VERS=v4.1.0
set WFL2_SIZE=2239kB
set WFL2_LINK=%DOWN_SERV%/wiiflow_%WFL2_VERS%.zip
set WFL2_FILE=%PATH_TEMP%\wiiflow_%WFL2_VERS%.zip
set WFL2_NAME=WiiFlow
set WFL2_TEXT=  %WFL2_NAME% [%WFL2_VERS%]			
set WFL2_VARS="%WFL2_NAME%" %WFL2_VERS% %WFL1_SIZE% %WFL2_SIZE% %WFL1_FILE% %WFL1_LINK% %WFL2_FILE% %WFL2_LINK%


REM These are the details for other homebrew apps:
set YAWM_VERS=rev4
set YAWM_SIZE=312kB
set YAWM_LINK=%DOWN_SERV%/yawmm_%YAWM_VERS%.zip
set YAWM_FILE=%PATH_TEMP%\yawmm_%YAWM_VERS%.zip
set YAWM_NAME=YAWMM_DE
set YAWM_TEXT=%YAWM_NAME%		with nice UI, batch mode, very secure...
set YAWM_VARS="%YAWM_NAME%" %YAWM_VERS% %YAWM_SIZE% %YAWM_FILE% %YAWM_LINK%

set WMAN_VERS=v1.7
set WMAN_SIZE=774kB
set WMAN_LINK=%DOWN_SERV%/wadmanager_%WMAN_VERS%.zip
set WMAN_FILE=%PATH_TEMP%\wadmanager_%WMAN_VERS%.zip
set WMAN_NAME=WAD Manager
set WMAN_TEXT=%WMAN_NAME%		with simple structure, works flawlessly...
set WMAN_VARS="%WMAN_NAME%" %WMAN_VERS% %WMAN_SIZE% %WMAN_FILE% %WMAN_LINK%

set CRIP_VERS=v1.0.5
set CRIP_SIZE=313kB
set CRIP_LINK=%DOWN_SERV%/cleanrip_%CRIP_VERS%.zip
set CRIP_FILE=%PATH_TEMP%\cleanrip_%CRIP_VERS%.zip
set CRIP_NAME=CleanRip
set CRIP_TEXT=%CRIP_NAME%		with SD/USB FAT/NTFS support, very fast, uses IOS58...
set CRIP_VARS="%CRIP_NAME%" %CRIP_VERS% %CRIP_SIZE% %CRIP_FILE% %CRIP_LINK%

set SUPD_VERS=v1.3
set SUPD_SIZE=192kB
set SUPD_LINK=%DOWN_SERV%/superdump_%SUPD_VERS%.zip
set SUPD_FILE=%PATH_TEMP%\superdump_%SUPD_VERS%.zip
set SUPD_NAME=SuperDump
set SUPD_TEXT=%SUPD_NAME%		with SD/USB FAT support, needs patched IOS...
set SUPD_VARS="%SUPD_NAME%" %SUPD_VERS% %SUPD_SIZE% %SUPD_FILE% %SUPD_LINK%