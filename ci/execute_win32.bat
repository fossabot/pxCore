@echo on
@rem  Windows platform (locally and on AppVeyor)
@rem
@rem

set "PX_DUMP_MEMUSAGE=1"
set "ENABLE_VALGRIND=1"
set "RT_LOG_LEVEL=info"
set "ORIG_DIR=%CD%"
set "testRunner=https://px-apps.sys.comcast.net/pxscene-samples/examples/px-reference/test-run/testRunner.js"

cd %~dp0
cd ..
set "BASE_DIR=%CD%"

echo %CD%
set "EXEC_LOG=%BASE_DIR%\logs\exec_logs.txt"
cd temp\_CPack_Packages\win32\NSIS\pxscene-setup

start /B pxscene.exe %testRunner%?tests=%BASE_DIR%\tests\pxScene2d\testRunner\tests.json > %EXEC_LOG% 2>&1 &


findstr /C:"TEST RESULTS: " %EXEC_LOG%
set errVal=%ERRORLEVEL%
set count=0
:while1
  if %errVal% NEQ 0 (
    if %count% LSS 1500 (
		set count+=30
		timeout /t 30
        findstr /C:"TEST RESULTS: " %EXEC_LOG%
        set errVal=%ERRORLEVEL%		
        goto while1:
      )
  )

taskkill /im pxscene.exe
timeout /t 2

findstr /C:"Failures: 0" %EXEC_LOG%
if %ERRORLEVEL% NEQ 0 (
    call:checkError "Testrunner failure" "Check the exec logs" "Follow the steps locally: export PX_DUMP_MEMUSAGE=1;export RT_LOG_LEVEL=info;./pxscene.sh $TESTRUNNERURL?tests=%BASE_DIR%\tests\pxScene2d\testRunner\tests.json locally and check for 'Failures: 0' in logs. Analyze whether failures is present or not"
	cd %BASE_DIR%
	EXIT /B 1
)



cd %BASE_DIR%
@rem type exec_log.txt

:checkError
    echo. >>%EXEC_LOG%
	echo. >>%EXEC_LOG%
    echo  ******************* >> %EXEC_LOG%
    echo  Failure Reason :  %~1 >> %EXEC_LOG%
	echo  Cause : %~2 >> %EXEC_LOG%
	echo  Reproduction Procedure : %~3 >> %EXEC_LOG%
    echo  ******************* >> %EXEC_LOG%
	echo. >>%EXEC_LOG%
	echo. >>%EXEC_LOG%




