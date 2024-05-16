.eqv MONITOR_SCREEN 0x10010000
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.text
main:
	li $k0, MONITOR_SCREEN
	li $s0, 0	#i=0	
	li $s1, 0	#j=0
for_row:
	li $s1, 0	#reset j=0
for_column:
	# vi tri 0
    	mul $t0, $s0, 8          # chi so hang
    	add $t0, $t0, $s1        # chi so hang + cot
    	sll $t0, $t0, 2          # dia chi byte
    	# to mau
    	beq $t0, $zero, set_white # o dau tien = white
    	andi $t1, $s0, 1          # hang chan or le
    	andi $t2, $s1, 1          # cot chan or le 
    	bne $t1, $t2, set_blue    # hang # cot -> xanh 
set_white:
	li $t3, WHITE
        sw $t3, 0($k0)     # to mau trang
        j end
set_blue:
        li $t3, BLUE
        sw $t3, 0($k0)     # to mau xanh
end:
    	# next
    	addi $k0, $k0, 4
    	# j++
    	addi $s1, $s1, 1
    	blt $s1, 8, for_column     
    	# i++
    	addi $s0, $s0, 1
    	blt $s0, 8, for_row      
    	# exit
    	li $v0, 10
    	syscall
