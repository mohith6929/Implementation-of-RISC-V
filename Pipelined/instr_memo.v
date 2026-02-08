module instr_memo(
   input wire [31:0]a;
   output wire [31:0]rd;
);


reg [31:0]mem[255:0];

initial
begin
   $readmemh("program.hex",mem);
end

assign rd = mem[a>>2];

endmodule