module data_mem(
    input wire clk,we;
    input wire [31:0]a,wd;
    output wire [31:0]rd;
);


reg [7:0]mem[1023:0];

assign rd = {mem[a+3],mem[a+2],mem[a+1],mem[a]};

always @(posedge clk)
begin
    if(we)
    begin
        {mem[a+3],mem[a+2],mem[a+1],mem[a]} <= wd;
    end
end

endmodule