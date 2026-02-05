module main_decoder(op,branch,result_src,mem_write,alu_src,imm_src,reg_write,alu_op,jump,jalr);
input wire [6:0]op;
output reg reg_write,alu_src,mem_write,branch,jump,jalr;
output reg [1:0]imm_src,alu_op,result_src;

always @(*)
begin
    case (op)
        7'b0000011: begin // LW
            reg_write = 1;
            imm_src   = 2'b00;
            alu_src   = 1;
            mem_write = 0;
            result_src= 2'b01;
            branch    = 0;
            alu_op    = 2'b00;
            jump = 0;
            jalr = 0;
        end
        7'b0100011: begin // SW
            reg_write = 0;
            imm_src   = 2'b01;
            alu_src   = 1;
            mem_write = 1;
            branch    = 0;
            alu_op    = 2'b00;
            jump = 0;
            jalr = 0;
        end
        7'b0110011: begin // R-type
            reg_write = 1;
            alu_src   = 0;
            mem_write = 0;
            result_src= 2'b00;
            branch    = 0;
            alu_op    = 2'b10;
            jump = 0;
            jalr = 0;
        end
        7'b1100011: begin // BEQ
            reg_write = 0;
            imm_src   = 2'b10;
            alu_src   = 0;
            branch    = 1;
            alu_op    = 2'b01;
            jump = 0;
            jalr = 0;
        end
        7'b0010011: begin //I-type
            reg_write = 1;
            imm_src   = 2'b00;
            alu_src   = 1;
            mem_write = 0;
            result_src= 2'b00; 
            branch    = 0;
            alu_op    = 2'b10;
            jump = 0;
            jalr = 0;
        end
        7'b1101111: begin //jump
            reg_write = 1;
            imm_src = 2'b11;
            mem_write = 0;
            result_src= 2'b10;
            branch    = 0;
            jump = 1;
            jalr = 0;
        end
        7'b1100111: begin //jalr
            reg_write = 1;
            imm_src   = 2'b00;
            alu_src   = 1; 
            mem_write = 0;
            result_src= 2'b10;
            branch    = 0;
            jump      = 0;
            jalr      = 1; 
            alu_op    = 2'b00;
        end
        default: begin
            reg_write = 0;
            mem_write = 0;
            alu_src   = 0;
            result_src= 0;
            branch    = 0;
            imm_src   = 2'b00;
            alu_op    = 2'b00;
            jump = 0;
        end
    endcase
end
endmodule