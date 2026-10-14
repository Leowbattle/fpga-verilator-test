#include "verilated.h"
#include <gtest/gtest.h>

// TODO figure out how to do VCD dump
// https://www.itsembedded.com/dhd/verilator_1/
// TODO Support modules with parameters
// TODO cocotb/hardcaml like coroutine/effect based simulation api?
// https://veripool.org/guide/latest/overview.html

template <typename T> class VerilogTest : public testing::Test {
protected:
    VerilogTest()
    {
        contextp = new VerilatedContext;
        dut = new T(contextp);
    }

    ~VerilogTest() override
    {
        delete dut;
        delete contextp;
    }

    VerilatedContext* contextp;
    T* dut;
};

// Example usage
// using AluTest = VerilogTest<Valu>;
