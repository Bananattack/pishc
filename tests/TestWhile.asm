L0:
# Initialize main frame pointer.
subi $fp, $sp, -112
# Return address info is always generated, but has no purpose in main.
sw $0, 0($fp)
sw $0, -4($fp)
sw $0, -8($fp)
sw $0, -12($fp) # There is no old nesting entry for the main function (since it cannot call itself recursively).
sw $fp, 0($gp) # Set nesting entry for this function to new activation record.
sw $0, -16($fp) # No t1 value worth caring about yet.
sw $0, -20($fp) # No t2 value worth caring about yet.
sw $0, -24($fp) # No t3 value worth caring about yet.
sw $0, -28($fp) # No t4 value worth caring about yet.
sw $0, -32($fp) # No t5 value worth caring about yet.
sw $0, -36($fp) # No t6 value worth caring about yet.
sw $0, -40($fp) # No t7 value worth caring about yet.
j L1
# Error handler for out-of-bounds array access
IndexOutOfBounds:
.data
IOOB1: .asciiz "Index "
IOOB2: .asciiz " is outside of array bounds "
IOOB3: .asciiz " .. "
IOOB4: .asciiz ". Abort."
.text
la $a0, IOOB1
li $v0, 4
syscall
move $a0, $t2
li $v0, 1
syscall
la $a0, IOOB2
li $v0, 4
syscall
move $a0, $t3
li $v0, 1
syscall
la $a0, IOOB3
li $v0, 4
syscall
move $a0, $t4
li $v0, 1
syscall
la $a0, IOOB4
li $v0, 4
syscall
li $v0, 10
syscall
L1:
li $t1, 3
sw $t1, -56($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -52 # Local: &x
lw $t2, -56($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L2: # Beginning of while loop
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -52 # Local: &x
sw $t1, -64($fp) # Store temp
li $t1, 3
sw $t1, -68($fp) # Store temp
lw $t2, -64($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -68($fp) # get temp
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -60($fp) # Store temp
lw $t1, -60($fp) # get temp
beq $t1, $0, L3 # Branch if we are equal to 0 (FALSE)
.data
L4: .word 71, 0
.text
la $t1, L4
sw $t1, -72($fp) # Store temp
lw $t1, -72($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
.data
L5: .word 111, 0
.text
la $t1, L5
sw $t1, -76($fp) # Store temp
lw $t1, -76($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
.data
L6: .word 116, 0
.text
la $t1, L6
sw $t1, -80($fp) # Store temp
lw $t1, -80($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
.data
L7: .word 32, 0
.text
la $t1, L7
sw $t1, -84($fp) # Store temp
lw $t1, -84($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
.data
L8: .word 104, 0
.text
la $t1, L8
sw $t1, -88($fp) # Store temp
lw $t1, -88($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
.data
L9: .word 101, 0
.text
la $t1, L9
sw $t1, -92($fp) # Store temp
lw $t1, -92($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
.data
L10: .word 114, 0
.text
la $t1, L10
sw $t1, -96($fp) # Store temp
lw $t1, -96($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
.data
L11: .word 101, 0
.text
la $t1, L11
sw $t1, -100($fp) # Store temp
lw $t1, -100($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
.data
L12: .word 10, 0
.text
la $t1, L12
sw $t1, -104($fp) # Store temp
lw $t1, -104($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
j L2# Jump to the beginning of the while loop
L3: # End of while loop
li $t1, 9
sw $t1, -108($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -52 # Local: &x
lw $t2, -108($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
# Exit the program.
li $v0, 10
syscall

