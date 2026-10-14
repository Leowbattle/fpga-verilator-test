module mx (
    input  logic       s,
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] y
);

  assign y = s ? a : b;

endmodule
