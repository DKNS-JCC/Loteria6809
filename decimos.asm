                
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
                .globl imprime_num
                .globl acumulador

cuenteo: .byte 0


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
n1:          .byte 0
n2:          .byte 0
n_digitos:   .byte 0


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
    ldx #ver
    jsr imprime_cadena
	lda #'\n
	sta pantalla

	ldb decimos_NUM
	ldx #valor_decimos
	jsr imprime_num

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
    sta n1
    lda teclado
    suba #'0
    sta n2

    ldb #10
    lda n1
    mul
    addb n2
    
    cmpb #decimos_MAX
    bhi decimos_introducir


    lda #'\n
    sta pantalla

    stb decimos_NUM
    
    ldx #valor_decimos
    stx temp ; Guardamos la direccion de memoria de valor_decimos en temp para modificarlo sin afectar a valor_decimos

for_introducir:

        clr acumulador
        lda decimos_NUM
        sta acumulador

decimo_a_decimo:

        lda #5 ; 5 numeros por decimo
        sta cuenteo   ; n_digitos = 5

digitos:

        lda teclado ; Cargamos el numero introducido por teclado
        sta ,x+    ; Lo guardamos en la direccion de memoria de temp        
        dec cuenteo ; Decrementamos el contador
        bne digitos ; Si el contador es distinto de 0, repetimos el bucle
        ldx temp    ; Cargamos la direccion de memoria de temp en x
        leax 6, x   ; Le sumamos 6 a x para que apunte al siguiente decimo
        stx temp    ; Guardamos la direccion de memoria de temp en temp
        ldb #'\n        ; Cargamos el salto de linea en b
        stb pantalla    ; Guardamos el salto de linea en pantalla
        dec acumulador      ; Decrementamos el acumulador
        bne decimo_a_decimo   ; Si el acumulador es distinto de 0, repetimos el bucle

fin_introducir:
        jsr decimos ; Volvemos a decimos