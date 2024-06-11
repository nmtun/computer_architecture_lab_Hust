#===========================================================================================
# Chương trình máy tính bỏ túi
# B1: Run code
# B2: Mở Digital Lab Sim và kết nối với MIPS
# B3: Thực hiện tính toán
# Lưu ý: 'a'='+'; 'b'='-'; 'c'='*'; 'd'='/'; 'e'='%'; 'f'='='
#===========================================================================================

.eqv	SEVENSEG_LEFT	0xFFFF0011	# Dia chi LED trai				
.eqv	SEVENSEG_RIGHT	0xFFFF0010	# Dia chi LED phai 
.eqv 	IN_ADDRESS_HEXA_KEYBOARD 	0xFFFF0012
.eqv 	OUT_ADDRESS_HEXA_KEYBOARD 	0xFFFF0014

.data
# gia tri hexa tuong ung khi hien thi tren LED
zero:  		.byte 0x3f
one:   		.byte 0x6
two:   		.byte 0x5b
three: 		.byte 0x4f
four:  		.byte 0x66
five:  		.byte 0x6d
six:   		.byte 0x7d
seven: 		.byte 0x7
eight: 		.byte 0x7f
nine:  		.byte 0x6f

msg_1:		.asciiz 	"Khong chia duoc cho 0!\n"

.text
main:
init:
	li 	$t0, SEVENSEG_LEFT
	li 	$t1, SEVENSEG_RIGHT
	li 	$t2, IN_ADDRESS_HEXA_KEYBOARD  	# bien xu ly ngat
	li 	$t3, OUT_ADDRESS_HEXA_KEYBOARD 	# bien luu vi tri phim
	li 	$t4, 0x80			# xu ly ngat va kiem tra dong` tren ban phim hexa
	sb 	$t4, 0($t2)
	li 	$t5, 0       		# bien chua gia tri tren LED
	li 	$t6, 0			# hien thi gia tri 0 -> 9
	li 	$t7, 0 			# tmp
	
	li 	$s0, 0      		# gia tri dau vao: 0-chu so; 1-toan tu
        li 	$s1, 0     		# bien xu ly LEFT LED
        li 	$s2, 0   		# bien xu ly RIGHT LED
        li 	$s3, 0     		# bien chua toan tu: 1: +, 2: -, 3: *, 4: /, 5: %
        li 	$s4, 0      		# so hang thu nhat
        li 	$s5, 0   		# so hang thu hai
        li 	$s6, 0     		# ket qua
first_value:
	li 	$t5, 0        		# gia tri ban dau can hien thi
	addi 	$sp,$sp, 4		# push vao stack
        sb 	$t5, 0($sp)	
	lb 	$t6, zero 		# bit dau tien can hien thi
	addi 	$sp, $sp, 4  		# push vao stack
        sb 	$t6, 0($sp)

loop:
	nop
	nop
	nop
	nop
	b 	loop		# doi ngat
	nop
	nop
	nop
	nop
	b 	loop		# doi ngat	
	nop
	nop
	nop
	nop
	b 	loop		# doi ngat		
end_loop:

# xu ly ngat
# hien thi gia tri len LED
# kiem tra phim da nhan
end_main:
	li 	$v0, 10
	syscall
	
	
.ktext 0x80000180
# chuyen den dong co phim da nhan
	jal 	check_row_1		# ktra dong 1
	bnez 	$t4, convert_row_1	# t4 != 0 -> co phim da nhan -> tim phim -> lay gia tri
	nop
	
	jal 	check_row_2		# ktra dong 2
	bnez 	$t4, convert_row_2	
	nop
	
	jal 	check_row_3		# ktra dong 3
	bnez 	$t4, convert_row_3	
	nop
	
	jal 	check_row_4		# ktra dong 4
	bnez 	$t4, convert_row_4	

# kiem tra phim da nhan
check_row_1:
	addi 	$sp, $sp, 4
        sw 	$ra, 0($sp) 		
        li 	$t4, 0x81     		# ngat
        sb 	$t4, 0($t2)
        jal 	get_value		# lay vi tri cua phim da nhan (neu co)
        lw 	$ra, 0($sp)
        addi 	$sp, $sp, -4
        jr 	$ra

check_row_2:
	addi 	$sp, $sp, 4
        sw 	$ra, 0($sp) 		
        li 	$t4, 0x82   		
        sb 	$t4, 0($t2)
        jal 	get_value		
        lw 	$ra, 0($sp)
        addi 	$sp, $sp, -4
        jr 	$ra

