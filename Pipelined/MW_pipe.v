module MW_pipe(
    input clk,
    input [31:0]ALU_resultM,
    input [31:0]read_dataM,
    input [4:0]rdM,
    input [31:0]pcplus4M,
    output reg [31:0]ALU_resultW,
    output reg [31:0]read_dataW,
    output reg [4:0]rdW,
    output reg [31:0]pcplus4W,

    input reg_writeM,
    input [1:0]result_srcM,
    output reg reg_writeW,
    output reg [1:0]result_srcW
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