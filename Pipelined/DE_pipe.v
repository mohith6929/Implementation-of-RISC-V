module DE_pipe(
    input clk,reset,
    input [31:0]rd1D,
    input [31:0]rd2D,
    input [31:0]pcD,
    input [4:0]rdD,
    input [31:0]imm_extD,
    input [31:0]pcplus4D,
    output reg [31:0]rd1E,
    output reg [31:0]rd2E,
    output reg [31:0]pcE,
    output reg [4:0]rdE,
    output reg [31:0]imm_extE,
    output reg [31:0]pcplus4E,

    input jalrD, // jalr
    input mem_writeD,
    input alu_srcD,
    input reg_writeD,
    input branchD,
    input jumpD,
    input [1:0]result_srcD,
    input [2:0]alu_cntrlD,
    output reg jalrE,
    output reg mem_writeE,
    output reg alu_srcE,
    output reg reg_writeE,
    output reg branchE,
    output reg jumpE,
    output reg [1:0]result_srcE,
    output reg [2:0]alu_cntrlE,

    input [4:0] rs1D,
    input [4:0] rs2D,
    output reg [4:0]rs1E,
    output reg [4:0]rs2E
);

always @(posedge clk)
begin
    if(reset == 1) 
    begin
        rd1E <= 0;
        rd2E <= 0;
        pcE <= 0;
        rdE <= 0;
        imm_extE <= 0;
        pcplus4E <= 0;

        jalrE <= 0;
        mem_writeE <= 0;
        alu_srcE <= 0;
        reg_writeE <= 0;
        branchE <= 0;
        jumpE <= 0;
        result_srcE <= 0;
        alu_cntrlE <= 0;

        rs1E <= 0;
        rs2E <= 0;
    end
    else
    begin
        rd1E <= rd1D;
        rd2E <= rd2D;
        pcE <= pcD;
        rdE <= rdD;
        imm_extE <= imm_extD;
        pcplus4E <= pcplus4D;

        jalrE <= jalrD;
        mem_writeE <= mem_writeD;
        alu_srcE <= alu_srcD;
        reg_writeE <= reg_writeD;
        branchE <= branchD;
        jumpE <= jumpD;
        result_srcE <= result_srcD;
        alu_cntrlE <= alu_cntrlD;

        rs1E <= rs1D;
        rs2E <= rs2D;
    end
    
end

endmodule