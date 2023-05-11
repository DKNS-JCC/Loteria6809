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
            .globl error_switch
            ;.globl programa_comparaciones
			; Inicio declaración de variables


menu_p:         .ascii "\n\33[33m           _.-------._\n"
                .ascii "        _-'_.------._ `-_\n"
                .ascii "      _- _-          `-_/\n"
                .ascii "     -  - \n"
                .ascii "  ___/  /______________\n"
                .ascii "/___  .______________/\n"
                .ascii " ___| |_____________\n"
                .ascii "/___  .____________/\n"
                .ascii "    \  \\n"
                .ascii "     -_ -_             /|\n"
                .ascii "       -_ -._        _- |\n"
                .ascii "         -._ `------'_./\n"
                .ascii "            `-------'\n"


                .ascii "\33[31m=====LOTERIA 6809=====\n"
                .ascii  "\33[32m1. DECIMOS\n"
                .ascii  "\33[33m2. SORTEO\n"
                .ascii  "\33[34m3. COMPROBAR\n"
                .asciz  "\33[35m4. SALIR\n"



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
    beq comprobar_j ; Si es 3, va a comprobar
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

comprobar_j:
    ;jsr programa_comparaciones

acabar: 	clra
	sta 	fin



    .area FIJA(ABS)
	.org 	0xFFFE	; Vector de RESET
	.word 	programa