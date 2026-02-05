module instr_decoder(op,imm_src);
input [6:0]op;
output reg [1:0]imm_src;

always @(*)
begin
    case (op)
        7'b0000011: imm_src   = 2'b00; //lw
        7'b0100011: imm_src   = 2'b01; //sw
        7'b1100011: imm_src   = 2'b10; //beq
        7'b0010011: imm_src   = 2'b00;
        7'b1101111: imm_src   = 2'b11;
        7'b1100111: imm_src   = 2'b00; //jalr
        default: imm_src   = 2'b00;
    endcase
end
endmodule