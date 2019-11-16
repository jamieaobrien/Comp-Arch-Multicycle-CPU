// Liv, Jamie and Sabrina

`define ADD      3'd0
`define SUB      3'd1
`define XOR_SEL  3'd2
`define SLT      3'd3
`define AND_SEL  3'd4
`define NAND_SEL 3'd5
`define NOR_SEL  3'd6
`define OR_SEL   3'd7


// define gates with delays
`define AND and
`define OR or
`define NOT not
`define XOR xor

// Include files
`include "ALU/alu_SUB.v"
`include "ALU/alu_SLT.v"
`include "ALU/alu_XOR.v"
`include "ALU/alu_AND.v"
`include "ALU/alu_NAND.v"
`include "ALU/alu_NOR.v"
`include "ALU/alu_OR.v"
`include "ALU/multiplexer.v"

/*
ALU

This ALU module instantiates each of the function modulesas well as the
ALUcontrolLUT and the multiplexer. It then puts the control signal setFlags
through AND gates with each of the three flags - overflow, carryout, and zero -
from the subtraction module to get the flags for the entire ALU. This ensures
that all flags will be zero if addition/subtraction is not being performed.
*/
module ALU
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
);
  wire[31:0] difference,XORresult,ANDresult,NANDresult,NORresult,ORresult;
  wire diff_carryout;
  wire diff_overflow;
  wire diff_zero;
  wire[31:0] slt_result;
  wire setFlags;
  wire ifslt;
  wire[2:0] ALUindex;
  FullSubtractor32bit subtractor0 (difference, diff_carryout, diff_overflow, diff_zero, operandA, operandB, command); // Instantiate subtractor
  SLT32bit slt0 (slt_result, operandA, operandB, command);  // Instantiate SLT32bit
  XOR32 xor0(XORresult,operandA,operandB);                  // Instantiate XOR32
  AND32 and0(ANDresult,operandA,operandB);                  // Instantiate AND32
  NAND32 nand0(NANDresult,operandA,operandB);               // Instantiate NAND32
  NOR32 nor0(NORresult,operandA,operandB);                  // Instantiate NOR32
  OR32 or0(ORresult,operandA,operandB);                     // Instantiate OR32
  ALUcontrolLUT LUT0 (ALUindex,setFlags,ifslt,command);     // Instantiate ALUcontrolLUT
  structuralMultiplexer ALUmux(result, ALUindex, difference, slt_result, XORresult,ANDresult,NANDresult,NORresult,ORresult,ifslt); // Instantiate multiplexer
  `AND ALUoverflow(overflow,diff_overflow,setFlags);
  `AND ALUcarryout(carryout,diff_carryout,setFlags);
  `AND ALUzero(zero,diff_zero,setFlags);


endmodule

/*
ALUcontrolLUT

This LUT maps 8 functions to 7 indices, as addition and subtraction can be
completed by the same module. It also sets setFlags to true for addition and
subtraction, and sets ifslt true for SLT.
*/
 module ALUcontrolLUT
 (
 output reg[2:0]  ALUindex,
 output reg       setFlags,
 output reg       ifslt,
 input[2:0]       ALUcommand
 );
   always @(ALUcommand) begin
     case (ALUcommand)
       `ADD:      begin ALUindex = 3'b000; setFlags=1; ifslt=0; end
       `SUB:      begin ALUindex = 3'b000; setFlags=1; ifslt=0; end
       `XOR_SEL:  begin ALUindex = 3'b010; setFlags=0; ifslt=0; end
       `SLT:      begin ALUindex = 3'b001; setFlags=0; ifslt=1; end
       `AND_SEL:  begin ALUindex = 3'b011; setFlags=0; ifslt=0; end
       `NAND_SEL: begin ALUindex = 3'b100; setFlags=0; ifslt=0; end
       `NOR_SEL:  begin ALUindex = 3'b101; setFlags=0; ifslt=0; end
       `OR_SEL:   begin ALUindex = 3'b110; setFlags=0; ifslt=0; end
     endcase
   end
 endmodule
