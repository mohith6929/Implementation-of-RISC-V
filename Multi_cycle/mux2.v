module mux2(
    input s,
    input [31:0]a0,a1,
    output [31:0]b
);

assign b = s ? a1 : a0;

endmodule