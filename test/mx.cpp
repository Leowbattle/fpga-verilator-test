#include "VerilogTest.hpp"
#include "Vmx.h"

class MxTest : public VerilogTest<Vmx> {
protected:
    uint8_t do_mx(uint8_t s, uint8_t a, uint8_t b)
    {
        dut->s = s;
        dut->a = a;
        dut->b = b;
        dut->eval();
        return dut->y;
    }
};

TEST_F(MxTest, SelectsAWhenS) { ASSERT_EQ(do_mx(1, 0x12, 0x34), 0x12); }

TEST_F(MxTest, SelectsBWhenNotS) { ASSERT_EQ(do_mx(0, 0x12, 0x34), 0x34); }
