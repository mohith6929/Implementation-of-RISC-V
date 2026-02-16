module pc(
    input wire clk,reset,en,
    input wire [31:0]pc_nxt,
    output reg [31:0]pc
);


always @(posedge clk)
begin
    if(reset)
    begin
        pc <= 32'b0;
    end

    else if (en == 0)
    begin
        if(reset)
            pc <= 32'b0;
        else
            pc <= pc_nxt;
    end
end

endmodule