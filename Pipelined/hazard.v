module hazard(
    input [4:0]rs1E,
    input [4:0]rs2E,
    input [4:0]rdM,
    input [4:0]rdW,
    input reg_writeM,
    input reg_writeW,
    input [1:0]result_srcE,
    input [4:0]rdE,
    input [4:0]rs1D,rs2D,
    input pc_srcE,
    output reg stallF,
    output reg stallD,
    output reg flushE,
    output reg flushD,
    output reg [1:0]forwardAE,
    output reg [1:0]forwardBE
);

wire lw_stall;

assign lw_stall = result_srcE[0] & ((rdE == rs1D) | (rdE == rs2D));

always @(*)
begin
    // defaults------------
    stallD = 0;
    stallF = 0;
    flushE = 0;
    flushD = 0;


    if(((rs1E == rdM) && reg_writeM) & (rs1E != 0))
        forwardAE = 2'b10;
    else if(((rs1E == rdW) && reg_writeW) & (rs1E != 0))
        forwardAE = 2'b01;
    else 
        forwardAE = 2'b00;

    if(((rs2E == rdM) && reg_writeM) & (rs2E != 0))
        forwardBE = 2'b10;
    else if(((rs2E == rdW) && reg_writeW) & (rs2E != 0))
        forwardBE = 2'b01;
    else 
        forwardBE = 2'b00;

    stallD = lw_stall;
    stallF = lw_stall;
    flushE = lw_stall | pc_srcE;
    flushD = pc_srcE;
end

endmodule