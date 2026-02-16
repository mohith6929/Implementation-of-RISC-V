module alu(
    input wire [2:0]cntrl,
    input wire [31:0]a,b,
    output wire zero,
    output reg [31:0]result
);


always @(*)
begin
    case(cntrl)
        3'b000: result = a + b;
        3'b001: result = a - b;
        default: result = 32'd0;
    endcase
end

assign zero = (result == 32'd0);

endmodule