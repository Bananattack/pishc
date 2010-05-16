L0:
# Initialize main frame pointer.
subi $fp, $sp, -116
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
li $t1, 5
sw $t1, -56($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -52 # Local: &x
lw $t2, -56($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
# Beginning of for loop
li $t1, 1
sw $t1, -60($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -52 # Local: &x
sw $t1, -68($fp) # Store temp
li $t1, 1
sw $t1, -72($fp) # Store temp
lw $t2, -68($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -72($fp) # get temp
sub $t1, $t2, $t3
sw $t1, -64($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -44 # Local: &a
lw $t2, -60($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L2: # Start the for loop
lw $t2, -64($fp) # get temp
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -44 # Local: &a
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L3 # Jump to the end if we are done, increasing
li $t1, 10
sw $t1, -76($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -52 # Local: &x
lw $t2, -76($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -44 # Local: &a
sw $t1, -80($fp) # Store temp
lw $t1, -80($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data
L4: .word 10, 0
.text
la $t1, L4
sw $t1, -84($fp) # Store temp
lw $t1, -84($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -44 # Local: &a
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L2 # Return to the start label
L3: # End of for loop
.data
L5: .word 10, 0
.text
la $t1, L5
sw $t1, -88($fp) # Store temp
lw $t1, -88($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
li $t1, 10
sw $t1, -96($fp) # Store temp
lw $t2, -96($fp) # get temp
sub $t1, $0, $t2
sw $t1, -92($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -52 # Local: &x
lw $t2, -92($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
# Beginning of for loop
li $t1, 3
sw $t1, -100($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -52 # Local: &x
sw $t1, -104($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -44 # Local: &a
lw $t2, -100($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L6: # Start the for loop
lw $t2, -104($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -44 # Local: &a
lw $t1, 0($t1) # Load the number into the register
blt $t1, $t2, L7 # Jump to the end if we are done, decreasing
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -44 # Local: &a
sw $t1, -108($fp) # Store temp
lw $t1, -108($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data
L8: .word 10, 0
.text
la $t1, L8
sw $t1, -112($fp) # Store temp
lw $t1, -112($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
lw $t1, 0($gp) # Get stackframe for testforloop
addi $t1, $t1, -44 # Local: &a
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, -1 # Decrement by 1
sw $t2, 0($t1) # Save the value 
j L6 # Return to the start label
L7: # End of for loop
# Exit the program.
li $v0, 10
syscall

