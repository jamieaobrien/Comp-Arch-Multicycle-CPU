# LW, SW, J, JR, JAL, BEQ, BNE, XORI, ADDI, ADD, SUB, SLT


addi $t0, $zero, 11


lw #R[rt] = M[R[rs]+SignExtImm]
sw #M[R[rs] + SignExtImm] = R[rt] 

j #PC=JumpAddr
jr 
jal 

