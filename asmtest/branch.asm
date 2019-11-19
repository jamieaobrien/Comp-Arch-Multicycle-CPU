addi $sp, $zero, 16380 #0
addi $a0, $zero, 0     #4
addi $a1, $zero, 1     #8
beq $a0, $zero, target #12
addi $v0, $zero, 9     #16


target: 	       #20
addi $v0, $zero, 7     #24


bne $a0, $a1, target2  #28
addi $v1, $zero, 9     #32

target2: 	       #36
addi $v1, $zero, 7     #40
