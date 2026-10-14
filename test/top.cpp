#include "VerilogTest.hpp"
#include "Vtop.h"

enum class Alu_op : uint8_t { Add = 0, Sub = 1, And = 2, Or = 3 };

using enum Alu_op;

class TopTest : public VerilogTest<Vtop> {
protected:
    uint8_t run(Alu_op op, bool select_alu, uint8_t a, uint8_t b)
    {
        dut->op = static_cast<uint8_t>(op);
        dut->sel = select_alu;
        dut->a = a;
        dut->b = b;
        dut->eval();
        return dut->out;
    }
};

TEST_F(TopTest, ForwardsAluResultWhenSelected) { ASSERT_EQ(run(Add, true, 4, 5), 9); }

TEST_F(TopTest, SelectsOperandBWhenNotSelected) { ASSERT_EQ(run(Add, false, 4, 5), 5); }