check_row_3:
	addi 	$sp, $sp, 4
        sw 	$ra, 0($sp) 		
        li 	$t4, 0x84     		
        sb 	$t4, 0($t2)
        jal 	get_value		
        lw 	$ra, 0($sp)
        addi 	$sp, $sp, -4
        jr 	$ra

check_row_4:
	addi 	$sp, $sp, 4
        sw 	$ra, 0($sp) 		
        li 	$t4, 0x88     		
        sb 	$t4, 0($t2)
        jal 	get_value		
        lw 	$ra, 0($sp)
        addi 	$sp, $sp, -4
        jr 	$ra

# lay gia tri
get_value:
	addi 	$sp, $sp, 4
        sw 	$ra, 0($sp) 
        li 	$t3, OUT_ADDRESS_HEXA_KEYBOARD 	# dia chi phim da nhan
        lb 	$t4, 0($t3)			# lay vi tri
        lw 	$ra, 0($sp)
        addi 	$sp, $sp, -4
        jr 	$ra	

# hien thi gia tri len LED va cac phep toan 
convert_row_1:	
	beq 	$t4, 0x11, case_0		# so 0
	beq 	$t4, 0x21, case_1		# so 1
	beq 	$t4, 0x41, case_2		# so 2
	beq 	$t4, 0xffffff81, case_3		# so 3
case_0:
	lb 	$t6,zero	# gia tri hien thi tren LED = 0
	li 	$t5,0		
	j 	update_tg
case_1:
	lb 	$t6,one		
	li 	$t5,1		
	j 	update_tg
case_2:
	lb	$t6,two		
	li 	$t5,2		
	j	update_tg
case_3:
	lb 	$t6, three	
	li 	$t5, 3		
	j 	update_tg

convert_row_2:	
	beq 	$t4, 0x12, case_4		# so 4
	beq 	$t4, 0x22, case_5		# so 5
	beq 	$t4, 0x42, case_6		# so 6
	beq 	$t4, 0xffffff82, case_7		# so 7
case_4:
	lb 	$t6, four	
	li 	$t5, 4		
	j 	update_tg
case_5:
	lb 	$t6, five	
	li 	$t5, 5		
	j 	update_tg
case_6:
	lb	$t6, six	
	li 	$t5,6		
	j	update_tg
case_7:
	lb 	$t6, seven	
	li 	$t5, 7		
	j 	update_tg
	
convert_row_3:	
	beq 	$t4, 0x14, case_8		# so 8
	beq 	$t4, 0x24, case_9		# so 9	
	beq 	$t4, 0x44, case_a		# phep +
	beq 	$t4, 0xffffff84, case_b		# phep -
case_8:
	lb 	$t6, eight	
	li 	$t5, 8		
	j 	update_tg
case_9:
	lb 	$t6, nine	
	li 	$t5, 9		
	j 	update_tg

# Case a: phep +
case_a:	
	addi 	$a3, $zero, 1
	addi 	$s0, $s0, 1          		# s0 = 1, da nhap toan tu 
	bne 	$s3, 0, set_next_operator
	addi 	$s3, $zero, 1			# s3 = 1 -> cong
	
	j 	set_first_number        	# chuyen den ham chuyen doi so hien thi tren LED -> tinh toan 
	
case_b:
	addi 	$a3, $zero, 2
	addi 	$s0, $s0, 1		
	bne 	$s3, 0, set_next_operator
	addi 	$s3, $zero, 2			# s3 = 2 -> phep - 
	j 	set_first_number


convert_row_4:	
	beq 	$t4, 0x18, case_c		# phep * 
	beq 	$t4, 0x28, case_d		# phep / 
	beq 	$t4, 0x48, case_e		# phep %
	beq 	$t4, 0xffffff88, case_f		# ket qua 
	
case_c:	
	addi 	$a3, $zero, 3
	addi 	$s0, $s0, 1          	
	bne 	$s3, 0, set_next_operator
	addi 	$s3, $zero, 3		
	
	j set_first_number        	
	
case_d:
	addi 	$a3, $zero, 4
	addi 	$s0, $s0, 1		
	bne 	$s3, 0, set_next_operator
	addi 	$s3, $zero, 4		
	j 	set_first_number

case_e:	
	addi 	$a3, $zero, 5
	addi 	$s0, $s0, 1          	
	bne 	$s3, 0, set_next_operator
	addi 	$s3, $zero, 5		
	j 	set_first_number        

