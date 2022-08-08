#!/bin/bash
# Build script for cleaning everything
set echo on

echo "Cleaning everything..."

make -f test-lin-build clean
ERRORLEVEL=$?
if [ $ERRORLEVEL -ne 0 ]
then
echo "Error:"$ERRORLEVEL && exit
fi

echo "All assemblies cleaned successfully."