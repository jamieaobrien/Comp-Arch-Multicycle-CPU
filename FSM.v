

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



`define IF   3'd0
`define ID   3'd1
`define EX   3'd2
`define MEM  3'd3
`define WB   3'd4



module FSM (
  output reg[1:0]    RegDst,
  output reg         RegWr,
  output reg         ALUSrc,
  output reg[2:0]    ALUcntrl,
  output reg         MemWr,
  output reg[1:0]    MemToReg,
  output reg         jump,
  output reg         bne,
  output reg         beq,
  output reg         wb,
  output reg         mem,
  output reg         addrGen,
  output reg         instrReg,
  output reg[2:0]    nextState,
  output reg         R_rsReg,
  output reg         R_rtReg,
  input  [5:0]       funct,
  input  [5:0]       opcode,
  input              clk
  );
reg[2:0]  state;
//reg[2:0]  nextState;
initial nextState = `IF;

always @(posedge clk) begin
  state = nextState;
  case (state)
    `IF: begin addrGen = 1'b0; nextState <= `ID; instrReg = 1'b1; R_rsReg = 1'b0; R_rtReg = 1'b0; end
    `ID: begin
      R_rsReg = 1'b0;
      R_rtReg = 1'b0;
      //always @* begin
        addrGen = 1'b1;
        instrReg = 1'b0;
        if (opcode == `Rtype) begin
            case (funct)
            `ADD:    begin   RegDst=2'b0; RegWr=1'b1; ALUSrc=1'b0; ALUcntrl=3'd0; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; wb=1'b1; mem=1'b0; nextState=`EX;  end
            `SUB:    begin   RegDst=2'b0; RegWr=1'b1; ALUSrc=1'b0; ALUcntrl=3'd1; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; wb=1'b1; mem=1'b0; nextState=`EX;  end
            `SLT:    begin   RegDst=2'b0; RegWr=1'b1; ALUSrc=1'b0; ALUcntrl=3'd3; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; wb=1'b1; mem=1'b0; nextState=`EX;  end
            `JR:     begin   RegDst=2'b0; RegWr=1'b0; ALUSrc=1'b0; ALUcntrl=3'b0; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b1; wb=1'b0; mem=1'b0; nextState=`IF;  end
            endcase
          end else begin
            case (opcode)
            `LW:     begin   RegDst=2'd2; RegWr=1'b1; ALUSrc=1'b1; ALUcntrl=3'd0; MemWr=1'b0; MemToReg=2'd1; bne=1'b0; beq=1'b0; jump=1'b0; wb=1'b1; mem=1'b1; nextState=`EX;  end
            `SW:     begin   RegDst=2'b0; RegWr=1'b0; ALUSrc=1'b1; ALUcntrl=3'd0; MemWr=1'b1; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; wb=1'b0; mem=1'b1; nextState=`EX;  end
            `J:      begin   RegDst=2'b0; RegWr=1'b0; ALUSrc=1'b0; ALUcntrl=3'b0; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b1; wb=1'b1; mem=1'b0; nextState=`IF;  end
            `JAL:    begin   RegDst=2'b1; RegWr=1'b1; ALUSrc=1'b0; ALUcntrl=3'b0; MemWr=1'b0; MemToReg=2'd2; bne=1'b0; beq=1'b0; jump=1'b1; wb=1'b1; mem=1'b0; nextState=`WB;  end
            `BEQ:    begin   RegDst=2'b0; RegWr=1'b0; ALUSrc=1'b0; ALUcntrl=3'd1; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b1; jump=1'b0; wb=1'b0; mem=1'b0; nextState=`EX;  end
            `BNE:    begin   RegDst=2'b0; RegWr=1'b0; ALUSrc=1'b0; ALUcntrl=3'd1; MemWr=1'b0; MemToReg=2'd0; bne=1'b1; beq=1'b0; jump=1'b0; wb=1'b0; mem=1'b0; nextState=`EX;  end
            `XORI:   begin   RegDst=2'd2; RegWr=1'b1; ALUSrc=1'b1; ALUcntrl=3'd2; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; wb=1'b1; mem=1'b0; nextState=`EX;  end
            `ADDI:   begin   RegDst=2'd2; RegWr=1'b1; ALUSrc=1'b1; ALUcntrl=3'd0; MemWr=1'b0; MemToReg=2'd0; bne=1'b0; beq=1'b0; jump=1'b0; wb=1'b1; mem=1'b0; nextState=`EX;  end
            endcase
          end
      //  end

    end
    `EX: begin
      R_rsReg = 1'b1;
      R_rtReg = 1'b1;
      addrGen = 1'b0;
      case (wb)
        0: begin  nextState=`IF;  end
        1: begin  nextState=`WB;  end
      endcase
      case (mem)
        0: begin  nextState=nextState;  end
        1: begin  nextState=`MEM;        end
      endcase
    end
    `MEM: begin
      R_rsReg = 1'b0;
      R_rtReg = 1'b0;
      addrGen = 1'b0;
      case (wb)
        0: begin  nextState=`IF;  end
        1: begin  nextState=`WB;  end
      endcase
    end
    `WB: begin  addrGen = 0; nextState = `IF; R_rsReg = 1'b0; R_rtReg = 1'b0;  end
  endcase
end
endmodule
