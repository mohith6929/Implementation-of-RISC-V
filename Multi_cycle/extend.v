module extend(instr,imm_ext,imm_src);
input wire [31:0]instr;
input wire [1:0]imm_src;
output reg [31:0]imm_ext;
always@(*) begin
    case (imm_src)
        2'b00: begin // I-type 12 bit signed
            imm_ext <= {{20{instr[31]}}, instr[31:20]};
        end 
        2'b01: begin //S-type 12 bit signed
            imm_ext <= {{20{instr[31]}}, instr[31:25], instr[11:7]};
        end
        2'b10: begin //B-type 13 bit signed
            imm_ext <= {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
        end
        2'b11: begin //J-type 21 bit signed
            imm_ext <= {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
        end
    endcase
end
endmodule