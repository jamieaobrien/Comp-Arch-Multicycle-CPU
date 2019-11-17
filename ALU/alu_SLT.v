// Liv Kelley, Sabrina Pereira, and Jamie O'Brien
// SLT module

// Define LUT commands
`define ADD      3'd0
`define SUB      3'd1
`define XOR_SEL  3'd2
`define SLT      3'd3
`define AND_SEL  3'd4
`define NAND     3'd5
`define NOR      3'd6
`define OR_SEL   3'd7


// define gates with delays
`define AND and 
`define OR or 
`define NOT not
`define XOR xor 


/*
SLT32bit module

This module initiates a subtraction module to calculate a-b, and if the result
is negative, the result will be one. This is calculated by making the result
the most significant bit of the difference if there is no overflow, or making the
result the inverse of the most significant bit of the difference if there is
overflow. This can be done simply by sending the most significant bit of the
difference and the overflow flag through an XOR gate to get the result. This is
a 1 bit result, so this will be contcatenated with 31 zero bits, making the
1 bit result the least significant bit of the 32 bit result.
*/
module SLT32bit
(
    output[31:0] slt_result,      // (a<b)?1:0
    input[31:0] a,                // First operand in 2's complement format
    input[31:0] b,                // Second operand in 2's complement format
    input[2:0] command
);
    wire carryout, overflow, slt, zero;  // Define wires resulting from subtractor module
    wire[31:0] difference;               // Define output of subtractor module
    // Instantiate subtractor module
    FullSubtractor32bit subtractor1(difference, carryout, overflow, zero, a, b, command);
    // Use XOR gate to find result
    `XOR sltxor(slt,overflow,difference[31]);
    // Concatenate the result with 31 zero bits to maintain a 32 bit output
    assign slt_result[31:0] = {31'b0,slt};
endmodule
