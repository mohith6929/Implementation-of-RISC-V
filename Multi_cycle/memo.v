module memo (clk,a,wd,we,rd);
input clk,we;
input [31:0]a,wd;
output [31:0]rd;

reg [31:0]file[0:1023];

initial begin
        $readmemh("program.hex", file);
end

assign rd = file[a[31:2]];

always@(posedge clk)
begin
    if(we)
    begin
        file[a[31:2]] <= wd;
    end
end
    
endmodule