L0:
# Initialize main frame pointer.
subi $fp, $sp, -88
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
L2: # Beginning of while loop
li $t1, 1
sw $t1, -56($fp) # Store temp
lw $t1, -56($fp) # get temp
beq $t1, $0, L3 # Branch if we are equal to 0 (FALSE)
lw $t1, 0($gp) # Get stackframe for adder
addi $t1, $t1, -48 # Local: &a
sw $t1, -60($fp) # Store temp
addi $t1, $fp, -60 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
li $v0, 5 # Service: read int
syscall # call readint
sw $v0, 0($t1) # store int we read at address of arg
lw $t1, 0($gp) # Get stackframe for adder
addi $t1, $t1, -52 # Local: &b
sw $t1, -64($fp) # Store temp
addi $t1, $fp, -64 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
li $v0, 5 # Service: read int
syscall # call readint
sw $v0, 0($t1) # store int we read at address of arg
.data # String literal as words (written in reverse).
.word 0, 32, 62, 45
L4: .word 45
.text
la $t1, L4
sw $t1, -68($fp) # Store temp
addi $t1, $fp, -68 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L5: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L6# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L5# go to top of loop
L6: # done!
lw $t1, 0($gp) # Get stackframe for adder
addi $t1, $t1, -48 # Local: &a
sw $t1, -76($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for adder
addi $t1, $t1, -52 # Local: &b
sw $t1, -80($fp) # Store temp
lw $t2, -76($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -80($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
add $t1, $t2, $t3
sw $t1, -72($fp) # Store temp
lw $t1, -72($fp) # get temp
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L7: .word 10
.text
la $t1, L7
sw $t1, -84($fp) # Store temp
addi $t1, $fp, -84 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L8: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L9# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L8# go to top of loop
L9: # done!
j L2# Jump to the beginning of the while loop
L3: # End of while loop
# Exit the program.
li $v0, 10
syscall

