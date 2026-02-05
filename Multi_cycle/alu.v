module alu(src_a,src_b,alu_cntrl,alu_result,zero);
input [31:0]src_a,src_b;
input [2:0]alu_cntrl;
output reg [31:0]alu_result;
output zero;

always@(*) 
begin
    case(alu_cntrl)
        3'b000: alu_result = src_a + src_b;
        3'b001: alu_result = src_a - src_b;
        default: alu_result = 32'd0;
    endcase
end

assign zero = (alu_result == 32'd0);

endmodule