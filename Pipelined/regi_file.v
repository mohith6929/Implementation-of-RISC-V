module regi_file(
    input wire clk,we3,
    input wire [4:0]a1,a2,a3,
    input wire [31:0]wd3,
    output wire [31:0]rd1,rd2
);


reg [31:0]file[31:0];

assign rd1 = (a1 == 5'd0)? 32'd0 : file[a1];
assign rd2 = (a2 == 5'd0)? 32'd0 : file[a2];

always @(posedge clk)
begin
    if(we3 && a3 != 5'd0)
    begin
        file[a3] <= wd3;
    end
end

endmodule