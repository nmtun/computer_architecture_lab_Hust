.data
	A: .word 1, 2, -4, -10, -12, 3, 5, -7, 8, 20, 9, -11 
.text
	addi $s5, $zero, 0	# max = 0
	addi $s1, $zero, 0	# i = 0
	addi $s3, $zero, 12	# n = 12
	addi $s4, $zero, 1	# buocs nh?y = 1
	addi $s6, $zero, 0	# c?p nh?t gttd_max vào $s6 
	la $s2, A
loop:
	slt $t2, $s1, $s3
	beq $t2, $zero, endloop
	add $t1, $s1, $s1
	add $t1, $t1, $t1
	add $t1, $t1, $s2
	lw $t0, 0($t1)
	abs $t0, $t0
	slt $t4, $t0, $s6
	bne $t4, $zero, else 
	add $s6, $zero, $t0
else:
	add $s1, $s1, $s4
	j loop
endloop: