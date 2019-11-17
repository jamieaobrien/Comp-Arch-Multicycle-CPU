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

module FullAdder1bit  // instantiate 1 bit full adder module
(
    output sum,       // output sum
    output carryout,  // output carryout
    input carryin,    // input carryin
    input a,          // input a
    input b,           // input b
    input[2:0] command
);
    wire AxorB;         // XOR gate - exclusive OR (a OR b)
    wire AandB;         // AND gate - ab
    wire CinAndAxorB;   // AND gate - Cin(a OR b)
    wire bXorcommand;
    `XOR xorgate0(bXorcommand,command[0],b);
    `XOR xorgate1(AxorB,a,bXorcommand);                    // XOR gate - exclusive OR (a OR b)
    `AND andgate0(AandB,a,bXorcommand);                    // AND gate - ab
    `XOR xorgate2(sum,carryin,AxorB);            // XOR gate - exclusive OR (Cin OR (a OR b))
    `AND andgate1(CinAndAxorB,carryin,AxorB);    // AND gate - Cin(a OR b)
    `OR orgate0(carryout,AandB,CinAndAxorB);     // OR  gate - carryout = (ab OR Cin(a OR b))
endmodule


module FullAdder32bit
(
    output[31:0] sum,  // 2's complement sum of a and b
    output carryout,  // Carry out of the summation of a and b
    output overflow,  // True if the calculation resulted in an overflow
    input[31:0] a,     // First operand in 2's complement format
    input[31:0] b,    // Second operand in 2's complement format
    input[2:0] command
    // something to indicate subtraction
);
    wire[31:0] CintoCout; // Connects Cout to Cin in between 1 bit modules
    //indicate subtraction!!!! buf buf0(CintoCout[0],sub?)
    FullAdder1bit adder0 (sum[0],CintoCout[0],command[0],a[0],b[0],command);
    generate
    genvar index;
      for (index = 1;
      index<32;
      index = index + 1)
      begin
        // 1 bit adders
        FullAdder1bit adderindex (sum[index],CintoCout[index],CintoCout[index-1],a[index],b[index],command);  // 1 bit adder 0
      end
    endgenerate
    buf buf1(carryout,CintoCout[31]);  // connect last CintoCout to carryout of 4 bit adder carryout
    //Looking for overflow
    wire na31;           // na wire from adder 31
    wire nb31;           // nb wire from adder 31
    wire nsum31;         // nsum from adder 31
    wire ifoverflow0;    // result of andgate 0 - na31 AND nb31 AND sum[31]
    wire ifoverflow1;    // result of andgate 1 - a[31] AND b[31] AND nsum31
    `NOT a31inv(na31,a[31]);                            // inverse of a[31]
    `NOT b31inv(nb31,b[31]);                            // inverse of b[31]
    `NOT sum31inv(nsum31,sum[31]);                      // inverse of sum[31]
    `AND andgate0(ifoverflow0,na31,nb31,sum[31]);       // AND gate - na31 AND nb31 AND sum[31]
    `AND andgate1(ifoverflow1,a[31],b[31],nsum31);      // AND gate - a[31] AND b[31] AND nsum3
    `OR  orgate0(overflow,ifoverflow0,ifoverflow1);  // OR  gate - ifoverflow0 OR ifoverflow1 - 1 if overflow
endmodule
