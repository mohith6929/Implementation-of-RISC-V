module FD_pipe(
    input clk,en,reset,
    input [31:0]instrF,
    input [31:0]pcF,
    input [31:0]pcplus4F,
    output reg [31:0]instrD,
    output reg [31:0]pcD,
    output reg [31:0]pcplus4D
);

always @(posedge clk)
begin
    if(reset == 1)
    begin
        instrD <= 0;
        pcD <= 0;
        pcplus4D <= 0;
    end
    else if(en == 0)
    begin
        instrD <= instrF;
        pcD <= pcF;
        pcplus4D <= pcplus4F;
    end
end

endmodule