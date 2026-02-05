module instr_memo(a,rd);
input wire [31:0]a;
output wire [31:0]rd;

reg [31:0]mem[255:0];

// initial begin
//     mem[0] = 32'h00500093; // addi x1, x0, 5
//     mem[1] = 32'h00A00113; // addi x2, x0, 10
//     mem[2] = 32'h002081B3; // add x3, x1, x2
// end


initial
begin
   $readmemh("program.hex",mem);
end

assign rd = mem[a>>2];

endmodule