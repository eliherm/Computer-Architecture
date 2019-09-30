	.equ LAST_RAM_WORD,   0x007FFFFC
	.equ JTAG_UART_BASE,  0x10001000
	.equ DATA_OFFSET,     0
	.equ STATUS_OFFSET,   4
	.equ WSPACE_MASK,     0xFFFF
	
	.text
	.global _start
	.org	0x00000000
	
_start:
	movia	sp, LAST_RAM_WORD
	movia	r2, MSG1
	call	PrintString
	movia	r2, MSG2
	call	PrintString
	call	GetDecimal99
	movia	r3, NUMBER
	stw		r2, 0(r3)
	movi	r2, '\n'
	call	PrintChar
	movia	r2, MSG3
	call	PrintString
	ldw		r2, 0(r3)
	call	PrintDecimal99
	movi	r2, '\n'
	call	PrintChar
	
_end:
	br		_end
	
#----------------------------------------------------------------------------------		
	
PrintChar:
	subi	sp, sp, 8
	stw 	r3, 4(sp)
	stw 	r4, 0(sp)
	movia 	r3, JTAG_UART_BASE
pc_loop:
	ldwio	r4, STATUS_OFFSET(r3)
	andhi	r4, r4, WSPACE_MASK
	beq		r4, r0, pc_loop
	stwio	r2, DATA_OFFSET(r3)
	ldw		r3, 4(sp)
	ldw 	r4, 0(sp)
	addi	sp, sp, 8
	ret  				
	
PrintString:
	subi	sp, sp, 12
	stw 	ra, 8(sp)
	stw 	r3, 4(sp)
	stw 	r2, 0(sp)
	mov		r3, r2
ps_loop:
	ldb 	r2, 0(r3)
	beq 	r2, r0, end_ps_loop
	call 	PrintChar
	addi	r3, r3, 1
	br 		ps_loop
end_ps_loop:
	ldw 	ra, 8(sp)
	ldw 	r3, 4(sp)
	ldw 	r2, 0(sp)
	addi	sp, sp, 12
	ret			

GetChar:
	subi	sp, sp, 8
	stw 	r3, 4(sp)
	stw 	r4, 0(sp)   #Data 
	movia 	r3, JTAG_UART_BASE
gc_loop:
	ldwio 	r4, DATA_OFFSET(r3)
	andi	r2, r4, 0x8000	
	beq		r2, r0, gc_loop
	andi	r2, r4, 0xFF
	
	ldw		r3, 4(sp)
	ldw		r4, 0(sp)
	addi	sp, sp, 8
	ret

GetDecimal99:
	subi	sp, sp, 12
	stw		ra, 8(sp)
	stw		r3, 4(sp) #result 	
	stw		r4, 0(sp) #temp holder
	mov		r3, r0
	
gd_loop1:
	call	GetChar
	movi	r4, '0'
	blt		r2, r4, gd_loop1	
	movi	r4, '9'	
	bgt		r2, r4, gd_loop1
	call	PrintChar
	subi	r3, r2, '0'
	muli	r3, r3, 10
gd_loop2:
	call	GetChar
	movi	r4, '0'
	blt		r2, r4, gd_loop2	
	movi	r4, '9'	
	bgt		r2, r4, gd_loop2
	call	PrintChar
	subi	r4, r2, '0'
	add		r3, r3, r4
	mov		r2, r3
	
	ldw		ra, 8(sp)
	ldw		r3, 4(sp) 	
	ldw		r4, 0(sp)
	addi	sp, sp, 12
	ret

PrintDecimal99:
	subi	sp, sp, 20
	stw		ra, 16(sp)
	stw		r2, 12(sp)
	stw		r3, 8(sp) #q
	stw		r4, 4(sp) #r
	stw		r5, 0(sp)
	movi	r5, 10
	
	div		r3, r2, r5
	mov     r5, r2		
	addi	r2, r3, '0'
	call	PrintChar
	
	muli	r3, r3, 10
	sub		r4, r5, r3
	addi	r2, r4, '0'
	call	PrintChar
	
	ldw		ra, 16(sp)
	ldw		r2, 12(sp)
	ldw		r3, 8(sp) 
	ldw		r4, 4(sp) 
	ldw		r5, 0(sp)
	addi	sp, sp, 20
	ret
	
#-----------------------------------------------------------------------------
.org	0x1000
NUMBER:	.skip   4
MSG1:	.asciz	"ELEC274 Lab 3\n"
MSG2:	.asciz	"Type two decimal digits: "	
MSG3:	.asciz	"You typed: "	
.end	