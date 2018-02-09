@echo on
@rem  Script to upload spark  (aka pxscene ) artifacts to build server) on
@rem  Windows platform (locally and on AppVeyor)
@rem
@rem
@rem  Assumes the following components are pre-installed:
@rem    - Visual Studio 2017,
@rem    - NSIS(>3.x), cmake(>2.8.x), python(2.7.x), 7z (all added to PATH).
@rem


cd %S%

@rem cd "build-win32/_CPack_Packages/win32/NSIS"

if "%DUKTAPE_SUPPORT%" == "ON" (
  7z a -y pxscene-setup-exe.zip pxscene-setup.exe 
   "C:\Program Files\PuTTY\pscp.exe" -i pxscene-build.pem.ppk build-win32/_CPack_Packages/win32/NSIS/pxscene-setup-exe.zip "ubuntu@96.116.56.119:/var/www/html/edge/windows"
  IF %ERRORLEVEL% NEQ 0 (
    echo "-------------------------- Failed to upload pxscene setup"
  )
  "C:\Program Files\PuTTY\pscp.exe" -i pxscene-build.pem.ppk build-win32/logs/build_logs.txt "ubuntu@96.116.56.119:/var/www/html/edge/windows"
  IF %ERRORLEVEL% NEQ 0 (
    echo "-------------------------- Failed to upload build logs"
  )
)

del pxscene-build.pem.ppk

EXIT 0
