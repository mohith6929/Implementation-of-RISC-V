module riscv(clk,rst);
input wire clk,rst;

wire [31:0]instr;
wire [2:0]alu_cntrl;
wire [1:0]imm_src;
wire mem_write;
wire alu_src;
wire [1:0]result_src;
wire reg_write;
wire pc_src;
wire zero;
wire jalr;

data_path path(
    .clk(clk),
    .rst(rst),
    .jalr(jalr),
    .pc_src(pc_src),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .mem_write(mem_write),
    .imm_src(imm_src),
    .result_src(result_src),
    .alu_cntrl(alu_cntrl),
    .zero(zero),
    .instr(instr)
);

control_path control(
    .zero(zero),
    .instr(instr),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .reg_write(reg_write),
    .jalr(jalr),
    .pc_src(pc_src),
    .result_src(result_src),
    .imm_src(imm_src),
    .alu_cntrl(alu_cntrl)
);

endmodule