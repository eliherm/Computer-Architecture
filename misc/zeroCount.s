	.text
	.global _start
	.org 0
	
_start:
	movia	sp, 0x7FFFFC
	movia	r2, LIST
	call	ZeroCount
	
_end:
	br		_end		
	
ZeroCount:
	subi	sp, sp, 12
	stw		r3, 8(sp)	#local ptr
	stw		r4, 4(sp)	#N
	stw		r5, 0(sp)	#Count
	
	ldw		r4, N(r0)
	mov		r5, r0
	
loop:
	ldw		r3, 0(r2)
if:
	bne		r3, r0, end_if
then:
	addi	r5, r5, 1
end_if:
	addi	r2, r2, 4
	subi	r4, r4, 1
	bgt		r4, r0, loop
	stw		r5, COUNT(r0)
	
	ldw		r3, 8(sp)
	ldw		r4, 4(sp)	
	ldw		r5, 0(sp)	
	addi	sp, sp, 12
	ret
	
#-----------------------------------
	.org	0x1000
COUNT:
	.skip	4	
N:	
	.word	5
LIST:
	.word	0, 0, 57, 0, 0	
	.end
									