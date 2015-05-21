<nul set /P .=%DEL%>"%~2"
findstr /V /A:%~1 /R "nul" "%~2" nul
del /F /Q "%~2" 2>nul >nul
goto :eof