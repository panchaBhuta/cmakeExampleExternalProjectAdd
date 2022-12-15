@echo off

mkdir rootbuild
cd rootbuild || goto :error
cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON .. || goto :error
cmake --build . || goto :error

ctest  || goto :error

cmakeExampleExternalProjectAdd --propfilename=..\property\test1.txt || goto :error

cd .. || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
