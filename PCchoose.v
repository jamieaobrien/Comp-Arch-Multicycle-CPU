// Liv Kelley, Jamie O'Brien, and Sabrina Pereira
// Sequential Multiplier PC Choose Module

/*-----------------------------------------------------------------------------
This module takes in PC+4, the branch address, and the jump address from the
address generator. It also takes in bne, beq, zero, jump, and reset from the
control logic. It uses these values to set the next PC value based on the
current operation. It does this at the positive clock edge.
------------------------------------------------------------------------------*/
//
module PCchoose
(

// Inputs ---------------------------------------------------------------------
input clk,                  // System clock
input[31:0] PC4,            // Current PC + 4 from address generator
input bne,                  // Control signal from logic - true if operation is BNE
input beq,                  // Control signal from logic - true if operation is BEQ
input[31:0] branchAddr,     // Branch address from address generator
input[31:0] jumpAddr,       // Jump address from address generator
input zero,                 // Zero flag from ALU
input jump,                 // Control signal from logic - true if operation is a jump
input reset,                // Control signal from logic
// Outputs --------------------------------------------------------------------
output reg[31:0] PC
);

reg[31:0] resetOut;         // Reset mux output
reg[31:0] bneBeqOut;        // bneBeq mux output
reg finalSel;               // Select for branch addr mux
reg jumpSel;                // Select for jump addr mux
reg[31:0] jumpOut;          // Jump addr mux output

always @(posedge clk) begin
//always @* begin
// Reset mux
case (reset)
  0:  begin resetOut = 0;   end
  1:  begin resetOut = PC4; end
endcase

// Jump addr mux
jumpSel = reset && jump;
case (jumpSel)
  0:  begin jumpOut = resetOut; end
  1:  begin jumpOut = jumpAddr; end
endcase

// Bne/Beq Mux
case (zero)
  0:  begin bneBeqOut = bne; end
  1:  begin bneBeqOut = beq; end
endcase
finalSel = bneBeqOut && (bne || beq) && reset;

// Branch Addr Mux
case (finalSel)
  0:  begin PC <= jumpOut;    end
  1:  begin PC <= branchAddr; end
endcase

end
endmodule
