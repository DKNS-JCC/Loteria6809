        .module numeros_sorteo
        pantalla    .equ   0xFF00
        teclado     .equ   0xFF02
        consola     .equ   0xFF01
                    .org   0x100

primer.premio:
            .asciz #'89603
segundo.premio:
            .asciz #'72289
tercero.premio:
            .asciz #'18918
cuatro.cifras:
            .asciz #'06338
            .asciz #'08173
tres.cifras:
            .asciz #'00224
            .asciz #'00231
            .asciz #'00266
            .asciz #'00278
            .asciz #'00300
            .asciz #'00387
            .asciz #'00457
            .asciz #'00527
            .asciz #'00538
            .asciz #'00550
            .asciz #'00726
            .asciz #'00760
            .asciz #'00888
            .asciz #'00928
dos.cifras:
            .asciz #'00011
            .asciz #'00018
            .asciz #'00024
            .asciz #'00029
            .asciz #'00041
reintegro:
            .asciz #'00003
            .asciz #'00004
            .asciz #'00009

        
