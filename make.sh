#!/usr/bin/env bash

# make.sh

mkdir -p ./rootbuild
cd ./rootbuild

#rm -rf ../libs3rdParty/
#rm -rf *


cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DPROJECT_BUILD_DEPENDENCIES=ON ..
cmake  --build . -v


cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DPROJECT_BUILD_DEPENDENCIES=OFF ..
cmake  --build . -v


./cmakeExampleExternalProjectAdd --propfilename=../property/test1.txt

