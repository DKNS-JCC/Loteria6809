                
                .module decimos

fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
        
                .globl ver_decimos
                .globl imprime_cadena
                .globl error_switch
                .globl limpia_pantalla
                .globl programa
                .globl imprime_cadena_seguida
                .globl salir

                .globl decimos

m_decimos:      .ascii  "\n\33[32m=========DECIMOS==========\n"
                .ascii  "\33[33m1. Ver\n"
                .ascii  "\33[34m2. Introducir resultados\n"
                .asciz  "\33[35m3. Volver\n"

valor_decimos:  .ascii  "65401"
                .ascii  "15315"
                .ascii  "56454"
                .ascii  "65401"
                .ascii  "54545"
                .ascii  "14575"
                .ascii  "48571"
                .ascii  "54523"
                .ascii  "65453"
                .ascii  "54435"
                .asciz  "94461\n"

decimos_MAX: .byte 11
decimos_NUM: .byte 11

ver:     .asciz "Los decimos actuales son...\n\n"


decimos:
    ldx #limpia_pantalla
    jsr imprime_cadena
    ldx #m_decimos
    jsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    jsr imprime_cadena 
    cmpa #'1 ; 1. Ver
    beq ver_decimos; Si es 1, va a decimos_ver
    cmpa #'2 ; 2. Introducir resultados
    beq decimos; CAMBIAR
    cmpa #'3 ; 3. Volver
    beq programa_decimos    ; Si es 3, vuelve al menu principal
    ldx #error_switch
    jsr imprime_cadena
    bra decimos

programa_decimos:
    jsr programa

ver_decimos:
    ldx #limpia_pantalla
    jsr imprime_cadena
    ldx #ver
    jsr imprime_cadena
    ldx #valor_decimos
    jsr imprime_cadena_seguida
    ldx #salir
    jsr imprime_cadena
    lda teclado
    cmpa #'c
    beq decimos
    cmpa #'C
    beq decimos
    ldx #error_switch
    jsr imprime_cadena
    bra ver_decimos


