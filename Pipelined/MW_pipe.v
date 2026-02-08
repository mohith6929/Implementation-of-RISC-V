module MW_pipe(
    input clk,
    input [31:0]ALU_resultM,
    input [31:0]read_dataM,
    input [31:0]rdM,
    input [31:0]pcplus4M,
    output [31:0]ALU_resultW,
    output [31:0]read_dataW,
    output [31:0]rdW,
    output [31:0]pcplus4W,

    input reg_writeM,
    input [1:0]result_srcM,
    output reg_writeW,
    output [1:0]result_srcW
);

always @(posedge clk)
begin
    ALU_resultW <= ALU_resultM;
    read_dataW <= read_dataM;
    rdW <= rdM;
    pcplus4W <= pcplus4M;

    reg_writeW <= reg_writeM;
    result_srcW <= result_srcM;
end

endmodule