module tb;
reg clk;
reg reset;

RISCV uut(
    .clk(clk),
    .rst(reset)
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
    $dumpvars(0,tb);
end

endmodule