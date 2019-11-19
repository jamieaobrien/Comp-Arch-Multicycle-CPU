addi $sp, $zero, 16380
jal target
addi $v0, $zero, 9
j end
target: 
addi $v0, $zero, 11
jr $ra
addi $v0, $zero, 14
end: