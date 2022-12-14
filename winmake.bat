@echo off

mkdir rootbuild
cd rootbuild || goto :error
cmake -DPROJECT_BUILD_DEPENDENCIES=ON .. || goto :error
cmake --build . || goto :error
cmake -DPROJECT_BUILD_DEPENDENCIES=OFF .. || goto :error
cmake --build . || goto :error
cd .. || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
