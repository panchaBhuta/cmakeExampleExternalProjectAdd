cmake_minimum_required(VERSION 3.25.1 FATAL_ERROR)

project(CMAKEEXAMPLE VERSION 1.0)

include(GNUInstallDirs)


set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(DOWNLOAD_3rdPARTY_LIBS ${CMAKE_SOURCE_DIR}/libs3rdParty/download)
set(BUILD_3rdPARTY_LIBS    ${CMAKE_SOURCE_DIR}/libs3rdParty/build)
set(INSTALL_3rdPARTY_LIBS  ${CMAKE_SOURCE_DIR}/libs3rdParty/install)

set(RAPIDCSV       rapidcsv_FilterSort)
set(CXXARGsOPTS    cxxopts)
set(CPPPROPERTIES  cppproperties_RecVar)

#list(APPEND EXTRA_LIBS rapidcsv)

option(PROJECT_BUILD_DEPENDENCIES "Build ${PROJECT_NAME} and the projects it depends on." ON)


if(PROJECT_BUILD_DEPENDENCIES)
  include("${CMAKE_CURRENT_SOURCE_DIR}/DependenciesBuild.cmake")

  #search for cppproperties package-config-cmake files
  # NOTE : find_package() is called here only for checking version number.
  find_package(cppproperties 2.0.01.0 REQUIRED PATHS ${INSTALL_3rdPARTY_LIBS}/lib/)

  return()
endif()

#NOTE : 'cxxopts' doesnot call export(...), hence `find_package(cxxopts... /lib/cmake/cxxopts)`
#        behavior is different from that of `find_package(cxxopts... /lib)`
find_package(cxxopts 3.0.0 REQUIRED PATHS ${INSTALL_3rdPARTY_LIBS}/lib/cmake/cxxopts)


# add the executable
add_executable(cmakeExampleExternalProjectAdd main.cxx)

add_library(rapidcsv INTERFACE IMPORTED)
add_library(cxxopts  INTERFACE IMPORTED)

# NOTE : find_package(cppproperties ...) can be used here instead, but while 
#        linking executable 'cmakeExampleExternalProjectAdd' , the library 'libcppproperties.a' in
#        build-path gets mapped instead of the one in install-path.
add_library(cppproperties STATIC IMPORTED)
set_property(TARGET cppproperties PROPERTY
             IMPORTED_LOCATION ${INSTALL_3rdPARTY_LIBS}/lib/libcppproperties.a)


#add_subdirectory(rapidcsv)
add_dependencies(cmakeExampleExternalProjectAdd rapidcsv cxxopts cppproperties)

target_include_directories(cmakeExampleExternalProjectAdd
                           PUBLIC ${PROJECT_BINARY_DIR}
                           PRIVATE ${INSTALL_3rdPARTY_LIBS}/include
                          )

target_link_directories(cmakeExampleExternalProjectAdd PRIVATE ${INSTALL_3rdPARTY_LIBS}/lib)

target_link_libraries(cmakeExampleExternalProjectAdd INTERFACE rapidcsv cxxopts)
target_link_libraries(cmakeExampleExternalProjectAdd PRIVATE cppproperties)

# add the install targets
install(TARGETS cmakeExampleExternalProjectAdd DESTINATION bin)

