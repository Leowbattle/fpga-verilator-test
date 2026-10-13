load("@rules_verilator//verilator:defs.bzl", "verilator_cc_library")
load("@rules_verilog//verilog:defs.bzl", "verilog_library")
load("@rules_cc//cc:cc_binary.bzl", "cc_binary")

verilog_library(
    name = "alu",
    srcs = ["alu.sv"],
    top_module = "alu",
)

verilator_cc_library(
    name = "alu_verilator",
    module = ":alu",
    timing = True,
    trace_mode = "vcd",
    vopts = [
        "-Wall",
        "--x-assign fast",
        "--x-initial fast",
    ],
)

cc_binary(
    name = "my_test",
    srcs = ["testbench.cpp"],
    deps = [":alu_verilator"],
    copts = ["-std=c++23"]
)