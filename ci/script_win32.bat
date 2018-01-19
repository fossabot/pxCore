@rem this.bat file calls other batch files like unittest, testrunner etc.
<<<<<<< HEAD
echo %CD%
ci\execute_win32.bat

echo ErrorLevel : %ERRORLEVEL%

execute_win32.bat
=======

echo %CD%
call ci\execute_win32.bat

echo ErrorLevel : %ERRORLEVEL%

call execute_win32.bat
>>>>>>> d8517675b... appveyor support


