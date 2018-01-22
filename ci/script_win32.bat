@rem this.bat file calls other batch files like unittest, testrunner etc.

echo %CD%
call ci\execute_win32.bat

echo ErrorLevel : %ERRORLEVEL%






