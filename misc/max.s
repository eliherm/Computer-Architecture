	.text
	.global _start
	.org 0
	
_start:
	movia	sp, 0x7FFFFC
	call 	Max
	call	PrintChar
	
_end:
	br 		_end	
	
Max:
	subi	sp, sp, 8
	stw 	r3, 4(sp)
	stw 	r4, 0(sp)
	
	ldw		r3, A(r0)
	ldw		r4, B(r0)
if:
	blt		r3, r4, else
then:
	mov		r2, r3
	br		end_if
else:
	mov 	r2, r4
end_if:
	ldw		r3, 4(sp)
	ldw		r4, 0(sp)
	addi	sp, sp, 8
	ret
	
PrintChar:
	subi	sp, sp, 8 
	stw		r3, 4(sp) #JTAG UART register
	stw		r4, 0(sp)
	movia	r3, 0x10001000
	
pc_loop:
	ldwio	r4, 4(r3)
	andhi	r4, r4, 0xFFFF
	beq		r4, r0, pc_loop
	
	stwio	r2, 0(r3)
	ldw		r3, 4(sp)
	ldw		r4, 0(sp)
	addi	sp, sp, 8
	ret

#------------------------------------	
	.org 	0x1000
A:	.word	5
B:	.word	9
	.end					
				