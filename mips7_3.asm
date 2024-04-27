#Laboratory Exercise 7, Home Assignment 3
.text
	addi $s0, $zero, 10
	addi $s1, $zero, 11
push: 	addi $sp,$sp,-8 #adjust the stack pointer
	sw $s0,4($sp) 	#push $s0 to stack
	sw $s1,0($sp) 	#push $s1 to stack
work: 	nop
	nop
	nop
pop: 	lw $s0,0($sp) 	#pop from stack to $s0
	lw $s1,4($sp) 	#pop from stack to $s1
	addi $sp,$sp,8 	#adjust the stack pointer