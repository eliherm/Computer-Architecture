	.text
	.global _start
	.org 0
	
_start:
	movia	sp, 0x7FFFFC
	movia	r2, LIST
	call	FindValue
	
_end:
	br		_end		
	
FindValue:
	subi	sp, sp, 16
	stw		r3, 12(sp)	#local ptr
	stw		r4, 8(sp)	#N
	stw		r5, 4(sp)	#Val
	stw		r6, 0(sp)	#Count
	
	ldw		r4, N(r0)
	ldw		r5, VAL(r0)
	mov		r6, r0
	
loop:
	ldw		r3, 0(r2)
if:
	bne		r3, r5, end_if
then:
	addi	r6, r6, 1
end_if:
	addi	r2, r2, 4
	subi	r4, r4, 1
	bgt		r4, r0, loop
	mov		r2, r6
	
	ldw		r3, 12(sp)	
	ldw		r4, 8(sp)	
	ldw		r5, 4(sp)	
	ldw		r6, 0(sp)
	addi	sp, sp, 16
	ret
	
#-----------------------------------
	.org	0x1000
N:	
	.word	5
VAL:
	.word	34	
LIST:
	.word	1, 17, 34, 17, 1	
	.end
									