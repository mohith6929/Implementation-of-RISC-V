module pc (pc,clk,reset,en,pc_nxt);
input clk,reset,en;
input [31:0]pc_nxt;
output reg [31:0]pc;

always @(posedge clk) begin
    if(reset)
    begin
        pc <= 32'd0;
    end
    else begin
        if(en)
        begin
            pc <= pc_nxt;
        end
    end
end
    
endmodule