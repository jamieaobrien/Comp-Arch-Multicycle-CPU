// Liv Kelley, Jamie O'Brien, Sabrina Pereira
// Single Cycle CPU Register File
//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------
`include "register.v"
`include "mux.v"
module decoder1to32
(
output[31:0]	out,
input		enable,
input[4:0]	address
);

    assign out = enable<<address;

endmodule

module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);

  wire[31:0] DecoderToReg;
  wire[31:0] RegToMUX[31:0];

  decoder1to32 regdecoder(DecoderToReg,RegWrite,WriteRegister);

  register32zero regZero(RegToMUX[0],WriteData,DecoderToReg[0],Clk);

  generate
  genvar index;
    for (index = 1;
    index<32;
    index = index + 1)
    begin
      // Registers
      register #(.width(32)) regIndex(.q(RegToMUX[index]),.d(WriteData),.wrenable(DecoderToReg[index]),.clk(Clk));
    end
  endgenerate

  mux32to1by32 MUX1(ReadData1,ReadRegister1,RegToMUX[0],RegToMUX[1],RegToMUX[2],RegToMUX[3],RegToMUX[4],RegToMUX[5],RegToMUX[6],RegToMUX[7],RegToMUX[8],RegToMUX[9],RegToMUX[10],RegToMUX[11],RegToMUX[12],RegToMUX[13],RegToMUX[14],RegToMUX[15],RegToMUX[16],RegToMUX[17],RegToMUX[18],RegToMUX[19],RegToMUX[20],RegToMUX[21],RegToMUX[22],RegToMUX[23],RegToMUX[24],RegToMUX[25],RegToMUX[26],RegToMUX[27],RegToMUX[28],RegToMUX[29],RegToMUX[30],RegToMUX[31]);
  mux32to1by32 MUX2(ReadData2,ReadRegister2,RegToMUX[0],RegToMUX[1],RegToMUX[2],RegToMUX[3],RegToMUX[4],RegToMUX[5],RegToMUX[6],RegToMUX[7],RegToMUX[8],RegToMUX[9],RegToMUX[10],RegToMUX[11],RegToMUX[12],RegToMUX[13],RegToMUX[14],RegToMUX[15],RegToMUX[16],RegToMUX[17],RegToMUX[18],RegToMUX[19],RegToMUX[20],RegToMUX[21],RegToMUX[22],RegToMUX[23],RegToMUX[24],RegToMUX[25],RegToMUX[26],RegToMUX[27],RegToMUX[28],RegToMUX[29],RegToMUX[30],RegToMUX[31]);

endmodule
