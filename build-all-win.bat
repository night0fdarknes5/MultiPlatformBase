@ECHO OFF
REM Build Everything

ECHO "Building everything..."

REM Testbed
make -f "test-win-build.mak" all
IF %ERRORLEVEL% NEQ 0 (echo Error:%ERRORLEVEL% && exit)

ECHO "All assemblies built successfully."