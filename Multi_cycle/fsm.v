module fsm(clk, reset, op, branch, pc_update, reg_write, mem_write, ir_write, result_src, alu_srca, alu_srcb, adr_src, alu_op);
input clk,reset;
input [6:0]op;
output reg pc_update, reg_write, mem_write, ir_write, adr_src, branch;
output reg [1:0]result_src,alu_srca,alu_srcb,alu_op;

parameter fetch = 4'd0;
parameter decode = 4'd1;
parameter mem_adr = 4'd2;
parameter mem_read = 4'd3;
parameter mem_wb = 4'd4;
parameter mem_write_s = 4'd5;
parameter execute_R = 4'd6;
parameter alu_wb = 4'd7;
parameter execute_I = 4'd8;
parameter jal = 4'd9;
parameter beq = 4'd10;
parameter execute_jalr = 4'd11;
parameter jalr_wb = 4'd12;

reg [3:0]state,nxt_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= fetch;
    else
        state <= nxt_state;
end

always @(*) begin
    // -------- defaults --------
    pc_update  = 0;
    reg_write  = 0;
    mem_write  = 0;
    ir_write   = 0;
    adr_src    = 0;
    branch     = 0;

    alu_srca   = 2'b00;
    alu_srcb   = 2'b00;
    alu_op     = 2'b00;
    result_src = 2'b00;

    nxt_state  = state;

    case (state)
        fetch: begin
            ir_write  = 1;
            pc_update = 1;
            adr_src   = 0;

            alu_srca  = 2'b00;   // PC
            alu_srcb  = 2'b10;   // +4
            alu_op    = 2'b00;   // ADD

            result_src = 2'b10;  // PC+4 (for JAL later)

            nxt_state = decode;
        end


        decode: begin
            // ALU computes branch target = old_pc + imm
            alu_srca = 2'b01;    // old_pc
            alu_srcb = 2'b01;    // imm
            alu_op   = 2'b00;    // ADD

            case (op)
                7'b0000011,      // LW
                7'b0100011:      // SW
                    nxt_state = mem_adr;

                7'b0110011:      // R-type
                    nxt_state = execute_R;

                7'b0010011:      // I-type ALU
                   nxt_state = execute_I;

               7'b1101111:      // JAL
                    nxt_state = jal;

               7'b1100011:      // BEQ
                    nxt_state = beq;

                7'b1100111: nxt_state = execute_jalr; //jalr

                default:
                    nxt_state = fetch;
            endcase
        end


        mem_adr: begin      
           alu_srca = 2'b10;    // A (rs1)
           alu_srcb = 2'b01;    // imm
            alu_op   = 2'b00;    // ADD

           if (op == 7'b0000011)
                nxt_state = mem_read;
           else
                nxt_state = mem_write_s;
        end


        mem_read: begin
            adr_src  = 1;
            nxt_state = mem_wb;
        end


        mem_wb: begin
            reg_write  = 1;
            result_src = 2'b01;  // MDR
            nxt_state  = fetch;
        end


        mem_write_s: begin
            adr_src   = 1;
           mem_write = 1;
            nxt_state = fetch;
        end


        execute_R: begin
            alu_srca = 2'b10;    // A
            alu_srcb = 2'b00;    // B
            alu_op   = 2'b10;    // funct

           nxt_state = alu_wb;
        end


        alu_wb: begin
           reg_write  = 1;
           result_src = 2'b00;  // ALUOut
           nxt_state  = fetch;
        end


        execute_I: begin
            alu_srca = 2'b10;    // A
            alu_srcb = 2'b01;    // imm
            alu_op   = 2'b10;    // funct

           nxt_state = alu_wb;
        end


        jal: begin
            pc_update  = 1;
            reg_write  = 1;

            alu_srca = 2'b01;    // old_pc
           alu_srcb = 2'b10;   
           alu_op   = 2'b00;    // ADD

           result_src = 2'b00;  // PC+4
           nxt_state  = alu_wb;
        end


        beq: begin
            alu_srca = 2'b10;    // A
            alu_srcb = 2'b00;    // B
            alu_op   = 2'b01;    // SUB

            branch = 1'b1;

           nxt_state = fetch;
        end

        execute_jalr: begin
            alu_srca = 2'b10; // Rs1
            alu_srcb = 2'b01; // Imm
            alu_op   = 2'b00; // ADD
            nxt_state = jalr_wb;
        end

        jalr_wb: begin
            // 1. Update PC with Target (calculated in previous state)
            pc_update = 1;
            result_src = 2'b00; // Select ALUOut
            
            // 2. Calculate Link (PC+4) for writeback
            alu_srca = 2'b01; // OldPC
            alu_srcb = 2'b10; // 4
            alu_op   = 2'b00; // ADD
            
            nxt_state = alu_wb; // Go to writeback to save PC+4 to Rd
        end


        default: begin
            nxt_state = fetch;
        end

    endcase


end


endmodule