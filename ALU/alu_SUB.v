// Liv, Jamie and Sabrina

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
Subtractor 1 bit

The 1 bit subtractor functions as an adder would, but it has a subtraction line,
which in this case is command[0]. The subtraction line is 1 if the desired
function is subtraction, and zero if the desired function is addition, as the
ALUcommand for subtraction is 001 and for addition is 000. The subtraction line
is the carryin for the first bit "adder", and the sum is a + (bXORcommand[0]).
The XOR gate returns the inverse of b, and carryign in the subtraction line adds
1 to the inverse, which is how a negative number is calculated by 2's complement.

*/
module FullSubtractor1bit
(
    output difference,
    output carryout,
    input carryin,
    input a,
    input b,
    input[2:0] command
);
    wire AxorB;
    wire AandB;
    wire CinAndAxorB;
    wire bXorcommand;
    `XOR xorgate0(bXorcommand,command[0],b);
    `XOR xorgate1(AxorB,a,bXorcommand);
    `AND andgate0(AandB,a,bXorcommand);
    `XOR xorgate2(difference,carryin,AxorB);
    `AND andgate1(CinAndAxorB,carryin,AxorB);
    `OR orgate0(carryout,AandB,CinAndAxorB);
endmodule

/*
Subtractor 32 bit

This subtractor uses a generate to execute bitwise subtraction. The generate
initiates 31 1-bit adders, connecting them by making their carryouts the carryin
of the next adder. The 0th bit adder is initiated separately to make command[0]
its carryin. The carryout of the 32nd adder is the carryout of the entire 32
bit adder. The zero flag is calculated by getting the inverse of each bit of the
difference and putting them all into an AND gate, so that the zero flag will be
true if all bits of the difference are zero. The over flow is calculated by
(na31 AND nbXORcommand31 AND sum[31]) OR (a[31] AND bXORcommand[31] AND nsum3).
*/
module FullSubtractor32bit
(
    output[31:0] difference,  // 2's complement sum of a and b
    output carryout,  // Carry out of the summation of a and b
    output overflow,  // True if the calculation resulted in an overflow
    output zero,
    input[31:0] a,     // First operand in 2's complement format
    input[31:0] b,    // Second operand in 2's complement format
    input[2:0] command

);
    wire[31:0] CintoCout; // Connects Cout to Cin in between 1 bit modules
    wire[31:0] BxorCommand;
    wire[31:0] bitinverse;

    FullSubtractor1bit subtractor0 (difference[0],CintoCout[0],command[0],a[0],b[0],command[2:0]);
    `NOT b0inv(bitinverse[0],difference[0]);
    generate
    genvar index;
      for (index = 1;
      index<32;
      index = index + 1)
      begin
        // 1 bit adders
        FullSubtractor1bit subtractorindex (difference[index],CintoCout[index],CintoCout[index-1],a[index],b[index],command[2:0]);
        `NOT b0index(bitinverse[index],difference[index]);
      end
    endgenerate
    // Calculate zero flag - is true if every bit of the difference is 0
    and zeroand(zero,bitinverse[31],bitinverse[30],bitinverse[29],bitinverse[28],bitinverse[27],bitinverse[26],bitinverse[25],bitinverse[24],bitinverse[23],bitinverse[22],bitinverse[21],
    bitinverse[20],bitinverse[19],bitinverse[18],bitinverse[17],bitinverse[16],bitinverse[15],bitinverse[14],bitinverse[13],bitinverse[12],bitinverse[11],bitinverse[10],bitinverse[9],
    bitinverse[8],bitinverse[7],bitinverse[6],bitinverse[5],bitinverse[4],bitinverse[3],bitinverse[2],bitinverse[1],bitinverse[0]);
    // Connect the carryout
    buf buf1(carryout,CintoCout[31]);  // connect last CintoCout to carryout of 4 bit adder carryout
    //Looking for overflow
    wire na31;           // na wire from adder 31
    wire nb31;           // nb wire from adder 31
    wire nsum31;         // nsum from adder 31
    wire ifoverflow0;    // result of andgate 0 - na31 AND nb31 AND sum[31]
    wire ifoverflow1;    // result of andgate 1 - a[31] AND b[31] AND nsum31
    wire subline;
    `XOR subxor(subline,b[31],command[0]);
    `NOT a31inv(na31,a[31]);                                   // inverse of a[31]
    `NOT b31inv(nb31,subline);                                 // inverse of b[31]
    `NOT sum31inv(nsum31,difference[31]);                      // inverse of sum[31]
    and #40 andgate0(ifoverflow0,na31,nb31,difference[31]);    // AND gate - na31 AND nb31 AND sum[31]
    and #40 andgate1(ifoverflow1,a[31],subline,nsum31);        // AND gate - a[31] AND b[31] AND nsum31
    `OR  orgate0(overflow,ifoverflow0,ifoverflow1);            // OR  gate - ifoverflow0 OR ifoverflow1 - 1 if overflow
endmodule
