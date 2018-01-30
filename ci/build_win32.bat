@echo on
@rem  Windows platform (locally and on AppVeyor)
@rem
@rem
@rem  Assumes the following components are pre-installed:
@rem    - Visual Studio 2017,
@rem    - NSIS(>3.x), cmake(>2.8.x), python(2.7.x), 7z (all added to PATH).
@rem

cmake --version
python --version

set "ORIG_DIR=%CD%"

cd %~dp0
cd ..
set "BASE_DIR=%CD%"


echo "SDK VERSION : "
echo %WINDOWSSDKDIR%

set "VSCMD_START_DIR=%CD%"
call "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Auxiliary/Build/vcvars32.bat" x86

@rem build dependencies
cd examples/pxScene2d/external
call buildWindows.bat

cd "%BASE_DIR%"
md logs
cd logs
set "LOGS_DIR=%CD%"
set "BUILD_LOGS=%LOGS_DIR%\build_logs"
cd ..
md build-win32
cd build-win32

@rem build pxScene

@rem cmake -DCMAKE_VERBOSE_MAKEFILE=ON ..
cmake -DBUILD_PX_TESTS=ON -DBUILD_PXSCENE_STATIC_LIB=ON -DPXSCENE_TEST_HTTP_CACHE=OFF -DCMAKE_VERBOSE_MAKEFILE=ON -Wno-dev .. > %BUILD_LOGS%
if %ERRORLEVEL% NEQ 0 (
    call checkError "cmake config failed"  "Config Error " "Check the error in build logs : %BUILD_LOGS%"
	EXIT /B 1
)

cmake --build . --config Release -- /m >> %BUILD_LOGS%
if %ERRORLEVEL% NEQ 0 (
    call checkError "cmake build failed for pxcore,rtcore,pxscene app,libpxscene or unitttests" "Compilation error" "Check the errors displayed in this window"
	EXIT /B 1
)

cpack .

@rem create standalone archive
cd _CPack_Packages/win32/NSIS
7z a -y pxscene-setup.zip pxscene-setup

cd %ORIG_DIR%
EXIT /B 0

:checkError
    echo. >>%BUILD_LOGS%
	echo. >>%BUILD_LOGS%
    echo  ******************* >> %BUILD_LOGS%
    echo  Failure Reason :  %~1 >> %BUILD_LOGS%
	echo  Cause : %~2 >> %BUILD_LOGS%
	echo  Reproduction Procedure : %~3 >> %BUILD_LOGS%
    echo  ******************* >> %BUILD_LOGS%
	echo. >>%BUILD_LOGS%
	echo. >>%BUILD_LOGS%
	EXIT /B 0
