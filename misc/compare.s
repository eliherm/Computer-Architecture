	.text
	.global _start
	.org 0
	
_start:
	ldw		r2, A(r0)
	ldw 	r3, B(r0)
	movi	r4, 5
	
if:
	bgt		r2, r4, else
then:
	movi	r4, 39
	stw		r4, C(r0)
	br		_end
else:
	addi	r3, r3, 13
	stw		r3, C(r0)
	
_end:
	br		_end

#-------------------------	
	.org 	0x1000
A:	.word 	20
B: 	.word 	10
C:	.skip 	4
	.end							