module alu (
    input  logic [2:0] op,
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] out
);

  always_comb begin
    case (op)
      0: out = a + b;
      1: out = a - b;
      2: out = a & b;
      3: out = a | b;
    endcase
  end

endmodule
