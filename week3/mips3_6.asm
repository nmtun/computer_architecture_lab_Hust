.data
arr: .word 1, 2, -4, -10, -12, 3, 5, -7, 8, 20, 9, -11 
n: .word 12

.text
.globl main 
main:
	la $s0, arr		# l?u ??a ch? ??u tiên c?a màng arr và $s0
	lw $t0, n($zero) 	# c?p nh?t s? l??ng ph?n t? vào $t0
	li $s1, 0		# ??t k?t qu? ban ??u là 0
	j loop

loop: 
	beq $t0, $zero, exit	# thoát kh?i vòng l?p sau khi ki?m tra t?t c? ph?n t?
	lw $t1, 0($s0)		# c?p nh?t giá tr? hi?n t?i vào $t1
	abs $t2, $t1		# tính gttd và l?u vào $t2
	bge $t2, $s1, max	# c?p nh?t gttd l?n h?n
	addi $s0, $s0, 4	# c?p nh?t ??a ch? ph?n t? ti?p theo 
	addi $t3, $zero, -1	# gán giá tr? $t3=-1
	add $t0, $t0, $t3	# gi?m s? l??ng ph?n t? c?n ki?m tra ?i 1 
	j loop

max:
	move $s1, $t2 		# c?p nh?t gttd max
	addi $s0, $s0, 4 	# xét ph?n t? ti?p theo
	addi $t3, $zero, -1	# gán giá tr? $t3=-1
	add $t0, $t0, $t3	# gi?m s? l??ng ph?n t? c?n ki?m tra ?i 1
	
exit: 
	li $v0, 1 		# in k?t qu?
	move $a0, $s1		# c?p nh?t gttd_max vào $a0
	syscall			
	li $v0, 10		# k?t thúc ch??ng trình 
	syscall			