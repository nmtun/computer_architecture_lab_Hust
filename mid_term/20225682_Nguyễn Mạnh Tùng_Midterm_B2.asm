
.data
A: .space 256
msg_1: .asciiz "Nhap n (n < 64): "	# n la so ptu  
msg_2: .asciiz "Nhap ptu: "
msg_3: .asciiz "Ket qua la tich cua: "
msg_4: .asciiz " and "

.text
main: 
    li $v0, 4   
    la $a0, msg_1  
    syscall
    li $v0, 5   # nhap ptu
    syscall
    move $t0, $v0   # luu n
    li $t1, 0   # i = 0
    la $t2, A   # load adress of A to $t2
insert: 
    beq $t1, $t0, find   	# Nhap du -> nhay den find
    add $t4, $t1, $t1   	# $t4 = 2 * i
    add $t4, $t4, $t4   	# $t4 = 4 * i
    add $t4, $t4, $t2   	# $t4 = 4i + A[0]
    li $v0, 4   
    la $a0, msg_2   	# nhap cac ptu 
    syscall
    li $v0, 5   
    syscall
    sw $v0, ($t4)   	# luu cac ptu vao A
    addi $t1, $t1, 1    # i++
    j insert    
find:
    li $t1, 0   	# i = 0
    la $t2, A   	# load adress of A to $t2
    li $t5, -999999 	# $t5 = tich max
    li $t6, 0   	# the first index 
    li $t7, 1   	# the second index
    addi $s3, $t0, -1
loop:
	bgt $t7, $s3, print
	
	add $t8, $t6, $t6
	add $t8, $t8, $t8
	add $t8, $t8, $t2
	
	addi $t9, $t8, 4
	#add $t9, $t9, $t9
	#add $t9, $t9, $t2
    lw $t8, ($t8)   		# load ptu i cua A -> $t8
    lw $t9, ($t9)   		# load ptu i + 1 cua A -> $t9
    mul $s1, $t8, $t9 		# $s1=$t8*$t9
    bgt $s1, $t5, update 	# if max > $s1 -> update
    addi $t6, $t6, 1    	# i++
    addi $t7, $t7, 1    	
    j loop
update:
    move $t5, $s1  		# $t5=max
    move $s6, $t6   		# luu lai chi so ptu thu nhat
    move $s7, $t7	 	# luu lai chi so ptu thu hai
    addi $t6, $t6, 1    	# i++
    addi $t7, $t7, 1    	
    j loop
print:
    # in msg_3
    li $v0, 4   
    la $a0, msg_3   
    syscall
    # in ra ptu thu nhat
    	add $t8, $s6, $s6
	add $t8, $t8, $t8
	add $t8, $t8, $t2
    li $v0, 1   
    lw $a0, ($t8)   		# Load pt tu A vao $a0
    syscall
    # in msg_4
    li $v0, 4   
    la $a0, msg_4
    syscall
    # in ra ptu thu hai 
    	add $t9, $s7, $s7
	add $t9, $t9, $t9
	add $t9, $t9, $t2
    li $v0, 1   
    lw $a0, ($t9)   		# Load ptu tu A vao $a0
    syscall
end_print:
    li $v0, 10  
    syscall


