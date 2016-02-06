.text
#Code principal
main:
	li $t1, 7
	sub $sp, $sp, 4
	sw $t1, 0($sp)
	jal print_int
	sub $sp, $sp, 4
	sw $zero, 0($sp)
	jal print_newline
	li $t1, 1
	sub $sp, $sp, 4
	sw $t1, 0($sp)
	li $t1, 2
	sub $sp, $sp, 4
	sw $t1, 0($sp)
	li $t1, 3
	sub $sp, $sp, 4
	sw $t1, 0($sp)
	lw $t1, 0($sp)
	add $sp, $sp, 4
	lw $t2, 0($sp)
	add $sp, $sp, 4
	mul $t1, $t1, $t2
	sub $sp, $sp, 4
	sw $t1, 0($sp)
	lw $t1, 0($sp)
	add $sp, $sp, 4
	lw $t2, 0($sp)
	add $sp, $sp, 4
	add $t1, $t1, $t2
	sub $sp, $sp, 4
	sw $t1, 0($sp)
	jal print_int
#Fin
end_exec:
	li $v0, 10
	syscall
#Primitives
print_newline:
	lw $zero, 0($sp)
	add $sp, $sp, 4
	li $v0, 11
	li $a0, 10
	syscall
	sub $sp, $sp, 4
	sw $zero, 0($sp)
	jr $ra
print_int:
	lw $a0, 0($sp)
	add $sp, $sp, 4
	li $v0, 1
	syscall
	jr $ra
.data
