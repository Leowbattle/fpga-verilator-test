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

# One library, several verilated models: one verilate() call per testable unit.
# Each call needs an explicit PREFIX so the generated V<prefix>.h name is
# deterministic (otherwise it is guessed from the first source file).
add_library(hdl)

# Leaf modules, verilated standalone for unit testing.
verilate(hdl TRACE PREFIX Valu TOP_MODULE alu SOURCES src/alu.sv)
verilate(hdl TRACE PREFIX Vmx TOP_MODULE mx SOURCES src/mx.sv)

# Example integration top. Its dependencies are listed before it: the `alu_op`
# typedef declared at $unit scope in alu.sv must be visible when top.sv is parsed.
verilate(hdl TRACE PREFIX Vtop TOP_MODULE top SOURCES src/alu.sv src/mx.sv src/top.sv)

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
