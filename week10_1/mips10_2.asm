.eqv SEVENSEG_LEFT 0xFFFF0010 	#Dia chi led trai
.eqv SEVENSEG_RIGHT 0xFFFF0011	#Dia chi led phai
.data
msg_1: .asciiz "Nhap vao mot so nguyen: "
.text
main:
	li $v0, 4
	la $a0, msg_1
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $t1, 100
	div $s0, $t1
	mfhi $t2
	
	li $t3, 10
	div $t2, $t3
	mfhi $s1	#chu so hang don vi
	mflo $s2	#chu so hang chuc
	
	beq $s1, 0, case0 
	beq $s1, 1, case1 
	beq $s1, 2, case2 
  	beq $s1, 3, case3
	beq $s1, 4, case4
	beq $s1, 5, case5 
  	beq $s1, 6, case6 
	beq $s1, 7, case7 
	beq $s1, 8, case8 
  	beq $s1, 9, case9			
case0: 	
	li $s3, 0x3F
	j continue1
case1: 	
	li $s3, 0x06
	j continue1
case2: 	
	li $s3, 0x5B
	j continue1 
case3: 
	li $s3, 0x4F
	j continue1
case4: 
	li $s3, 0x66
	j continue1
case5: 
	li $s3, 0x6D
	j continue1 
case6: 
	li $s3, 0x7D
	j continue1
case7: 
	li $s3, 0x07
	j continue1
case8: 
	li $s3, 0x7F
	j continue1
case9: 
	li $s3, 0x6F
	j continue1
continue1:
	beq $s2, 0, case_0 
	beq $s2, 1, case_1 
	beq $s2, 2, case_2 
  	beq $s2, 3, case_3
	beq $s2, 4, case_4
	beq $s2, 5, case_5 
  	beq $s2, 6, case_6 
	beq $s2, 7, case_7 
	beq $s2, 8, case_8 
  	beq $s2, 9, case_9			
case_0: 
	li $s4, 0x3F
	j continue2
case_1: 
	li $s4, 0x06
	j continue2
case_2: 
	li $s4, 0x5B
	j continue2 
case_3: 
	li $s4, 0x4F
	j continue2
case_4: 
	li $s4, 0x66
	j continue2
case_5: 
	li $s4, 0x6D
	j continue2
case_6: 
	li $s4, 0x7D
	j continue2
case_7: 
	li $s4, 0x07
	j continue2
case_8: 
	li $s4, 0x7F
	j continue2
case_9: 
	li $s4, 0x6F
	j continue2
continue2:
	move $a0, $s3 # set value for segments
	jal SHOW_7SEG_LEFT # show
	move $a0, $s4 # set value for segments
	jal SHOW_7SEG_RIGHT # show 
exit: 	
	li $v0, 10
	syscall
endmain:
SHOW_7SEG_LEFT: 
	li $t0, SEVENSEG_LEFT # assign port's address
	sb $a0, 0($t0) 	# assign new value
	jr $ra
SHOW_7SEG_RIGHT: 
	li $t0, SEVENSEG_RIGHT # assign port's address
	sb $a0, 0($t0) # assign new value
	jr $ra
	