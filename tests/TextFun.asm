L0:
# Initialize main frame pointer.
subi $fp, $sp, -512
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
# Function min
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L3
L3:
 # Beginning of if statement
lw $t1, 4($gp) # Get stackframe for min
lw $t1, -48($t1) # Argument: &*x
sw $t1, -60($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for min
lw $t1, -52($t1) # Argument: &*y
sw $t1, -64($fp) # Store temp
lw $t2, -60($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -64($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
slt $t1, $t2, $t3
sw $t1, -56($fp) # Store temp
lw $t1, -56($fp) # get temp
beq $t1, $0, L4 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
lw $t1, 4($gp) # Get stackframe for min
lw $t1, -48($t1) # Argument: &*x
sw $t1, -68($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for min
addi $t1, $t1, -44 # Local: &min
lw $t2, -68($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into the function return value
j L5# Jump to the end of the if
L4: # Else statement 
lw $t1, 4($gp) # Get stackframe for min
lw $t1, -52($t1) # Argument: &*y
sw $t1, -72($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for min
addi $t1, $t1, -44 # Local: &min
lw $t2, -72($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into the function return value
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
# Function max
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L7
L7:
 # Beginning of if statement
lw $t1, 8($gp) # Get stackframe for max
lw $t1, -48($t1) # Argument: &*x
sw $t1, -60($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for max
lw $t1, -52($t1) # Argument: &*y
sw $t1, -64($fp) # Store temp
lw $t2, -60($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -64($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
slt $t1, $t3, $t2
sw $t1, -56($fp) # Store temp
lw $t1, -56($fp) # get temp
beq $t1, $0, L8 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
lw $t1, 8($gp) # Get stackframe for max
lw $t1, -48($t1) # Argument: &*x
sw $t1, -68($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for max
addi $t1, $t1, -44 # Local: &max
lw $t2, -68($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into the function return value
j L9# Jump to the end of the if
L8: # Else statement 
lw $t1, 8($gp) # Get stackframe for max
lw $t1, -52($t1) # Argument: &*y
sw $t1, -72($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for max
addi $t1, $t1, -44 # Local: &max
lw $t2, -72($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
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

L10:
# Function combatantadd
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L11
L11:
 # Beginning of if statement
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
sw $t1, -164($fp) # Store temp
li $t1, 3
sw $t1, -168($fp) # Store temp
lw $t2, -164($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -168($fp) # get temp
slt $t1, $t3, $t2
sltiu $t1, $t1, 1
sw $t1, -160($fp) # Store temp
lw $t1, -160($fp) # get temp
beq $t1, $0, L12 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
sw $t1, -176($fp) # Store temp
li $t1, 1
sw $t1, -180($fp) # Store temp
lw $t2, -176($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -180($fp) # get temp
add $t1, $t2, $t3
sw $t1, -172($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
lw $t2, -172($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
lw $t1, 12($gp) # Get stackframe for combatantadd
lw $t1, -48($t1) # Argument: &*name
sw $t1, -188($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
sw $t1, -184($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -184($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute name
lw $t2, -188($fp)
# Copy 96 words into t1 from t2
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
lw $t1, 12($gp) # Get stackframe for combatantadd
lw $t1, -144($t1) # Argument: &*hp
sw $t1, -196($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
sw $t1, -192($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -192($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -96 # Get attribute hp
lw $t2, -196($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into a variable
lw $t1, 12($gp) # Get stackframe for combatantadd
lw $t1, -144($t1) # Argument: &*hp
sw $t1, -204($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
sw $t1, -200($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -200($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -100 # Get attribute maxhp
lw $t2, -204($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into a variable
lw $t1, 12($gp) # Get stackframe for combatantadd
lw $t1, -148($t1) # Argument: &*atk
sw $t1, -212($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
sw $t1, -208($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -208($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -104 # Get attribute atk
lw $t2, -212($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into a variable
lw $t1, 12($gp) # Get stackframe for combatantadd
lw $t1, -152($t1) # Argument: &*def
sw $t1, -220($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
sw $t1, -216($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -216($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -108 # Get attribute def
lw $t2, -220($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into a variable
lw $t1, 12($gp) # Get stackframe for combatantadd
lw $t1, -156($t1) # Argument: &*team
sw $t1, -228($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
sw $t1, -224($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -224($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -116 # Get attribute team
lw $t2, -228($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into a variable
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
sw $t1, -232($fp) # Store temp
lw $t1, 12($gp) # Get stackframe for combatantadd
addi $t1, $t1, -44 # Local: &combatantadd
lw $t2, -232($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into the function return value
j L13# Jump to the end of the if
L12: # Else statement 
.data # String literal as words (written in reverse).
.word 0, 32, 102, 111, 32, 120, 97, 109, 32, 97, 32, 111, 116, 32, 100, 101, 116, 105, 109, 105, 76, 40, 32, 101, 118, 105, 116, 99, 97, 32, 115, 116, 110, 97, 116, 97, 98, 109, 111, 99, 32, 121, 110, 97, 109, 32, 111, 111
L14: .word 84
.text
la $t1, L14
sw $t1, -236($fp) # Store temp
addi $t1, $fp, -236 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L15: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L16# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L15# go to top of loop
L16: # done!
li $t1, 3
sw $t1, -240($fp) # Store temp
lw $t1, -240($fp) # get temp
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 46, 41, 101, 99, 110, 111, 32, 116, 97
L17: .word 32
.text
la $t1, L17
sw $t1, -244($fp) # Store temp
addi $t1, $fp, -244 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L18: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L19# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L18# go to top of loop
L19: # done!
li $t1, 1
sw $t1, -252($fp) # Store temp
lw $t2, -252($fp) # get temp
sub $t1, $0, $t2
sw $t1, -248($fp) # Store temp
lw $t1, 12($gp) # Get stackframe for combatantadd
addi $t1, $t1, -44 # Local: &combatantadd
lw $t2, -248($fp) # get temp
sw $t2, 0($t1) # Store value into the function return value
L13: # End of if statement
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

L20:
# Function combatantpicktarget
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L21
L21:
li $a0, 0 # seed id 0
li $v0, 41 # Service: random
syscall
move $t1, $a0 # load result
andi $t1, $t1, 0x7fffffff # mask off sign bit
sw $t1, -72($fp) # Store temp
li $t1, 2147483647
sw $t1, -80($fp) # Store temp
.data
L22: .float 1
.text
l.s $f4, L22
swc1 $f4, -84($fp) # Store temp
lw $t2, -80($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -84
l.s $f8, 0($t3)
add.s $f4, $f6, $f8
swc1 $f4, -76($fp) # Store temp
lw $t2, -72($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -76
l.s $f8, 0($t3)
div.s $f4, $f6, $f8
swc1 $f4, -68($fp) # Store temp
li $t1, 3
sw $t1, -88($fp) # Store temp
addi $t2, $fp, -68
l.s $f6, 0($t2)
lw $t3, -88($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
mul.s $f4, $f6, $f8
swc1 $f4, -64($fp) # Store temp
addi $t1, $fp, -64
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -60($fp) # Store temp
li $t1, 1
sw $t1, -92($fp) # Store temp
lw $t2, -60($fp) # get temp
lw $t3, -92($fp) # get temp
add $t1, $t2, $t3
sw $t1, -56($fp) # Store temp
lw $t1, 16($gp) # Get stackframe for combatantpicktarget
addi $t1, $t1, -52 # Local: &result
lw $t2, -56($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L23: # Beginning of while loop
lw $t1, 16($gp) # Get stackframe for combatantpicktarget
addi $t1, $t1, -52 # Local: &result
sw $t1, -108($fp) # Store temp
lw $t1, 16($gp) # Get stackframe for combatantpicktarget
lw $t1, -48($t1) # Argument: &*combatantindex
sw $t1, -112($fp) # Store temp
lw $t2, -108($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -112($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -104($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 16($gp) # Get stackframe for combatantpicktarget
addi $t1, $t1, -52 # Local: &result
sw $t1, -124($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -124($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -116 # Get attribute team
sw $t1, -120($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 16($gp) # Get stackframe for combatantpicktarget
lw $t1, -48($t1) # Argument: &*combatantindex
sw $t1, -132($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -132($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -116 # Get attribute team
sw $t1, -128($fp) # Store temp
lw $t2, -120($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -128($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -116($fp) # Store temp
lw $t2, -104($fp) # get temp
lw $t3, -116($fp) # get temp
add $t1, $t2, $t3
sw $t1, -100($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 16($gp) # Get stackframe for combatantpicktarget
addi $t1, $t1, -52 # Local: &result
sw $t1, -144($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -144($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -96 # Get attribute hp
sw $t1, -140($fp) # Store temp
li $t1, 0
sw $t1, -148($fp) # Store temp
lw $t2, -140($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -148($fp) # get temp
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -136($fp) # Store temp
lw $t2, -100($fp) # get temp
lw $t3, -136($fp) # get temp
add $t1, $t2, $t3
sw $t1, -96($fp) # Store temp
lw $t1, -96($fp) # get temp
beq $t1, $0, L24 # Branch if we are equal to 0 (FALSE)
li $a0, 0 # seed id 0
li $v0, 41 # Service: random
syscall
move $t1, $a0 # load result
andi $t1, $t1, 0x7fffffff # mask off sign bit
sw $t1, -168($fp) # Store temp
li $t1, 2147483647
sw $t1, -176($fp) # Store temp
.data
L25: .float 1
.text
l.s $f4, L25
swc1 $f4, -180($fp) # Store temp
lw $t2, -176($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -180
l.s $f8, 0($t3)
add.s $f4, $f6, $f8
swc1 $f4, -172($fp) # Store temp
lw $t2, -168($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -172
l.s $f8, 0($t3)
div.s $f4, $f6, $f8
swc1 $f4, -164($fp) # Store temp
li $t1, 3
sw $t1, -184($fp) # Store temp
addi $t2, $fp, -164
l.s $f6, 0($t2)
lw $t3, -184($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
mul.s $f4, $f6, $f8
swc1 $f4, -160($fp) # Store temp
addi $t1, $fp, -160
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -156($fp) # Store temp
li $t1, 1
sw $t1, -188($fp) # Store temp
lw $t2, -156($fp) # get temp
lw $t3, -188($fp) # get temp
add $t1, $t2, $t3
sw $t1, -152($fp) # Store temp
lw $t1, 16($gp) # Get stackframe for combatantpicktarget
addi $t1, $t1, -52 # Local: &result
lw $t2, -152($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
j L23# Jump to the beginning of the while loop
L24: # End of while loop
lw $t1, 16($gp) # Get stackframe for combatantpicktarget
addi $t1, $t1, -52 # Local: &result
sw $t1, -192($fp) # Store temp
lw $t1, 16($gp) # Get stackframe for combatantpicktarget
addi $t1, $t1, -44 # Local: &combatantpicktarget
lw $t2, -192($fp) # get temp
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
sw $t1, 16($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L26:
# Function combatantattack
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L27
L27:
.data # String literal as words (written in reverse).
.word 0, 32, 32, 32
L28: .word 32
.text
la $t1, L28
sw $t1, -60($fp) # Store temp
addi $t1, $fp, -60 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L29: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L30# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L29# go to top of loop
L30: # done!
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -48($t1) # Argument: &*combatantindex
sw $t1, -68($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -68($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute name
sw $t1, -64($fp) # Store temp
addi $t1, $fp, -64 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
L31: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L32# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L31# go to top of loop
L32: # done!
.data # String literal as words (written in reverse).
.word 0, 32, 115, 107, 99, 97, 116, 116, 97
L33: .word 32
.text
la $t1, L33
sw $t1, -72($fp) # Store temp
addi $t1, $fp, -72 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L34: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L35# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L34# go to top of loop
L35: # done!
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -52($t1) # Argument: &*targetindex
sw $t1, -80($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -80($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute name
sw $t1, -76($fp) # Store temp
addi $t1, $fp, -76 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
L36: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L37# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L36# go to top of loop
L37: # done!
.data # String literal as words (written in reverse).
.word 0, 10
L38: .word 33
.text
la $t1, L38
sw $t1, -84($fp) # Store temp
addi $t1, $fp, -84 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L39: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L40# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L39# go to top of loop
L40: # done!
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -52($t1) # Argument: &*targetindex
sw $t1, -92($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -92($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -112 # Get attribute defending
sw $t1, -88($fp) # Store temp
lw $t1, -88($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
beq $t1, $0, L41 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
.data # String literal as words (written in reverse).
.word 0, 32, 32, 32
L43: .word 32
.text
la $t1, L43
sw $t1, -96($fp) # Store temp
addi $t1, $fp, -96 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L44: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L45# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L44# go to top of loop
L45: # done!
.data # String literal as words (written in reverse).
.word 0, 32, 116, 117
L46: .word 66
.text
la $t1, L46
sw $t1, -100($fp) # Store temp
addi $t1, $fp, -100 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L47: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L48# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L47# go to top of loop
L48: # done!
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -52($t1) # Argument: &*targetindex
sw $t1, -108($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -108($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute name
sw $t1, -104($fp) # Store temp
addi $t1, $fp, -104 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
L49: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L50# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L49# go to top of loop
L50: # done!
.data # String literal as words (written in reverse).
.word 0, 107, 99, 97, 116, 116, 97, 32, 101, 104, 116, 32, 100, 101, 107, 99, 111, 108, 98
L51: .word 32
.text
la $t1, L51
sw $t1, -112($fp) # Store temp
addi $t1, $fp, -112 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L52: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L53# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L52# go to top of loop
L53: # done!
.data # String literal as words (written in reverse).
.word 0, 10
L54: .word 33
.text
la $t1, L54
sw $t1, -116($fp) # Store temp
addi $t1, $fp, -116 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L55: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L56# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L55# go to top of loop
L56: # done!
j L42# Jump to the end of the if
L41: # Else statement 
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -48($t1) # Argument: &*combatantindex
sw $t1, -136($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -136($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -104 # Get attribute atk
sw $t1, -132($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -52($t1) # Argument: &*targetindex
sw $t1, -144($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -144($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -108 # Get attribute def
sw $t1, -140($fp) # Store temp
lw $t2, -132($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -140($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
sub $t1, $t2, $t3
sw $t1, -128($fp) # Store temp
li $a0, 0 # seed id 0
li $v0, 41 # Service: random
syscall
move $t1, $a0 # load result
andi $t1, $t1, 0x7fffffff # mask off sign bit
sw $t1, -160($fp) # Store temp
li $t1, 2147483647
sw $t1, -168($fp) # Store temp
.data
L57: .float 1
.text
l.s $f4, L57
swc1 $f4, -172($fp) # Store temp
lw $t2, -168($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -172
l.s $f8, 0($t3)
add.s $f4, $f6, $f8
swc1 $f4, -164($fp) # Store temp
lw $t2, -160($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -164
l.s $f8, 0($t3)
div.s $f4, $f6, $f8
swc1 $f4, -156($fp) # Store temp
li $t1, 5
sw $t1, -176($fp) # Store temp
addi $t2, $fp, -156
l.s $f6, 0($t2)
lw $t3, -176($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
mul.s $f4, $f6, $f8
swc1 $f4, -152($fp) # Store temp
addi $t1, $fp, -152
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -148($fp) # Store temp
lw $t2, -128($fp) # get temp
lw $t3, -148($fp) # get temp
add $t1, $t2, $t3
sw $t1, -124($fp) # Store temp
li $t1, 0
sw $t1, -180($fp) # Store temp
# Call function max.
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
addi $t1, $fp, -124 # get address of temp
sw $t1, -48($sp)
addi $t1, $fp, -180 # get address of temp
sw $t1, -52($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 76 # expand stack
la $t7, L6 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
sw $t1, -120($fp) # Store temp
lw $t1, 20($gp) # Get stackframe for combatantattack
addi $t1, $t1, -56 # Local: &damage
lw $t2, -120($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
.data # String literal as words (written in reverse).
.word 0, 32, 32, 32
L58: .word 32
.text
la $t1, L58
sw $t1, -184($fp) # Store temp
addi $t1, $fp, -184 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L59: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L60# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L59# go to top of loop
L60: # done!
.data # String literal as words (written in reverse).
.word 0, 32, 116, 108, 97, 101
L61: .word 68
.text
la $t1, L61
sw $t1, -188($fp) # Store temp
addi $t1, $fp, -188 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L62: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L63# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L62# go to top of loop
L63: # done!
lw $t1, 20($gp) # Get stackframe for combatantattack
addi $t1, $t1, -56 # Local: &damage
sw $t1, -192($fp) # Store temp
lw $t1, -192($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 32, 111, 116, 32, 101, 103, 97, 109, 97, 100
L64: .word 32
.text
la $t1, L64
sw $t1, -196($fp) # Store temp
addi $t1, $fp, -196 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L65: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L66# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L65# go to top of loop
L66: # done!
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -52($t1) # Argument: &*targetindex
sw $t1, -204($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -204($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute name
sw $t1, -200($fp) # Store temp
addi $t1, $fp, -200 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
L67: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L68# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L67# go to top of loop
L68: # done!
.data # String literal as words (written in reverse).
.word 0, 10
L69: .word 46
.text
la $t1, L69
sw $t1, -208($fp) # Store temp
addi $t1, $fp, -208 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L70: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L71# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L70# go to top of loop
L71: # done!
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -52($t1) # Argument: &*targetindex
sw $t1, -224($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -224($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -96 # Get attribute hp
sw $t1, -220($fp) # Store temp
lw $t1, 20($gp) # Get stackframe for combatantattack
addi $t1, $t1, -56 # Local: &damage
sw $t1, -228($fp) # Store temp
lw $t2, -220($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -228($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
sub $t1, $t2, $t3
sw $t1, -216($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -52($t1) # Argument: &*targetindex
sw $t1, -212($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -212($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -96 # Get attribute hp
lw $t2, -216($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -52($t1) # Argument: &*targetindex
sw $t1, -240($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -240($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -96 # Get attribute hp
sw $t1, -236($fp) # Store temp
li $t1, 0
sw $t1, -244($fp) # Store temp
lw $t2, -236($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -244($fp) # get temp
slt $t1, $t3, $t2
sltiu $t1, $t1, 1
sw $t1, -232($fp) # Store temp
lw $t1, -232($fp) # get temp
beq $t1, $0, L73 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
li $t1, 0
sw $t1, -252($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -52($t1) # Argument: &*targetindex
sw $t1, -248($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -248($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -96 # Get attribute hp
lw $t2, -252($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
.data # String literal as words (written in reverse).
.word 0, 32, 33, 119, 111, 108, 98, 32, 108, 97, 116, 97, 102, 32
L74: .word 65
.text
la $t1, L74
sw $t1, -256($fp) # Store temp
addi $t1, $fp, -256 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L75: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L76# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L75# go to top of loop
L76: # done!
# Array index (subscript #0 - part one)
lw $t1, 20($gp) # Get stackframe for combatantattack
lw $t1, -52($t1) # Argument: &*targetindex
sw $t1, -264($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -264($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute name
sw $t1, -260($fp) # Store temp
addi $t1, $fp, -260 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
L77: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L78# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L77# go to top of loop
L78: # done!
.data # String literal as words (written in reverse).
.word 0, 10, 46, 108, 108, 101, 102
L79: .word 32
.text
la $t1, L79
sw $t1, -268($fp) # Store temp
addi $t1, $fp, -268 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L80: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L81# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L80# go to top of loop
L81: # done!
L73: # End of if statement
L42: # End of if statement
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

L82:
# Function combatantdefend
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L83
L83:
li $t1, 1
sw $t1, -56($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 24($gp) # Get stackframe for combatantdefend
lw $t1, -48($t1) # Argument: &*combatantindex
sw $t1, -52($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -52($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -112 # Get attribute defending
lw $t2, -56($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
.data # String literal as words (written in reverse).
.word 0, 32, 32, 32
L84: .word 32
.text
la $t1, L84
sw $t1, -60($fp) # Store temp
addi $t1, $fp, -60 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L85: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L86# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L85# go to top of loop
L86: # done!
# Array index (subscript #0 - part one)
lw $t1, 24($gp) # Get stackframe for combatantdefend
lw $t1, -48($t1) # Argument: &*combatantindex
sw $t1, -68($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -68($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute name
sw $t1, -64($fp) # Store temp
addi $t1, $fp, -64 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
L87: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L88# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L87# go to top of loop
L88: # done!
.data # String literal as words (written in reverse).
.word 0, 10, 46, 103, 110, 105, 100, 110, 101, 102, 101, 100, 32, 115, 105
L89: .word 32
.text
la $t1, L89
sw $t1, -72($fp) # Store temp
addi $t1, $fp, -72 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L90: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L91# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L90# go to top of loop
L91: # done!
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

L92:
# Function combatantupdate
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L93
L93:
li $t1, 0
sw $t1, -64($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 28($gp) # Get stackframe for combatantupdate
lw $t1, -48($t1) # Argument: &*combatantindex
sw $t1, -60($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -60($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -112 # Get attribute defending
lw $t2, -64($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
li $a0, 0 # seed id 0
li $v0, 41 # Service: random
syscall
move $t1, $a0 # load result
andi $t1, $t1, 0x7fffffff # mask off sign bit
sw $t1, -80($fp) # Store temp
li $t1, 2147483647
sw $t1, -88($fp) # Store temp
.data
L94: .float 1
.text
l.s $f4, L94
swc1 $f4, -92($fp) # Store temp
lw $t2, -88($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -92
l.s $f8, 0($t3)
add.s $f4, $f6, $f8
swc1 $f4, -84($fp) # Store temp
lw $t2, -80($fp) # get temp
mtc1 $t2, $f6 # move value into float register
cvt.s.w $f6, $f6 # convert to real
addi $t3, $fp, -84
l.s $f8, 0($t3)
div.s $f4, $f6, $f8
swc1 $f4, -76($fp) # Store temp
li $t1, 20
sw $t1, -96($fp) # Store temp
addi $t2, $fp, -76
l.s $f6, 0($t2)
lw $t3, -96($fp) # get temp
mtc1 $t3, $f8 # move value into float register
cvt.s.w $f8, $f8 # convert to real
mul.s $f4, $f6, $f8
swc1 $f4, -72($fp) # Store temp
addi $t1, $fp, -72
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -68($fp) # Store temp
lw $t1, 28($gp) # Get stackframe for combatantupdate
addi $t1, $t1, -56 # Local: &roll
lw $t2, -68($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
 # Beginning of if statement
lw $t1, 28($gp) # Get stackframe for combatantupdate
addi $t1, $t1, -56 # Local: &roll
sw $t1, -104($fp) # Store temp
li $t1, 10
sw $t1, -108($fp) # Store temp
lw $t2, -104($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -108($fp) # get temp
slt $t1, $t2, $t3
sw $t1, -100($fp) # Store temp
lw $t1, -100($fp) # get temp
beq $t1, $0, L95 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
lw $t1, 28($gp) # Get stackframe for combatantupdate
lw $t1, -48($t1) # Argument: &*combatantindex
sw $t1, -116($fp) # Store temp
# Call function combatantpicktarget.
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
addi $t1, $fp, -116 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 196 # expand stack
la $t7, L20 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
sw $t1, -112($fp) # Store temp
lw $t1, 28($gp) # Get stackframe for combatantupdate
addi $t1, $t1, -52 # Local: &targetindex
lw $t2, -112($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
lw $t1, 28($gp) # Get stackframe for combatantupdate
lw $t1, -48($t1) # Argument: &*combatantindex
sw $t1, -120($fp) # Store temp
lw $t1, 28($gp) # Get stackframe for combatantupdate
addi $t1, $t1, -52 # Local: &targetindex
sw $t1, -124($fp) # Store temp
# Call function combatantattack.
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
addi $t1, $fp, -120 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
addi $t1, $fp, -124 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -52($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 272 # expand stack
la $t7, L26 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
j L96# Jump to the end of the if
L95: # Else statement 
lw $t1, 28($gp) # Get stackframe for combatantupdate
lw $t1, -48($t1) # Argument: &*combatantindex
sw $t1, -128($fp) # Store temp
# Call function combatantdefend.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 24($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 24($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -128 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 76 # expand stack
la $t7, L82 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
L96: # End of if statement
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 28($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L97:
# Function countliving
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L98
L98:
# Beginning of for loop
li $t1, 1
sw $t1, -60($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -412 # Local: &teamcount
sw $t1, -64($fp) # Store temp
lw $t1, 32($gp) # Get stackframe for countliving
addi $t1, $t1, -56 # Local: &i
lw $t2, -60($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L99: # Start the for loop
lw $t2, -64($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t1, 32($gp) # Get stackframe for countliving
addi $t1, $t1, -56 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L100 # Jump to the end if we are done, increasing
li $t1, 0
sw $t1, -72($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 32($gp) # Get stackframe for countliving
addi $t1, $t1, -56 # Local: &i
sw $t1, -68($fp) # Store temp
lw $t1, 32($gp) # Get stackframe for countliving
lw $t1, -48($t1) # Argument: &*standings
# Array index (subscript #0 - part two)
lw $t2, -68($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 2 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
lw $t2, -72($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
lw $t1, 32($gp) # Get stackframe for countliving
addi $t1, $t1, -56 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L99 # Return to the start label
L100: # End of for loop
# Beginning of for loop
li $t1, 1
sw $t1, -76($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
sw $t1, -80($fp) # Store temp
lw $t1, 32($gp) # Get stackframe for countliving
addi $t1, $t1, -56 # Local: &i
lw $t2, -76($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L101: # Start the for loop
lw $t2, -80($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t1, 32($gp) # Get stackframe for countliving
addi $t1, $t1, -56 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L102 # Jump to the end if we are done, increasing
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 32($gp) # Get stackframe for countliving
addi $t1, $t1, -56 # Local: &i
sw $t1, -92($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -92($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -96 # Get attribute hp
sw $t1, -88($fp) # Store temp
li $t1, 0
sw $t1, -96($fp) # Store temp
lw $t2, -88($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -96($fp) # get temp
slt $t1, $t3, $t2
sw $t1, -84($fp) # Store temp
lw $t1, -84($fp) # get temp
beq $t1, $0, L104 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
# Array index (subscript #0 - part one)
# Array index (subscript #0 - part one)
lw $t1, 32($gp) # Get stackframe for countliving
addi $t1, $t1, -56 # Local: &i
sw $t1, -120($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -120($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -116 # Get attribute team
sw $t1, -116($fp) # Store temp
lw $t1, 32($gp) # Get stackframe for countliving
lw $t1, -48($t1) # Argument: &*standings
# Array index (subscript #0 - part two)
lw $t2, -116($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 2 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -112($fp) # Store temp
li $t1, 1
sw $t1, -124($fp) # Store temp
lw $t2, -112($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -124($fp) # get temp
add $t1, $t2, $t3
sw $t1, -108($fp) # Store temp
# Array index (subscript #0 - part one)
# Array index (subscript #0 - part one)
lw $t1, 32($gp) # Get stackframe for countliving
addi $t1, $t1, -56 # Local: &i
sw $t1, -104($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -104($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -116 # Get attribute team
sw $t1, -100($fp) # Store temp
lw $t1, 32($gp) # Get stackframe for countliving
lw $t1, -48($t1) # Argument: &*standings
# Array index (subscript #0 - part two)
lw $t2, -100($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 2 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
lw $t2, -108($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L104: # End of if statement
lw $t1, 32($gp) # Get stackframe for countliving
addi $t1, $t1, -56 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L101 # Return to the start label
L102: # End of for loop
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 32($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L105:
# Function battledone
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L106
L106:
li $t1, 0
sw $t1, -64($fp) # Store temp
lw $t1, 36($gp) # Get stackframe for battledone
addi $t1, $t1, -60 # Local: &done
lw $t2, -64($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
lw $t1, 36($gp) # Get stackframe for battledone
addi $t1, $t1, -52 # Local: &standings
sw $t1, -68($fp) # Store temp
# Call function countliving.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 32($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 32($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -68 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 128 # expand stack
la $t7, L97 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
# Beginning of for loop
li $t1, 1
sw $t1, -72($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -412 # Local: &teamcount
sw $t1, -76($fp) # Store temp
lw $t1, 36($gp) # Get stackframe for battledone
addi $t1, $t1, -48 # Local: &i
lw $t2, -72($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L107: # Start the for loop
lw $t2, -76($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t1, 36($gp) # Get stackframe for battledone
addi $t1, $t1, -48 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L108 # Jump to the end if we are done, increasing
 # Beginning of if statement
# Array index (subscript #0 - part one)
lw $t1, 36($gp) # Get stackframe for battledone
addi $t1, $t1, -48 # Local: &i
sw $t1, -88($fp) # Store temp
lw $t1, 36($gp) # Get stackframe for battledone
addi $t1, $t1, -52 # Local: &standings
# Array index (subscript #0 - part two)
lw $t2, -88($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 2 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 4 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
sw $t1, -84($fp) # Store temp
li $t1, 0
sw $t1, -92($fp) # Store temp
lw $t2, -84($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -92($fp) # get temp
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -80($fp) # Store temp
lw $t1, -80($fp) # get temp
beq $t1, $0, L110 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
li $t1, 1
sw $t1, -96($fp) # Store temp
lw $t1, 36($gp) # Get stackframe for battledone
addi $t1, $t1, -60 # Local: &done
lw $t2, -96($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L110: # End of if statement
lw $t1, 36($gp) # Get stackframe for battledone
addi $t1, $t1, -48 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L107 # Return to the start label
L108: # End of for loop
lw $t1, 36($gp) # Get stackframe for battledone
addi $t1, $t1, -60 # Local: &done
sw $t1, -100($fp) # Store temp
lw $t1, 36($gp) # Get stackframe for battledone
addi $t1, $t1, -44 # Local: &battledone
lw $t2, -100($fp) # get temp
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
sw $t1, 36($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L111:
# Function runbattle
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L112
L112:
L113: # Beginning of while loop
# Call function battledone.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 36($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 36($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
move $fp, $sp # update frame pointer
subi $sp, $sp, 104 # expand stack
la $t7, L105 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
sw $t1, -56($fp) # Store temp
lw $t2, -56($fp) # get temp
sltiu $t1, $t2, 1
sw $t1, -52($fp) # Store temp
lw $t1, -52($fp) # get temp
beq $t1, $0, L114 # Branch if we are equal to 0 (FALSE)
# Beginning of for loop
li $t1, 1
sw $t1, -60($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
sw $t1, -64($fp) # Store temp
lw $t1, 40($gp) # Get stackframe for runbattle
addi $t1, $t1, -48 # Local: &i
lw $t2, -60($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L115: # Start the for loop
lw $t2, -64($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t1, 40($gp) # Get stackframe for runbattle
addi $t1, $t1, -48 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L116 # Jump to the end if we are done, increasing
 # Beginning of if statement
# Call function battledone.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 36($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 36($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
move $fp, $sp # update frame pointer
subi $sp, $sp, 104 # expand stack
la $t7, L105 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
sw $t1, -76($fp) # Store temp
lw $t2, -76($fp) # get temp
sltiu $t1, $t2, 1
sw $t1, -72($fp) # Store temp
# Array index (subscript #0 - part one)
lw $t1, 40($gp) # Get stackframe for runbattle
addi $t1, $t1, -48 # Local: &i
sw $t1, -88($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -88($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -96 # Get attribute hp
sw $t1, -84($fp) # Store temp
li $t1, 0
sw $t1, -92($fp) # Store temp
lw $t2, -84($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -92($fp) # get temp
slt $t1, $t3, $t2
sw $t1, -80($fp) # Store temp
lw $t2, -72($fp) # get temp
lw $t3, -80($fp) # get temp
and $t1, $t2, $t3
sw $t1, -68($fp) # Store temp
lw $t1, -68($fp) # get temp
beq $t1, $0, L118 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
# Array index (subscript #0 - part one)
lw $t1, 40($gp) # Get stackframe for runbattle
addi $t1, $t1, -48 # Local: &i
sw $t1, -100($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -100($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -0 # Get attribute name
sw $t1, -96($fp) # Store temp
addi $t1, $fp, -96 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
L119: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L120# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L119# go to top of loop
L120: # done!
.data # String literal as words (written in reverse).
.word 0, 10, 33, 110, 114, 117, 116, 32, 115
L121: .word 39
.text
la $t1, L121
sw $t1, -104($fp) # Store temp
addi $t1, $fp, -104 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L122: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L123# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L122# go to top of loop
L123: # done!
lw $t1, 40($gp) # Get stackframe for runbattle
addi $t1, $t1, -48 # Local: &i
sw $t1, -108($fp) # Store temp
# Call function combatantupdate.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 28($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 28($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -108 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 132 # expand stack
la $t7, L92 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
L118: # End of if statement
lw $t1, 40($gp) # Get stackframe for runbattle
addi $t1, $t1, -48 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L115 # Return to the start label
L116: # End of for loop
.data # String literal as words (written in reverse).
.word 0
L124: .word 10
.text
la $t1, L124
sw $t1, -112($fp) # Store temp
addi $t1, $fp, -112 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L125: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L126# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L125# go to top of loop
L126: # done!
# Beginning of for loop
li $t1, 1
sw $t1, -116($fp) # Store temp
li $t1, 50000
sw $t1, -120($fp) # Store temp
lw $t1, 40($gp) # Get stackframe for runbattle
addi $t1, $t1, -48 # Local: &i
lw $t2, -116($fp) # get temp
sw $t2, 0($t1) # Store the starting value
L127: # Start the for loop
lw $t2, -120($fp) # get temp
lw $t1, 40($gp) # Get stackframe for runbattle
addi $t1, $t1, -48 # Local: &i
lw $t1, 0($t1) # Load the number into the register
blt $t2, $t1, L128 # Jump to the end if we are done, increasing
lw $t1, 40($gp) # Get stackframe for runbattle
addi $t1, $t1, -48 # Local: &i
lw $t2, 0($t1) # Load into memory
addi $t2, $t2, 1 # Increment by 1
sw $t2, 0($t1) # Save the value 
j L127 # Return to the start label
L128: # End of for loop
j L113# Jump to the beginning of the while loop
L114: # End of while loop
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 40($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L1:
li $t1, 0
sw $t1, -420($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -408 # Local: &combatantcount
lw $t2, -420($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
li $t1, 2
sw $t1, -424($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -412 # Local: &teamcount
lw $t2, -424($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 111
L129: .word 66
.text
la $t1, L129
sw $t1, -428($fp) # Store temp
li $t1, 300
sw $t1, -432($fp) # Store temp
li $t1, 30
sw $t1, -436($fp) # Store temp
li $t1, 4
sw $t1, -440($fp) # Store temp
li $t1, 1
sw $t1, -444($fp) # Store temp
# Call function combatantadd.
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
addi $t1, $fp, -428 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
sw $t1, -48($sp)
addi $t1, $fp, -432 # get address of temp
sw $t1, -144($sp)
addi $t1, $fp, -436 # get address of temp
sw $t1, -148($sp)
addi $t1, $fp, -440 # get address of temp
sw $t1, -152($sp)
addi $t1, $fp, -444 # get address of temp
sw $t1, -156($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 256 # expand stack
la $t7, L10 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 101, 109, 105, 108
L130: .word 83
.text
la $t1, L130
sw $t1, -448($fp) # Store temp
li $t1, 50
sw $t1, -452($fp) # Store temp
li $t1, 12
sw $t1, -456($fp) # Store temp
li $t1, 2
sw $t1, -460($fp) # Store temp
li $t1, 2
sw $t1, -464($fp) # Store temp
# Call function combatantadd.
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
addi $t1, $fp, -448 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
sw $t1, -48($sp)
addi $t1, $fp, -452 # get address of temp
sw $t1, -144($sp)
addi $t1, $fp, -456 # get address of temp
sw $t1, -148($sp)
addi $t1, $fp, -460 # get address of temp
sw $t1, -152($sp)
addi $t1, $fp, -464 # get address of temp
sw $t1, -156($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 256 # expand stack
la $t7, L10 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
.data # String literal as words (written in reverse).
.word 0, 0, 0, 110, 97, 109, 115, 101, 108, 97, 83, 32, 110, 105, 109, 97, 116, 105, 86, 32, 108, 105, 118
L131: .word 69
.text
la $t1, L131
sw $t1, -468($fp) # Store temp
li $t1, 200
sw $t1, -472($fp) # Store temp
li $t1, 23
sw $t1, -476($fp) # Store temp
li $t1, 15
sw $t1, -480($fp) # Store temp
li $t1, 2
sw $t1, -484($fp) # Store temp
# Call function combatantadd.
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
addi $t1, $fp, -468 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
sw $t1, -48($sp)
addi $t1, $fp, -472 # get address of temp
sw $t1, -144($sp)
addi $t1, $fp, -476 # get address of temp
sw $t1, -148($sp)
addi $t1, $fp, -480 # get address of temp
sw $t1, -152($sp)
addi $t1, $fp, -484 # get address of temp
sw $t1, -156($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 256 # expand stack
la $t7, L10 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
# Call function runbattle.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 40($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 40($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
move $fp, $sp # update frame pointer
subi $sp, $sp, 124 # expand stack
la $t7, L111 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
 # Beginning of if statement
# Array index (subscript #0 - part one)
li $t1, 1
sw $t1, -496($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for textfun
addi $t1, $t1, -48 # Local: &combatants
# Array index (subscript #0 - part two)
lw $t2, -496($fp) # get temp
li $t3, 1 # lower bound 
li $t4, 3 # upper bound
blt $t2, $t3, IndexOutOfBounds # i < lower? error.
bgt $t2, $t4, IndexOutOfBounds # i > upper? error.
addi $t2, $t2, -1 # We need to reposition relative to the actual memory location.
li $t3, 120 # t3 = sizeof(array subtype).
mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype).
sub $t1, $t1, $t2 # base -= t2
addi $t1, $t1, -96 # Get attribute hp
sw $t1, -492($fp) # Store temp
li $t1, 0
sw $t1, -500($fp) # Store temp
lw $t2, -492($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -500($fp) # get temp
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -488($fp) # Store temp
lw $t1, -488($fp) # get temp
beq $t1, $0, L132 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
.data # String literal as words (written in reverse).
.word 0, 10, 114, 101, 118, 111, 32, 101, 109, 97
L134: .word 71
.text
la $t1, L134
sw $t1, -504($fp) # Store temp
addi $t1, $fp, -504 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L135: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L136# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L135# go to top of loop
L136: # done!
j L133# Jump to the end of the if
L132: # Else statement 
.data # String literal as words (written in reverse).
.word 0, 10, 33, 121, 114, 111, 116, 99, 105
L137: .word 86
.text
la $t1, L137
sw $t1, -508($fp) # Store temp
addi $t1, $fp, -508 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L138: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L139# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L138# go to top of loop
L139: # done!
L133: # End of if statement
# Exit the program.
li $v0, 10
syscall

