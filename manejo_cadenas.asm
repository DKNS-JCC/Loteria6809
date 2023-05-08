                .module manejo_cadenas

fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00

                .globl imprime_cadena
                .globl limpia_pantalla
                .globl error_switch
                .globl imprime_cadena_seguida
                .globl salir

limpia_pantalla:  .asciz  "\033[2J"
salir:            .asciz  "\n\n\nPulse la tecla c para salir.\n"
error_switch:     .asciz  "\33[31mOpcion incorrecta, intentelo de nuevo.\n"


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_cadena_seguida:
    pshs a            ; Guarda el valor de A en la pila
    clrb        ; Inicializa el contador a 0
numero_sgte:
    lda ,x+     ; Carga el primer caracter de la cadena
    beq loop    ; Si es 0, sale a ret_imprime_cadena
    cmpa #'\n   ; Compara el caracter con el salto de linea
    beq contador        ; Si es igual, salta a contador
    sta pantalla        ; Si no, lo imprime en pantalla
    bra numero_sgte        ; y vuelve a sgte
contador:
    incb        ; Incrementa el contador
    bra loop    ; Vuelve a numero_sgte
loop:
    puls a      
    rts