# hien thi so tren LED -> gia tri cua so dau tien
set_first_number:      
	addi 	$s4, $t7, 0
	li 	$t7, 0
	j 	done

# Case f:
case_f: 
	addi $s5, $t7, 0
	
# hien thi so tren LED -> gia tri cua so thu hai
set_second_number:  
	beq 	$s3, 1, addition	
	beq 	$s3, 2, substraction	
	beq 	$s3, 3, multiplication	
	beq 	$s3, 4, division	
	beq	$s3, 5, find_remainder	
addition:
	add 	$s6, $s5, $s4
	li 	$s3, 0
	li 	$t7, 0 
	j 	print_addition
	nop     		

print_addition:
	li 	$v0, 1
	move 	$a0, $s4
	syscall
	li 	$s4, 0		# reset so dau dien = 0
	
	li 	$v0, 11
	li 	$a0, '+'
	syscall
	
	li 	$v0, 1
	move 	$a0, $s5
	syscall
	li 	$s5, 0		# reset so thu hai = 0
	
	li 	$v0, 11
	li 	$a0, '='
	syscall
	
	li 	$v0, 1
	move 	$a0, $s6
	syscall
	nop
	
	li 	$v0, 11
	li 	$a0, '\n'
	syscall
	li 	$s7, 100
	div 	$s6, $s7
	mfhi 	$s6	    	# lay hai chu so cuoi cua kq
	j show_result_in_led	# hien thi tren LED
	nop

substraction:
	sub 	$s6, $s4, $s5   
	li 	$s3, 0
	li 	$t7, 0 
	j 	print_substraction
	nop
	
print_substraction:
	li 	$v0, 1
	move 	$a0, $s4
	syscall
	li 	$s4, 0		
	
	li 	$v0, 11
	li 	$a0, '-'
	syscall
	
	li 	$v0, 1
	move 	$a0, $s5
	syscall
	li 	$s5, 0		
	
	
	li 	$v0, 11
	li 	$a0, '='
	syscall
	
	li 	$v0, 1
	move 	$a0, $s6
	syscall
	
	li 	$v0, 11
	li 	$a0, '\n'
	syscall
	
	li 	$s7, 100
	div 	$s6, $s7
	mfhi 	$s6
	bltz	$s6, multi		    	
	j 	show_result_in_led	
	nop
multi: 	
	mul 	$s6, $s6, -1
	j 	show_result_in_led	
	nop
	
multiplication:
	mul 	$s6, $s4, $s5    
	li 	$s3, 0
	li 	$t7, 0 
	j 	print_multiplication
	nop
	
print_multiplication:
	li 	$v0, 1
	move 	$a0, $s4
	syscall
	li 	$s4, 0		
	
	li 	$v0, 11
	li 	$a0, '*'
	syscall
	
	li 	$v0, 1
	move 	$a0, $s5
	syscall
	li 	$s5, 0		
	
	
	li 	$v0, 11
	li 	$a0, '='
	syscall
	
	li 	$v0, 1
	move 	$a0, $s6
	syscall
	
	li 	$v0, 11
	li 	$a0, '\n'
	syscall
	
	li 	$s7, 100
	div 	$s6, $s7
	mfhi 	$s6	    	
	j show_result_in_led    
	nop

division:
	beq 	$s5, 0, divide_by_0	
	li 	$s3, 0
	div 	$s4, $s5   	    
	mflo 	$s6
	mfhi 	$s7
	li 	$t7, 0 
	j 	print_division
	nop

divide_by_0: 
	li 	$v0, 55
	la 	$a0, msg_1
	li 	$a1, 0
	syscall
	j 	reset_led

print_division:
	li 	$v0, 1
	move 	$a0, $s4
	syscall
	li 	$s4, 0		
	
	li 	$v0, 11
	li 	$a0, '/'
	syscall
	
	li 	$v0, 1
	move 	$a0, $s5
	syscall
	li 	$s5, 0		
	
	
	li 	$v0, 11
	li 	$a0, '='
	syscall
	
	li 	$v0, 1
	move 	$a0, $s6
	syscall
	
		
	li 	$v0, 11
	li 	$a0, '\n'
	syscall
	
	li 	$s7, 100
	div 	$s6, $s7
	mfhi 	$s6		    	
	j 	show_result_in_led	
	nop

find_remainder:
	beq 	$s5, 0, find_remainder_0	
	li 	$s3, 0
	div 	$s4, $s5   	    
	mflo 	$s7
	mfhi 	$s6
	li 	$t7, 0 
	j 	print_find_remainder
	nop

