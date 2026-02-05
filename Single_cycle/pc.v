module pc(clk, reset,pc_nxt,pc);
input wire clk,reset;
input wire [31:0]pc_nxt;
output reg [31:0]pc;

always @(posedge clk)
begin
    if(reset)
        pc <= 32'b0;
    else
        pc <= pc_nxt;
end

endmodule