module DE_pipe(
    input clk,
    input [31:0]rd1D,
    input [31:0]rd2D,
    input [31:0]pcD,
    input [5:0]rdD,
    input [31:0]imm_extD,
    input [31:0]pcplus4D,
    output [31:0]rd1E,
    output [31:0]rd2E,
    output [31:0]pcE,
    output [5:0]rdE,
    output [31:0]imm_extE,
    output [31:0]pcplus4E,

    input jalrD, // jalr
    input mem_writeD,
    input alu_srcD,
    input reg_writeD,
    input branchD,
    input jumpD,
    input [1:0]result_srcD,
    input [2:0]alu_cntrlD,
    output jalrE,
    output mem_writeE,
    output alu_srcE,
    output reg_writeE,
    output branchE,
    output jumpE,
    output [1:0]result_srcE,
    output [2:0]alu_cntrlE
);

always @(posedge clk)
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
end

endmodule