@rem this.bat file calls other batch files like unittest, testrunner etc.
echo %CD%
ci\execute_win32.bat

echo ErrorLevel : %ERRORLEVEL%

execute_win32.bat


