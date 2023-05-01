            .module prueba
            .area PROG (REL)
            .org 0x100

         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			; Fin definicion de constantes

                    ; Inicio definicion de variables
                    .globl ver_decimos
                    ;.globl imprime_cadena
         			; Fin definicion de variables

programa:
    jsr ver_decimos
    

    .org 	0xFFFE	; Vector de RESET
	.word 	programa
                            
