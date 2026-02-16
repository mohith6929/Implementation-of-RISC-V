module mux4(
    input [1:0]s,
    input [31:0]a0,a1,a2,a3,
    output reg [31:0]b
);


always @(*) begin
    case(s)
        2'b00: b = a0;
        2'b01: b = a1;
        2'b10: b = a2;
        2'b11: b = a3;
    endcase
end

endmodule