module EM_pipe(
    input clk,
    input [31:0]ALU_resultE,
    input [31:0]w_dataE,
    input [31:0]rdE,
    input [31:0]pcplus4E,
    output [31:0]ALU_resultM,
    output [31:0]w_dataM,
    output [31:0]rdM,
    output [31:0]pcplus4M,

    input reg_writeE,
    input mem_writeE,
    input [1:0]result_srcE,
    output reg_writeM,
    output mem_writeM,
    output [1:0]result_srcM
);

always @(posedge clk)
begin
    ALU_resultM <= ALU_resultE;
    w_dataM <= w_dataE;
    rdM <= rd1E;
    pcplus4M <= pcplus4E;

    .reg_writeM <= reg_writeM;
    .mem_writeM <= mem_writeM;
    .result_srcM <= result_srcM;
end

endmodule