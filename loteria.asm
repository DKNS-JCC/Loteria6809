            .module loteria6809
            .org 0x100

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			; Fin definicion de constantes
            

			; Inicio declaración de variables


menu_p:         .ascii "\33[31m=====LOTERIA 6809=====\n"
                .ascii  "\33[32m1. DECIMOS\n"
                .ascii  "\33[33m2. SORTEO\n"
                .ascii  "\33[34m3. COMPROBAR\n"
                .asciz  "\33[35m4. SALIR\n"


m_decimos:      .ascii  "\33[32m=========DECIMOS==========\n"
                .ascii  "\33[33m1. Ver\n"
                .ascii  "\33[34m2. Introducir resultados\n"
                .asciz  "\33[35m3. Volver\n"


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


m_comprobar:      .asciz  "\31[34m=========COMPROBAR==========\n"

error_switch:     .asciz  "\33[31mOpcion incorrecta, intentelo de nuevo.\n"
limpia_pantalla:  .asciz  "\033[2J"

            .globl programa
            .globl imprime_cadena
            .globl ver_decimos
            			; Fin declaración de variables
	        	
; Comienzo del programa
programa:

    lds #0xFF00

    ldx #menu_p
    jsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    jsr imprime_cadena 
    cmpa #'1 ; 1. Decimos
    beq decimos; Si es 1, va a decimos
    cmpa #'2 ; 2. Sorteo
    beq sorteo; Si es 2, va a sorteo
    cmpa #'3 ; 3. Comprobar
    beq comprobar ; Si es 3, va a comprobar
    cmpa #'4 ; 4. Salir
    beq acabar  ; Si es 4, va a salir

mensaje_error:
    ldx #error_switch
    jsr imprime_cadena
    jmp programa

acabar: 	clra
	sta 	fin

comprobar:     
    ldx #m_comprobar
    jsr imprime_cadena
    jmp acabar

decimos:
    ldx #m_decimos
    jsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    jsr imprime_cadena 
    cmpa #'1 ; 1. Ver
    ;beq ver_decimos; Si es 1, va a decimos_ver
    cmpa #'2 ; 2. Introducir resultados
    beq decimos; CAMBIAR
    cmpa #'3 ; 3. Volver
    beq programa    ; Si es 3, vuelve al menu principal
    ldx #error_switch
    jsr imprime_cadena
    jmp decimos

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
    beq programa    ; Si es 3, vuelve al menu principal
    ldx #error_switch
    jsr imprime_cadena
    jmp sorteo

sorteo_ver:
    ;;llamar a la funcion que imprime los resultados
    jmp acabar

sorteo_introducir:
    ldx #m_sorteo2
    jsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    jsr imprime_cadena 
    cmpa #'1 ; 1. 3 primeros premios
    beq sorteo_introducir_3premios; Si es 1, va a sorteo_introducir_3premios
    cmpa #'2 ; 2. Terminaciones 4 cifras
    beq sorteo_introducir_4cifras; Si es 2, va a sorteo_introducir_2
    cmpa #'3 ; 3. Terminaciones 3 cifras
    beq sorteo_introducir_3cifras; Si es 3, va a sorteo_introducir_3
    cmpa #'4 ; 4. Terminaciones 2 cifras
    beq sorteo_introducir_2cifras; Si es 4, va a sorteo_introducir_4
    cmpa #'5 ; 5. Reintegros
    beq sorteo_introducir_reintegros; Si es 5, va a sorteo_introducir_5
    cmpa #'6 ; 6. Volver
    beq sorteo;    ; Si es 6, vuelve al menu sorteo
    ldx #error_switch
    jsr imprime_cadena
    jmp sorteo_introducir

	.org 	0xFFFE	; Vector de RESET
	.word 	programa