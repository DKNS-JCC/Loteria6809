    .module sorteo

fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00

    .globl sorteo_introducir_3premios
    .globl sorteo_introducir_4cifras
    .globl sorteo_introducir_3cifras
    .globl sorteo_introducir_2cifras
    .globl sorteo_introducir_reintegros

    .globl imprime_cadena
    .globl limpia_pantalla
    .globl error_switch
    .globl programa


    .globl sorteo




m_sorteo:       .ascii  "\33[33m=========SORTEO========== \n"
                .ascii  "\33[34m1. Ver Resultados\n"
                .ascii  "\33[35m2. Introducir Resultados\n"
                .asciz  "\33[36m3. Volver\n"

m_sorteo2:      .ascii  "\33[35m=========INTRODUCIR RESULTADOS==========\n"
                .ascii  "\33[31m1. 3 Primeros premios\n"
                .ascii  "\33[32m2. Terminaciones 4 cifras\n"
                .ascii  "\33[33m3. Terminaciones 3 cifras\n"
                .ascii  "\33[34m4. Terminaciones 2 cifras\n"
                .ascii  "\33[35m5. Reintegros\n"
                .asciz  "\33[36m6. Volver\n"

sorteo:
    ldx #m_sorteo
    jsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    jsr imprime_cadena 
    cmpa #'1 ; 1. Ver resultados
    beq sorteo_ver; Si es 1, va a sorteo_ver
    cmpa #'2 ; 2. Introducir resultados
    beq sorteo_introducir; Si es 2, va a sorteo_introducir
    cmpa #'3 ; 3. Volver
    beq programa_j  ; Si es 3, vuelve al menu principal
    ldx #error_switch
    jsr imprime_cadena
    bra sorteo

programa_j:
    jsr programa

sorteo_ver:
    ;;llamar a la funcion que imprime los resultados
    rts

sorteo_introducir:
    ldx #m_sorteo2
    jsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    jsr imprime_cadena 
    cmpa #'1 ; 1. 3 primeros premios
    beq sorteo_ver; Si es 1, va a sorteo_introducir_3premios
    cmpa #'2 ; 2. Terminaciones 4 cifras
    beq sorteo_ver; Si es 2, va a sorteo_introducir_2
    cmpa #'3 ; 3. Terminaciones 3 cifras
    beq sorteo_ver; Si es 3, va a sorteo_introducir_3
    cmpa #'4 ; 4. Terminaciones 2 cifras
    beq sorteo_ver; Si es 4, va a sorteo_introducir_4
    cmpa #'5 ; 5. Reintegros
    beq sorteo_ver; Si es 5, va a sorteo_introducir_5
    cmpa #'6 ; 6. Volver
    beq sorteo;    ; Si es 6, vuelve al menu sorteo
    ldx #error_switch
    jsr imprime_cadena
    bra sorteo_introducir

sorteo_introducir_3premios:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce los 3 premios
    rts

sorteo_introducir_4cifras:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce las terminaciones de 4 cifras
    rts

sorteo_introducir_3cifras:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce las terminaciones de 3 cifras
    rts

sorteo_introducir_2cifras:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce las terminaciones de 2 cifras
    rts

sorteo_introducir_reintegros:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce los reintegros
    rts
    