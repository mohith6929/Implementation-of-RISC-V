module alu_decoder(op,funct3,funct7,alu_op,alu_cntrl);
input wire op;
input wire [2:0]funct3;
input wire funct7;
input wire [1:0]alu_op;
output reg [2:0]alu_cntrl;

always @(*)
begin
    alu_cntrl = 3'b000;

    case(alu_op)
        2'b00: alu_cntrl <= 3'b000;
        2'b01: alu_cntrl <= 3'b001;
        2'b10:
        begin
            if((funct3 == 3'b000) && (op & funct7))
            begin
                alu_cntrl <= 3'b001;
            end
            else if((funct3 == 3'b000) && ~(op & funct7))
            begin
                alu_cntrl <= 3'b000;
            end
        end
    endcase
end

endmodule