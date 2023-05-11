                
.module decimos

fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
        
                .globl ver_decimos
                .globl imprime_cadena
                .globl error_switch
                .globl limpia_pantalla
                .globl programa
                .globl salir

                .globl valor_decimos
                .globl decimos
var1: .byte 0
var2: .byte 0

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
contador:    .byte 0
temp:        .byte 0
tam_decimo:  .byte 0

ver:     .asciz "Los decimos actuales son...\n\n"
txtintroducirdecimos: .asciz "\nCuantos decimos va a introducir?:"


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
    beq decimos_introducir; CAMBIAR
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
    ;LIMPIA PANTALLA
    ldx #ver
    jsr imprime_cadena
    
    lda #0
    ldx #valor_decimos
    
for:

    cmpa decimos_NUM
    bge salir_bucle0
    jsr imprime_cadena
    adda #1
    ldb #'\n
    stb pantalla
    bra for

salir_bucle0:

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

decimos_introducir:
    ldx #limpia_pantalla
    jsr imprime_cadena
    ldx #txtintroducirdecimos
    jsr imprime_cadena

    lda teclado
    suba #'0
    sta var1
    lda teclado
    suba #'0
    sta var2

    ldb #10
    lda var1
    mul
    addb var2

    stb decimos_NUM
    
    ldx #valor_decimos
    stx temp

for_introducir:

        lda decimos_NUM
        sta contador

bucle_decimos:

        lda #5
        sta tam_decimo

cargadecimo:

        lda teclado
        sta ,x+
        dec tam_decimo
        bne cargadecimo

        ldx temp
        leax 6, x
        stx temp

        ldb #'\n
        stb pantalla

        dec contador
        bne bucle_decimos

fin_introducir:

        ldx #salir
        jsr imprime_cadena
        lda teclado
        cmpa #'c
        lbeq decimos
        cmpa #'C
        lbeq decimos
        ldx #error_switch
        jsr imprime_cadena
        bra fin_introducir