.data
get: .space 20
msg_1: .asciiz "Nhap phan tu thu "
msg_2: .asciiz ": "
msg_3: .asciiz "Ket qua la: "
msg_4: .asciiz "\n"
.text
li $s0, 20 		# max 20 characters 
li $s1, 0		# i=0
la $s2, get		# load address get to $s2
li $s3, 10
load_char:
beq $s1, $s0, end	# i=20, exit
# print msg_1
li $v0, 4
la $a0, msg_1
syscall
# print ki tu thu i 
addi $t1, $s1, 1
li $v0, 1
move $a0, $t1
syscall
# print msg_2
li $v0, 4
la $a0, msg_2
syscall
li $v0, 12		# read 
syscall
move $t0, $v0
beq $t0, $s3, end	# $t0="enter" -> exit
li $v0, 4
la $a0, msg_4
syscall
add $s5, $s2, $s1
sb $t0, 0($s5)
addi $s1, $s1, 1	# i=i+1
j load_char
end:
li $v0, 4
la $a0, msg_3
syscall
exit: 
li $v0, 10
syscall
