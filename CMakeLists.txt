cmake_minimum_required(VERSION 3.31.6)
project(fpga-verilator-test)
 
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)


find_package(verilator HINTS $ENV{VERILATOR_ROOT})

file(GLOB TEST_SRC_FILES test/*.cpp)
file(GLOB VERILOG_SRC_FILES src/*.sv)

add_library(hdl)
verilate(hdl TRACE TOP_MODULE alu SOURCES ${VERILOG_SRC_FILES})

enable_testing()

add_executable(
  tests
  ${TEST_SRC_FILES}
)
target_link_libraries(
  tests
  GTest::gtest_main
  hdl
)

include(GoogleTest)
gtest_discover_tests(tests)
