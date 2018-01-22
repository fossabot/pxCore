@rem this.bat file calls other batch files like unittest, testrunner etc.

echo ************starting script_win32******************
echo %CD%
call ci\execute_win32.bat

echo ErrorLevel : %ERRORLEVEL%






