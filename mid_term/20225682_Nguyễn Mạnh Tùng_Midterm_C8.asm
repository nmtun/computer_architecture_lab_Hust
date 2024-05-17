.data
str: .space 100   # max 100 ki tu
msg_1: .asciiz "Nhap vao mot chuoi: "
msg_2: .asciiz "So luong chu hoa: "
msg_3: .asciiz "\nSo luong chu thuong: "
msg_4: .asciiz "\nSo luong chu so: "
msg_5: .asciiz "\n"

.text
main:
    	# in msg_1
    	li $v0, 4
    	la $a0, msg_1
    	syscall
    	# doc chuoi
    	li $v0, 8
    	la $a0, str
    	li $a1, 100   	# max 100 ki tu
    	syscall
    	# goi cac ham
    	la $a0, str
    	jal count_hoa
    	nop
    	move $s0, $v0   # $s0 = so luong chu hoa

    	la $a0, str
    	jal count_thuong
    	nop
    	move $s1, $v0   #  $s1 = so luong chu thuong 

    	la $a0, str
    	jal count_so
    	nop
    	move $s2, $v0   # $s2 = so luong chu so
    	# in kq
    	li $v0, 4
    	la $a0, msg_2
    	syscall
    	li $v0, 1
    	move $a0, $s0
    	syscall

    	li $v0, 4
    	la $a0, msg_3
    	syscall
    	li $v0, 1
    	move $a0, $s1
    	syscall

    	li $v0, 4
    	la $a0, msg_4
    	syscall
    	li $v0, 1
    	move $a0, $s2
    	syscall
    	# xuong dong
    	li $v0, 4
    	la $a0, msg_5
    	syscall
    	# end
    	li $v0, 10
    	syscall

# dem chu hoa
count_hoa:
    	li $v0, 0          # kq=0
    	li $t0, 0x41       # ASCII of 'A'
    	li $t1, 0x5A       # ASCII of 'Z'

loop_hoa:
    	lb $t2, ($a0)      # doc ki tu
    	beq $t2, $zero, hoa_end  	# neu gap ki tu ket thuc -> dung lap 
    	blt $t2, $t0, hoa_next  	# if < 'A' bo qua
    	bgt $t2, $t1, hoa_next  	# if > 'Z' bo qua
    	addi $v0, $v0, 1   # kq+=
hoa_next:
    	addi $a0, $a0, 1   # i++
    	j loop_hoa
hoa_end:
    	jr $ra

# dem chu thuong
count_thuong:
    	li $v0, 0          # kq=0
    	li $t0, 0x61       # ASCII of 'a'
    	li $t1, 0x7A       # ASCII of 'z'

loop_thuong:
    	lb $t2, ($a0)      # doc ki tu
    	beq $t2, $zero, thuong_end  	# neu gap ki tu ket thuc -> dung lap
    	blt $t2, $t0, thuong_next  	# if < 'a' bo qua
    	bgt $t2, $t1, thuong_next  	# if > 'z' bo qua
    	addi $v0, $v0, 1   # kq++
thuong_next:
    	addi $a0, $a0, 1   # i++
    	j loop_thuong
thuong_end:
    	jr $ra
    	
# dem so
count_so:
    	li $v0, 0          # kq 0
    	li $t0, 0x30       # ASCII of '0'
    	li $t1, 0x39       # ASCII of '9'

loop_so:
    	lb $t2, ($a0)      # doc ki tu
    	beq $t2, $zero, so_end  	# neu gap ki tu ket thuc -> dung lap
    	blt $t2, $t0, so_next  		# if < '0' bo qua
    	bgt $t2, $t1, so_next  		# if > '9' bo qua
    	addi $v0, $v0, 1   # kq++
so_next:
    	addi $a0, $a0, 1   # i++
    	j loop_so
so_end:
    	jr $ra
