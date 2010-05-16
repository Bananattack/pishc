L0:
# Initialize main frame pointer.
subi $fp, $sp, -276
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
# Function quicksort
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L3
L4:
# Function partition
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L5
L5:
# Array index (subscript #0 - part one)
lw $t1, 8($gp) # Get stackframe for partition
lw $t1, -56($t1) # Argument: &*pivotindex
sw $t1, -76($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -76($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -72($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -60 # Local: &pivotvalue
addi $t2, $fp, -72
lw $t2, -72($fp)
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
# Array index (subscript #0 - part one)
lw $t1, 8($gp) # Get stackframe for partition
lw $t1, -52($t1) # Argument: &*right
sw $t1, -88($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -88($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -84($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 8($gp) # Get stackframe for partition
lw $t1, -56($t1) # Argument: &*pivotindex
sw $t1, -80($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -80($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t2, $fp, -84
lw $t2, -84($fp)
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -60 # Local: &pivotvalue
sw $t1, -96($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 8($gp) # Get stackframe for partition
lw $t1, -52($t1) # Argument: &*right
sw $t1, -92($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -92($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t2, $fp, -96
lw $t2, -96($fp)
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
lw $t1, 8($gp) # Get stackframe for partition
lw $t1, -48($t1) # Argument: &*left
sw $t1, -100($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for quicksort
addi $t1, $t1, -64 # Local: &part
lw $t2, -100($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into a variable
# Beginning of for loop
lw $t1, 8($gp) # Get stackframe for partition
lw $t1, -48($t1) # Argument: &*left
sw $t1, -104($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for partition
lw $t1, -52($t1) # Argument: &*right
sw $t1, -112($fp) # Store temp
li $t1, 1
sw $t1, -116($fp) # Store temp
lw $t2, -112($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -116($fp) # get temp
sub $t1, $t2, $t3
sw $t1, -108($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -64 # Local: &x
lw $t2, -104($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store the starting value
L6: # Start the for loop
lw $t2, -108($fp) # get temp
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -64 # Local: &x
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L7 # Jump to the end if we are done, increasing
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -64 # Local: &x
sw $t1, -128($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -128($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -124($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -60 # Local: &pivotvalue
sw $t1, -132($fp) # Store temp
addi $t2, $fp, -124
lw $t2, -124($fp)
l.s $f6, 0($t2)
addi $t3, $fp, -132
lw $t3, -132($fp)
l.s $f8, 0($t3)
c.le.s $f6, $f8
li $t1, 0
bc1f L10
li $t1, 1
L10:sw $t1, -120($fp) # Store temp
lw $t1, -120($fp) # get temp
beq $t1, $0, L9 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
# Array index (subscript #0 - part one)
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -64 # Local: &x
sw $t1, -140($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -140($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -136($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -68 # Local: &temp
addi $t2, $fp, -136
lw $t2, -136($fp)
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
# Array index (subscript #0 - part one)
lw $t1, 4($gp) # Get stackframe for quicksort
addi $t1, $t1, -64 # Local: &part
sw $t1, -152($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -152($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -148($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -64 # Local: &x
sw $t1, -144($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -144($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t2, $fp, -148
lw $t2, -148($fp)
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -68 # Local: &temp
sw $t1, -160($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 4($gp) # Get stackframe for quicksort
addi $t1, $t1, -64 # Local: &part
sw $t1, -156($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -156($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t2, $fp, -160
lw $t2, -160($fp)
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
lw $t1, 4($gp) # Get stackframe for quicksort
addi $t1, $t1, -64 # Local: &part
sw $t1, -168($fp) # Store temp
li $t1, 1
sw $t1, -172($fp) # Store temp
lw $t2, -168($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -172($fp) # get temp
add $t1, $t2, $t3
sw $t1, -164($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for quicksort
addi $t1, $t1, -64 # Local: &part
lw $t2, -164($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L9: # End of if statement
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -64 # Local: &x
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L6 # Return to the start label
L7: # End of for loop
# Array index (subscript #0 - part one)
lw $t1, 4($gp) # Get stackframe for quicksort
addi $t1, $t1, -64 # Local: &part
sw $t1, -180($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -180($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -176($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -68 # Local: &temp
addi $t2, $fp, -176
lw $t2, -176($fp)
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
# Array index (subscript #0 - part one)
lw $t1, 8($gp) # Get stackframe for partition
lw $t1, -52($t1) # Argument: &*right
sw $t1, -192($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -192($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -188($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 4($gp) # Get stackframe for quicksort
addi $t1, $t1, -64 # Local: &part
sw $t1, -184($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -184($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t2, $fp, -188
lw $t2, -188($fp)
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
lw $t1, 8($gp) # Get stackframe for partition
addi $t1, $t1, -68 # Local: &temp
sw $t1, -200($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 8($gp) # Get stackframe for partition
lw $t1, -52($t1) # Argument: &*right
sw $t1, -196($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -196($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t2, $fp, -200
lw $t2, -200($fp)
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
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

L3:
 # Beginning of if statement
lw $t1, 4($gp) # Get stackframe for quicksort
lw $t1, -52($t1) # Argument: &*right
sw $t1, -72($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for quicksort
lw $t1, -48($t1) # Argument: &*left
sw $t1, -76($fp) # Store temp
lw $t2, -72($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -76($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
slt $t1, $t3, $t2
sw $t1, -68($fp) # Store temp
lw $t1, -68($fp) # get temp
beq $t1, $0, L12 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
lw $t1, 4($gp) # Get stackframe for quicksort
lw $t1, -48($t1) # Argument: &*left
sw $t1, -88($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for quicksort
lw $t1, -52($t1) # Argument: &*right
sw $t1, -92($fp) # Store temp
lw $t2, -88($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -92($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
add $t1, $t2, $t3
sw $t1, -84($fp) # Store temp
li $t1, 2
sw $t1, -96($fp) # Store temp
lw $t2, -84($fp) # get temp
lw $t3, -96($fp) # get temp
div $t2, $t3
mflo $t1
sw $t1, -80($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for quicksort
addi $t1, $t1, -56 # Local: &pivot
lw $t2, -80($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
lw $t1, 4($gp) # Get stackframe for quicksort
lw $t1, -48($t1) # Argument: &*left
sw $t1, -100($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for quicksort
lw $t1, -52($t1) # Argument: &*right
sw $t1, -104($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for quicksort
addi $t1, $t1, -56 # Local: &pivot
sw $t1, -108($fp) # Store temp
# Call function partition.
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
addi $t1, $fp, -100 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
addi $t1, $fp, -104 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -52($sp)
addi $t1, $fp, -108 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -56($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 204 # expand stack
la $t7, L4 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, 4($gp) # Get stackframe for quicksort
lw $t1, -48($t1) # Argument: &*left
sw $t1, -112($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for quicksort
addi $t1, $t1, -64 # Local: &part
sw $t1, -120($fp) # Store temp
li $t1, 1
sw $t1, -124($fp) # Store temp
lw $t2, -120($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -124($fp) # get temp
sub $t1, $t2, $t3
sw $t1, -116($fp) # Store temp
# Call function quicksort.
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
addi $t1, $fp, -112 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
addi $t1, $fp, -116 # get address of temp
sw $t1, -52($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 144 # expand stack
la $t7, L2 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, 4($gp) # Get stackframe for quicksort
addi $t1, $t1, -64 # Local: &part
sw $t1, -132($fp) # Store temp
li $t1, 1
sw $t1, -136($fp) # Store temp
lw $t2, -132($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -136($fp) # get temp
add $t1, $t2, $t3
sw $t1, -128($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for quicksort
lw $t1, -52($t1) # Argument: &*right
sw $t1, -140($fp) # Store temp
# Call function quicksort.
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
addi $t1, $fp, -128 # get address of temp
sw $t1, -48($sp)
addi $t1, $fp, -140 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -52($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 144 # expand stack
la $t7, L2 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
L12: # End of if statement
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

L1:
# Beginning of for loop
li $t1, 1
sw $t1, -184($fp) # Store temp
li $t1, 30
sw $t1, -188($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -180 # Local: &x
lw $t2, -184($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L13: # Start the for loop
lw $t2, -188($fp) # get temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -180 # Local: &x
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L14 # Jump to the end if we are done, increasing
li $a0, 0 # seed id 0
li $v0, 41 # Service: random
syscall
move $t1, $a0 # load result
andi $t1, $t1, 0x7fffffff # mask off sign bit
sw $t1, -204($fp) # Store temp
li $t1, 10000
sw $t1, -208($fp) # Store temp
lw $t2, -204($fp) # get temp
lw $t3, -208($fp) # get temp
div $t2, $t3
mfhi $t1
sw $t1, -200($fp) # Store temp
.data
L15: .float 100
.text
l.s $f4, L15
swc1 $f4, -212($fp) # Store temp
lw $t2, -200($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -212
l.s $f8, 0($t3)
div.s $f4, $f6, $f8
swc1 $f4, -196($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -180 # Local: &x
sw $t1, -192($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -192($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t2, $fp, -196
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into a variable
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -180 # Local: &x
sw $t1, -216($fp) # Store temp
lw $t1, -216($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L16: .word 58
.text
la $t1, L16
sw $t1, -220($fp) # Store temp
lw $t1, -220($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -180 # Local: &x
sw $t1, -228($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -228($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -224($fp) # Store temp
addi $t1, $fp, -224
lw $t1, -224($fp)
l.s $f12, 0($t1)
li $v0, 2 # Service: write float
syscall # Call writereal
.data # String literal as words (written in reverse).
.word 0
L17: .word 10
.text
la $t1, L17
sw $t1, -232($fp) # Store temp
lw $t1, -232($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -180 # Local: &x
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L13 # Return to the start label
L14: # End of for loop
li $t1, 1
sw $t1, -236($fp) # Store temp
li $t1, 30
sw $t1, -240($fp) # Store temp
# Call function quicksort.
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
addi $t1, $fp, -236 # get address of temp
sw $t1, -48($sp)
addi $t1, $fp, -240 # get address of temp
sw $t1, -52($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 144 # expand stack
la $t7, L2 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
.data # String literal as words (written in reverse).
.word 0
L18: .word 10
.text
la $t1, L18
sw $t1, -244($fp) # Store temp
lw $t1, -244($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
# Beginning of for loop
li $t1, 1
sw $t1, -248($fp) # Store temp
li $t1, 30
sw $t1, -252($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -180 # Local: &x
lw $t2, -248($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L19: # Start the for loop
lw $t2, -252($fp) # get temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -180 # Local: &x
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L20 # Jump to the end if we are done, increasing
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -180 # Local: &x
sw $t1, -256($fp) # Store temp
lw $t1, -256($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L21: .word 58
.text
la $t1, L21
sw $t1, -260($fp) # Store temp
lw $t1, -260($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -180 # Local: &x
sw $t1, -268($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -48 # Local: &unsorted
# Array index (subscript #0 - part two)
lw $t2, -268($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 30 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -264($fp) # Store temp
addi $t1, $fp, -264
lw $t1, -264($fp)
l.s $f12, 0($t1)
li $v0, 2 # Service: write float
syscall # Call writereal
.data # String literal as words (written in reverse).
.word 0
L22: .word 10
.text
la $t1, L22
sw $t1, -272($fp) # Store temp
lw $t1, -272($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
lw $t1, 0($gp) # Get stackframe for testquicksort
addi $t1, $t1, -180 # Local: &x
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L19 # Return to the start label
L20: # End of for loop
# Exit the program.
li $v0, 10
syscall

