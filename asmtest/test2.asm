addi $sp, $zero, 16380
addi $v0, $zero, 7
addi $v1, $zero, 3
sub  $v0, $v0, $v1
add  $v1, $v1,$v0

sw $v0, ($sp)

lw $t0, ($sp)


