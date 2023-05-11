       .module comparaciones_prueba
       pantalla     .equ   0xFF00
       teclado      .equ   0xFF02
                    
;Premios por categoria
premio.txt:     .asciz "Puntos al decimo: \n"
primer_5cifras: .asciz "Primer premio de 5 cifras equivale a 1000 puntos\n"
segundo_5cifras:.asciz "Segundo premio de 5 cifras equivale a 500 puntos\n"
tercero_5cifras:.asciz "Tercer premio de 5 cifras equivale a 200 puntos\n"
cifras4:        .asciz "Terminacion de 4 cifras equivale a 50 puntos\n"
cifras3:        .asciz "Terminacion de 3 cifras equivale a 10 puntos\n"
cifras2:        .asciz "Terminacion de 2 cifras equivale a 5 puntos\n"
cifras1:         .asciz "Terminacion de 1 cifra (reintegro) equivale a 1 punto\n"

resultado_boleto.txt:   .ascii  "El puntuaje del boleto es: "
resultado_txt:  .ascii "El total acumulado es: "

;Declaraciones
puntuaje:       .word   0
puntuaje_total: .word   0
sujeto_comparacion: .word   0
numeros.cuatrocifras:   .byte   2
numeros.trescifras:     .byte   14
numeros.doscifras:      .byte   5
numeros.reintegro:      .byte   3

                .globl programa
                .globl  valor_decimos
                .globl  primer.premio
                .globl  segundo.premio
                .globl  tercer.premio
                .globl  cuatro.cifras
                .globl  tres.cifras
                .globl  dos.cifras
                .globl  reintegro
                .globl  imprime_cadena
                .globl  imprime_decimal
                .globl  programa_comparaciones
                .globl  decimos_NUM
                .globl  compara_decimos


