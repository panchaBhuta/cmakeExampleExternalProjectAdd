cmakeExampleExternalProjectAdd
==============================

This repository contains implementation for downloading few external project's source at CMake's configure step rather than as part of the main build. These external project's are added using `ExternalProject_Add(...)`, which after downloading, configure's, build and installs them.

At the time of creation of this project I am new to `cmake`. This project is meant as place holder for my learnings and observations which might help othersi by sharing it here.

Any improvements or corrections in the `cmake` code are welcome.

External projects integration details
-------------------------------------
### 1.  [rapivcsv_FilterSort :: v2.0.fs-8.68](https://github.com/panchaBhuta/rapivcsv_FilterSort/tree/v2.0.fs-8.68)
#### C++     :
This is header only library.

#### cmake   :
No packaging or export provided.

#### cmake-integration   :
No version check of `v2.0.08.68`. Installation of headers.


### 2.  [cxxopts :: 32afbc65](https://github.com/jarro2783/cxxopts/tree/32afbc65263e42fa089f473d5a6131983d9b7200)
#### C++     :
This is header only library.

#### cmake   :
Packaging using `pkgconfig.pc.in`.

#### cmake-integration   :
Version check of `3.0.0`. Installation of header and cmake-files.  
File `include/cxxopts.hpp` moved to `include/`**`cxxopts`**`/cxxopts.hpp`.  
`find_package(cxxopts ...)` works as expected.


### 3.  [cppproperties_RecVar :: v2.0.rv-01.0](https://github.com/panchaBhuta/cpp-properties_RecVar/tree/v2.0.rv-01.0)
#### C++     :
This is a STATIC library.

#### cmake   :
Packaging using `export(PACKAGE cppproperties)`.

#### cmake-integration   :
Version check of `2.0.01.0`. Installation of headers, binary-lib and cmake-files.  
`find_package(cppproperties )` when used in the build of main project, has the side-effect that during linking of the `cmakeExampleExternalProjectAdd`, uses the library `libcppproperties.a` in build-path, instead of the one in install-path. Hence, `find_package(cppproperties )` is called to check the version `2.0.01.0` after installation of `cppproperties` library.  
The path to the library `libcppproperties.a` is provided thru `set_property(TARGET cppproperties ...)`.


Usage
-----

```command
mkdir ./rootbuild
cd ./rootbuild


cmake .. -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
cmake  --build . -v

ctest

./cmakeExampleExternalProjectAdd --propfilename=../property/test1.txt

```

Keywords
========
cmake, ExternalProject_Add.  
Integration of rapicsv, cxxopts, cppproperties.