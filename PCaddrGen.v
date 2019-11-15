// Sabrina Pereira, Jamie O'Brien, Liv Kelley
// Single Cycle CPU Address Generator

`define Rtype   6'h0

/*-----------------------------------------------------------------------------
This module generates the possible PC values based on the instruction. It
creates PC4, which is PC+4. This will be the next PC value if the instruction
is not a jump or branch. It also creates branchAddress based on MIPS standard
branchAddr = {14{immediate[15]},immediate,2'b0} . This will be the next PC value
if the instruction is a branch. jumpAddress is the MIPS standard
jumpAddress = {PC+4[31:28],address,2'b0} . This will be the next PC value if the
instruction is a jump. These all go to PCchoose, which will determine which PC
address to use based on control signals from the control logic.
-----------------------------------------------------------------------------*/

module PCaddrGen
(
output reg[31:0]   PC4,
output reg[31:0]   branchAddress,
output reg[31:0]   jumpAddress,
input  [25:0]      address,
input  [15:0]      immediate,
input  [5:0]       opcode,
input  [31:0]      R_rs,
input  [31:0]      PC,
input              clk
);
reg [13:0] extend;

//always @(posedge clk) begin
always @* begin
  extend[13:0] = immediate[15];
  PC4 = PC + 32'd4;
  branchAddress = {extend,immediate,2'b0}+PC4;
  if (opcode == `Rtype) begin
    jumpAddress = R_rs;
  end else begin
    jumpAddress = {PC4[31:28],address,2'b0};
  end
end
endmodule
