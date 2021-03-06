//
// Assembler program to print "Hello World!"
// to stdout.
//
// X0-X2 - parameters to Unix system calls
// X16 - Mach System Call function number
//

.global _start			// Provide program starting address to linker

// Setup the parameters to print hello world
// and then call the Kernel to do it.

.global _start
.align 2

_start: mov x0, 1	   // 1 = StdOut
	adr x1, helloworld // string to print
	mov x2, #18 	   // length of our string
	mov x16, #4	   // Unix write system call
	svc #0x80	   // Call kernel to output the string

// Setup the parameters to exit the program
// and then call the kernel to do it.
	mov x0, 0 	   // Use 0 return code
	mov x16, #1	   // System call number 1 terminates this program
	svc #0x80	   // Call kernel to terminate the program


helloworld:      .ascii  "learning assembly!\n"
