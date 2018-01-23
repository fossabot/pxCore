@rem this.bat file calls other batch files like unittest, testrunner etc.

echo ************starting script_win32******************
echo %CD%
call ci\execute_win32.bat

echo ErrorLevel : %ERRORLEVEL%

if %ERRORLEVEL% NEQ 0 (
echo execute_win32.bat Failed
EXIT /B 1
)

echo ************completed script_win32******************
EXIT /B 0






