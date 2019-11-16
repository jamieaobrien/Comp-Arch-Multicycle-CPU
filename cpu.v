// Jamie, Liv, Sabrina

/*----------------------------------------------------------------------------
 CPU file
----------------------------------------------------------------------------*/

// `include "mux.v"
`include "regfile.v"
`include "ALU/alu.v"
`include "memory.v"
`include "controlLogic.v"
`include "decoder.v"
`include "PCchoose.v"
`include "PCaddrGen.v"

module cpu
(
    // Read port for instructions
    // input  [31:0]  PC,		// Program counter (instruction address)

    input  clk,
    input  reset

);

//------------------------------------------------------------------------------
// Initialzining intermediary wires
//------------------------------------------------------------------------------
// PC wires
wire  [31:0]  currentPC;

// Wire for instruction memory output
wire  [31:0]  instruction;

// Wires for decoder output
wire  [4:0]  rs, rt, rd;
wire  [15:0] immediate;
wire  [25:0]  address;
wire  [5:0]  opcode;
wire  [5:0] funct;

// Wires for control logic signals
wire  [2:0]  ALUcontrol;
wire  ALUsource;
wire  [1:0]  MemToReg, RegDst; // Not fully sure what size these need to be?
wire  MemWr, RegWr; // Write enables
wire  jump, bne, beq; // Flags for choosing new NewPC

// Wires for regfile outputs
wire  [31:0]  R_rt, R_rs;

// Wires for intermediary calculations/inputs
wire  [31:0] addend, res, memData;
reg   [31:0] WriteData;
reg   [4:0]  WriteRegister;
wire carryout,zero, overflow; // For ALU

// Wires for possible new PC values
wire  [31:0] PC4, branchAddress, jumpAddress;

//------------------------------------------------------------------------------
// Instantiate modules
//------------------------------------------------------------------------------

PCchoose PCchoose(.clk(clk),.PC4(PC4),.bne(bne),.beq(beq),.branchAddr(branchAddress),.jumpAddr(jumpAddress),.zero(zero),.jump(jump),.reset(reset),.PC(currentPC));
memory memory(.PC(currentPC),.instruction(instruction),.data_out(memData),.data_in(R_rt),.data_addr(res),.clk(!clk),.wr_en(MemWr));

decoder decoder(.rs(rs),.rt(rt),.rd(rd),.immediate(immediate),.address(address),.opcode(opcode),.funct(funct),.instruction(instruction));

controlLogic controlLogic(.RegDst(RegDst),.RegWr(RegWr),.ALUSrc(ALUsource),.ALUcntrl(ALUcontrol),.MemWr(MemWr),.MemToReg(MemToReg),.jump(jump),.bne(bne),.beq(beq),.funct(funct),.opcode(opcode),.clk(clk));

regfile regfile(.ReadData1(R_rs),.ReadData2(R_rt),.WriteData(WriteData),.ReadRegister1(rs),.ReadRegister2(rt),.WriteRegister(WriteRegister),.RegWrite(RegWr),.Clk(!clk));

PCaddrGen PCaddrGen(.PC4(PC4),.branchAddress(branchAddress),.jumpAddress(jumpAddress),.address(address),.immediate(immediate),.opcode(opcode),.R_rs(R_rs),.PC(currentPC),.clk(clk));


// Mux to choose between immediate and register data operands for ALU
mux2to1 #(32) addendMUX (.out(addend), .address(ALUsource),.input0(R_rt), .input1({16'b0, immediate}));

// Setting up ALU
ALU alu(.result(res),.carryout(carryout),.zero(zero),.overflow(overflow),.operandA(R_rs),.operandB(addend),.command(ALUcontrol));

// Behavioral Mux to choose which register to write to
always @* begin
case (RegDst)
  0:  begin  WriteRegister <= rd;  end
  1:  begin  WriteRegister <= 5'd31;  end
  2:  begin  WriteRegister <= rt;  end
endcase
end

// Behavioral Mux to choose which register to write to
always @* begin
case (MemToReg)
  0:  begin  WriteData <= res;  end
  1:  begin  WriteData <= memData;  end
  2:  begin  WriteData <= PC4;  end
endcase
end


endmodule
