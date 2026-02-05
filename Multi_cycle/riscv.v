module riscv(
    input clk,
    input reset
);
wire pc_write;
wire mem_write;
wire adr_src;
wire ir_write;
wire we;
wire zero;
wire [1:0]result_src;
wire [1:0]alu_srca,alu_srcb;
wire [1:0]imm_src;
wire [2:0]alu_cntrl;
wire [31:0]instr;

data_path path(
    .clk(clk),
    .reset(reset),
    .pc_write(pc_write),
    .mem_write(mem_write),
    .adr_src(adr_src),
    .ir_write(ir_write),
    .we(we),
    .result_src(result_src),
    .alu_srca(alu_srca),
    .alu_srcb(alu_srcb),
    .imm_src(imm_src),
    .alu_cntrl(alu_cntrl),
    .zero(zero),
    .instr(instr)
);

control_path control(
    .zero(zero),
    .instr(instr),
    .clk(clk),
    .reset(reset),
    .pc_write(pc_write),
    .mem_write(mem_write),
    .adr_src(adr_src),
    .ir_write(ir_write),
    .we(we),
    .result_src(result_src),
    .alu_srca(alu_srca),
    .alu_srcb(alu_srcb),
    .imm_src(imm_src),
    .alu_cntrl(alu_cntrl)
);

endmodule