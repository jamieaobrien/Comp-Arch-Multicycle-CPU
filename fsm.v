// Liv Kelley, Jamie O'Brien, Sabrina Pereira
// Sequential Multiplier Control Logic

// Define opcodes/functs
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


/*
Control Logic
*/
module controlLogic
(
output reg[1:0]    RegDst,
output reg         RegWr,
output reg         ALUSrc,
output reg[2:0]    ALUcntrl,
output reg         MemWr,
output reg[1:0]    MemToReg,
output reg         jump,
output reg         bne,
output reg         beq,
input  [5:0]       funct,
input  [5:0]       opcode,
input              clk
);



// This isn't totally finished. The states need to be set to something and there needs to be a way to return values. 
// We also have to relate it back to the control signals. 

always @* begin

if (opcode == `Rtype) begin
    case (funct)
    `ADD:    begin   IF; ID; EX; WB; end
    `SUB:    begin   IF; ID; EX; WB; end
    `SLT:    begin   IF; ID; EX; WB; end
    `JR:     begin   IF; ID; end 
    endcase
  end else begin
end else begin
    case (opcode)
    `LW:     begin   IF; ID; MEM; EX; WB; end 
    `SW:     begin   IF; ID; MEM; EX; WB; end 
    `J:      begin   IF; ID; end 
    `JAL:    begin   IF; ID; WB; end 
    `BEQ:    begin   IF; ID; EX; end
    `BNE:    begin   IF; ID; EX; end
    `XORI:   begin   IF; ID; EX; WB; end 
    `ADDI:   begin   IF; ID; EX; WB; end 
    endcase
  end



  if (opcode == `Rtype) begin
    case (funct)
    `ADD:    begin   RegDst=2'b0; RegWr=1'b1; ALUSrc=1'b0; ALUcntrl=3'd0; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; end
    `SUB:    begin   RegDst=2'b0; RegWr=1'b1; ALUSrc=1'b0; ALUcntrl=3'd1; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; end
    `SLT:    begin   RegDst=2'b0; RegWr=1'b1; ALUSrc=1'b0; ALUcntrl=3'd3; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; end
    `JR:     begin   RegDst=2'b0; RegWr=1'b0; ALUSrc=1'b0; ALUcntrl=3'b0; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b1; end
    endcase
  end else begin
    case (opcode)
    `LW:     begin   RegDst=2'd2; RegWr=1'b1; ALUSrc=1'b1; ALUcntrl=3'd0; MemWr=1'b0; MemToReg=2'd1; bne=1'b0; beq=1'b0; jump=1'b0; end
    `SW:     begin   RegDst=2'b0; RegWr=1'b0; ALUSrc=1'b1; ALUcntrl=3'd0; MemWr=1'b1; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; end
    `J:      begin   RegDst=2'b0; RegWr=1'b0; ALUSrc=1'b0; ALUcntrl=3'b0; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b1; end
    `JAL:    begin   RegDst=2'b1; RegWr=1'b1; ALUSrc=1'b0; ALUcntrl=3'b0; MemWr=1'b0; MemToReg=2'd2; bne=1'b0; beq=1'b0; jump=1'b1; end
    `BEQ:    begin   RegDst=2'b0; RegWr=1'b0; ALUSrc=1'b0; ALUcntrl=3'd1; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b1; jump=1'b0; end
    `BNE:    begin   RegDst=2'b0; RegWr=1'b0; ALUSrc=1'b0; ALUcntrl=3'd1; MemWr=1'b0; MemToReg=2'd0; bne=1'b1; beq=1'b0; jump=1'b0; end
    `XORI:   begin   RegDst=2'd2; RegWr=1'b1; ALUSrc=1'b1; ALUcntrl=3'd2; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; end
    `ADDI:   begin   RegDst=2'd2; RegWr=1'b1; ALUSrc=1'b1; ALUcntrl=3'd0; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; end
    endcase
  end
end
endmodule
