       .module comparaciones
       pantalla     .equ   0xFF00
       teclado      .equ   0xFF02
                    .include "numeros.asm"
                    .include "manejo_cadenas.asm"

premios:
                .ascii "Primer premio de 5 cifras equivale a 1000 puntos\n"
                .ascii "Segundo premio de 5 cifras equivale a 500 puntos\n"
                .ascii "Tercer premio de 5 cifras equivale a 200 puntos\n"
                .ascii "Terminacion de 4 cifras equivale a 50 puntos\n"
                .ascii "Terminacion de 3 cifras equivale a 10 puntos\n"
                .ascii "Terminacion de 2 cifras equivale a 5 puntos\n"
                .ascii "Terminacion de 1 cifra (reintegro) equivale a 1 punto\n"

acumulador:     .word 0
                .globl  main
                .globl  comparacion_primero
                .globl  comparacion_segundo
                .globl  comparacion_tercero


comparacion_5cifras:
        pshs a
        lda acumulador
        cmps #primer.premio
        bne else1
        adda #1000
        jmp comparacion_4cifras

else1:
        cmps #segundo.premio
        bne else2
        adda #500
        jmp comparacion_4cifras

else2:
        cmps #tercer.premio
        bne else3
        adda #200
        jmp comparacion_4cifras

else3:
        jmp comparacion_4cifras

comparacion_4cifras