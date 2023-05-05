            .module loteria6809
            

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			; Fin definicion de constantes
            
            .globl programa
            .globl imprime_cadena
            .globl decimos
            .globl sorteo
            .globl limpia_pantalla

			; Inicio declaración de variables


menu_p:         .ascii "\33[31m=====LOTERIA 6809=====\n"
                .ascii  "\33[32m1. DECIMOS\n"
                .ascii  "\33[33m2. SORTEO\n"
                .ascii  "\33[34m3. COMPROBAR\n"
                .asciz  "\33[35m4. SALIR\n"





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





            			; Fin declaración de variables
	        	
; Comienzo del programa
programa:

    ldx #menu_p
    jsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    jsr imprime_cadena 
    cmpa #'1 ; 1. Decimos
    beq decimos_j; Si es 1, va a decimos
    cmpa #'2 ; 2. Sorteo
    beq sorteo_j; Si es 2, va a sorteo
    cmpa #'3 ; 3. Comprobar
    beq comprobar ; Si es 3, va a comprobar
    cmpa #'4 ; 4. Salir
    beq acabar  ; Si es 4, va a salir

mensaje_error:
    ldx #error_switch
    jsr imprime_cadena
    bra programa

decimos_j:
    jsr decimos
    
sorteo_j:
    jsr sorteo

acabar: 	clra
	sta 	fin

comprobar:     
    ldx #m_comprobar
    jsr imprime_cadena
    bra acabar


    .area FIJA(ABS)
	.org 	0xFFFE	; Vector de RESET
	.word 	programa