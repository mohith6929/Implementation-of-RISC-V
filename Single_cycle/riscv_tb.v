module riscv_tb;
reg clk,reset;

riscv uut(.clk(clk),.rst(reset));

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #20 reset = 0;
    #100 $finish;
end

initial begin
    $dumpfile("waves.vcd");
    $dumpvars(0,riscv_tb);
end
endmodule