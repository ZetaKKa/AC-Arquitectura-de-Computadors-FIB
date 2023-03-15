 .text
	.align 4
	.globl Buscar
	.type Buscar,@function
Buscar:
        # Aqui viene vuestro codigo
        pushl %ebp
        movl %esp, %ebp
        subl $16, %esp              #4*4ints => 16B
        
        movl $-1, -4(%ebp)          #trobat = -1
        
        movl $0, -16(%ebp)          #low = 0
        
        movl $0, -8(%ebp)           #mid = 0 = low
        
        movl 24(%ebp), %eax         #N
        decl %eax                   #N-1
        
        movl %eax, -12(%ebp)        #high = N-1

while:  movl -16(%ebp), %edx        #low
        movl -12(%ebp), %eax        #high
        cmpl %eax, %edx
        jg return                  #low > high
        
        pushl 8(%ebp)               #@v
        pushl 20(%ebp)              #X.m
        pushl 16(%ebp)              #X.k
        pushl 12(%ebp)              #X.c
        leal -8(%ebp), %eax         #eax <- &mid
        pushl %eax                  
        leal -12(%ebp), %eax        #eax <- &high
        pushl %eax                  
        leal -16(%ebp), %eax        #eax <- &low
        pushl %eax 
        call BuscarElemento
        
        addl $28, %esp              #4*7pushl => 28B
        
        movl %eax, -4(%ebp)         #trobat = BuscarElemento()
        
        #if
        cmpl $0, %eax
        jl while                    #0 < trobat, no fa el break
        
return: movl -4(%ebp), %eax         #return trobat
        movl %ebp,%esp
        popl %ebp
        ret
