.data 
msg_1: .asciiz "Largest: "
msg_2: .asciiz "\nSmallest: "
msg_3: .asciiz ","
.text
main: 
	li $s0, 2
	li $s1, 22  
	li $s2, 3  
	li $s3, -4  
	li $s4, 5  
	li $s5, 6  
	li $s6, 7  
	li $s7, -8 
	jal check
	nop
	li $v0, 4		#print Largrest
	la $a0, msg_1
	syscall
	add $a0, $t0, $zero	#print max
	li $v0, 1
	syscall
	li $v0, 4 		#print ","
	la $a0, msg_3
	syscall
	add $a0, $t5, $zero	#print register number of max
	li $v0, 1
	syscall
	li $v0, 4		#print Smallest
	la $a0, msg_2
	syscall
	add $a0, $t1, $zero	#print min
	li $v0, 1
	syscall
	li $v0, 4 		#print ","
	la $a0, msg_3
	syscall
	add $a0, $t6, $zero	#print register number of min
	li $v0, 1
	syscall
	li $v0, 10		#exit
	syscall
swap_max:
	add $t0,$t3,$zero
 	add $t5,$t2,$zero
 	jr $ra
swap_min:
	add $t1,$t3,$zero
 	add $t6,$t2,$zero
 	jr $ra
check:
 	add $t9,$sp,$zero 	#Save address of $sp
 	addi $sp,$sp, -32
 	#cập nhật giá trị vào stack 
 	sw $s1, 0($sp)
 	sw $s2, 4($sp)
 	sw $s3, 8($sp)
 	sw $s4, 12($sp)
 	sw $s5, 16($sp)
 	sw $s6, 20($sp)
 	sw $s7, 24($sp)
 	sw $ra, 28($sp) 	#Save $ra 
 	add $t0,$s0,$zero 	#Max = $s0
 	add $t1,$s0,$zero 	#Min = $s0
 	li $t5, 0 		#Index of Max = 0
 	li $t6, 0 		#Index of Min = 0
 	li $t2, 0 		#i = 0
find:
 	addi $sp,$sp,4
 	lw $t3,-4($sp)
 	sub $t4, $sp, $t9
 	beq $t4,$zero, done 	#If $sp = $fp exit
 	nop
 	addi $t2,$t2,1 		#i++
 	sub $t4,$t0,$t3
 	bltzal $t4, swap_max 	#cập nhật max
 	nop
 	sub $t4,$t3,$t1
 	bltzal $t4, swap_min 	#cập nhật min
 	nop
 	j find 			#lặp
done:
	lw $ra, -4($sp)
 	jr $ra 			

    		

	
	 
	  