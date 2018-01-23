@echo on
@rem  Windows platform (locally and on AppVeyor)
@rem
@rem

cd %~dp0
cd ..
set "BASE_DIR=%CD%"

echo %CD%
copy %BASE_DIR%\tests\pxScene2d\testRunner\tests.json %BASE_DIR%\tests\pxScene2d\testRunner\tests_orig.json
type %BASE_DIR%\tests\pxScene2d\testRunner\tests_orig.json | findstr /v %BASE_DIR%\test_pxWayland > tests\pxScene2d\testRunner\tests.json








