module EM_pipe(
    input clk,
    input [31:0]ALU_resultE,
    input [31:0]w_dataE,
    input [4:0]rdE,
    input [31:0]pcplus4E,
    output reg [31:0]ALU_resultM,
    output reg [31:0]w_dataM,
    output reg [4:0]rdM,
    output reg [31:0]pcplus4M,

    input reg_writeE,
    input mem_writeE,
    input [1:0]result_srcE,
    output reg reg_writeM,
    output reg mem_writeM,
    output reg [1:0]result_srcM
);

always @(posedge clk)
begin
    ALU_resultM <= ALU_resultE;
    w_dataM <= w_dataE;
    rdM <= rdE;
    pcplus4M <= pcplus4E;

    reg_writeM <= reg_writeE;
    mem_writeM <= mem_writeE;
    result_srcM <= result_srcE;
end

endmodule