find_remainder_0: 
	li 	$v0, 55
	la 	$a0, msg_1
	li 	$a1, 0
	syscall
	j 	reset_led

print_find_remainder:
	li 	$v0, 1
	move 	$a0, $s4
	syscall
	li 	$s4, 0		
	
	li 	$v0, 11
	li 	$a0, '%'
	syscall
	
	li 	$v0, 1
	move 	$a0, $s5
	syscall
	li 	$s4, 0		
	
	li 	$v0, 11
	li 	$a0, '='
	syscall
	
	li 	$v0, 1
	move 	$a0, $s6
	syscall
	
		
	li 	$v0, 11
	li 	$a0, '\n'
	syscall
	
	li 	$s7, 100
	div 	$s6, $s7
	mfhi 	$s6		    	
	j 	show_result_in_led	
	nop

# hien thi kq
# so 'ab'
# LEFT LED = a = ab div 10
# RIGHT LED = b = ab mod 10
show_result_in_led:
	li 	$t8, 10			# t8 = 10
	div 	$s6, $t8    		# s6 = a
	mflo 	$t5        		# t5 = kq div 10
	jal 	check    		# chuyen den ham hien thi gia tri cua $t5 len LED

        sb 	$t6, 0($t0)  		# hien thi len LEFT LED
     	add 	$sp, $sp, 4
	sb 	$t5, 0($sp)		# Push vao stack
	add 	$sp, $sp, 4
	sb 	$t6, 0($sp)    		# Push vao stack
	add 	$s2, $t5, $zero   	# s2 = gtri cua LEFT LED
	
	mfhi 	$t5       		# t5 = kq mod 10
	jal 	check    		# t5 -> LED
        sb 	$t6, 0($t1)  		# -> RIGHT LED
       	add 	$sp, $sp, 4
	sb 	$t5, 0($sp)		# Push to stack
	add 	$sp, $sp, 4
	sb 	$t6, 0($sp)    		# Push to stack
	add 	$s1, $t5, $zero		# s1 = gia tri cua RIGHT LED
        j 	reset_led     		# reset LED
           
check:
	addi 	$sp, $sp, 4
        sw 	$ra, 0($sp)
        beq 	$t5, 0, check_0		# hien thi 0
        beq 	$t5, 1, check_1	   	# hien thi 1
        beq 	$t5, 2, check_2		# hien thi 2
        beq 	$t5, 3, check_3		# hien thi 3
        beq 	$t5, 4, check_4		# hien thi 4
        beq 	$t5, 5, check_5		# hien thi 5
        beq 	$t5, 6, check_6		# hien thi 6
        beq 	$t5, 7, check_7		# hien thi 7
        beq 	$t5, 8, check_8		# hien thi 8
        beq 	$t5, 9, check_9		# hien thi 9
        
check_0:	
	lb 	$t6, zero    
	j 	finish_check
check_1:
	lb 	$t6, one
	j 	finish_check
check_2:
	lb 	$t6, two
	j 	finish_check
check_3:
	lb 	$t6, three
	j	finish_check
check_4:
	lb 	$t6, four
	j 	finish_check
check_5:
	lb 	$t6, five
	j 	finish_check
check_6:
	lb 	$t6, six
	j 	finish_check
check_7:
	lb 	$t6, seven
	j 	finish_check
check_8:
	lb 	$t6, eight
	j 	finish_check
check_9:
	lb 	$t6, nine
	j 	finish_check	

finish_check:
	lw 	$ra, 0($sp)
	addi 	$sp, $sp, -4
	jr 	$ra

update_tg:			
	 mul 	$t7, $t7, 10
	 add 	$t7, $t7, $t5

# hien thi 1 so  -> reset LED
done:
	beq 	$s0, 1, reset_led   	# s0 = 1 -> toan hang -> reset LED
	nop

# hien thi LEFT LED
load_to_left_led: 
	lb 	$t9, 0($sp)       	# lay bit tu stack
	add 	$sp, $sp, -4
	lb 	$t8, 0($sp)       	# lay gia tri
	add 	$sp, $sp, -4      
	add 	$s2, $t8, $zero   	# s2 = gtri cua LEFT LED
	sb 	$t9, 0($t0)       	# hien thi

# hien thi RIGHT LED
load_to_right_led:	
	sb 	$t6, 0($t1)       	# tuong tu ...
	add 	$sp, $sp,4
	sb 	$t5, 0($sp)	  
	add 	$sp, $sp,4
	sb 	$t6, 0($sp)       
	add 	$s1, $t5, $zero   
	j 	finish            

