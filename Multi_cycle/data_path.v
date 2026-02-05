module data_path(
    input clk,reset,
    input pc_write,
    input mem_write,
    input adr_src,
    input ir_write,
    input we,
    input [1:0]result_src,
    input [1:0]alu_srca,
    input [1:0]alu_srcb,
    input [1:0]imm_src,
    input [2:0]alu_cntrl,
    output zero,
    output [31:0]instr
);
wire [31:0]pc;
wire [31:0]rd;
wire [31:0]adr;
wire [31:0]imm_ext;
wire [31:0]rd1;
wire [31:0]rd2;
wire [31:0]alu_result;
wire [31:0]src_a,src_b;
wire [31:0]result;
wire [31:0]data;
wire [31:0]old_pc;
wire [31:0]a;
wire [31:0]a2;
wire [31:0]alu_out;



pc pc_reg(
    .clk(clk),
    .pc(pc),
    .en(pc_write),
    .pc_nxt(result),
    .reset(reset)
);

mux2 adr_mux(
    .s(adr_src),
    .a0(pc),
    .a1(result),
    .b(adr)
);

memo memory(
    .clk(clk),
    .a(adr),
    .rd(rd),
    .wd(a2),
    .we(mem_write)
);

ff NA_data(
    .clk(clk),
    .en(1'b1),
    .d(rd),
    .q(data)
);

ff NA_instr(
    .clk(clk),
    .en(ir_write),
    .d(rd),
    .q(instr)
);

ff NA_oldpc(
    .clk(clk),
    .en(ir_write),
    .d(pc),
    .q(old_pc)
);

extend imm_extend(
    .instr(instr),
    .imm_ext(imm_ext),
    .imm_src(imm_src)
);

regi_file registers(
    .clk(clk),
    .a1(instr[19:15]),
    .rd1(rd1),
    .a3(instr[11:7]),
    .wd3(result),
    .a2(instr[24:20]),
    .rd2(rd2),
    .we3(we)
);

ff NA_a1(
    .clk(clk),
    .en(1'b1),
    .d(rd1),
    .q(a)
);

ff NA_a2(
    .clk(clk),
    .en(1'b1),
    .d(rd2),
    .q(a2)
);

mux4 src_a_mux(
    .s(alu_srca),
    .a0(pc),
    .a1(old_pc),
    .a2(a),
    .a3(a),
    .b(src_a)
);

mux4 src_b_mux(
    .s(alu_srcb),
    .a0(a2),
    .a1(imm_ext),
    .a2(32'd4),
    .a3(32'd4),
    .b(src_b)
);

alu alu(
    .src_a(src_a),
    .src_b(src_b),
    .alu_cntrl(alu_cntrl),
    .alu_result(alu_result),
    .zero(zero)
);

ff NA_ALUout(
    .clk(clk),
    .en(1'b1),
    .d(alu_result),
    .q(alu_out)
);

mux4 result_mux(
    .s(result_src),
    .a0(alu_out),
    .a1(data),
    .a2(alu_result),
    .a3(alu_result),
    .b(result)
);

endmodule