L0:
# Initialize main frame pointer.
subi $fp, $sp, -2540
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
# Function printchar
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L3
L3:
lw $t1, 4($gp) # Get stackframe for printchar
lw $t1, -48($t1) # Argument: &*ch
sw $t1, -52($fp) # Store temp
lw $t1, -52($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
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

L4:
# Function printstring
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L5
L5:
li $t1, 1
sw $t1, -1076($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for printstring
addi $t1, $t1, -1072 # Local: &x
lw $t2, -1076($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
li $t1, 2
sw $t1, -1080($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1132 # Local: &y
lw $t2, -1080($fp) # get temp
mtc1 $t2, $f4 # move value into float register
cvt.s.w $f4, $f4 # convert to real
swc1 $f4, 0($t1) # Store value into a variable
L6: # Beginning of while loop
lw $t1, 8($gp) # Get stackframe for printstring
addi $t1, $t1, -1072 # Local: &x
sw $t1, -1088($fp) # Store temp
li $t1, 256
sw $t1, -1092($fp) # Store temp
lw $t2, -1088($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -1092($fp) # get temp
slt $t1, $t3, $t2
sltiu $t1, $t1, 1
sw $t1, -1084($fp) # Store temp
lw $t1, -1084($fp) # get temp
beq $t1, $0, L7 # Branch if we are equal to 0 (FALSE)
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 8($gp) # Get stackframe for printstring
addi $t1, $t1, -1072 # Local: &x
sw $t1, -1104($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for printstring
lw $t1, -48($t1) # Argument: &*s
# Array index (subscript #0 - part two)
lw $t2, -1104($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 256 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -1100($fp) # Store temp
li $t1, 0
sw $t1, -1108($fp) # Store temp
lw $t2, -1100($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -1108($fp) # get temp
xor $t1, $t2, $t3
sltu $t1, $0, $t1
sw $t1, -1096($fp) # Store temp
lw $t1, -1096($fp) # get temp
beq $t1, $0, L9 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
# Array index (subscript #0 - part one)
lw $t1, 8($gp) # Get stackframe for printstring
addi $t1, $t1, -1072 # Local: &x
sw $t1, -1116($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for printstring
lw $t1, -48($t1) # Argument: &*s
# Array index (subscript #0 - part two)
lw $t2, -1116($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 256 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -1112($fp) # Store temp
# Call function printchar.
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
addi $t1, $fp, -1112 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 56 # expand stack
la $t7, L2 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
L9: # End of if statement
lw $t1, 8($gp) # Get stackframe for printstring
addi $t1, $t1, -1072 # Local: &x
sw $t1, -1124($fp) # Store temp
li $t1, 1
sw $t1, -1128($fp) # Store temp
lw $t2, -1124($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -1128($fp) # get temp
add $t1, $t2, $t3
sw $t1, -1120($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for printstring
addi $t1, $t1, -1072 # Local: &x
lw $t2, -1120($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
j L6# Jump to the beginning of the while loop
L7: # End of while loop
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

L10:
# Function printline
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L11
L11:
lw $t1, 12($gp) # Get stackframe for printline
lw $t1, -48($t1) # Argument: &*s
sw $t1, -1072($fp) # Store temp
# Call function printstring.
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
addi $t1, $fp, -1072 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 1132 # expand stack
la $t7, L4 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
.data # String literal as words (written in reverse).
.word 0
L12: .word 10
.text
la $t1, L12
sw $t1, -1076($fp) # Store temp
# Call function printchar.
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
addi $t1, $fp, -1076 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 56 # expand stack
la $t7, L2 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
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

L13:
# Function factorial
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L14
L15:
# Function fact
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L16
L16:
 # Beginning of if statement
lw $t1, 20($gp) # Get stackframe for fact
lw $t1, -48($t1) # Argument: &*n
sw $t1, -56($fp) # Store temp
li $t1, 1
sw $t1, -60($fp) # Store temp
lw $t2, -56($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -60($fp) # get temp
slt $t1, $t3, $t2
sltiu $t1, $t1, 1
sw $t1, -52($fp) # Store temp
lw $t1, -52($fp) # get temp
beq $t1, $0, L17 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
li $t1, 1
sw $t1, -64($fp) # Store temp
lw $t1, 20($gp) # Get stackframe for fact
addi $t1, $t1, -44 # Local: &fact
lw $t2, -64($fp) # get temp
sw $t2, 0($t1) # Store value into the function return value
j L18# Jump to the end of the if
L17: # Else statement 
lw $t1, 20($gp) # Get stackframe for fact
lw $t1, -48($t1) # Argument: &*n
sw $t1, -72($fp) # Store temp
lw $t1, 20($gp) # Get stackframe for fact
lw $t1, -48($t1) # Argument: &*n
sw $t1, -84($fp) # Store temp
li $t1, 1
sw $t1, -88($fp) # Store temp
lw $t2, -84($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -88($fp) # get temp
sub $t1, $t2, $t3
sw $t1, -80($fp) # Store temp
# Call function fact.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 20($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 20($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -80 # get address of temp
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 92 # expand stack
la $t7, L15 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
sw $t1, -76($fp) # Store temp
lw $t2, -72($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -76($fp) # get temp
mul $t1, $t2, $t3
sw $t1, -68($fp) # Store temp
lw $t1, 20($gp) # Get stackframe for fact
addi $t1, $t1, -44 # Local: &fact
lw $t2, -68($fp) # get temp
sw $t2, 0($t1) # Store value into the function return value
L18: # End of if statement
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 20($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L14:
lw $t1, 16($gp) # Get stackframe for factorial
lw $t1, -48($t1) # Argument: &*n
sw $t1, -60($fp) # Store temp
# Call function fact.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 20($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 20($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -60 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 92 # expand stack
la $t7, L15 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
sw $t1, -56($fp) # Store temp
lw $t1, 16($gp) # Get stackframe for factorial
lw $t1, -52($t1) # Argument: &*result
lw $t2, -56($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 16($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L19:
# Function passingarrayfunc
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L20
L20:
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 24($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L1:
# Beginning of for loop
li $t1, 1
sw $t1, -2272($fp) # Store temp
li $t1, 5
sw $t1, -2276($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1140 # Local: &i
lw $t2, -2272($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L21: # Start the for loop
lw $t2, -2276($fp) # get temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1140 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L22 # Jump to the end if we are done, increasing
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1140 # Local: &i
sw $t1, -2284($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -48 # Local: &polygons
# Array index (subscript #0 - part two)
lw $t2, -2284($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 5 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 180 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -2280($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -948 # Local: &pory
lw $t2, -2280($fp)
# Copy 180 words into t1 from t2
lw $t3, 0($t2) # Read
sw $t3, 0($t1) # Copy
lw $t3, -4($t2) # Read
sw $t3, -4($t1) # Copy
lw $t3, -8($t2) # Read
sw $t3, -8($t1) # Copy
lw $t3, -12($t2) # Read
sw $t3, -12($t1) # Copy
lw $t3, -16($t2) # Read
sw $t3, -16($t1) # Copy
lw $t3, -20($t2) # Read
sw $t3, -20($t1) # Copy
lw $t3, -24($t2) # Read
sw $t3, -24($t1) # Copy
lw $t3, -28($t2) # Read
sw $t3, -28($t1) # Copy
lw $t3, -32($t2) # Read
sw $t3, -32($t1) # Copy
lw $t3, -36($t2) # Read
sw $t3, -36($t1) # Copy
lw $t3, -40($t2) # Read
sw $t3, -40($t1) # Copy
lw $t3, -44($t2) # Read
sw $t3, -44($t1) # Copy
lw $t3, -48($t2) # Read
sw $t3, -48($t1) # Copy
lw $t3, -52($t2) # Read
sw $t3, -52($t1) # Copy
lw $t3, -56($t2) # Read
sw $t3, -56($t1) # Copy
lw $t3, -60($t2) # Read
sw $t3, -60($t1) # Copy
lw $t3, -64($t2) # Read
sw $t3, -64($t1) # Copy
lw $t3, -68($t2) # Read
sw $t3, -68($t1) # Copy
lw $t3, -72($t2) # Read
sw $t3, -72($t1) # Copy
lw $t3, -76($t2) # Read
sw $t3, -76($t1) # Copy
lw $t3, -80($t2) # Read
sw $t3, -80($t1) # Copy
lw $t3, -84($t2) # Read
sw $t3, -84($t1) # Copy
lw $t3, -88($t2) # Read
sw $t3, -88($t1) # Copy
lw $t3, -92($t2) # Read
sw $t3, -92($t1) # Copy
lw $t3, -96($t2) # Read
sw $t3, -96($t1) # Copy
lw $t3, -100($t2) # Read
sw $t3, -100($t1) # Copy
lw $t3, -104($t2) # Read
sw $t3, -104($t1) # Copy
lw $t3, -108($t2) # Read
sw $t3, -108($t1) # Copy
lw $t3, -112($t2) # Read
sw $t3, -112($t1) # Copy
lw $t3, -116($t2) # Read
sw $t3, -116($t1) # Copy
lw $t3, -120($t2) # Read
sw $t3, -120($t1) # Copy
lw $t3, -124($t2) # Read
sw $t3, -124($t1) # Copy
lw $t3, -128($t2) # Read
sw $t3, -128($t1) # Copy
lw $t3, -132($t2) # Read
sw $t3, -132($t1) # Copy
lw $t3, -136($t2) # Read
sw $t3, -136($t1) # Copy
lw $t3, -140($t2) # Read
sw $t3, -140($t1) # Copy
lw $t3, -144($t2) # Read
sw $t3, -144($t1) # Copy
lw $t3, -148($t2) # Read
sw $t3, -148($t1) # Copy
lw $t3, -152($t2) # Read
sw $t3, -152($t1) # Copy
lw $t3, -156($t2) # Read
sw $t3, -156($t1) # Copy
lw $t3, -160($t2) # Read
sw $t3, -160($t1) # Copy
lw $t3, -164($t2) # Read
sw $t3, -164($t1) # Copy
lw $t3, -168($t2) # Read
sw $t3, -168($t1) # Copy
lw $t3, -172($t2) # Read
sw $t3, -172($t1) # Copy
lw $t3, -176($t2) # Read
sw $t3, -176($t1) # Copy
 # Beginning of if statement
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1140 # Local: &i
sw $t1, -2292($fp) # Store temp
li $t1, 2
sw $t1, -2296($fp) # Store temp
lw $t2, -2292($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -2296($fp) # get temp
div $t2, $t3
mfhi $t1
sw $t1, -2288($fp) # Store temp
lw $t1, -2288($fp) # get temp
beq $t1, $0, L23 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
li $t1, 32
sw $t1, -2308($fp) # Store temp
.data
L25: .float 2.1234
.text
l.s $f4, L25
swc1 $f4, -2312($fp) # Store temp
lw $t2, -2308($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -2312
l.s $f8, 0($t3)
div.s $f4, $f6, $f8
swc1 $f4, -2304($fp) # Store temp
# Array index (subscript #1 - part one)
li $t1, 0
sw $t1, -2300($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -948 # Local: &pory
addi $t1, $t1, 0 # Get attribute vertices
# Array index (subscript #1 - part two)
lw $t2, -2300($fp) # get temp
li $t3, -5 # lower bound 
li $t4, 9 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, 5 # We need to reposition relative to the actual memory location.
li $t3, 12 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, 0 # Get attribute x
addi $t2, $fp, -2304
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
li $t1, 3
sw $t1, -2324($fp) # Store temp
# Array index (subscript #1 - part one)
li $t1, 4
sw $t1, -2320($fp) # Store temp
lw $t2, -2320($fp) # get temp
sub $t1, $0, $t2
sw $t1, -2316($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -948 # Local: &pory
addi $t1, $t1, 0 # Get attribute vertices
# Array index (subscript #1 - part two)
lw $t2, -2316($fp) # get temp
li $t3, -5 # lower bound 
li $t4, 9 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, 5 # We need to reposition relative to the actual memory location.
li $t3, 12 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, 4 # Get attribute y
lw $t2, -2324($fp) # get temp
mtc1 $t2, $f4 # move value into float register
cvt.s.w $f4, $f4 # convert to real
swc1 $f4, 0($t1) # Store value into a variable
li $t1, 3
sw $t1, -2332($fp) # Store temp
# Array index (subscript #1 - part one)
li $t1, 2
sw $t1, -2328($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -948 # Local: &pory
addi $t1, $t1, 0 # Get attribute vertices
# Array index (subscript #1 - part two)
lw $t2, -2328($fp) # get temp
li $t3, -5 # lower bound 
li $t4, 9 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, 5 # We need to reposition relative to the actual memory location.
li $t3, 12 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, 8 # Get attribute z
lw $t2, -2332($fp) # get temp
mtc1 $t2, $f4 # move value into float register
cvt.s.w $f4, $f4 # convert to real
swc1 $f4, 0($t1) # Store value into a variable
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 69, 66, 77, 85, 78, 32, 68, 68
L26: .word 79
.text
la $t1, L26
sw $t1, -2336($fp) # Store temp
# Call function printline.
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
addi $t1, $fp, -2336 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 1080 # expand stack
la $t7, L10 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1140 # Local: &i
sw $t1, -2340($fp) # Store temp
lw $t1, -2340($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
mtc1 $t1, $f12 # move value into float register
cvt.s.w $f12, $f12 # convert to real
li $v0, 2 # Service: write float
syscall # Call writereal
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
L27: .word 0
.text
la $t1, L27
sw $t1, -2344($fp) # Store temp
# Call function printline.
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
addi $t1, $fp, -2344 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 1080 # expand stack
la $t7, L10 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
j L24# Jump to the end of the if
L23: # Else statement 
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 69, 66, 77, 85, 78, 32, 78, 69, 86
L28: .word 69
.text
la $t1, L28
sw $t1, -2348($fp) # Store temp
# Call function printline.
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
addi $t1, $fp, -2348 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 1080 # expand stack
la $t7, L10 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1140 # Local: &i
sw $t1, -2364($fp) # Store temp
lw $t1, -2364($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
mtc1 $t1, $f12 # move value into float register
cvt.s.w $f12, $f12 # convert to real
swc1 $f4, -2360($fp) # Store temp
.data
L29: .float 0.5
.text
l.s $f4, L29
swc1 $f4, -2368($fp) # Store temp
addi $t2, $fp, -2360
l.s $f6, 0($t2)
addi $t3, $fp, -2368
l.s $f8, 0($t3)
add.s $f4, $f6, $f8
swc1 $f4, -2356($fp) # Store temp
addi $t1, $fp, -2356
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -2352($fp) # Store temp
lw $t1, -2352($fp) # get temp
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
L30: .word 0
.text
la $t1, L30
sw $t1, -2372($fp) # Store temp
# Call function printline.
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
addi $t1, $fp, -2372 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 1080 # expand stack
la $t7, L10 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
L24: # End of if statement
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1140 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L21 # Return to the start label
L22: # End of for loop
li $t1, 1
sw $t1, -2380($fp) # Store temp
li $t1, 4
sw $t1, -2392($fp) # Store temp
li $t1, 3
sw $t1, -2396($fp) # Store temp
lw $t2, -2392($fp) # get temp
lw $t3, -2396($fp) # get temp
mul $t1, $t2, $t3
sw $t1, -2388($fp) # Store temp
li $t1, 2
sw $t1, -2400($fp) # Store temp
lw $t2, -2388($fp) # get temp
lw $t3, -2400($fp) # get temp
add $t1, $t2, $t3
sw $t1, -2384($fp) # Store temp
lw $t2, -2380($fp) # get temp
lw $t3, -2384($fp) # get temp
div $t2, $t3
mflo $t1
sw $t1, -2376($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1128 # Local: &x
lw $t2, -2376($fp) # get temp
mtc1 $t2, $f4 # move value into float register
cvt.s.w $f4, $f4 # convert to real
swc1 $f4, 0($t1) # Store value into a variable
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1128 # Local: &x
sw $t1, -2408($fp) # Store temp
li $t1, 3
sw $t1, -2412($fp) # Store temp
addi $t2, $fp, -2408
lw $t2, -2408($fp)
l.s $f6, 0($t2)
lw $t3, -2412($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
c.le.s $f8, $f6
li $t1, 0
bc1f L31
li $t1, 1
L31:sw $t1, -2404($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1128 # Local: &x
lw $t2, -2404($fp) # get temp
mtc1 $t2, $f4 # move value into float register
cvt.s.w $f4, $f4 # convert to real
swc1 $f4, 0($t1) # Store value into a variable
li $t1, 4
sw $t1, -2424($fp) # Store temp
# Array index (subscript #0 - part one)
li $t1, 2
sw $t1, -2416($fp) # Store temp
# Array index (subscript #2 - part one)
li $t1, 3
sw $t1, -2420($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -48 # Local: &polygons
# Array index (subscript #0 - part two)
lw $t2, -2416($fp) # get temp
li $t3, 1 # lower bound 
li $t4, 5 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 180 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, 0 # Get attribute vertices
# Array index (subscript #2 - part two)
lw $t2, -2420($fp) # get temp
li $t3, -5 # lower bound 
li $t4, 9 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, 5 # We need to reposition relative to the actual memory location.
li $t3, 12 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, 0 # Get attribute x
lw $t2, -2424($fp) # get temp
mtc1 $t2, $f4 # move value into float register
cvt.s.w $f4, $f4 # convert to real
swc1 $f4, 0($t1) # Store value into a variable
L32: # Beginning of while loop
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1128 # Local: &x
sw $t1, -2432($fp) # Store temp
li $t1, 5
sw $t1, -2436($fp) # Store temp
addi $t2, $fp, -2432
lw $t2, -2432($fp)
l.s $f6, 0($t2)
lw $t3, -2436($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
c.lt.s $f6, $f8
li $t1, 0
bc1f L34
li $t1, 1
L34:sw $t1, -2428($fp) # Store temp
lw $t1, -2428($fp) # get temp
beq $t1, $0, L33 # Branch if we are equal to 0 (FALSE)
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1128 # Local: &x
sw $t1, -2444($fp) # Store temp
addi $t1, $fp, -2444
lw $t1, -2444($fp)
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -2440($fp) # Store temp
lw $t1, -2440($fp) # get temp
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 61, 32
L35: .word 33
.text
la $t1, L35
sw $t1, -2448($fp) # Store temp
# Call function printstring.
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
addi $t1, $fp, -2448 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 1132 # expand stack
la $t7, L4 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1128 # Local: &x
sw $t1, -2456($fp) # Store temp
addi $t1, $fp, -2456
lw $t1, -2456($fp)
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -2452($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1140 # Local: &i
sw $t1, -2460($fp) # Store temp
# Call function factorial.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 16($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 16($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -2452 # get address of temp
sw $t1, -48($sp)
addi $t1, $fp, -2460 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -52($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 64 # expand stack
la $t7, L13 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1140 # Local: &i
sw $t1, -2464($fp) # Store temp
lw $t1, -2464($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
L36: .word 0
.text
la $t1, L36
sw $t1, -2468($fp) # Store temp
# Call function printline.
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
addi $t1, $fp, -2468 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 1080 # expand stack
la $t7, L10 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1128 # Local: &x
sw $t1, -2476($fp) # Store temp
li $t1, 1
sw $t1, -2480($fp) # Store temp
addi $t2, $fp, -2476
lw $t2, -2476($fp)
l.s $f6, 0($t2)
lw $t3, -2480($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
add.s $f4, $f6, $f8
swc1 $f4, -2472($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1128 # Local: &x
addi $t2, $fp, -2472
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
li $t1, 2
sw $t1, -2484($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1136 # Local: &z
lw $t2, -2484($fp) # get temp
mtc1 $t2, $f4 # move value into float register
cvt.s.w $f4, $f4 # convert to real
swc1 $f4, 0($t1) # Store value into a variable
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1132 # Local: &y
sw $t1, -2508($fp) # Store temp
li $t1, 4
sw $t1, -2512($fp) # Store temp
addi $t2, $fp, -2508
lw $t2, -2508($fp)
l.s $f6, 0($t2)
lw $t3, -2512($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
div.s $f4, $f6, $f8
swc1 $f4, -2504($fp) # Store temp
li $t1, 324
sw $t1, -2516($fp) # Store temp
addi $t2, $fp, -2504
l.s $f6, 0($t2)
lw $t3, -2516($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
mul.s $f4, $f6, $f8
swc1 $f4, -2500($fp) # Store temp
li $t1, 1
sw $t1, -2520($fp) # Store temp
addi $t2, $fp, -2500
l.s $f6, 0($t2)
lw $t3, -2520($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
add.s $f4, $f6, $f8
swc1 $f4, -2496($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1136 # Local: &z
sw $t1, -2524($fp) # Store temp
addi $t2, $fp, -2496
l.s $f6, 0($t2)
addi $t3, $fp, -2524
lw $t3, -2524($fp)
l.s $f8, 0($t3)
c.eq.s $f6, $f8
li $t1, 0
bc1f L37
li $t1, 1
L37:sw $t1, -2492($fp) # Store temp
li $t1, 5
sw $t1, -2528($fp) # Store temp
lw $t2, -2492($fp) # get temp
lw $t3, -2528($fp) # get temp
and $t1, $t2, $t3
sw $t1, -2488($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1132 # Local: &y
lw $t2, -2488($fp) # get temp
mtc1 $t2, $f4 # move value into float register
cvt.s.w $f4, $f4 # convert to real
swc1 $f4, 0($t1) # Store value into a variable
j L32# Jump to the beginning of the while loop
L33: # End of while loop
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 104, 115, 105, 80, 32, 110, 105, 32, 39, 100, 108, 114, 111, 119, 32, 111, 108, 108, 101, 72, 39, 32, 101, 108, 98, 105, 114, 114, 111, 104, 32, 97, 32, 115, 105, 32, 115, 105, 104
L38: .word 84
.text
la $t1, L38
sw $t1, -2532($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1148 # Local: &message
lw $t2, -2532($fp)
# Copy 164 words into t1 from t2
lw $t3, 0($t2) # Read
sw $t3, 0($t1) # Copy
lw $t3, -4($t2) # Read
sw $t3, -4($t1) # Copy
lw $t3, -8($t2) # Read
sw $t3, -8($t1) # Copy
lw $t3, -12($t2) # Read
sw $t3, -12($t1) # Copy
lw $t3, -16($t2) # Read
sw $t3, -16($t1) # Copy
lw $t3, -20($t2) # Read
sw $t3, -20($t1) # Copy
lw $t3, -24($t2) # Read
sw $t3, -24($t1) # Copy
lw $t3, -28($t2) # Read
sw $t3, -28($t1) # Copy
lw $t3, -32($t2) # Read
sw $t3, -32($t1) # Copy
lw $t3, -36($t2) # Read
sw $t3, -36($t1) # Copy
lw $t3, -40($t2) # Read
sw $t3, -40($t1) # Copy
lw $t3, -44($t2) # Read
sw $t3, -44($t1) # Copy
lw $t3, -48($t2) # Read
sw $t3, -48($t1) # Copy
lw $t3, -52($t2) # Read
sw $t3, -52($t1) # Copy
lw $t3, -56($t2) # Read
sw $t3, -56($t1) # Copy
lw $t3, -60($t2) # Read
sw $t3, -60($t1) # Copy
lw $t3, -64($t2) # Read
sw $t3, -64($t1) # Copy
lw $t3, -68($t2) # Read
sw $t3, -68($t1) # Copy
lw $t3, -72($t2) # Read
sw $t3, -72($t1) # Copy
lw $t3, -76($t2) # Read
sw $t3, -76($t1) # Copy
lw $t3, -80($t2) # Read
sw $t3, -80($t1) # Copy
lw $t3, -84($t2) # Read
sw $t3, -84($t1) # Copy
lw $t3, -88($t2) # Read
sw $t3, -88($t1) # Copy
lw $t3, -92($t2) # Read
sw $t3, -92($t1) # Copy
lw $t3, -96($t2) # Read
sw $t3, -96($t1) # Copy
lw $t3, -100($t2) # Read
sw $t3, -100($t1) # Copy
lw $t3, -104($t2) # Read
sw $t3, -104($t1) # Copy
lw $t3, -108($t2) # Read
sw $t3, -108($t1) # Copy
lw $t3, -112($t2) # Read
sw $t3, -112($t1) # Copy
lw $t3, -116($t2) # Read
sw $t3, -116($t1) # Copy
lw $t3, -120($t2) # Read
sw $t3, -120($t1) # Copy
lw $t3, -124($t2) # Read
sw $t3, -124($t1) # Copy
lw $t3, -128($t2) # Read
sw $t3, -128($t1) # Copy
lw $t3, -132($t2) # Read
sw $t3, -132($t1) # Copy
lw $t3, -136($t2) # Read
sw $t3, -136($t1) # Copy
lw $t3, -140($t2) # Read
sw $t3, -140($t1) # Copy
lw $t3, -144($t2) # Read
sw $t3, -144($t1) # Copy
lw $t3, -148($t2) # Read
sw $t3, -148($t1) # Copy
lw $t3, -152($t2) # Read
sw $t3, -152($t1) # Copy
lw $t3, -156($t2) # Read
sw $t3, -156($t1) # Copy
lw $t3, -160($t2) # Read
sw $t3, -160($t1) # Copy
lw $t1, 0($gp) # Get stackframe for thisonecompiles
addi $t1, $t1, -1148 # Local: &message
sw $t1, -2536($fp) # Store temp
# Call function printline.
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
addi $t1, $fp, -2536 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 1080 # expand stack
la $t7, L10 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
# Exit the program.
li $v0, 10
syscall

