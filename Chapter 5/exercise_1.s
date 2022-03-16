


.global _main	//program starting address
.align 2

_main:	
	//print asciz data type
	
	//linux write system call
	mov	x0,	#1			//stdout = 1
	adrp	x1,	my_word@PAGE		//load word address into x1
	add	x1, 	x1,	my_word@PAGEOFF	//end the offset
	mov	x2,	#12			//length of the string
	mov	x16,	#4			//darwin write system call
	
	

.data
my_word:	.word 0x1234ABCD
my_asciz:	.asciz "Hello world\n"
my_byte:	.byte 0xF1

