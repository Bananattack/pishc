L0:
# Initialize main frame pointer.
subi $fp, $sp, -104
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
sw $t1, -92($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for main
addi $t1, $t1, -84 # Local: &a
lw $t2, -92($fp) # get temp
mtc1 $t2, $f4 # move value into float register
cvt.s.w $f4, $f4 # convert to real
swc1 $f4, 0($t1) # Store value into a variable
.data
L2: .word 104, 101, 121, 0, 0, 0, 0, 0, 0, 0
.text
la $t1, L2
sw $t1, -96($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for main
addi $t1, $t1, -44 # Local: &test
lw $t2, -96($fp)
# Copy 4 words into t1 from t2
lw $t1, 0($t2)
subi $t1, $t1, 4
lw $t1, -4($t2)
subi $t1, $t1, 4
lw $t1, -8($t2)
subi $t1, $t1, 4
lw $t1, -12($t2)
subi $t1, $t1, 4
.data
L3: .word 10, 0
.text
la $t1, L3
sw $t1, -100($fp) # Store temp
lw $t1, -100($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
# Exit the program.
li $v0, 10
syscall

