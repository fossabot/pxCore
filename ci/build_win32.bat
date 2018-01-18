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

set "VSCMD_START_DIR=%CD%"
call "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Auxiliary/Build/vcvars32.bat" x86

@rem build dependencies
cd examples/pxScene2d/external
call buildWindows.bat

cd "%BASE_DIR%"
md build-win32
cd build-win32

@rem build pxScene
<<<<<<< HEAD
@rem cmake -DCMAKE_VERBOSE_MAKEFILE=ON ..
cmake -DBUILD_PX_TESTS=ON -DBUILD_PXSCENE_STATIC_LIB=ON -DPXSCENE_TEST_HTTP_CACHE=OFF ..
=======
cmake -DCMAKE_VERBOSE_MAKEFILE=ON ..
>>>>>>> 48222fb97... Appveyor configuration
cmake --build . --config Release -- /m
cpack .

@rem create standalone archive
cd _CPack_Packages/win32/NSIS
7z a -y pxscene-setup.zip pxscene-setup

cd %ORIG_DIR%
