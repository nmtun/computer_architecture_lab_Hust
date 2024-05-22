.eqv IN_ADDRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADDRESS_HEXA_KEYBOARD 0xFFFF0014
.data
msg_1: .asciiz "\n"
.text
main: 
	li $t1, IN_ADDRESS_HEXA_KEYBOARD
	li $t2, OUT_ADDRESS_HEXA_KEYBOARD
	li $t3, 0x01 # check row 1 
	li $t4, 0x02 # check row 2 
	li $t5, 0x04 # check row 3 
	li $t6, 0x08 # check row 4 
polling: 

	sb $t3, 0($t1 ) # must reassign expected row
	lb $a0, 0($t2) # read scan code of key button
	bne $a0, $zero, print
	
	sb $t4, 0($t1 ) # must reassign expected row
	lb $a0, 0($t2) # read scan code of key button
	bne $a0, $zero, print
	
	sb $t5, 0($t1 ) # must reassign expected row
	lb $a0, 0($t2) # read scan code of key button
	bne $a0, $zero, print
	
	sb $t6, 0($t1 ) # must reassign expected row
	lb $a0, 0($t2) # read scan code of key button
	bne $a0, $zero, print
print: 
	beq $a0, 0, sleep
	li $v0, 34 # print integer (hexa)
	syscall
	li $v0, 4
	la $a0, msg_1
	syscall
sleep: 
	li $a0, 100 # sleep 100ms
	li $v0, 32
	syscall
back_to_polling: 
	j polling # continue polling

