// Sabrina Pereira, Jamie O'Brien, Liv Kelley
// Singe Cycle CPU Logic Testbench
`include "controlLogic.v"
// Define states
`define LW      6'h23
`define SW      6'h2b
`define J       6'h2
`define JR      6'h08
`define JAL     6'h3
`define BEQ     6'h4
`define BNE     6'h5
`define XORI    6'he
`define ADDI    6'h8
`define Rtype   6'h0
`define ADD     6'h20
`define SUB     6'h22
`define SLT     6'h2a

module logicTest();
wire[1:0]    RegDst;
wire         RegWr;
wire         ALUSrc;
wire[2:0]    ALUcntrl;
wire         MemWr;
wire[1:0]    MemToReg;
wire         jump;
wire         bne;
wire         beq;
wire         reset;
reg[5:0]     funct;
reg[5:0]     opcode;
reg          clk;

controlLogic dut(.RegDst(RegDst),.RegWr(RegWr),.ALUSrc(ALUSrc),.ALUcntrl(ALUcntrl),.MemWr(MemWr),
                 .MemToReg(MemToReg),.jump(jump),.bne(bne),.beq(beq),.reset(reset),.funct(funct),
                 .opcode(opcode),.clk(clk));

initial begin
$display("Logic Test");
$display("opcode funct  |  RegDst  RegWr  ALUSrc  ALUcntrl   MemWr MemToReg Jump BNE BEQ  ");
clk=0; opcode=6'b0; funct=`SLT; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
clk=0; opcode=6'b0; funct=`ADD; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
clk=0; opcode=6'b0; funct=`SUB; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
clk=0; opcode=6'b0; funct=`JR; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
clk=0; opcode=`LW; funct=6'b0; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
clk=0; opcode=`SW; funct=6'b0; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
clk=0; opcode=`J; funct=6'b0; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
clk=0; opcode=`JAL; funct=6'b0; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
clk=0; opcode=`XORI; funct=6'b0; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
clk=0; opcode=`ADDI; funct=6'b0; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
clk=0; opcode=`BNE; funct=6'b0; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
clk=0; opcode=`BEQ; funct=6'b0; #5 clk=1; #10000
$display(" %h      %h   |    %b      %b      %b       %b        %b      %b      %b   %b   %b    ",
opcode,funct,RegDst,RegWr,ALUSrc,ALUcntrl,MemWr,MemToReg,jump,bne,beq);
end

endmodule
