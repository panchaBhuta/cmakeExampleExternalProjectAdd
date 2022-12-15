#!/usr/bin/env bash

# make.sh

mkdir -p ./rootbuild
cd ./rootbuild

#rm -rf ../libs3rdParty/
#rm -rf *


cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ..
cmake  --build . -v

ctest

./cmakeExampleExternalProjectAdd --propfilename=../property/test1.txt

