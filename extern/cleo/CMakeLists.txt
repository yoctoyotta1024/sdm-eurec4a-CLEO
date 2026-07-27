# set cmake version
if(NOT DEFINED CMAKE_MINIMUM_REQUIRED_VERSION)
  cmake_minimum_required(VERSION 3.18.0)
endif()

# fetch and make cleo library available
include(FetchContent)
FetchContent_Declare(
  cleo
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  URL https://github.com/yoctoyotta1024/CLEO/archive/refs/heads/main.zip
  GIT_TAG 83318c23223546d10759d202d70f4fa2f7fe4688
)
FetchContent_MakeAvailable(cleo)

message(STATUS "CLEO head above v0.65.1, installation in: ${CLEO_BINARY_DIR}")
