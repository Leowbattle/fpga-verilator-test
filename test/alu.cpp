#include "VerilogTest.hpp"
#include "Valu.h"

enum class Alu_op : uint8_t {
    Add = 0,
    Sub = 1,
    And = 2,
    Or = 4
};

using enum Alu_op;

class AluTest : public VerilogTest<Valu> {
protected:
    uint8_t do_alu(Alu_op op, uint8_t a, uint8_t b) {
        dut->op = static_cast<uint8_t>(op);
        dut->a = a;
        dut->b = b;
        dut->eval();
        return dut->out;
    }
};

TEST_F(AluTest, Addition) {
    ASSERT_EQ(do_alu(Add, 4, 5), 9);
}

TEST_F(AluTest, Subtraction) {
    ASSERT_EQ(do_alu(Sub, 10, 5), 5);
}

TEST_F(AluTest, And) {
    ASSERT_EQ(do_alu(And, 0b110, 0b101), 0b100);
}

TEST_F(AluTest, Or) {
    ASSERT_EQ(do_alu(Or, 0b1001, 0b1101), 0b1101);
}
