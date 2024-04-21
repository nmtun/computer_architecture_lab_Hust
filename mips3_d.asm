.text 
li $s1, 0x00000005
li $s2, 0x00000008
slt $s0, $s2, $s1
beq $s0, $zero, label
label:
exit: