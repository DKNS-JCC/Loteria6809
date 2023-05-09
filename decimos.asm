                
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

                .globl valor_decimos
                .globl decimos

m_decimos:      .ascii  "\n\33[32m=========DECIMOS==========\n"
                .ascii  "\33[33m1. Ver\n"
                .ascii  "\33[34m2. Introducir resultados\n"
                .asciz  "\33[35m3. Volver\n"

valor_decimos:  .asciz  "89603"
                .asciz  "15315"
                .asciz  "56454"
                .asciz  "65301"
                .asciz  "54545"
                .asciz  "14575"
                .asciz  "48571"
                .asciz  "54523"
                .asciz  "65453"
                .asciz  "54435"
                .asciz  "94461"

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
    lda #0
    ldx #valor_decimos
    
for:

    cmpa decimos_NUM
    bge salir_bucle
    jsr imprime_cadena
    adda #1
    ldb #'\n
    stb pantalla
    bra for

salir_bucle:

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


