.eqv HEADING 0xffff8010 
.eqv MOVING 0xffff8050 
.eqv LEAVETRACK 0xffff8020 
.eqv WHEREX 0xffff8030 
.eqv WHEREY 0xffff8040 
.text
main: 
	jal UNTRACK # draw track line
	addi $a0, $zero, 90 # Marsbot rotates 90* and start
	jal ROTATE
	jal GO
sleep1: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,5000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
goDOWN: 
	addi $a0, $zero, 180 # Marsbot rotates 180*
	jal UNTRACK
	jal ROTATE
sleep2: 
	addi $v0,$zero,32 # Keep running by sleeping in 2000 ms
	li $a0,5000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
	
# ve tam giac
canh_1: 
	addi $a0, $zero, 150 # Marsbot rotates 270*
	jal ROTATE
sleep3: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
canh_2:
	addi $a0, $zero, 270 # Marsbot rotates 120*
	jal ROTATE
	
sleep4: 
	addi $v0,$zero,32 # Keep running by sleeping in 2000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
canh_3:
	addi $a0, $zero, 30 # Marsbot rotates 120*
	jal ROTATE
sleep5: 
	addi $v0,$zero,32 # Keep running by sleeping in 2000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
	
# ve hinh vuong
tieptuc1:
	jal UNTRACK # draw track line
	addi $a0, $zero, 90 # Marsbot rotates 90* and start
	jal ROTATE
	jal GO
sleep6: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,5000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
canh_1_hv: 
	addi $a0, $zero, 90 # Marsbot rotates 270*
	jal ROTATE
sleep7: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
canh_2_hv: 
	addi $a0, $zero, 180 # Marsbot rotates 270*
	jal ROTATE
sleep8: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
canh_3_hv: 
	addi $a0, $zero, 270 # Marsbot rotates 270*
	jal ROTATE
sleep9: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
canh_4_hv: 
	addi $a0, $zero, 360 # Marsbot rotates 270*
	jal ROTATE
sleep10: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
	
# ve hinh ngoi sao 
tieptuc2:
	jal UNTRACK # draw track line
	addi $a0, $zero, 90 # Marsbot rotates 90* and start
	jal ROTATE
	jal GO
slee11: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,8000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
canh_1_sao: 
	addi $a0, $zero, 198 # Marsbot rotates 270*
	jal ROTATE
sleep11: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
canh_2_sao: 
	addi $a0, $zero, 54 # Marsbot rotates 270*
	jal ROTATE
sleep12: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
canh_3_sao: 
	addi $a0, $zero, 270 # Marsbot rotates 270*
	jal ROTATE
sleep13: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
canh_4_sao: 
	addi $a0, $zero, 126 # Marsbot rotates 270*
	jal ROTATE
sleep14: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
canh_5_sao: 
	addi $a0, $zero, 343 # Marsbot rotates 270*
	jal ROTATE
sleep15: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
tieptuc3:
	jal UNTRACK # draw track line
	addi $a0, $zero, 90 # Marsbot rotates 90* and start
	jal ROTATE
	jal GO
slee16: 
	addi $v0,$zero,32 # Keep running by sleeping in 1000 ms
	li $a0,2000
	syscall
	jal UNTRACK # keep old track
	jal TRACK # and draw new track line
	
end_main:
	jal STOP 
	li $v0, 10
	syscall
GO: 
	li $at, MOVING # change MOVING port
	addi $k0, $zero,1 # to logic 1,
	sb $k0, 0($at) # to start running
	jr $ra
STOP: 
	li $at, MOVING # change MOVING port to 0
	sb $zero, 0($at) # to stop
	jr $ra
TRACK: 
	li $at, LEAVETRACK # change LEAVETRACK port
	addi $k0, $zero,1 # to logic 1,
	sb $k0, 0($at) # to start tracking
	jr $ra
UNTRACK:
	li $at, LEAVETRACK # change LEAVETRACK port to 0
	sb $zero, 0($at) # to stop drawing tail
	jr $ra
ROTATE: 
	li $at, HEADING # change HEADING port
	sw $a0, 0($at) # to rotate robot
	jr $ra
