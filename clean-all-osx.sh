#!/bin/bash
# Build script for rebuilding everything
set echo on

echo "Cleaning everything..."

make -f eng-osx-build.mak clean

ERRORLEVEL=$?
if [ $ERRORLEVEL -ne 0 ]
then
echo "Error:"$ERRORLEVEL && exit
fi

make -f test-osx-build.mak clean
ERRORLEVEL=$?
if [ $ERRORLEVEL -ne 0 ]
then
echo "Error:"$ERRORLEVEL && exit
fi

echo "All files cleaned successfully."