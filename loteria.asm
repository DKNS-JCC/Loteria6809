            .module loteria6809
            .area PROG (ABS)
            .org 0x100
            .globl programa
         			; Inicio definicion de constantes
fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00
         			; Fin definicion de constantes

			; Inicio declaración de variables
menu_p:         .ascii "=====LOTERIA 6809=====\n"
                .ascii  "1. DECIMOS\n"
                .ascii  "2. SORTEO\n"
                .ascii  "3. COMPROBAR\n"
                .asciz  "4. SALIR\n"


m_decimos:      .ascii  "=========DECIMOS==========\n"
                .ascii  "1. Ver\n"
                .ascii  "2. Introducir resultados\n"
                .asciz  "3. Volver\n"


m_sorteo:       .ascii  "=========SORTEO==========\n"
                .ascii  "1. Ver Resultados\n"
                .ascii  "2. Introducir Resultados\n"
                .asciz  "3. Volver\n"

m_sorteo2:     .ascii  "=========INTRODUCIR RESULTADOS==========\n"
                .ascii  "1. 3 primeros premios\n"
                .ascii  "2. Terminaciones 4 cifras\n"
                .ascii  "3. Terminaciones 3 cifras\n"
                .ascii  "4. Terminaciones 2 cifras\n"
                .ascii  "5. Reintegros\n"
                .asciz  "6. Volver\n"


m_comprobar:      .asciz  "=========COMPROBAR==========\n"

error_switch:     .asciz  "Opcion incorrecta, intentelo de nuevo.\n"
limpia_pantalla:  .asciz  "\033[2J"
			; Fin declaración de variables
	        	
			; Comienzo del programa
programa:

    ldx #menu_p
    lbsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    lbsr imprime_cadena 
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
    lbsr imprime_cadena
    jmp programa

acabar: 	clra
	sta 	fin

comprobar:     
    ldx #m_comprobar
    lbsr imprime_cadena
    jmp acabar

decimos:
    ldx #m_decimos
    lbsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    lbsr imprime_cadena 
    cmpa #'1 ; 1. Ver
    beq decimos_ver; Si es 1, va a decimos_ver
    cmpa #'2 ; 2. Introducir resultados
    beq decimos_introducir; Si es 2, va a decimos_introducir
    cmpa #'3 ; 3. Volver
    beq programa    ; Si es 3, vuelve al menu principal
    ldx #error_switch
    lbsr imprime_cadena
    jmp decimos

decimos_ver:
    ;;llamar a la funcion que imprime los decimos
    jmp acabar

decimos_introducir:
    ;;llamar a la funcion que introduce los decimos
    jmp acabar
sorteo:
    ldx #m_sorteo
    lbsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    lbsr imprime_cadena 
    cmpa #'1 ; 1. Ver resultados
    beq sorteo_ver; Si es 1, va a sorteo_ver
    cmpa #'2 ; 2. Introducir resultados
    beq sorteo_introducir; Si es 2, va a sorteo_introducir
    cmpa #'3 ; 3. Volver
    beq programa    ; Si es 3, vuelve al menu principal
    ldx #error_switch
    lbsr imprime_cadena
    jmp sorteo

sorteo_ver:
    ;;llamar a la funcion que imprime los resultados
    jmp acabar

sorteo_introducir:
    ldx #m_sorteo2
    lbsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    lbsr imprime_cadena 
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
    beq sorteo;    ; Si es 6, vuelve al menu principal
    ldx #error_switch
    lbsr imprime_cadena 
    jmp sorteo_introducir

sorteo_introducir_3premios:
    ;;llamar a la funcion que introduce los 3 premios
    jmp acabar

sorteo_introducir_4cifras:
    ;;llamar a la funcion que introduce las terminaciones de 4 cifras
    jmp acabar

sorteo_introducir_3cifras:
    ;;llamar a la funcion que introduce las terminaciones de 3 cifras
    jmp acabar

sorteo_introducir_2cifras:
    ;;llamar a la funcion que introduce las terminaciones de 2 cifras
    jmp acabar

sorteo_introducir_reintegros:
    ;;llamar a la funcion que introduce los reintegros
    jmp acabar

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_cadena                                                   ;
; saca por la pantalla la cadena acabada en '\0 apuntada por X     ;
;                                                                  ;       
; Entrada: X-direcciOn de comienzo de la cadena                    ;
; Salida: ninguna                                                  ;   
; Registros afectados: X, CC.                                      ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_cadena:
        pshs    a               ; Guarda el valor de A en la pila
sgte:              
        lda     ,x+             ; Carga el primer caracter de la cadena
        beq ret_imprime_cadena  ; Si es 0, sale a ret_imprime_cadena
        sta     pantalla        ; Si no, lo imprime en pantalla
        jmp     sgte            ; y vuelve a sgte
ret_imprime_cadena:
        puls    a               ; Recupera el valor de A
        rts                     ; y sale de la subrutina equivalente a puls pc (return)



	.org 	0xFFFE	; Vector de RESET
	.word 	programa