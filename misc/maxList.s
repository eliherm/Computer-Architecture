	.text
	.global	_start
	.org 0
	
_start:
	movia	sp, 0x7FFFFC
	movia	r2, LIST
	call	MaxList
	
_end:
	br		_end
	
MaxList:
	subi	sp, sp, 12
	stw 	r3, 8(sp)
	stw		r4, 4(sp)
	stw		r5, 0(sp)
	
	ldw		r4, N(r0)
	mov		r5, r0
	
max_loop:
	ldw		r3, 0(r2)
if:
	blt		r3, r5, end_if
then:
	mov		r5, r3
end_if:
	addi	r2, r2, 4
	subi 	r4, r4, 1
	bgt 	r4, r0, max_loop
	
	mov		r2, r5
	ldw		r3, 8(sp)
	ldw		r4, 4(sp)
	ldw		r5, 0(sp)
	addi	sp, sp, 12
	ret				
	
#---------------------------
	.org 0x1000
N:	
	.word	5
LIST:		
	.word	1,4,3,2,4
	.end			
	