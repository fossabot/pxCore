@echo on
@rem  Windows platform (locally and on AppVeyor)
@rem
@rem

set "ORIG_DIR=%CD%"
set "testRunner=https://px-apps.sys.comcast.net/pxscene-samples/examples/px-reference/test-run/testRunner.js"

cd %~dp0
cd ..
set "BASE_DIR=%CD%"

echo %CD%

cd build-win32\_CPack_Packages\win32\NSIS\pxscene-setup

start /B pxscene.exe %testRunner%?test=tests\pxScene2d\testRunner\tests.json > exec_log.txt &
findstr /C: "TEST RESULTS: " exec_log.txt
set errVal=%ERRORLEVEL%
set count
:while1
  if %errVal% NEQ 0 (
    if %count% LSS 1500 (
	findstr /C: "TEST RESULTS: " exec_log.txt
	set errVal=%ERRORLEVEL%
        set count+=30
        goto while1:
      )
  )

taskkill /im pxscene.exe

type exec_log.txt