reset_led:
	li 	$s0, 0           
        li 	$t8, 0
	addi 	$sp, $sp, 4
        sb 	$t8, 0($sp)
        lb 	$t9, zero        
	addi 	$sp, $sp, 4
        sb 	$t9, 0($sp)
finish:
	j 	return
	nop

return:
	la 	$a3, loop
	mtc0 	$a3, $14
	eret

set_next_operator:
    
# tinh so thu hai
set_second_number_1: 
	addi 	$s5, $t7, 0
	beq 	$s3, 1, addition_1         	
	beq 	$s3, 2, substraction_1		
	beq 	$s3, 3, multiplication_1		
	beq 	$s3, 4, division_1		
	beq	$s3, 5, find_remainder_1		

addition_1:
	add 	$s6, $s5, $s4
	li 	$s3, 0
	li 	$t7, 0 
	j 	print_addition_1
	nop     		

print_addition_1:
	li 	$v0, 1
	move 	$a0, $s4
	syscall
	li 	$s4, 0		
	
	li 	$v0, 11
	li 	$a0, '+'
	syscall
	
	li 	$v0, 1
	move 	$a0, $s5
	syscall
	li 	$s5, 0		
	
	li 	$v0, 11
	li 	$a0, '='
	syscall
	
	li 	$v0, 1
	move 	$a0, $s6
	syscall
	nop
	
	li 	$v0, 11
	li 	$a0, '\n'
	syscall
	li 	$s7, 100
	div 	$s6, $s7
	mfhi 	$s6	    		# lay hai chua so cuoi cung cua kq
	j show_result_in_led_1		# hien thi
	nop

substraction_1:
	sub 	$s6, $s4, $s5   
	li 	$s3, 0
	li 	$t7, 0 
	j 	print_substraction_1
	nop
	
print_substraction_1:
	li 	$v0, 1
	move 	$a0, $s4
	syscall
	li 	$s4, 0		
	
	li 	$v0, 11
	li 	$a0, '-'
	syscall
	li 	$s5, 0		
	
	li 	$v0, 1
	move 	$a0, $s5
	syscall
	
	li 	$v0, 11
	li 	$a0, '='
	syscall
	
	li 	$v0, 1
	move 	$a0, $s6
	syscall
	
	li 	$v0, 55
	li 	$a0, '\n'
	syscall
	li 	$s7, 100
	div 	$s6, $s7
	mfhi 	$s6	    	
	j show_result_in_led_1	
	nop

multiplication_1:
	mul 	$s6, $s4, $s5    
	li 	$s3, 0
	li 	$t7, 0 
	j 	print_multiplication_1
	nop
	
print_multiplication_1:
	li 	$v0, 1
	move 	$a0, $s4
	syscall
	li 	$s4, 0		
	
	li 	$v0, 11
	li 	$a0, '*'
	syscall
	
	li 	$v0, 1
	move 	$a0, $s5
	syscall
	li 	$s5, 0		
	
	li 	$v0, 11
	li 	$a0, '='
	syscall
	
	li 	$v0, 1
	move 	$a0, $s6
	syscall
	
	li 	$v0, 11
	li 	$a0, '\n'
	syscall
	
	li 	$s7, 100
	div 	$s6, $s7
	mfhi 	$s6	    	
	j show_result_in_led_1    
	nop

division_1:
	beq 	$s5, 0, division_01
	li 	$s3, 0
	div 	$s4, $s5   	    
	mflo 	$s6
	mfhi 	$s7
	li 	$t7, 0 
	j 	print_division_1
	nop

# truong hop chia lay phan nguyen cho 0
division_01: 
	li 	$v0, 55
	la 	$a0, msg_1
	li 	$a1, 0
	syscall
	j 	reset_led_1

print_division_1:
	li 	$v0, 1
	move 	$a0, $s4
	syscall
	li 	$s4, 0		
	
	li 	$v0, 11
	li 	$a0, '/'
	syscall
	
	li 	$v0, 1
	move 	$a0, $s5
	syscall
	li 	$s5, 0		
	
	li 	$v0, 11
	li 	$a0, '='
	syscall
	
	li 	$v0, 1
	move 	$a0, $s6
	syscall
	
	li 	$v0, 11
	li 	$a0, '\n'
	syscall
	
	li 	$s7, 100
	div 	$s6, $s7
	mfhi 	$s6	   	
	j show_result_in_led_1  
	nop

