L0:
# Initialize main frame pointer.
subi $fp, $sp, -2264
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
# Function gettile
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L3
L3:
 # Beginning of if statement
# Array index (subscript #1 - part one)
lw $t1, 4($gp) # Get stackframe for gettile
lw $t1, -48($t1) # Argument: &*i
sw $t1, -68($fp) # Store temp
# Array index (subscript #2 - part one)
lw $t1, 4($gp) # Get stackframe for gettile
lw $t1, -52($t1) # Argument: &*j
sw $t1, -72($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -48 # Local: &board
addi $t1, $t1, -0 # Get attribute grid
# Array index (subscript #1 - part two)
lw $t2, -68($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 52 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
# Array index (subscript #2 - part two)
lw $t2, -72($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 13 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -64($fp) # Store temp
lw $t1, -64($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
beq $t1, $0, L4 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
.data # String literal as words (written in reverse).
.word 0
L6: .word 46
.text
la $t1, L6
sw $t1, -76($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -56 # Local: &ch
lw $t2, -76($fp) # get temp
lw $t2, 0($t2) # deref temp to get string
sw $t2, 0($t1) # Store value into a variable
j L5# Jump to the end of the if
L4: # Else statement 
.data # String literal as words (written in reverse).
.word 0
L7: .word 95
.text
la $t1, L7
sw $t1, -80($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -56 # Local: &ch
lw $t2, -80($fp) # get temp
lw $t2, 0($t2) # deref temp to get string
sw $t2, 0($t1) # Store value into a variable
L5: # End of if statement
# Beginning of for loop
li $t1, 1
sw $t1, -84($fp) # Store temp
li $t1, 25
sw $t1, -88($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -60 # Local: &h
lw $t2, -84($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L8: # Start the for loop
lw $t2, -88($fp) # get temp
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -60 # Local: &h
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L9 # Jump to the end if we are done, increasing
 # Beginning of if statement
lw $t1, 4($gp) # Get stackframe for gettile
lw $t1, -48($t1) # Argument: &*i
sw $t1, -100($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -60 # Local: &h
sw $t1, -108($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -108($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -104($fp) # Store temp
lw $t2, -100($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -104($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -96($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for gettile
lw $t1, -52($t1) # Argument: &*j
sw $t1, -116($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -60 # Local: &h
sw $t1, -124($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -124($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -120($fp) # Store temp
lw $t2, -116($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -120($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -112($fp) # Store temp
lw $t2, -96($fp) # get temp
lw $t3, -112($fp) # get temp
and $t1, $t2, $t3
sw $t1, -92($fp) # Store temp
lw $t1, -92($fp) # get temp
beq $t1, $0, L11 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
.data # String literal as words (written in reverse).
.word 0
L12: .word 72
.text
la $t1, L12
sw $t1, -128($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -56 # Local: &ch
lw $t2, -128($fp) # get temp
lw $t2, 0($t2) # deref temp to get string
sw $t2, 0($t1) # Store value into a variable
L11: # End of if statement
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -60 # Local: &h
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L8 # Return to the start label
L9: # End of for loop
 # Beginning of if statement
lw $t1, 4($gp) # Get stackframe for gettile
lw $t1, -48($t1) # Argument: &*i
sw $t1, -140($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -0 # Get attribute x
sw $t1, -144($fp) # Store temp
lw $t2, -140($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -144($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -136($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for gettile
lw $t1, -52($t1) # Argument: &*j
sw $t1, -152($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -4 # Get attribute y
sw $t1, -156($fp) # Store temp
lw $t2, -152($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -156($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -148($fp) # Store temp
lw $t2, -136($fp) # get temp
lw $t3, -148($fp) # get temp
and $t1, $t2, $t3
sw $t1, -132($fp) # Store temp
lw $t1, -132($fp) # get temp
beq $t1, $0, L14 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
 # Beginning of if statement
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -56 # Local: &ch
sw $t1, -164($fp) # Store temp
.data # String literal as words (written in reverse).
.word 0
L17: .word 72
.text
la $t1, L17
sw $t1, -168($fp) # Store temp
lw $t2, -164($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -168($fp) # get temp
lw $t3, 0($t3) # deref temp to get string
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -160($fp) # Store temp
lw $t1, -160($fp) # get temp
beq $t1, $0, L15 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
.data # String literal as words (written in reverse).
.word 0
L18: .word 79
.text
la $t1, L18
sw $t1, -172($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -56 # Local: &ch
lw $t2, -172($fp) # get temp
lw $t2, 0($t2) # deref temp to get string
sw $t2, 0($t1) # Store value into a variable
j L16# Jump to the end of the if
L15: # Else statement 
.data # String literal as words (written in reverse).
.word 0
L19: .word 80
.text
la $t1, L19
sw $t1, -176($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -56 # Local: &ch
lw $t2, -176($fp) # get temp
lw $t2, 0($t2) # deref temp to get string
sw $t2, 0($t1) # Store value into a variable
L16: # End of if statement
L14: # End of if statement
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -56 # Local: &ch
sw $t1, -180($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for gettile
addi $t1, $t1, -44 # Local: &gettile
lw $t2, -180($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into the function return value
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

L20:
# Function printboard
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L21
L21:
# Beginning of for loop
li $t1, 1
sw $t1, -56($fp) # Store temp
li $t1, 13
sw $t1, -60($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for printboard
addi $t1, $t1, -52 # Local: &j
lw $t2, -56($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L22: # Start the for loop
lw $t2, -60($fp) # get temp
lw $t1, 8($gp) # Get stackframe for printboard
addi $t1, $t1, -52 # Local: &j
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L23 # Jump to the end if we are done, increasing
# Beginning of for loop
li $t1, 1
sw $t1, -64($fp) # Store temp
li $t1, 30
sw $t1, -68($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for printboard
addi $t1, $t1, -48 # Local: &i
lw $t2, -64($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L24: # Start the for loop
lw $t2, -68($fp) # get temp
lw $t1, 8($gp) # Get stackframe for printboard
addi $t1, $t1, -48 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L25 # Jump to the end if we are done, increasing
lw $t1, 8($gp) # Get stackframe for printboard
addi $t1, $t1, -48 # Local: &i
sw $t1, -76($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for printboard
addi $t1, $t1, -52 # Local: &j
sw $t1, -80($fp) # Store temp
# Call function gettile.
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
addi $t1, $fp, -76 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
addi $t1, $fp, -80 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -52($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 184 # expand stack
la $t7, L2 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
sw $t1, -72($fp) # Store temp
lw $t1, -72($fp) # get temp
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
lw $t1, 8($gp) # Get stackframe for printboard
addi $t1, $t1, -48 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L24 # Return to the start label
L25: # End of for loop
.data # String literal as words (written in reverse).
.word 0
L26: .word 10
.text
la $t1, L26
sw $t1, -84($fp) # Store temp
lw $t1, -84($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
lw $t1, 8($gp) # Get stackframe for printboard
addi $t1, $t1, -52 # Local: &j
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L22 # Return to the start label
L23: # End of for loop
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

L27:
# Function update
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L28
L28:
li $t1, 1
sw $t1, -56($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1816 # Local: &won
lw $t2, -56($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
# Beginning of for loop
li $t1, 1
sw $t1, -60($fp) # Store temp
li $t1, 25
sw $t1, -64($fp) # Store temp
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
lw $t2, -60($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L29: # Start the for loop
lw $t2, -64($fp) # get temp
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L30 # Jump to the end if we are done, increasing
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -76($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -76($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -72($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -0 # Get attribute x
sw $t1, -80($fp) # Store temp
lw $t2, -72($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -80($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
slt $t1, $t2, $t3
sw $t1, -68($fp) # Store temp
lw $t1, -68($fp) # get temp
beq $t1, $0, L31 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -96($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -96($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -92($fp) # Store temp
li $t1, 1
sw $t1, -100($fp) # Store temp
lw $t2, -92($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -100($fp) # get temp
add $t1, $t2, $t3
sw $t1, -88($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -84($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -84($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
lw $t2, -88($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
j L32# Jump to the end of the if
L31: # Else statement 
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -112($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -112($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -108($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -0 # Get attribute x
sw $t1, -116($fp) # Store temp
lw $t2, -108($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -116($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
slt $t1, $t3, $t2
sw $t1, -104($fp) # Store temp
lw $t1, -104($fp) # get temp
beq $t1, $0, L33 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -132($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -132($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -128($fp) # Store temp
li $t1, 1
sw $t1, -136($fp) # Store temp
lw $t2, -128($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -136($fp) # get temp
sub $t1, $t2, $t3
sw $t1, -124($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -120($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -120($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
lw $t2, -124($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
j L34# Jump to the end of the if
L33: # Else statement 
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -148($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -148($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -144($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -4 # Get attribute y
sw $t1, -152($fp) # Store temp
lw $t2, -144($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -152($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
slt $t1, $t2, $t3
sw $t1, -140($fp) # Store temp
lw $t1, -140($fp) # get temp
beq $t1, $0, L35 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -168($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -168($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -164($fp) # Store temp
li $t1, 1
sw $t1, -172($fp) # Store temp
lw $t2, -164($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -172($fp) # get temp
add $t1, $t2, $t3
sw $t1, -160($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -156($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -156($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
lw $t2, -160($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
j L36# Jump to the end of the if
L35: # Else statement 
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -184($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -184($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -180($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -4 # Get attribute y
sw $t1, -188($fp) # Store temp
lw $t2, -180($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -188($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
slt $t1, $t3, $t2
sw $t1, -176($fp) # Store temp
lw $t1, -176($fp) # get temp
beq $t1, $0, L38 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -204($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -204($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -200($fp) # Store temp
li $t1, 1
sw $t1, -208($fp) # Store temp
lw $t2, -200($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -208($fp) # get temp
sub $t1, $t2, $t3
sw $t1, -196($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -192($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -192($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
lw $t2, -196($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L38: # End of if statement
L36: # End of if statement
L34: # End of if statement
L32: # End of if statement
# Beginning of for loop
li $t1, 1
sw $t1, -212($fp) # Store temp
li $t1, 25
sw $t1, -216($fp) # Store temp
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -52 # Local: &j
lw $t2, -212($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L39: # Start the for loop
lw $t2, -216($fp) # get temp
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -52 # Local: &j
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L40 # Jump to the end if we are done, increasing
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -232($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -232($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -228($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -52 # Local: &j
sw $t1, -240($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -240($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -236($fp) # Store temp
lw $t2, -228($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -236($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltu $t1, $0, $t1
sw $t1, -224($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -252($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -252($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -248($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -52 # Local: &j
sw $t1, -260($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -260($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -256($fp) # Store temp
lw $t2, -248($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -256($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltu $t1, $0, $t1
sw $t1, -244($fp) # Store temp
lw $t2, -224($fp) # get temp
lw $t3, -244($fp) # get temp
add $t1, $t2, $t3
sw $t1, -220($fp) # Store temp
lw $t1, -220($fp) # get temp
beq $t1, $0, L42 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
li $t1, 0
sw $t1, -264($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1816 # Local: &won
lw $t2, -264($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L42: # End of if statement
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -52 # Local: &j
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L39 # Return to the start label
L40: # End of for loop
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -280($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -280($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -276($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -0 # Get attribute x
sw $t1, -284($fp) # Store temp
lw $t2, -276($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -284($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltu $t1, $0, $t1
sw $t1, -272($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
sw $t1, -296($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -296($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -292($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -4 # Get attribute y
sw $t1, -300($fp) # Store temp
lw $t2, -292($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -300($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltu $t1, $0, $t1
sw $t1, -288($fp) # Store temp
lw $t2, -272($fp) # get temp
lw $t3, -288($fp) # get temp
add $t1, $t2, $t3
sw $t1, -268($fp) # Store temp
lw $t1, -268($fp) # get temp
beq $t1, $0, L44 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
li $t1, 0
sw $t1, -304($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1816 # Local: &won
lw $t2, -304($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L44: # End of if statement
lw $t1, 12($gp) # Get stackframe for update
addi $t1, $t1, -48 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L29 # Return to the start label
L30: # End of for loop
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 12($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L1:
li $t1, 0
sw $t1, -1836($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1816 # Local: &won
lw $t2, -1836($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
# Beginning of for loop
li $t1, 1
sw $t1, -1840($fp) # Store temp
li $t1, 25
sw $t1, -1844($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t2, -1840($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L45: # Start the for loop
lw $t2, -1844($fp) # get temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L46 # Jump to the end if we are done, increasing
li $t1, 0
sw $t1, -1852($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
sw $t1, -1848($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -1848($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
lw $t2, -1852($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
li $t1, 0
sw $t1, -1860($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
sw $t1, -1856($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -1856($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
lw $t2, -1860($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L45 # Return to the start label
L46: # End of for loop
# Beginning of for loop
li $t1, 1
sw $t1, -1864($fp) # Store temp
li $t1, 25
sw $t1, -1868($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t2, -1864($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L47: # Start the for loop
lw $t2, -1868($fp) # get temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L48 # Jump to the end if we are done, increasing
li $t1, 0
sw $t1, -1872($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1832 # Local: &done
lw $t2, -1872($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L49: # Beginning of while loop
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1832 # Local: &done
sw $t1, -1880($fp) # Store temp
lw $t2, -1880($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sltiu $t1, $t2, 1
sw $t1, -1876($fp) # Store temp
lw $t1, -1876($fp) # get temp
beq $t1, $0, L50 # Branch if we are equal to 0 (FALSE)
li $a0, 0 # seed id 0
li $v0, 41 # Service: random
syscall
move $t1, $a0 # load result
andi $t1, $t1, 0x7fffffff # mask off sign bit
sw $t1, -1904($fp) # Store temp
.data
L51: .float 2.14748e+09
.text
l.s $f4, L51
swc1 $f4, -1908($fp) # Store temp
lw $t2, -1904($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -1908
l.s $f8, 0($t3)
div.s $f4, $f6, $f8
swc1 $f4, -1900($fp) # Store temp
li $t1, 30
sw $t1, -1912($fp) # Store temp
addi $t2, $fp, -1900
l.s $f6, 0($t2)
lw $t3, -1912($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
mul.s $f4, $f6, $f8
swc1 $f4, -1896($fp) # Store temp
addi $t1, $fp, -1896
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -1892($fp) # Store temp
li $t1, 1
sw $t1, -1916($fp) # Store temp
lw $t2, -1892($fp) # get temp
lw $t3, -1916($fp) # get temp
add $t1, $t2, $t3
sw $t1, -1888($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
sw $t1, -1884($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -1884($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
lw $t2, -1888($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
li $a0, 0 # seed id 0
li $v0, 41 # Service: random
syscall
move $t1, $a0 # load result
andi $t1, $t1, 0x7fffffff # mask off sign bit
sw $t1, -1940($fp) # Store temp
.data
L52: .float 2.14748e+09
.text
l.s $f4, L52
swc1 $f4, -1944($fp) # Store temp
lw $t2, -1940($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -1944
l.s $f8, 0($t3)
div.s $f4, $f6, $f8
swc1 $f4, -1936($fp) # Store temp
li $t1, 13
sw $t1, -1948($fp) # Store temp
addi $t2, $fp, -1936
l.s $f6, 0($t2)
lw $t3, -1948($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
mul.s $f4, $f6, $f8
swc1 $f4, -1932($fp) # Store temp
addi $t1, $fp, -1932
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -1928($fp) # Store temp
li $t1, 1
sw $t1, -1952($fp) # Store temp
lw $t2, -1928($fp) # get temp
lw $t3, -1952($fp) # get temp
add $t1, $t2, $t3
sw $t1, -1924($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
sw $t1, -1920($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -1920($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
lw $t2, -1924($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
li $t1, 1
sw $t1, -1956($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1832 # Local: &done
lw $t2, -1956($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
# Beginning of for loop
li $t1, 1
sw $t1, -1960($fp) # Store temp
li $t1, 25
sw $t1, -1964($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
lw $t2, -1960($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L53: # Start the for loop
lw $t2, -1964($fp) # get temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L54 # Jump to the end if we are done, increasing
 # Beginning of if statement
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
sw $t1, -1980($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
sw $t1, -1984($fp) # Store temp
lw $t2, -1980($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -1984($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltu $t1, $0, $t1
sw $t1, -1976($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
sw $t1, -1996($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -1996($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -1992($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
sw $t1, -2004($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -2004($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -2000($fp) # Store temp
lw $t2, -1992($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -2000($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -1988($fp) # Store temp
lw $t2, -1976($fp) # get temp
lw $t3, -1988($fp) # get temp
and $t1, $t2, $t3
sw $t1, -1972($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
sw $t1, -2016($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -2016($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -2012($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
sw $t1, -2024($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -2024($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -2020($fp) # Store temp
lw $t2, -2012($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -2020($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -2008($fp) # Store temp
lw $t2, -1972($fp) # get temp
lw $t3, -2008($fp) # get temp
and $t1, $t2, $t3
sw $t1, -1968($fp) # Store temp
lw $t1, -1968($fp) # get temp
beq $t1, $0, L56 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
li $t1, 0
sw $t1, -2028($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1832 # Local: &done
lw $t2, -2028($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L56: # End of if statement
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L53 # Return to the start label
L54: # End of for loop
j L49# Jump to the beginning of the while loop
L50: # End of while loop
.data # String literal as words (written in reverse).
.word 0
L57: .word 40
.text
la $t1, L57
sw $t1, -2032($fp) # Store temp
addi $t1, $fp, -2032 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L58: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L59# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L58# go to top of loop
L59: # done!
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
sw $t1, -2040($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -2040($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -2036($fp) # Store temp
lw $t1, -2036($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 32
L60: .word 44
.text
la $t1, L60
sw $t1, -2044($fp) # Store temp
addi $t1, $fp, -2044 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L61: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L62# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L61# go to top of loop
L62: # done!
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
sw $t1, -2052($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -2052($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -2048($fp) # Store temp
lw $t1, -2048($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 10
L63: .word 41
.text
la $t1, L63
sw $t1, -2056($fp) # Store temp
addi $t1, $fp, -2056 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L64: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L65# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L64# go to top of loop
L65: # done!
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L47 # Return to the start label
L48: # End of for loop
li $t1, 0
sw $t1, -2060($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1832 # Local: &done
lw $t2, -2060($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L66: # Beginning of while loop
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1832 # Local: &done
sw $t1, -2068($fp) # Store temp
lw $t2, -2068($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sltiu $t1, $t2, 1
sw $t1, -2064($fp) # Store temp
lw $t1, -2064($fp) # get temp
beq $t1, $0, L67 # Branch if we are equal to 0 (FALSE)
li $a0, 0 # seed id 0
li $v0, 41 # Service: random
syscall
move $t1, $a0 # load result
andi $t1, $t1, 0x7fffffff # mask off sign bit
sw $t1, -2088($fp) # Store temp
.data
L68: .float 2.14748e+09
.text
l.s $f4, L68
swc1 $f4, -2092($fp) # Store temp
lw $t2, -2088($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -2092
l.s $f8, 0($t3)
div.s $f4, $f6, $f8
swc1 $f4, -2084($fp) # Store temp
li $t1, 30
sw $t1, -2096($fp) # Store temp
addi $t2, $fp, -2084
l.s $f6, 0($t2)
lw $t3, -2096($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
mul.s $f4, $f6, $f8
swc1 $f4, -2080($fp) # Store temp
addi $t1, $fp, -2080
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -2076($fp) # Store temp
li $t1, 1
sw $t1, -2100($fp) # Store temp
lw $t2, -2076($fp) # get temp
lw $t3, -2100($fp) # get temp
add $t1, $t2, $t3
sw $t1, -2072($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -0 # Get attribute x
lw $t2, -2072($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
li $a0, 0 # seed id 0
li $v0, 41 # Service: random
syscall
move $t1, $a0 # load result
andi $t1, $t1, 0x7fffffff # mask off sign bit
sw $t1, -2120($fp) # Store temp
.data
L69: .float 2.14748e+09
.text
l.s $f4, L69
swc1 $f4, -2124($fp) # Store temp
lw $t2, -2120($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -2124
l.s $f8, 0($t3)
div.s $f4, $f6, $f8
swc1 $f4, -2116($fp) # Store temp
li $t1, 13
sw $t1, -2128($fp) # Store temp
addi $t2, $fp, -2116
l.s $f6, 0($t2)
lw $t3, -2128($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
mul.s $f4, $f6, $f8
swc1 $f4, -2112($fp) # Store temp
addi $t1, $fp, -2112
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -2108($fp) # Store temp
li $t1, 1
sw $t1, -2132($fp) # Store temp
lw $t2, -2108($fp) # get temp
lw $t3, -2132($fp) # get temp
add $t1, $t2, $t3
sw $t1, -2104($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -4 # Get attribute y
lw $t2, -2104($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
li $t1, 1
sw $t1, -2136($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1832 # Local: &done
lw $t2, -2136($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
# Beginning of for loop
li $t1, 1
sw $t1, -2140($fp) # Store temp
li $t1, 25
sw $t1, -2144($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
lw $t2, -2140($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L70: # Start the for loop
lw $t2, -2144($fp) # get temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L71 # Jump to the end if we are done, increasing
 # Beginning of if statement
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -0 # Get attribute x
sw $t1, -2156($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
sw $t1, -2164($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -2164($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute x
sw $t1, -2160($fp) # Store temp
lw $t2, -2156($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -2160($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -2152($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -4 # Get attribute y
sw $t1, -2172($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
sw $t1, -2180($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1608 # Local: &hunters
# Array index (subscript #0 - part two)
lw $t2, -2180($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 25 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 8 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -4 # Get attribute y
sw $t1, -2176($fp) # Store temp
lw $t2, -2172($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -2176($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -2168($fp) # Store temp
lw $t2, -2152($fp) # get temp
lw $t3, -2168($fp) # get temp
and $t1, $t2, $t3
sw $t1, -2148($fp) # Store temp
lw $t1, -2148($fp) # get temp
beq $t1, $0, L73 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
li $t1, 0
sw $t1, -2184($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1832 # Local: &done
lw $t2, -2184($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L73: # End of if statement
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L70 # Return to the start label
L71: # End of for loop
j L66# Jump to the beginning of the while loop
L67: # End of while loop
.data # String literal as words (written in reverse).
.word 0
L74: .word 40
.text
la $t1, L74
sw $t1, -2188($fp) # Store temp
addi $t1, $fp, -2188 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L75: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L76# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L75# go to top of loop
L76: # done!
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -0 # Get attribute x
sw $t1, -2192($fp) # Store temp
lw $t1, -2192($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 32
L77: .word 44
.text
la $t1, L77
sw $t1, -2196($fp) # Store temp
addi $t1, $fp, -2196 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L78: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L79# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L78# go to top of loop
L79: # done!
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1808 # Local: &prey
addi $t1, $t1, -4 # Get attribute y
sw $t1, -2200($fp) # Store temp
lw $t1, -2200($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 10
L80: .word 41
.text
la $t1, L80
sw $t1, -2204($fp) # Store temp
addi $t1, $fp, -2204 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L81: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L82# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L81# go to top of loop
L82: # done!
# Beginning of for loop
li $t1, 1
sw $t1, -2208($fp) # Store temp
li $t1, 13
sw $t1, -2212($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
lw $t2, -2208($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L83: # Start the for loop
lw $t2, -2212($fp) # get temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L84 # Jump to the end if we are done, increasing
# Beginning of for loop
li $t1, 1
sw $t1, -2216($fp) # Store temp
li $t1, 30
sw $t1, -2220($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t2, -2216($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L85: # Start the for loop
lw $t2, -2220($fp) # get temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L86 # Jump to the end if we are done, increasing
li $a0, 0 # seed id 0
li $v0, 41 # Service: random
syscall
move $t1, $a0 # load result
andi $t1, $t1, 0x7fffffff # mask off sign bit
sw $t1, -2236($fp) # Store temp
li $t1, 2
sw $t1, -2240($fp) # Store temp
lw $t2, -2236($fp) # get temp
lw $t3, -2240($fp) # get temp
div $t2, $t3
mfhi $t1
sw $t1, -2232($fp) # Store temp
# Array index (subscript #1 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
sw $t1, -2224($fp) # Store temp
# Array index (subscript #2 - part one)
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
sw $t1, -2228($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -48 # Local: &board
addi $t1, $t1, -0 # Get attribute grid
# Array index (subscript #1 - part two)
lw $t2, -2224($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 52 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
# Array index (subscript #2 - part two)
lw $t2, -2228($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 13 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
lw $t2, -2232($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L85 # Return to the start label
L86: # End of for loop
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1824 # Local: &j
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L83 # Return to the start label
L84: # End of for loop
L87: # Beginning of while loop
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1816 # Local: &won
sw $t1, -2248($fp) # Store temp
lw $t2, -2248($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sltiu $t1, $t2, 1
sw $t1, -2244($fp) # Store temp
lw $t1, -2244($fp) # get temp
beq $t1, $0, L88 # Branch if we are equal to 0 (FALSE)
# Call function printboard.
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
move $fp, $sp # update frame pointer
subi $sp, $sp, 88 # expand stack
la $t7, L20 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
# Call function update.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 12($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 12($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
move $fp, $sp # update frame pointer
subi $sp, $sp, 308 # expand stack
la $t7, L27 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
.data # String literal as words (written in reverse).
.word 0
L89: .word 10
.text
la $t1, L89
sw $t1, -2252($fp) # Store temp
addi $t1, $fp, -2252 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L90: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L91# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L90# go to top of loop
L91: # done!
# Beginning of for loop
li $t1, 1
sw $t1, -2256($fp) # Store temp
li $t1, 25000
sw $t1, -2260($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t2, -2256($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L92: # Start the for loop
lw $t2, -2260($fp) # get temp
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L93 # Jump to the end if we are done, increasing
lw $t1, 0($gp) # Get stackframe for hunterprey
addi $t1, $t1, -1820 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L92 # Return to the start label
L93: # End of for loop
j L87# Jump to the beginning of the while loop
L88: # End of while loop
# Call function printboard.
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
move $fp, $sp # update frame pointer
subi $sp, $sp, 88 # expand stack
la $t7, L20 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
# Exit the program.
li $v0, 10
syscall

