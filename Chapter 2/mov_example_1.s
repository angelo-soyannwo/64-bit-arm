
//
// Examples of mov instruction
//
.global _main
.align 2

// Load X2 with 0x1234FEDC4F5D6E3A
// mov sets all bits in the detination register to zero before loading in the new bits
// movk loads in bits without erasing content that's already there.

_main: mov  x2, #0x6E34         // load in the immediate value into x2
       movk x2, #0x4F5D, LSL 16 // shift out the immediate value 16 bits before loading into x2
       movk x2, #0xFEDC, LSL 32 // shift out the immediate value 32 bits before loading into x2
       movk x2, #0x1234, LSL 48 // shift out the immediate value 48 bits before loading into x2

// Just move W2 into W1
       mov  w1, w2

// Repeat the above shifts using the Assembler mnemonics.
       LSL  x1, x2, #1 // Logical shift left
       LSR  x1, x2, #1 // Logical shift right
       ASR  x1, x2, #1 //Arithmetic shift right
       ror  x1, x2, #1 // Rotate right

// Setup the parameters to exit the program
// and then call the kernel to do it.
       mov  x0, #0     // Use 0 return code
       mov  x16, #1    // System call number 1 terminates this
       svc  #0x80      // Call kernel to terminate this
