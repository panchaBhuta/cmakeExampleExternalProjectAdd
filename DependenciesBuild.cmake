
# This Project Depends on External Project(s) 
include (ExternalProject)

# Begin: External Third Party Library
ExternalProject_Add (rapidcsv
  GIT_REPOSITORY "git@github.com:panchaBhuta/rapidcsv_FilterSort.git"
  GIT_TAG "v2.0.fs-8.68"
  SOURCE_DIR ${DOWNLOAD_3rdPARTY_LIBS}/${RAPIDCSV}
  BINARY_DIR ${BUILD_3rdPARTY_LIBS}/${RAPIDCSV}
  CONFIGURE_COMMAND ${CMAKE_COMMAND}  -DCMAKE_BUILD_TYPE=Release  ${DOWNLOAD_3rdPARTY_LIBS}/${RAPIDCSV}
        #BUILD_COMMAND     cmake --build .        # cd ${BINARY_DIR} -> default command
  INSTALL_COMMAND   ${CMAKE_COMMAND}  --install .   --prefix ${INSTALL_3rdPARTY_LIBS}
  TEST_COMMAND      ""
)

ExternalProject_Add (cxxopts
  GIT_REPOSITORY "git@github.com:jarro2783/cxxopts.git"
  GIT_TAG "e9d20c2c078076da928288fdbae2a39431b4f253"
  SOURCE_DIR ${DOWNLOAD_3rdPARTY_LIBS}/${CXXARGsOPTS}
  BINARY_DIR ${BUILD_3rdPARTY_LIBS}/${CXXARGsOPTS}
  CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCXXOPTS_BUILD_EXAMPLES=OFF  -DCXXOPTS_BUILD_TESTS=OFF
                             -DCXXOPTS_ENABLE_INSTALL=ON  -DCXXOPTS_ENABLE_WARNINGS=ON
                                 #-Dcxxopts_DIR:PATH=${INSTALL_3rdPARTY_LIBS}/cmake/cxxopts/
                             ${DOWNLOAD_3rdPARTY_LIBS}/${CXXARGsOPTS}
        #BUILD_COMMAND     cmake --build .
  INSTALL_COMMAND   ${CMAKE_COMMAND}  --install .   --prefix ${INSTALL_3rdPARTY_LIBS} &&
                    ${CMAKE_COMMAND} -E make_directory ${INSTALL_3rdPARTY_LIBS}/include/${CXXARGsOPTS}  &&
                       # move file `include/cxxopts.hpp` to `include/${CXXARGsOPTS}/cxxopts.hpp`
                    ${CMAKE_COMMAND} -E rename ${INSTALL_3rdPARTY_LIBS}/include/cxxopts.hpp ${INSTALL_3rdPARTY_LIBS}/include/${CXXARGsOPTS}/cxxopts.hpp
  TEST_COMMAND      ""
)

ExternalProject_Add (cppproperties
  GIT_REPOSITORY "git@github.com:panchaBhuta/cpp-properties_RecVar.git"
  GIT_TAG "v2.0.rv-01.0"
  SOURCE_DIR ${DOWNLOAD_3rdPARTY_LIBS}/${CPPPROPERTIES}
  BINARY_DIR ${BUILD_3rdPARTY_LIBS}/${CPPPROPERTIES}
  CONFIGURE_COMMAND  ${CMAKE_COMMAND}  ${DOWNLOAD_3rdPARTY_LIBS}/${CPPPROPERTIES}
        #BUILD_COMMAND     cmake --build .
  INSTALL_COMMAND   ${CMAKE_COMMAND}  --install .   --prefix ${INSTALL_3rdPARTY_LIBS}
  TEST_COMMAND      ""
)

