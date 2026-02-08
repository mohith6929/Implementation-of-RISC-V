module FD_pipe(
    input clk,
    input [31:0]instrF,
    input [31:0]pcF,
    input [31:0]pcplus4F,
    output reg [31:0]instrD,
    output reg [31:0]pcD,
    output reg [31:0]pcplus4D,
);

always @(posedge clk)
begin
    instrD <= instrF;
    pcD <= pcF;
    pcplus4D <= pcplus4F;
end

endmodule