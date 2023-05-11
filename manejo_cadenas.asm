                .module manejo_cadenas

fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00

                .globl imprime_cadena
                .globl limpia_pantalla
                .globl error_switch
                .globl salir
                .globl imprime_decimal
                .globl imprime_num
                .globl acumulador
                .globl barra
                .globl compara_bucle

limpia_pantalla:  .asciz  "\033[2J"
salir:            .asciz  "\n\n\nPulse la tecla c para salir.\n"
error_switch:     .asciz  "\33[31mOpcion incorrecta, intentelo de nuevo.\n"
acumulador:       .byte  0
barra:            .asciz  "==========================================================\n"


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


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;imprime_decimal
;ENTRADA: D
;Registros Afectados: D,X,CC
;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_decimal:
    pshs x
    ldx    #0                       ;inicializa el contador a 0
id_primera_cifra:
    cmpd #10000                     ;compara el valor de D con 10000
    blo  id_imprime_primera_cifra   ;si D es menor que 10000, imprime la primera cifra
    subd #10000                     ;si no, resta 10000 a D
    exg  d,x                        ;intercambia el valor de D con el valor de X
    incb                            ;incrementa el valor de B
    exg  d,x                        ;intercambia el valor de D con el valor de X
    bra  id_primera_cifra           ;vuelve a la etiqueta id_primera_cifra

id_imprime_primera_cifra:
    exg  x,d                        ;intercambia el valor de X con el valor de D
    addb #'0                        ;suma 0 a B
    stb  pantalla                   ;imprime el valor de B en pantalla
    exg  x,d                        ;intercambia el valor de X con el valor de D
    ldx  #0  
id_segunda_cifra:
    cmpd #1000                      ;compara el valor de D con 1000
    blo  id_imprime_segunda_cifra   ;si D es menor que 1000, imprime la primera cifra
    subd #1000                      ;si no, resta 1000 a D
    exg  d,x                        ;intercambia el valor de D con el valor de X
    incb                            ;incrementa el valor de B
    exg  d,x                        ;intercambia el valor de D con el valor de X
    bra  id_segunda_cifra           ;vuelve a la etiqueta id_segunda_cifra

id_imprime_segunda_cifra:
    exg  x,d                        ;intercambia el valor de X con el valor de D
    addb #'0                        ;suma 0 a B
    stb  pantalla                   ;imprime el valor de B en pantalla
    exg  x,d                        ;intercambia el valor de X con el valor de D
    ldx  #0  
id_tercera_cifra:
    cmpd #100                       ;compara el valor de D con 100
    blo  id_imprime_tercera_cifra   ;si D es menor que 100, imprime la primera cifra
    subd #100                       ;si no, resta 100 a D
    exg  d,x                        ;intercambia el valor de D con el valor de X
    incb                            ;incrementa el valor de B
    exg  d,x                        ;intercambia el valor de D con el valor de X
    bra  id_tercera_cifra           ;vuelve a la etiqueta id_tercera_cifra

id_imprime_tercera_cifra:
    exg  x,d                        ;intercambia el valor de X con el valor de D
    addb #'0                        ;suma 0 a B
    stb  pantalla                   ;imprime el valor de B en pantalla
    exg  x,d                        ;intercambia el valor de X con el valor de D
    ldx  #0  
id_cuarta_cifra:
    cmpd #10                        ;compara el valor de D con 10
    blo  id_imprime_cuarta_cifra    ;si D es menor que 10, imprime la primera cifra
    subd #10                        ;si no, resta 10 a D
    exg  d,x                        ;intercambia el valor de D con el valor de X
    incb                            ;incrementa el valor de B
    exg  d,x                        ;intercambia el valor de D con el valor de X
    bra  id_cuarta_cifra            ;vuelve a la etiqueta id_cuarta_cifra

id_imprime_cuarta_cifra:
    exg  x,d                        ;intercambia el valor de X con el valor de D
    addb #'0                        ;suma 0 a B
    stb  pantalla                   ;imprime el valor de B en pantalla
    exg  x,d                        ;intercambia el valor de X con el valor de D
    ldx  #0  
id_quinta_cifra:
    addb #'0                        ;suma 0 a B
    stb  pantalla                   ;imprime el valor de B en pantalla
    puls x
    rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_entero                                                  ;
; saca por la pantalla el entero contenido en X                   ;
;                                                                 ;
; Entrada: X-valor a imprimir                                     ;
; Salida: pantalla                                                ;
; Registros afectados: X, CC.                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_num:

	stb acumulador
    lda #1

num_sig:

	leax ,x+        
	jsr imprime_cadena
	ldb #'\n
	stb pantalla
	cmpa acumulador
	beq num_fin
	inca
	bra num_sig

num_fin:
    rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;comparacion de 2 numeros                                                                                              ;
; compara lso numeros de los registros X e Y y da un valor de retorno                                                  ;
;                                                                                                                      ;       
; Entrada: X-direcciOn de comienzo de la cadena                                                                        ;
; Salida: b con un valor de retorno                                                                                    ;   
; Registros afectados: X, A, B, Y.                                                                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
compara_bucle:
	lda     ,x+
	beq     compara_IGUAL
	cmpa    ,y+
	beq     compara_bucle
compara_DISTINTO:
	ldb     #0
	bra     compara_fin

compara_IGUAL:
	ldb    #1
        bra    compara_fin
compara_fin:
        rts
		










