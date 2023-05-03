       .module comparaciones
       pantalla     .equ   0xFF00
       teclado      .equ   0xFF02
                    .include "numeros.asm"
                    .include "manejo_cadenas.asm"


primer_5cifras:  .ascii "Primer premio de 5 cifras equivale a 1000 puntos\n"
segundo_5cifras: .ascii "Segundo premio de 5 cifras equivale a 500 puntos\n"
tercer_5cifras:  .ascii "Tercer premio de 5 cifras equivale a 200 puntos\n"
cuatro_cifras:  .ascii "Terminacion de 4 cifras equivale a 50 puntos\n"
tres_cifras:    .ascii "Terminacion de 3 cifras equivale a 10 puntos\n"
segundo_cifras: .ascii "Terminacion de 2 cifras equivale a 5 puntos\n"
reintegro:      .ascii "Terminacion de 1 cifra (reintegro) equivale a 1 punto\n"

puntuaje:       .word 0
                .globl  comparacion_5cifras
                .globl  comparacion_4cifras
                .globl  comparacion_3cifras
                .globl  comparacion_2cifras
                .globl comparacion_reintegro

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
        jsr     comparacion_4cifras

comparacion_4cifras;
        