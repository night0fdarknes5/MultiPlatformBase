@ECHO OFF
REM Clean Everything

ECHO "Cleaning everything..."

REM Engine
make -f "eng-win-build.mak" clean
IF %ERRORLEVEL% NEQ 0 (echo Error:%ERRORLEVEL% && exit)

REM Testbed
make -f "test-win-build.mak" clean
IF %ERRORLEVEL% NEQ 0 (echo Error:%ERRORLEVEL% && exit)

ECHO "All assemblies cleaned successfully."