find_remainder_1:
	beq 	$s5, 0, find_remainder_01
	li 	$s3, 0
	div 	$s4, $s5   	    
	mflo 	$s7
	mfhi 	$s6
	li 	$t7, 0 
	j 	print_find_remainder_1
	nop

# truong hop chia lay phan du cho 0
find_remainder_01: 
	li 	$v0, 55
	la 	$a0, msg_1
	li 	$a1, 0
	syscall
	j 	reset_led_1

print_find_remainder_1:
	li 	$v0, 1
	move 	$a0, $s4
	syscall
	li 	$s4, 0		
	
	li 	$v0, 11
	li 	$a0, '%'
	syscall
	
	li 	$v0, 1
	move 	$a0, $s5
	syscall
	li 	$s4, 0		
	
	li 	$v0, 11
	li 	$a0, '='
	syscall
	
	li 	$v0, 1
	move 	$a0, $s6
	syscall

	li 	$v0, 11
	li 	$a0, '\n'
	syscall
	
	li 	$s7, 100
	div 	$s6, $s7
	mfhi 	$s6		    	
	j 	show_result_in_led_1	
	nop

show_result_in_led_1:
	li 	$t8, 10		
	div 	$s6, $t8    	
	mflo 	$t5        	
	jal 	check_l1    	
	
        sb 	$t6, 0($t0)  	
     	add 	$sp, $sp, 4
	sb 	$t5, 0($sp)	
	add 	$sp, $sp, 4
	sb 	$t6, 0($sp)       	
	add 	$s2, $t5, $zero   	

	mfhi 	$t5       	
	jal 	check_l1    	
        sb 	$t6, 0($t1)  	
       	add 	$sp, $sp, 4
	sb 	$t5, 0($sp)	
	add 	$sp, $sp, 4	
	sb 	$t6, 0($sp)     	
	add 	$s1, $t5, $zero   	
        j 	reset_led_1     		
             
check_l1:
	addi 	$sp, $sp, 4
        sw 	$ra, 0($sp)
        beq 	$t5, 0, check_01		
        beq 	$t5, 1, check_11	   	
        beq 	$t5, 2, check_21		
        beq 	$t5, 3, check_31		
        beq 	$t5, 4, check_41		
        beq 	$t5, 5, check_51		
        beq 	$t5, 6, check_61		
        beq 	$t5, 7, check_71		
        beq 	$t5, 8, check_81		
        beq 	$t5, 9, check_91		
        
check_01:	
	lb 	$t6, zero    
	j 	finish_check_1
check_11:
	lb 	$t6, one
	j 	finish_check_1
check_21:
	lb 	$t6, two
	j 	finish_check_1
check_31:
	lb 	$t6, three
	j	finish_check_1
check_41:
	lb 	$t6, four
	j 	finish_check_1
check_51:
	lb 	$t6, five
	j 	finish_check_1
check_61:
	lb 	$t6, six
	j 	finish_check_1
check_71:
	lb 	$t6, seven
	j 	finish_check_1
check_81:
	lb 	$t6, eight
	j 	finish_check_1
check_91:
	lb 	$t6, nine
	j 	finish_check_1


finish_check_1:
	lw 	$ra, 0($sp)
	addi 	$sp, $sp, -4
	jr 	$ra

done_1:
	beq $s0,1,reset_led_1   
	nop

reset_led_1:
	li 	$s0, 0           
        li 	$t8, 0
	addi 	$sp, $sp, 4
        sb 	$t8, 0($sp)
        lb 	$t9, zero        
	addi 	$sp, $sp, 4
        sb 	$t9, 0($sp)
        
	beq 	$a3, 1, set_add
	nop
	
	beq 	$a3, 2, set_sub
	nop
	
	beq 	$a3, 3, set_mul
	nop
	
	beq 	$a3, 4, set_div
	nop
	
	beq	$a3, 5, set_mod
	nop
	
set_add: 
	addi 	$s3, $zero, 1
	j 	finish_1
	nop
	
set_sub: 
	addi 	$s3, $zero, 2
	j 	finish_1
	nop
	
set_mul: 
	addi 	$s3, $zero, 3
	j  	finish_1
	nop
	
set_div: 
	addi 	$s3, $zero, 4
	j 	finish_1
	nop

set_mod:
	addi	$s3, $zero, 5
	j	finish_1
	nop
        
finish_1:
	j return_1
	nop

return_1:
	la $a3, init
	mtc0 $a3, $14
	eret



