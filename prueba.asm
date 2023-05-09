                
                .module decimos
                .area PROG (ABS)
                .org 0x100

fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00

                .globl imprime_cadena
                .globl limpia_pantalla
                .globl error_switch
        

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
                .asciz  "94461"

decimos_MAX: .byte 11
decimos_NUM: .byte 11

ver:     .asciz "Los decimos actuales son...\n"


decimos:

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
    rts

ver_decimos:

    ldx #ver
    jsr imprime_cadena
    lda #0
    ldx #valor_decimos

for:    
    cmpa #11
    beq salir_bucle
    jsr imprime_cadena
    adda #1

salir_bucle:
    ;ldx #salir
    jsr imprime_cadena
    lda teclado
    cmpa #'c
    beq decimos
    cmpa #'C
    beq decimos
    nop



                            
