       .module comparaciones_prueba
       pantalla     .equ   0xFF00
       teclado      .equ   0xFF02
                    
;Premios por categoria
primer_5cifras: .asciz "Primer premio de 5 cifras equivale a 1000 puntos\n"
segundo_5cifras:.asciz "Segundo premio de 5 cifras equivale a 500 puntos\n"
tercero_5cifras:.asciz "Tercer premio de 5 cifras equivale a 200 puntos\n"
cifras4:        .asciz "Terminacion de 4 cifras equivale a 50 puntos\n"
cifras3:        .asciz "Terminacion de 3 cifras equivale a 10 puntos\n"
cifras2:        .asciz "Terminacion de 2 cifras equivale a 5 puntos\n"
cifra1:         .asciz "Terminacion de 1 cifra (reintegro) equivale a 1 punto\n"
premiado:       .asciz "El"

resultado_txt:  .ascii "El resultado es: "

;Declaraciones
puntuaje:       .word   0
puntuaje_total: .word   0
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
                .globl  programa_comparaciones
                .globl  decimos_NUM
                


programa_comparaciones:
        bucle_decimos0:

        ldx     #premiados
        jsr     imprime_cadena
        lda     decimos_NUM
        ldx     #valor_decimos
        jsr     imprime_decimal
                                ;itinerancia de numeros
        cmpa    #0
        beq     salida
        dec     a
        bra     comparacion_primero
        salida:
        rts     
        
        comparacion_primero:

        ldx     #valor_decimos
        ldy     #primer.premio
        jsr     compara_bucle
        cmpb    #0
        bne     else1
        ldd     #0
        bra     comparacion_segundo
else1:
        ldd     #1000
        std     puntuaje
        ldx     #primer_5cifras
        jsr     imprime_cadena
        ldd     #0
        bra     comparacion_4cifras


comparacion_segundo:
        ldx     #valor_decimos
        ldy     #segundo.premio
        jsr     compara_bucle
        cmpb    #0
        bne     else2
        ldd     #0
        bra     comparacion_tercero
else2:
        ldd     puntuaje
        addd    #500
        ldx     #segundo_5cifras
        jsr     imprime_cadena
        ldd     #0
        bra     comparacion_4cifras


comparacion_tercero:
        ldx     #valor_decimos
        ldy     #tercer.premio
        jsr     compara_bucle
        cmpb    #0
        bne     else3
        ldd     #0
        bra     comparacion_4cifras
else3:
        ldd     puntuaje
        addd    #200
        ldx     #tercero_5cifras
        jsr     imprime_cadena
        ldd     #0
        bra     comparacion_4cifras


comparacion_4cifras:
        lda     numeros.cuatrocifras
        ldx     #valor_decimos
                                        ;itinerancia de numeros
        cmpa    #0
        beq     comparacion_3cifras
        dec     numeros.cuatrocifras
bucle_numeros4cifras:
        leax    1,x
        ldy     #cuatro.cifras
        cmpb    #0
        bne     else4
        bra     comparacion_4cifras
else4:
        clra
        clrb
        ldd     puntuaje
        addd    #50
        ldx     #cifras4
        jsr     imprime_cadena
        jsr     comparacion_3cifras


comparacion_3cifras:
        lda     numeros.trescifras
        ldx     #valor_decimos
                                        ;itinerancia de numeros
        cmpa    #0
        beq     comparacion_2cifras
        dec     numeros.cuatrocifras
bucle_numeros3cifras:
        leax    2,x
        ldy     #tres.cifras
        cmpb    #0
        bne     else5
        bra     comparacion_3cifras
else5:
        clra
        clrb
        ldd     puntuaje
        addd    #5
        ldx     #cifras3
        jsr     imprime_cadena
        jsr     comparacion_2cifras


comparacion_2cifras:
        lda     numeros.doscifras
        ldx     #valor_decimos
                                        ;itinerancia de numeros
        cmpa    #0
        beq     comparacion_3cifras
        dec     numeros.doscifras
bucle_numeros2cifras:
        leax    3,x
        ldy     #dos.cifras
        cmpb    #0
        bne     else6
        bra     comparacion_4cifras
else6:
        clra
        clrb
        ldd     puntuaje
        addd    #5
        ldx     #cifras2
        jsr     imprime_cadena
        jsr     comparacion_reintegros


comparacion_reintegros:
        lda     numeros.reintegro
        ldx     #valor_decimos
                                        ;itinerancia de numeros
        cmpa    #0
        beq     salto
        dec     numeros.reintegro
        bra     bucle_numeros4cifras
        salto:
        jsr     programa_comparaciones
bucle_numeros1cifras:
        leax    4,x
        ldy     #reintegro
        cmpb    #0
        bne     else7
        bra     comparacion_reintegros
else7:
        clra
        clrb
        ldd     puntuaje
        addd    #1
        ldx     #cifra1
        jsr     imprime_cadena
        ldd     puntuaje_total
        addd    puntuaje
        std     puntuaje_total
        jsr     programa_comparaciones



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
	beq     compara_IGUAL           ;para si llega a final de linea
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
		
