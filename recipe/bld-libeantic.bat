call %BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat build-libeantic.sh
if %ERRORLEVEL% neq 0 exit 1