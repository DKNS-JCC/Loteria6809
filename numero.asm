        .module numeros_sorteo

        .globl  primer.premio
        .globl  segundo.premio
        .globl  tercer.premio
        .globl  cuatro.cifras
        .globl  tres.cifras
        .globl  dos.cifras
        .globl  reintegro

        .globl  cantidad_4cifras
        .globl  cantidad_3cifras
        .globl  cantidad_2cifras
        .globl  cantidad_reintegro


cantidad_4cifras:       .byte 2
cantidad_3cifras:       .byte 14
cantidad_2cifras:       .byte 5
cantidad_reintegro:     .byte 3

        

primer.premio:
        .asciz "89603"
segundo.premio:

        .asciz "72289"
tercer.premio:
        .asciz "18918"

cuatro.cifras:
        .asciz "6338"
        .asciz "8173"
tres.cifras:
        .asciz "224"
        .asciz "231"
        .asciz "266"
        .asciz "278"
        .asciz "300"
        .asciz "387"
        .asciz "457"
        .asciz "527"
        .asciz "538"
        .asciz "550"
        .asciz "726"
        .asciz "760"
        .asciz "888"
        .asciz "928"
dos.cifras:
        .asciz "11"
        .asciz "18"
        .asciz "24"
        .asciz "29"
        .asciz "41"
reintegro:
        .asciz "3"
        .asciz "4"
        .asciz "9"

        
