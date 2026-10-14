module top (
    input  alu_op       op,
    input  logic        sel,
    input  logic  [7:0] a,
    input  logic  [7:0] b,
    output logic  [7:0] out
);

  logic [7:0] alu_out;

  alu u_alu (
      .op (op),
      .a  (a),
      .b  (b),
      .out(alu_out)
  );

  mx u_mx (
      .s(sel),
      .a(alu_out),
      .b(b),
      .y(out)
  );

endmodule
