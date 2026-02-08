module control_path(
    input [31:0]instr,
    output mem_write,alu_src,reg_write,jalr,branch,jump,
    output [1:0]result_src,imm_src,
    output [2:0]alu_cntrl
);

wire [1:0]alu_op;


main_decoder control(
    .op(instr[6:0]),
    .branch(branch),
    .result_src(result_src),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .imm_src(imm_src),
    .reg_write(reg_write),
    .alu_op(alu_op),
    .jump(jump),
    .jalr(jalr)
);



alu_decoder alu_control(
    .op(instr[5]),
    .funct3(instr[14:12]),
    .funct7(instr[30]),
    .alu_op(alu_op),
    .alu_cntrl(alu_cntrl)
);

endmodule