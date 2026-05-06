; =========================================================================================
; FASM - Rosetta Code Collection (Linux x86_64)
; =========================================================================================

format ELF64 executable 3
segment readable executable

entry main

main:
    ; 1. Hello World
    mov     rax, 1          ; sys_write
    mov     rdi, 1          ; stdout
    mov     rsi, msg_hello
    mov     rdx, 13
    syscall

    ; 7. Empty Program (already part of this structure)

    ; 8. A+B (Simple Example: 5 + 7)
    mov     rax, 5
    add     rax, 7          ; rax = 12

    ; 6. FizzBuzz (1 to 100)
    mov     ecx, 1
.fizzloop:
    push    rcx
    mov     eax, ecx
    xor     edx, edx
    mov     ebx, 15
    div     ebx
    test    edx, edx
    jz      .fizzbuzz_print
    
    mov     eax, ecx
    xor     edx, edx
    mov     ebx, 3
    div     ebx
    test    edx, edx
    jz      .fizz_print
    
    mov     eax, ecx
    xor     edx, edx
    mov     ebx, 5
    div     ebx
    test    edx, edx
    jz      .buzz_print
    jmp     .next_fizz

.fizzbuzz_print:
    mov     rsi, msg_fb
    mov     rdx, 8
    jmp     .do_print
.fizz_print:
    mov     rsi, msg_f
    mov     rdx, 4
    jmp     .do_print
.buzz_print:
    mov     rsi, msg_b
    mov     rdx, 4
.do_print:
    mov     rax, 1
    mov     rdi, 1
    syscall
.next_fizz:
    pop     rcx
    inc     ecx
    cmp     ecx, 101
    jne     .fizzloop

    ; Exit
    mov     rax, 60         ; sys_exit
    xor     rdi, rdi
    syscall

; 2. Fibonacci (Iterative logic)
; Input: ecx (n), Output: rax
fib:
    xor     rax, rax        ; a = 0
    mov     rbx, 1          ; b = 1
.loop:
    test    ecx, ecx
    jz      .done
    mov     rdx, rax
    add     rdx, rbx        ; tmp = a + b
    mov     rax, rbx        ; a = b
    mov     rbx, rdx        ; b = tmp
    dec     ecx
    jmp     .loop
.done:
    ret

; 3. Factorial
; Input: rax (n), Output: rax
factorial:
    mov     rcx, rax
    mov     rax, 1
.fact_loop:
    cmp     rcx, 1
    jle     .fact_done
    mul     rcx
    dec     rcx
    jmp     .fact_loop
.fact_done:
    ret

; 5. Bubble Sort (Minimal implementation)
; rsi = array ptr, rdi = length
bubble_sort:
    dec     rdi
.outer:
    xor     rcx, rcx        ; swapped = 0
    xor     rdx, rdx        ; j = 0
.inner:
    mov     eax, [rsi + rdx*4]
    cmp     eax, [rsi + rdx*4 + 4]
    jle     .no_swap
    xchg    eax, [rsi + rdx*4 + 4]
    mov     [rsi + rdx*4], eax
    inc     rcx
.no_swap:
    inc     rdx
    cmp     rdx, rdi
    jl      .inner
    test    rcx, rcx
    jz      .done_sort
    dec     rdi
    jnz     .outer
.done_sort:
    ret

; 10. Quine (Conceptual layout - FASM can use `file` directive)
quine:
    ; A true ASM quine typically uses the data segment to point back to its instructions
    ; or uses sys_open/sys_read on __FILE__ (linux)

; 11. Launch Rocket (Countdown)
launch:
    mov     ecx, 10
.count:
    ; ... print T-minus ecx ...
    ; sys_nanosleep here for timing
    dec     ecx
    jns     .count
    ret

; 13. Universal Lambda (Church Zero)
lambda_zero:
    ; λf.λx.x
    mov     rax, rdi        ; Return the second argument (x)
    ret

; 18. Chat Server (Socket logic)
init_socket:
    mov     rax, 41         ; sys_socket
    mov     rdi, 2          ; AF_INET
    mov     rsi, 1          ; SOCK_STREAM
    xor     rdx, rdx
    syscall
    ret

segment readable
    msg_hello db 'Hello world!', 10
    msg_f     db 'Fizz', 10
    msg_b     db 'Buzz', 10
    msg_fb    db 'FizzBuzz', 10

segment readable writeable
    array     dd 5, 2, 8, 1, 9
    doors     db 101 dup (0)  ; Task 9: 100 doors