`include "register.v"

// Define instructions - based on controlLogic.t.v from lab 3

`define LW
`define SW
`define J
`define JR
`define JAL
`define BEQ
`define BNE
`define XORI
`define ADDI
`define ADD
`define SUB
`define SLT

// Define states (Based on FSM diagram/slides)

`define IF
`define ID
`define EX
`define WB
`define MEM
`define WB

// FSM module

module fsm
(

output reg[11:0] newState,
//input reg[11:0] instruct,  // ADD, SUB, SLT, XORI, ADDI,
input reg[0] cycle          // JR, JAL, J, BNE, BEQ, LW, SW
  );

always @ posedge begin

reg[2:0] math
reg[1:0] math_imm
reg[0] jumpreg
reg[1:0] jump
reg[1:0] branch
reg[1:0] store

math <= [instruct[0], instruct[1], instruct[2]] // ADD, SUB, SLT
math_imm <= [instruct[3], instruct[4]]           // XORI, ADDI
jumpreg <= [instruct[5]]                         // JR
jump <= [instruct[6], instruct[7]]               // JAL, J
branch <= [instruct[8], instruct[9]]             // BNE, BEQ
store <= [instruct[10], instruct[11]]            // LW, SW


// IF = 1, ID = 2, EX = 3, MEM = 4, WB = 5

this_cycle = IF;


if (cycle == 1)
    begin
     math <= [ID, ID, ID]
     math_imm <= [ID, ID]
     jumpreg <= [ID]
     jump <= [ID, ID]
     branch <= [ID, ID]
     store <= [ID, ID] // have to figure out how to do this
    end                                            // requires putting values from another register into this one

else if (cycle == 2)
    begin
    math <= [EX, EX, EX]
    math_imm <= [EX, EX]
    jumpreg <= [IF]
    jump <= [IF, WB]
    branch <= [EX, EX]
    store <= [EX, EX]
    end

else if (cycle == 3)
    math <= [WB, WB, WB]
    math_imm <= [WB, WB]
    branch <= [IF, IF]
    store <= [WB, MEM]
    end

else if (cycle == 4)
    store <= [IF, IF]
endcase

case (5)
    math <= [IF, IF, IF]
    math_imm <= [IF, IF]
    jump <= [IF, IF]
    store <= [IF, IF]
endcase
