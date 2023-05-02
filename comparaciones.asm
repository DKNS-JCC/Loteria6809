       .module comparaciones
       pantalla     .equ   0xFF00
       teclado      .equ   0xFF02
                    .include "numeros.asm"


premios:
                .ascii "Primer premio de 5 cifras equivale a 1000 puntos\n"
                .ascii "Segundo premio de 5 cifras equivale a 500 puntos\n"
                .ascii "Tercer premio de 5 cifras equivale a 200 puntos\n"
                .ascii "Terminacion de 4 cifras equivale a 50 puntos\n"
                .ascii "Terminacion de 3 cifras equivale a 10 puntos\n"
                .ascii "Terminacion de 2 cifras equivale a 5 puntos\n"
                .ascii "Terminacion de 1 cifra (reintegro) equivale a 1 punto\n"

                    .globl  main
                    .globl  comparacion_primero
                    .globl  comparacion_segundo
                    .globl  comparacion_tercero


main: 
        lds #0xFF00             ;reservo espacio en pila
        ldx #premios              
        bsr imprimir_cadena      ;Llamo a la subrutina imprimir cadena



comparacion.primero:
       ldx mi_boleto            ;cargo el mi boleto en el registro x
       cmpx primer_premio       ;comparo con el valor del primer premio
       bne else1                ;si el premio y el boleto no son iguales se va al else
       
comparacion.segundo:
       ldx mi.boleto            ;cargo el mi boleto en el registro x
       cmpx segundo_premio      ;comparo con el valor del segundo premio
       bne else2                ;si el premio y el boleto no son iguales se va al else

comparacion.tercero:
       ldx mi.boleto            ;cargo el mi boleto en el registro x
       cmpx primer_premio       ;comparo con el valor del tercero premio


comparacion.tres.cifras:        ;hay que dividir el numero del boleto


comparaciones.dos.cifras:


comparacion.reintegros:


else1:


else2:


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
