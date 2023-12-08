cmakeExampleExternalProjectAdd
==============================

This repository contains implementation for downloading few external project's source at CMake's configure step rather than as part of the main build. These external project's are added using `ExternalProject_Add(...)`, which after downloading, configure's, build and installs them.  

At the time of creation of this project I am new to `cmake`. This project is meant as place holder for my learnings and observations which might help others by sharing it here.  

Any improvements or corrections in the `cmake` code are welcome.

External projects integration details
-------------------------------------
### 1.  [rapivcsv_FilterSort :: v3.2.8080](https://github.com/panchaBhuta/rapidcsv_FilterSort/tree/v3.2.8080)
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


### 4. [googletest :: latest](https://github.com/google/googletest)
This test-lib is integrated by calling `add_subdirectory(...)`.


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

All the 3rd-Party-libs are downloaded, built and installed in `${CMAKE_SOURCE_DIRECTORY}/libs3rdParty`.  


References
----------
Check out [Crascit-DownloadProject](https://github.com/Crascit/DownloadProject) for better understanding of using `ExternalProject_Add(googletest ...)`
  


Keywords
========
cmake, ExternalProject_Add, add_library, add_subdirectory, find_package.  
Integration of rapicsv, cxxopts, cppproperties, googletest.
