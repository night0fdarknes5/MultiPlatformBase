#!/bin/bash
# Build script for rebuilding everything
set echo on

echo "Building everything..."

make -f eng-lin-build all

ERRORLEVEL=$?
if [ $ERRORLEVEL -ne 0 ]
then
echo "Error:"$ERRORLEVEL && exit
fi

make -f test-lin-build all
ERRORLEVEL=$?
if [ $ERRORLEVEL -ne 0 ]
then
echo "Error:"$ERRORLEVEL && exit
fi

echo "All assemblies built successfully."