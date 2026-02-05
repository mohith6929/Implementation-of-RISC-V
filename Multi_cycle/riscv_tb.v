module riscv_tb;
reg clk;
reg reset;

riscv uut(
    .clk(clk),
    .reset(reset)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #20 reset = 0;

    #500 $finish;
end

initial begin
    $dumpfile("waves.vcd");
    $dumpvars(0,riscv_tb);
end
endmodule