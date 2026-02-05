module data_path(
    input clk,rst,jalr,pc_src,reg_write,alu_src,mem_write,
    input [1:0]imm_src,result_src,
    input [2:0]alu_cntrl,
    output zero,
    output [31:0]instr
);

wire [31:0]pc,pc_nxt;
wire [31:0]base;
wire [31:0]offset;
wire [31:0]ALU_result;
wire [31:0]read_data;
wire [31:0]w_data;
wire [31:0]offset_regi;
wire [31:0]result;

mux4 pc_mux(
    .s({jalr,pc_src}),
    .a0(pc + 32'd4),
    .a1(pc + offset),
    .a2(ALU_result),
    .a3(ALU_result),
    .b(pc_nxt)
);


pc pc_reg(
    .clk(clk),
    .reset(rst),
    .pc_nxt(pc_nxt),
    .pc(pc)
);


instr_memo instr_rom(
    .a(pc),
    .rd(instr)
);


regi_file registers(
    .clk(clk),
    .a1(instr[19:15]),
    .rd1(base),
    .wd3(result),
    .a2(instr[24:20]),
    .a3(instr[11:7]),
    .rd2(w_data),
    .we3(reg_write)
);


extend sign_extend(
    .imm(instr[31:7]),
    .extimm(offset),
    .immcntrl(imm_src)
);



mux2 ALU_mux(
    .s(alu_src),
    .a0(w_data),
    .a1(offset),
    .b(offset_regi)
);


alu logi_unit(
    .cntrl(alu_cntrl),
    .a(base),.b(offset_regi),
    .result(ALU_result),
    .zero(zero)
);


data_mem data_ram(
    .clk(clk),
    .a(ALU_result),
    .rd(read_data),
    .wd(w_data),
    .we(mem_write)
);


mux4 result_mux(
    .s(result_src),
    .a0(ALU_result),
    .a1(read_data),
    .a2(pc + 32'd4),
    .a3(pc + 32'd4),
    .b(result)
);

endmodule