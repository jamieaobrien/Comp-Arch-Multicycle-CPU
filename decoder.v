// Instruction decoder
// Liv, Jamie, Sabrina

module decoder(

output  [4:0]   rs, rt, rd,
output  [15:0]  immediate,
output  [25:0]  address,
output  [5:0]   opcode,
output  [5:0]   funct,
input   [31:0]  instruction
);

assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign funct = instruction[5:0];
assign opcode = instruction[31:26];     
assign immediate = instruction[15:0];
assign address = instruction[25:0];

endmodule