programa_comparaciones:
        ;Presentacion comparaciones
        ldx     #premio.txt
        jsr     imprime_cadena
        ldx     #primer_5cifras
        jsr     imprime_cadena
        ldx     #segundo_5cifras
        jsr     imprime_cadena
        ldx     #tercero_5cifras
        jsr     imprime_cadena
        ldx     #cifras4
        jsr     imprime_cadena
        ldx     #cifras3
        jsr     imprime_cadena
        ldx     #cifras2
        jsr     imprime_cadena
        ldx     #cifras1
        jsr     imprime_cadena
        ldx     #'\n
        stx     pantalla

        ldd     #0
        std     puntuaje_total
        ldx     #valor_decimos
        bucle_comparacion:
        cmpb    decimos_NUM
        lbhi    bucle_fin_comparacion
        stx     sujeto_comparacion
        jsr     imprime_cadena
        incb
        pshs    x,d     ;cargo los valores de x y d en la pila
        ldd     #0
        std     puntuaje                ;cargo el puntuaje a 0
        ldx     sujeto_comparacion          ;cargo x con el decimo a comparar
        ldy     #primer.premio          ;cargo y con el boleto del primer premio
        lda     #0                      ;cargo A con 0 por si acaso habia algo hay
        jsr     compara_decimos
        cmpb    #1
        beq     else1   ;es el primer premio
        bra     comparacion_segundo
                else1:
                ldd     puntuaje
                addd    #1000
                std     puntuaje
                ldx     #primer_5cifras
                jsr     imprime_cadena
                jmp     comparacion_4cifras
                comparacion_segundo:    ;comparacion del segundo premio
                ldy     #segundo.premio
                lda     #0              ;cargo A con 0 por si acaso habia algo hay
                ldx     sujeto_comparacion
                jsr     compara_decimos
                cmpb    #1
                beq     else2
                bra     comparacion_tercero
                        else2:
                        ldd     puntuaje
                        addd    #500
                        std     puntuaje
                        ldx     #segundo_5cifras
                        jsr     imprime_cadena
                        jmp     comparacion_4cifras
                        comparacion_tercero:    ;comparacion de tercero   
                        ldy     #tercer.premio
                        lda     #0
                        ldx     sujeto_comparacion
                        jsr     compara_decimos
                        cmpb    #1
                        beq     else3
                        bra     comparacion_4cifras
                                else3:
                                ldd     puntuaje
                                addd    #200
                                std     puntuaje
                                ldx     #tercero_5cifras
                                jsr     imprime_cadena
                                jmp     comparacion_4cifras
                                comparacion_4cifras:
                                ldb     #0
                                bucle_numeros4cifras:
                                cmpb    #1
                                bhi     else4
                                ldy     #cuatro.cifras
                                lda     #5              ;para avanzar en cada interaccion 5 posiciones
                                pshs    b
                                mul
                                leay    d,y
                                ldx     sujeto_comparacion
                                lda     #1
                                jsr     compara_decimos
                                cmpb    #1
                                beq     else5
                                puls    b
                                incb
                                bra     comparacion_4cifras
                                        else4:
                                        bra     comparacion_3cifras
                                        else5:
                                        puls    b
                                        ldd     puntuaje
                                        addd    #50
                                        std     puntuaje
                                        ldx     #cifras4
                                        jsr     imprime_cadena
                                        comparacion_3cifras:
                                        ldb     #0
                                        bucle_numeros3cifras:
                                        cmpb    #13
                                        bhi     else6
                                        ldy     #tres.cifras
                                        lda     #4
                                        pshs    b
                                        mul
                                        leay    d,y
                                        ldx     sujeto_comparacion
                                        lda     #2
                                        jsr     compara_decimos
                                        cmpb    #1
                                        beq     else7
                                        puls    b
                                        incb
                                        bra     bucle_numeros3cifras
                                                else6:
                                                bra     comparacion_2cifras
                                                else7:
                                                puls    b
                                                ldd     puntuaje
                                                addd    #10
                                                std     puntuaje
                                                ldx     #cifras3
                                                jsr     imprime_cadena
                                                comparacion_2cifras:
                                                ldb     #0
                                                bucle_numeros2cifras:
                                                cmpb    #4
                                                bhi     else8
                                                ldy     #dos.cifras
                                                lda    #3              
                                                pshs    b
                                                mul
                                                leay    d,y
                                                ldx     sujeto_comparacion
                                                lda     #3 
                                                jsr     compara_decimos
                                                cmpb    #1
                                                beq     else9 
                                                puls    b 
                                                incb
                                                bra     bucle_numeros2cifras
                                                        else8:
                                                        bra     comparacion_reintegros
                                                        else9:
                                                        puls    b
                                                        ldd     puntuaje
                                                        addd    #5
                                                        std     puntuaje
                                                        ldx     #cifras2
                                                        jsr     imprime_cadena
                                                        comparacion_reintegros:
                                                        ldb     #0
                                                        bucle_numeros1cifras:
                                                        cmpb    #2
                                                        bhi     else10
                                                        ldy     #reintegro
                                                        lda     #2              
                                                        pshs    b
                                                        mul
                                                        leay    d,y
                                                        ldx     sujeto_comparacion
                                                        lda     #4 
                                                        jsr     compara_decimos
                                                        cmpb    #1
                                                        beq     else11
                                                        puls    b 
                                                        incb
                                                        bra     bucle_numeros1cifras
                                                                else10:
                                                                bra     fin0
                                                                else11:
                                                                puls    b
                                                                ldd     puntuaje
                                                                addd    #1
                                                                std     puntuaje
                                                                ldx     #cifras1
                                                                jsr     imprime_cadena
                                                                        fin0:
                                                                        ldx     #resultado_boleto.txt
                                                                        jsr     imprime_cadena
                                                                        ldd     puntuaje
                                                                        jsr     imprime_decimal
                                                                        ldd     puntuaje_total
                                                                        addd    #puntuaje
                                                                        std     puntuaje_total
                                                                        ldx     #'\n
                                                                        stx     pantalla
                                                                        jmp     bucle_comparacion 




        bucle_fin_comparacion:
        ldx     #resultado_txt
        jsr     imprime_cadena
        ldd     puntuaje_total
        jsr     imprime_decimal  
        rts


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;comparacion de 2 numeros                                                                                              ;
; compara lso numeros de los registros X e Y y da un valor de retorno                                                  ;
;                                                                                                                      ;       
; Entrada: X-direcciOn de comienzo de la cadena                                                                        ;
; Salida: b con un valor de retorno                                                                                    ;   
; Registros afectados: X, A, B, Y.                                                                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
compara_decimos:
	lda     ,x+
	beq     compara_IGUAL
	cmpa    ,y+
	beq     compara_decimos

compara_distinto:
	ldb     #0
	bra     compara_fin
compara_IGUAL:
	ldb    #1
        bra    compara_fin
compara_fin:
        rts
		

