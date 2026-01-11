.global _main  // Declare the entry point of the program
.global _my_function
.align 4  // Align the next instruction to a 4 byte memory 

_main: 

	mov x1, 2
	mov x0, 3
	bl _examples_add_two_ints

	add x0, x0, #0x30

	strb w0, [sp, #-16]!
	mov x0, #1	 ; arg 0: file descriptor (stdout = 1)
	mov x1, sp	 ; pointer to the start of bytes to write
	mov x2, #1   ; number of bytes to write (1)
	mov x16, #4  ; write is system call no 4 
	svc #0x80

	add sp, sp, #16  ; clean up the stack 

	adr X1, message  // char* X1 = &message 
	mov X2, #14      // put the length of message into X2 
	bl print         // call print subroutine 



	; mov X0, #0       // Move exit code 0 into X0
	b exit           // jump to exit

_my_function:
	stp x29, x30, [sp, #-16]! ; store the Frame Pointer (FP) and link register (LR) onto the stack 
	mov x29, sp               ; set the Frame Pointer to the current Stack Pointer 

	add x0, x0, x1

	mov sp, x29
	ldp x29, x30, [sp], #16   ; restore Frame Pointer (FP) and Link Register (LR) from the stack 
	ret												; return from the function

print:
	mov X16, #4  // 4 = syscall 'write'
	mov X0, #1   // 1 = stdout fd
	svc #0x80		 // execute syscall
	ret          // Return to the caller address (saved in register X30)

exit:
	mov X16, #1 	// 1 = 'exit' syscall
	svc #0x80

message:
	.ascii "Hello World\n"
