typedef enum logic [2:0] {
  ALU_ADD = 0,
  ALU_SUB = 1,
  ALU_AND = 2,
  ALU_OR  = 3
} alu_op;

module alu (
    input alu_op op,
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] out
);

  always_comb begin
    case (op)
      ALU_ADD: out = a + b;
      ALU_SUB: out = a - b;
      ALU_AND: out = a & b;
      ALU_OR:  out = a | b;
    endcase
  end

endmodule
