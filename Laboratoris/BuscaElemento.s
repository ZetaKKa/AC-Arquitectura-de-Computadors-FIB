.text
	.align 4
	.globl BuscarElemento
	.type BuscarElemento,@function
BuscarElemento:
        # Aqui viene vuestro codigo

        pushl %ebp
        movl %esp, %ebp
        pushl %ebx
        pushl %esi
        
        movl 16(%ebp), %eax     #eax <- mid
        movl (%eax), %eax       #eax <- *mid
        movl 32(%ebp), %ecx     #ecx <- @v
        imull $12, %eax          #eax <- 12*(*mid)
        addl %eax, %ecx         #ecx <- @v + 12*(*mid) => v[*mid]
        
        movl 24(%ebp), %ebx     #edx <- x.k
        
        cmpl 4(%ecx), %ebx      #v[*mid].k
        jne else_1              #x.k != v[*mid].k
        
        #if1
        movl 16(%ebp), %eax     #eax <- mid
        movl (%eax), %eax       #eax <- *mid
        jmp return
    
else_1: movl 16(%ebp), %ecx     #ecx <- mid
        movl (%ecx), %ecx       #ecx <- *mid
        movl 12(%ebp), %edx     #edx <- high
        movl (%edx), %edx       #edx <- *high
        
        cmpl %edx, %ecx
        jge else_2              #*mid >= *high
        
        #if2
        movl 16(%ebp), %eax
        movl %edx, (%eax)         #*mid = *high
        
        movl 8(%ebp), %esi      #esi <- low
        movl (%esi), %esi       #esi <- *low
        addl $1, %esi           #eax <- (*low)++
        movl 8(%ebp), %edx      #edx <- low
        movl %esi, (%edx)       #edx <- (*low)++
        jmp end
        
else_2: movl 8(%ebp), %ecx      #ecx <- low
        movl (%ecx), %ecx       #ecx <- *low
        
        movl 16(%ebp), %eax     #eax <- mid
        movl %ecx, (%eax)       #*mid = *low
        
        subl $1, %edx           #edx <- (*high)--
        movl 12(%ebp), %ecx     #ecx <- *high
        movl %edx, (%ecx)       #ecx <- (*high)--
        jmp end
    
end:    movl $-1, %eax          #return -1
        jmp return
        
return: popl %esi
        popl %ebx
        movl %ebp, %esp
        popl %ebp
        ret
