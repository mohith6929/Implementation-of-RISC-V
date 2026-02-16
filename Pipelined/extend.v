module extend(
    input wire [1:0]immcntrl,
    input wire [24:0]imm,
    output reg [31:0]extimm
);


always @(*)
begin
    case(immcntrl)
        2'b00: extimm <= {{20{imm[24]}},imm[24:13]};
        2'b01: extimm <= {{20{imm[24]}},imm[24:18],imm[4:0]};
        2'b10: extimm <= {{20{imm[24]}},imm[0],imm[23:18],imm[4:1],1'b0};
        2'b11: extimm <= {{12{imm[24]}},imm[12:5],imm[13],imm[23:14],1'b0};
    endcase
end

endmodule