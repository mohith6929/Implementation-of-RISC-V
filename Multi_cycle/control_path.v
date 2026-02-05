module control_path(
    input clk,reset,
    input zero,
    input [31:0]instr,
    output pc_write,
    output mem_write,
    output adr_src,
    output ir_write,
    output we,
    output [1:0]result_src,
    output [1:0]alu_srca,
    output [1:0]alu_srcb,
    output [1:0]imm_src,
    output [2:0]alu_cntrl
);
wire branch;
wire pc_update;
wire [1:0]alu_op;

fsm main_fsm(
    .clk(clk),
    .reset(reset), 
    .op(instr[6:0]), 
    .branch(branch), 
    .pc_update(pc_update), 
    .reg_write(we), 
    .mem_write(mem_write), 
    .ir_write(ir_write), 
    .result_src(result_src), 
    .alu_srca(alu_srca), 
    .alu_srcb(alu_srcb), 
    .adr_src(adr_src), 
    .alu_op(alu_op)
);

assign pc_write = pc_update | (branch & zero);


alu_decoder alu_decoder(
    .op(instr[5]),
    .funct3(instr[14:12]),
    .funct7(instr[30]),
    .alu_op(alu_op),
    .alu_cntrl(alu_cntrl)
);

instr_decoder instr_decoder(
    .op(instr[6:0]),
    .imm_src(imm_src)
);
endmodule