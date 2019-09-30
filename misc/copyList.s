	.text
	.global	_start
	.org 0
	
_start:
	movia	sp, 0x7FFFFC
	movia	r2, LIST1
	movia	r3, LIST2
	call	CopyList
	
_end:
	br		_end 
	
CopyList:
	subi	sp, sp, 8
	stw		r4, 4(sp) #N
	stw		r5, 0(sp) #local ptr
	
	ldw		r4, N(r0)
loop:
	ldw		r5, 0(r2)
	stw		r5, 0(r3)
	addi	r2, r2, 4
	addi	r3, r3, 4
	subi	r4, r4, 1
	bgt		r4, r0, loop
	
	ldw		r4, 4(sp) 
	ldw		r5, 0(sp)
	addi	sp, sp, 8
	ret
	
#-----------------------------
	.org 0x1000
N:	.word	5
LIST1:
	.word	1,6,2,8,3
LIST2:
	.skip	20
	.end							
	