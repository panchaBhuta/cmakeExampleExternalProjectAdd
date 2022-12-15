cmake_minimum_required(VERSION 3.25.1 FATAL_ERROR)

project(CMAKEEXAMPLE VERSION 1.0)

include(CTest)
include(GNUInstallDirs)


set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(DOWNLOAD_3rdPARTY_LIBS ${CMAKE_SOURCE_DIR}/libs3rdParty/download)
set(BUILD_3rdPARTY_LIBS    ${CMAKE_SOURCE_DIR}/libs3rdParty/build)
set(INSTALL_3rdPARTY_LIBS  ${CMAKE_SOURCE_DIR}/libs3rdParty/install)

set(RAPIDCSV       rapidcsv_FilterSort)
set(CXXARGsOPTS    cxxopts)
set(CPPPROPERTIES  cppproperties_RecVar)

set(GOOGLETEST googletest)

#list(APPEND EXTRA_LIBS rapidcsv)

option(PROJECT_BUILD_DEPENDENCIES "Build ${PROJECT_NAME} and the projects it depends on." ON)


    # The way that CLion manages multiple configurations, it causes a copy of
    # the CMakeCache.txt to be copied across due to it not expecting there to
    # be a project within a project.  This causes the hard-coded paths in the
    # cache to be copied and builds to fail.  To mitigate this, we simply
    # remove the cache if it exists before we configure the new project.  It
    # is safe to do so because it will be re-generated.  Since this is only
    # executed at the configure step, it should not cause additional builds or
    # downloads.
    file(REMOVE "${DOWNLOAD_3rdPARTY_LIBS}/CMakeCache.txt")

    # Create and build a separate CMake project to carry out the download.
    # If we've already previously done these steps, they will not cause
    # anything to be updated, so extra rebuilds of the project won't occur.
    # Make sure to pass through CMAKE_MAKE_PROGRAM in case the main project
    # has this set to something not findable on the PATH.
    configure_file("${CMAKE_CURRENT_LIST_DIR}/DependenciesBuild.cmake.in"
                   "${DOWNLOAD_3rdPARTY_LIBS}/CMakeLists.txt"
                   @ONLY
    )
    execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}"
                        -D "CMAKE_MAKE_PROGRAM:FILE=${CMAKE_MAKE_PROGRAM}"
                        .
                    RESULT_VARIABLE result
                    #${OUTPUT_QUIET}
                    WORKING_DIRECTORY "${DOWNLOAD_3rdPARTY_LIBS}"
    )
    if(result)
        message(FATAL_ERROR "CMake step for CMAKEEXAMPLE failed: ${result}")
    endif()
    execute_process(COMMAND ${CMAKE_COMMAND} --build .
                    RESULT_VARIABLE result
                    #${OUTPUT_QUIET}
                    WORKING_DIRECTORY "${DOWNLOAD_3rdPARTY_LIBS}"
    )
    if(result)
        message(FATAL_ERROR "Build step for CMAKEEXAMPLE failed: ${result}")
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


# Prevent GoogleTest from overriding our compiler/linker options
# when building with Visual Studio
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

add_subdirectory(${DOWNLOAD_3rdPARTY_LIBS}/${GOOGLETEST} ${BUILD_3rdPARTY_LIBS}/${GOOGLETEST})


add_dependencies(cmakeExampleExternalProjectAdd rapidcsv cxxopts cppproperties)

target_include_directories(cmakeExampleExternalProjectAdd
                           PUBLIC ${PROJECT_BINARY_DIR}
                           PRIVATE ${INSTALL_3rdPARTY_LIBS}/include
                          )

target_link_directories(cmakeExampleExternalProjectAdd PRIVATE ${INSTALL_3rdPARTY_LIBS}/lib)

target_link_libraries(cmakeExampleExternalProjectAdd INTERFACE rapidcsv cxxopts)
target_link_libraries(cmakeExampleExternalProjectAdd PRIVATE cppproperties  gtest gmock_main)

# add the install targets
install(TARGETS cmakeExampleExternalProjectAdd DESTINATION bin)


add_test(NAME example_test COMMAND cmakeExampleExternalProjectAdd --propfilename=${CMAKE_CURRENT_LIST_DIR}/property/test1.txt)