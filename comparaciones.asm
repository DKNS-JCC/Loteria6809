       .module comparaciones
       pantalla     .equ   0xFF00
       teclado      .equ   0xFF02
                    .include "numeros.asm"
                    .include "manejo_cadenas.asm"

primer_5cifras: .asciz "Primer premio de 5 cifras equivale a 1000 puntos\n"
segundo_5cifras:.asciz "Segundo premio de 5 cifras equivale a 500 puntos\n"
tercero_5cifras:.asciz "Tercer premio de 5 cifras equivale a 200 puntos\n"
cuatro_cifras:  .asciz "Terminacion de 4 cifras equivale a 50 puntos\n"
tres_cifras:    .asciz "Terminacion de 3 cifras equivale a 10 puntos\n"
dos_cifras:     .asciz "Terminacion de 2 cifras equivale a 5 puntos\n"
reintegros:     .asciz "Terminacion de 1 cifra (reintegro) equivale a 1 punto\n"

puntuaje:     .word 0
                .globl  comparacion_5cifras
                .globl  comparacion_4cifras
                .globl  comparacion_3cifras
                .globl  bucle_despazamiento4cifras
                .globl  bucle_despazamiento3cifras
                .globl  bucle_despazamiento2cifras
                .globl  bucle_despazamientoreintegros


comparacion_5cifras:
        pshs    a
        lda     puntuaje
        cmps    #primer.premio
        bne     else1
        adda    #1000
        ldx     #primer_5cifras
        jsr     imprime_cadena
        jsr     comparacion_4cifras

else1:
        cmps    #segundo.premio
        bne     else2
        adda    #500
        ldx     #segundo_5cifras
        jsr     imprime_cadena
        jsr     comparacion_4cifras

else2:
        cmps    #tercer.premio
        bne     else3
        adda    #200
        ldx     #tercer_5cifras
        jsr     imprime_cadena
        jsr     comparacion_4cifras

else3:
        jsr comparacion_4cifras

comparacion_4cifras:
        leay    #cuatro.cifras,+1
        cmps    y
        bne     
        ldx     #cuatro_cifras
        jsr     imprime_cadena

bucle_despazamiento4cifras:
bucle_despazamiento3cifras:
bucle_despazamiento2cifras:
bucle_despazamientoreintegros: