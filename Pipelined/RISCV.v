module RISCV(
    input clk,rst   
);

wire [31:0]pcF;
wire [31:0]pcplus4F;
wire [31:0]pc_nxtF;
wire [31:0]instrF;


mux4 pc_mux(
    .s({jalrE,pc_srcE}), //jump
    // .s({1'b0,pc_srcE}),
    .a0(pcplus4F),
    .a1(pcTargetE),
    .a2(ALU_resultE), //jump
    .a3(ALU_resultE), //jump
    .b(pc_nxtF)
);


pc pc_reg(
    .clk(clk),
    .reset(rst),
    .en(stallF),
    .pc_nxt(pc_nxtF),
    .pc(pcF)
);


adder pc_adder(
    .a(pcF),
    .b(32'd4),
    .s(pcplus4F)
);


instr_memo instr_rom(
    .a(pcF),
    .rd(instrF)
);


FD_pipe FD_pipe(
    .clk(clk),
    .en(stallD),
    .reset(flushD | rst),
    .instrF(instrF),
    .pcF(pcF),
    .pcplus4F(pcplus4F),
    .instrD(instrD),
    .pcD(pcD),
    .pcplus4D(pcplus4D)
);

//-----------------------------------------

wire [31:0]pcD;
wire [31:0]pcplus4D;
wire [31:0]rd1D,rd2D;


wire jalrD; // jump
wire reg_writeD;
wire alu_srcD;
wire mem_writeD;
wire branchD;
wire jumpD;
wire [1:0]imm_srcD;
wire [1:0]result_srcD;
wire [2:0]alu_cntrlD;
wire [31:0]instrD;
wire [31:0]imm_extD;

control_path control(
    .instr(instrD),
    .mem_write(mem_writeD),
    .alu_src(alu_srcD),
    .reg_write(reg_writeD),
    .jalr(jalrD), //jump
    .branch(branchD),
    .jump(jumpD),
    .result_src(result_srcD),
    .imm_src(imm_srcD),
    .alu_cntrl(alu_cntrlD) 
);


regi_file registers(
    .clk(clk),
    .a1(instrD[19:15]),
    .rd1(rd1D),
    .wd3(resultW),
    .a2(instrD[24:20]),
    .a3(rdW),
    .rd2(rd2D),
    .we3(reg_writeW)
);


extend sign_extend(
    .imm(instrD[31:7]),
    .extimm(imm_extD), 
    .immcntrl(imm_srcD)
);


DE_pipe DE_pipe(
    .clk(clk),
    .reset(flushE | rst),
    .rd1D(rd1D),
    .rd2D(rd2D),
    .pcD(pcD),
    .rdD(instrD[11:7]),
    .imm_extD(imm_extD),
    .pcplus4D(pcplus4D),
    .rd1E(rd1E),
    .rd2E(rd2E),
    .pcE(pcE),
    .rdE(rdE),
    .imm_extE(imm_extE),
    .pcplus4E(pcplus4E),

    .jalrD(jalrD),
    .mem_writeD(mem_writeD),
    .alu_srcD(alu_srcD),
    .reg_writeD(reg_writeD),
    .branchD(branchD),
    .jumpD(jumpD),
    .result_srcD(result_srcD),
    .alu_cntrlD(alu_cntrlD),
    .jalrE(jalrE),
    .mem_writeE(mem_writeE),
    .alu_srcE(alu_srcE),
    .reg_writeE(reg_writeE),
    .branchE(branchE),
    .jumpE(jumpE),
    .result_srcE(result_srcE),
    .alu_cntrlE(alu_cntrlE),

    .rs1D(instrD[19:15]),
    .rs2D(instrD[24:20]),
    .rs1E(rs1E),
    .rs2E(rs2E)
);


//--------------------------------------


wire [31:0]rd1E;
wire [31:0]rd2E;
wire [31:0]pcE;
wire [4:0]rdE;
wire [31:0]imm_extE;
wire [31:0]pcplus4E;
wire [31:0]pcTargetE;
wire [31:0]ALUmux_outE;
wire [31:0]ALU_resultE;

wire jalrE;
wire mem_writeE;
wire alu_srcE;
wire reg_writeE;
wire branchE;
wire jumpE;
wire [1:0]result_srcE;
wire [2:0]alu_cntrlE;
wire zeroE;
wire pc_srcE;

wire [4:0]rs1E;
wire [4:0]rs2E;

wire [31:0]srcAE;
wire [31:0]srcBE;
wire [31:0]ALU_mux0;

mux4 srcA_mux(
    .s(forwardAE),
    .a0(rd1E),
    .a1(resultW),
    .a2(ALU_resultM),
    .b(srcAE)
);


mux4 srcB_mux(
    .s(forwardBE),
    .a0(rd2E),
    .a1(resultW),
    .a2(ALU_resultM),
    .b(ALU_mux0)
);


assign pc_srcE = jumpE | (branchE & zeroE);

mux2 ALU_mux(
    .s(alu_srcE),
    .a0(ALU_mux0),
    .a1(imm_extE),
    .b(ALUmux_outE)
);


alu logi_unit(
    .cntrl(alu_cntrlE),
    .a(srcAE),
    .b(ALUmux_outE),
    .result(ALU_resultE),
    .zero(zeroE)
);


adder target_adder(
    .a(pcE),
    .b(imm_extE),
    .s(pcTargetE)
);


EM_pipe EM_pipe(
    .clk(clk),
    .ALU_resultE(ALU_resultE),
    .w_dataE(ALU_mux0),
    .rdE(rdE),
    .pcplus4E(pcplus4E),
    .ALU_resultM(ALU_resultM),
    .w_dataM(w_dataM),
    .rdM(rdM),
    .pcplus4M(pcplus4M),

    .reg_writeE(reg_writeE),
    .mem_writeE(mem_writeE),
    .result_srcE(result_srcE),
    .reg_writeM(reg_writeM),
    .mem_writeM(mem_writeM),
    .result_srcM(result_srcM)
);


//------------------------------


wire [31:0]ALU_resultM;
wire [31:0]w_dataM;
wire [4:0]rdM;
wire [31:0]pcplus4M;
wire [31:0]read_dataM;

wire reg_writeM;
wire mem_writeM;
wire [1:0]result_srcM;

data_mem data_ram(
    .clk(clk),
    .a(ALU_resultM),
    .rd(read_dataM),
    .wd(w_dataM),
    .we(mem_writeM)
);


MW_pipe MW_pipe(
    .clk(clk),
    .ALU_resultM(ALU_resultM),
    .read_dataM(read_dataM),
    .rdM(rdM),
    .pcplus4M(pcplus4M),
    .ALU_resultW(ALU_resultW),
    .read_dataW(read_dataW),
    .rdW(rdW),
    .pcplus4W(pcplus4W),

    .reg_writeM(reg_writeM),
    .result_srcM(result_srcM),
    .reg_writeW(reg_writeW),
    .result_srcW(result_srcW)
);

//------------------------------------


wire [31:0]ALU_resultW;
wire [31:0]read_dataW;
wire [4:0]rdW;
wire [31:0]pcplus4W;
wire [31:0]resultW;

wire reg_writeW;
wire [1:0]result_srcW;


mux4 result_mux(
    .s(result_srcW),
    .a0(ALU_resultW),
    .a1(read_dataW),
    .a2(pcplus4W),
    .a3(pcplus4W),
    .b(resultW)
);

//---------------------------------------

wire stallD,stallF,flushE,flushD;
wire [1:0]forwardAE,forwardBE;


hazard hazard(
    .rs1E(rs1E),
    .rs2E(rs2E),
    .rdM(rdM),
    .rdW(rdW),
    .reg_writeM(reg_writeM),
    .reg_writeW(reg_writeW),
    .result_srcE(result_srcE),
    .rdE(rdE),
    .rs1D(instrD[19:15]),
    .rs2D(instrD[24:20]),
    .pc_srcE(pc_srcE),
    .stallF(stallF),
    .stallD(stallD),
    .flushE(flushE),
    .flushD(flushD),
    .forwardAE(forwardAE),
    .forwardBE(forwardBE)
);

endmodule