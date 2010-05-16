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
L2:
# Function factorial
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L3
L3:
 # Beginning of if statement
lw $t1, 4($gp) # Get stackframe for factorial
lw $t1, -52($t1) # Argument: &*n
sw $t1, -64($fp) # Store temp
li $t1, 0
sw $t1, -68($fp) # Store temp
lw $t2, -64($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -68($fp) # get temp
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -60($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for factorial
lw $t1, -52($t1) # Argument: &*n
sw $t1, -76($fp) # Store temp
li $t1, 1
sw $t1, -80($fp) # Store temp
lw $t2, -76($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -80($fp) # get temp
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -72($fp) # Store temp
lw $t2, -60($fp) # get temp
lw $t3, -72($fp) # get temp
add $t1, $t2, $t3
sw $t1, -56($fp) # Store temp
lw $t1, -56($fp) # get temp
beq $t1, $0, L4 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
li $t1, 1
sw $t1, -84($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for factorial
lw $t1, -48($t1) # Argument: &*ret
lw $t2, -84($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
j L5# Jump to the end of the if
L4: # Else statement 
lw $t1, 4($gp) # Get stackframe for factorial
lw $t1, -48($t1) # Argument: &*ret
sw $t1, -88($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for factorial
lw $t1, -52($t1) # Argument: &*n
sw $t1, -96($fp) # Store temp
li $t1, 1
sw $t1, -100($fp) # Store temp
lw $t2, -96($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -100($fp) # get temp
sub $t1, $t2, $t3
sw $t1, -92($fp) # Store temp
# Call function factorial.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 4($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 4($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -88 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
addi $t1, $fp, -92 # get address of temp
sw $t1, -52($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 116 # expand stack
la $t7, L2 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, 4($gp) # Get stackframe for factorial
lw $t1, -48($t1) # Argument: &*ret
sw $t1, -108($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for factorial
lw $t1, -52($t1) # Argument: &*n
sw $t1, -112($fp) # Store temp
lw $t2, -108($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -112($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
mul $t1, $t2, $t3
sw $t1, -104($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for factorial
lw $t1, -48($t1) # Argument: &*ret
lw $t2, -104($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L5: # End of if statement
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 4($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L6:
# Function fibonacci
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L7
L7:
 # Beginning of if statement
lw $t1, 8($gp) # Get stackframe for fibonacci
lw $t1, -48($t1) # Argument: &*n
sw $t1, -60($fp) # Store temp
li $t1, 1
sw $t1, -64($fp) # Store temp
lw $t2, -60($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -64($fp) # get temp
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -56($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for fibonacci
lw $t1, -48($t1) # Argument: &*n
sw $t1, -72($fp) # Store temp
li $t1, 2
sw $t1, -76($fp) # Store temp
lw $t2, -72($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -76($fp) # get temp
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -68($fp) # Store temp
lw $t2, -56($fp) # get temp
lw $t3, -68($fp) # get temp
add $t1, $t2, $t3
sw $t1, -52($fp) # Store temp
lw $t1, -52($fp) # get temp
beq $t1, $0, L8 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
li $t1, 1
sw $t1, -80($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for fibonacci
addi $t1, $t1, -44 # Local: &fibonacci
lw $t2, -80($fp) # get temp
sw $t2, 0($t1) # Store value into the function return value
j L9# Jump to the end of the if
L8: # Else statement 
lw $t1, 8($gp) # Get stackframe for fibonacci
lw $t1, -48($t1) # Argument: &*n
sw $t1, -96($fp) # Store temp
li $t1, 1
sw $t1, -100($fp) # Store temp
lw $t2, -96($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -100($fp) # get temp
sub $t1, $t2, $t3
sw $t1, -92($fp) # Store temp
# Call function fibonacci.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 8($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 8($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -92 # get address of temp
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 120 # expand stack
la $t7, L6 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
sw $t1, -88($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for fibonacci
lw $t1, -48($t1) # Argument: &*n
sw $t1, -112($fp) # Store temp
li $t1, 2
sw $t1, -116($fp) # Store temp
lw $t2, -112($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -116($fp) # get temp
sub $t1, $t2, $t3
sw $t1, -108($fp) # Store temp
# Call function fibonacci.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 8($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 8($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -108 # get address of temp
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 120 # expand stack
la $t7, L6 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
sw $t1, -104($fp) # Store temp
lw $t2, -88($fp) # get temp
lw $t3, -104($fp) # get temp
add $t1, $t2, $t3
sw $t1, -84($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for fibonacci
addi $t1, $t1, -44 # Local: &fibonacci
lw $t2, -84($fp) # get temp
sw $t2, 0($t1) # Store value into the function return value
L9: # End of if statement
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 8($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L1:
li $t1, 0
sw $t1, -60($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testrecursion
addi $t1, $t1, -48 # Local: &calc
lw $t2, -60($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
# Beginning of for loop
li $t1, 1
sw $t1, -64($fp) # Store temp
li $t1, 10
sw $t1, -68($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testrecursion
addi $t1, $t1, -52 # Local: &num
lw $t2, -64($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L10: # Start the for loop
lw $t2, -68($fp) # get temp
lw $t1, 0($gp) # Get stackframe for testrecursion
addi $t1, $t1, -52 # Local: &num
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L11 # Jump to the end if we are done, increasing
lw $t1, 0($gp) # Get stackframe for testrecursion
addi $t1, $t1, -48 # Local: &calc
sw $t1, -72($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testrecursion
addi $t1, $t1, -52 # Local: &num
sw $t1, -76($fp) # Store temp
# Call function factorial.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 4($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 4($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -72 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
addi $t1, $fp, -76 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -52($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 116 # expand stack
la $t7, L2 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, 0($gp) # Get stackframe for testrecursion
addi $t1, $t1, -48 # Local: &calc
sw $t1, -80($fp) # Store temp
lw $t1, -80($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L12: .word 32
.text
la $t1, L12
sw $t1, -84($fp) # Store temp
lw $t1, -84($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
lw $t1, 0($gp) # Get stackframe for testrecursion
addi $t1, $t1, -52 # Local: &num
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L10 # Return to the start label
L11: # End of for loop
.data # String literal as words (written in reverse).
.word 0
L13: .word 10
.text
la $t1, L13
sw $t1, -88($fp) # Store temp
lw $t1, -88($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
# Beginning of for loop
li $t1, 1
sw $t1, -92($fp) # Store temp
li $t1, 10
sw $t1, -96($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testrecursion
addi $t1, $t1, -52 # Local: &num
lw $t2, -92($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L14: # Start the for loop
lw $t2, -96($fp) # get temp
lw $t1, 0($gp) # Get stackframe for testrecursion
addi $t1, $t1, -52 # Local: &num
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L15 # Jump to the end if we are done, increasing
lw $t1, 0($gp) # Get stackframe for testrecursion
addi $t1, $t1, -52 # Local: &num
sw $t1, -104($fp) # Store temp
# Call function fibonacci.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 8($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 8($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -104 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 120 # expand stack
la $t7, L6 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
sw $t1, -100($fp) # Store temp
lw $t1, -100($fp) # get temp
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L16: .word 32
.text
la $t1, L16
sw $t1, -108($fp) # Store temp
lw $t1, -108($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
lw $t1, 0($gp) # Get stackframe for testrecursion
addi $t1, $t1, -52 # Local: &num
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L14 # Return to the start label
L15: # End of for loop
.data # String literal as words (written in reverse).
.word 0
L17: .word 10
.text
la $t1, L17
sw $t1, -112($fp) # Store temp
lw $t1, -112($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
# Exit the program.
li $v0, 10
syscall

