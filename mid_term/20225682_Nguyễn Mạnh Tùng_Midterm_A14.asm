.data
msg_1: .asciiz "Nhap so thu nhat: "
msg_2: .asciiz "Nhap so thu hai: "
msg_3: .asciiz "BCNN cua hai so la: "

.text
main:
    	# in msg_1
    	li $v0, 4
    	la $a0, msg_1
    	syscall
    	# nhap so thu nhat
    	li $v0, 5
    	syscall
   	move $s0, $v0
    	# in msg_2
    	li $v0, 4
    	la $a0, msg_2
    	syscall
    	# nhap so thu hai
    	li $v0, 5
    	syscall
    	move $s1, $v0
    	move $a0, $s0	# a0=m
    	move $a1, $s1	# a1=n
    	jal bcnn	# thuc hien ct con
    	nop
    	# in msg_3
    	li $v0, 4
    	la $a0, msg_3
    	syscall
    	# in kq
    	li $v0, 1
    	move $a0, $t0
    	syscall
    	# Kết thúc chương trình
    	li $v0, 10
    	syscall
bcnn: 
    	move $t0, $a0        # $t0=m
    	move $t1, $a1        # $t1=n

loop_ucln:
    	beq $t1, $zero, end	  # if n=0 -> end
    	move $t2, $t1             # t2=n
    	div $t0, $t1              # m mod n
    	mfhi $t0                  # t0 = m mod n 
    	move $t1, $t0             # t1=t0
    	move $t0, $t2             # m=n
    	j loop_ucln                

end:
    	move $t0, $t2             # Lưu UCLN vào $t0
    
    	# tim bcnn
   	mul $t3, $a0, $a1         # t3=m*n
    	div $t3, $t0              # m*n / ucln
    	mflo $t0                  # $t0=kq

    	jr $ra                    # tra ve 

