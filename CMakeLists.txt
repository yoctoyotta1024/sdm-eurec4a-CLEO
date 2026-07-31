# set cmake version
cmake_minimum_required(VERSION 3.18.0)
# cmake_minimum_required(VERSION 3.21.1) ### if using Kokkos with nvc++ compiler on Levante

project(sdm_eurec4a_CLEO
  LANGUAGES CXX
  DESCRIPTION "sdm_eurec4a_CLEO by Clara Bayley, Nils Niebaum and other developers"
  VERSION 0.0.1
)

find_package(MPI REQUIRED)

message(STATUS "sdm_eurec4a_CLEO source from CLEO_SOURCE_DIR: ${sdm_eurec4a_CLEO_SOURCE_DIR}")
message(STATUS "sdm_eurec4a_CLEO build in CLEO_BINARY_DIR: ${sdm_eurec4a_CLEO_BINARY_DIR}")

# ensure C++ compiler uses certain settings
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
set(CMAKE_CXX_STANDARD "20")
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CXX_EXTENSIONS ON)

# install CLEO for project
set(cleopath ${CMAKE_SOURCE_DIR}/extern/cleo)
message(STATUS "Using CLEO installation from: ${cleopath}")
add_subdirectory(${cleopath})

message(STATUS "CLEO_SOURCE_DIR: ${CLEO_SOURCE_DIR}")
message(STATUS "CLEO_BINARY_DIR: ${CLEO_BINARY_DIR}")

# print default compiler flags
message(STATUS "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")

# add examples directory for main program
add_subdirectory(examples)
