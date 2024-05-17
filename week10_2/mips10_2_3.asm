.eqv KEY_CODE 0xFFFF0004
.eqv KEY_READY 0xFFFF0000
.eqv DISPLAY_CODE 0xFFFF000C
.eqv DISPLAY_READY 0xFFFF0008

.eqv MOVING 0xFFFF8050
.eqv LEAVETRACK 0xFFFF8020
.eqv HEADING 0xFFFF8010

.text
    li $k0, KEY_CODE
    li $k1, KEY_READY
    li $s0, DISPLAY_CODE
    li $s1, DISPLAY_READY
    li $t3, 0

loop:
    nop

WaitForKey:
    lw $t1, 0($k1)
    beq $t1, $zero, WaitForKey

ReadKey:
    lw $t0, 0($k0)

WaitForDis:
    lw $t2, 0($s1)
    beq $t2, $zero, WaitForDis

    sw $t0, 0($s0)
    nop

    li $t4, 32
    beq $t0, $t4, ToggleMove

    li $t4, 87
    beq $t0, $t4, MoveUp
    li $t4, 119
    beq $t0, $t4, MoveUp

    li $t4, 83
    beq $t0, $t4, MoveDown
    li $t4, 115
    beq $t0, $t4, MoveDown

    li $t4, 65
    beq $t0, $t4, MoveLeft
    li $t4, 97
    beq $t0, $t4, MoveLeft

    li $t4, 68
    beq $t0, $t4, MoveRight
    li $t4, 100
    beq $t0, $t4, MoveRight

    j loop

ToggleMove:
    beq $t3, $zero, StartMoving
    j StopMoving

StartMoving:
    li $at, LEAVETRACK
    li $v0, 1
    sb $v0, 0($at)
    li $at, MOVING
    sb $v0, 0($at)
    li $t3, 1
    j loop

StopMoving:
    li $at, LEAVETRACK
    sb $zero, 0($at)
    li $at, MOVING
    sb $zero, 0($at)
    li $t3, 0
    j loop

MoveUp:
    li $a0, 0
    j SetHeading

MoveDown:
    li $a0, 180
    j SetHeading

MoveLeft:
    li $a0, 270
    j SetHeading

MoveRight:
    li $a0, 90

SetHeading:
    li $at, HEADING
    sw $a0, 0($at)
    j loop

End:
    li $v0, 10
    syscall
