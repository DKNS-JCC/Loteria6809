                
       .module comparaciones_prueba
       pantalla     .equ   0xFF00
       teclado      .equ   0xFF02
                    
;Premios por categoria
primer_5cifras: .asciz "Primer premio de 5 cifras equivale a 1000 puntos\n"
segundo_5cifras:.asciz "Segundo premio de 5 cifras equivale a 500 puntos\n"
tercero_5cifras:.asciz "Tercer premio de 5 cifras equivale a 200 puntos\n"
cifras4:  .asciz "Terminacion de 4 cifras equivale a 50 puntos\n"
cifras3:    .asciz "Terminacion de 3 cifras equivale a 10 puntos\n"
cifras2:     .asciz "Terminacion de 2 cifras equivale a 5 puntos\n"
cifra1:     .asciz "Terminacion de 1 cifra (reintegro) equivale a 1 punto\n"

resultado_txt:  .ascii "El resultado es: "

;Declaraciones
numeros_sorteo: .byte   2
puntuaje:       .word   0
puntuaje_total: .word   0

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

                .globl  comparacion_primero
                .globl  comparacion_segundo
                .globl  comparacion_tercero
                .globl  comparacion_4cifras


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Bucle de itinerancia de los numeros
bucle_numeros:    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
comparacion_primero:
        ldx     #valor_decimos
        ldy     #primer.premio
compara_bucle1:
	lda     ,x+     
	beq     compara_igual1          
	cmpa    ,y+
	beq     compara_bucle1
compara_distinto1:
        jsr     comparacion_segundo

compara_igual1:
        ldd     #1000
        std     puntuaje
        ldx     #primer_5cifras
        jsr     imprime_cadena
        bra     fin_comparacion1

fin_comparacion1:
        std     puntuaje_total
        clr     puntuaje
        ldd     #0
        jsr     comparacion_4cifras



;Comparacion del segundo premio
comparacion_segundo:
        ldx     #valor_decimos
        ldy     #segundo.premio
compara_bucle2:
	lda     ,x+     
	beq     compara_igual2          
	cmpa    ,y+
	beq     compara_bucle2
compara_distinto2:
        jsr     comparacion_tercero

compara_igual2:
        ldd     #500
        std     puntuaje
        ldx     #segundo_5cifras
        jsr     imprime_cadena
        bra     fin_comparacion2

fin_comparacion2:
        std     puntuaje_total
        clr     puntuaje
        ldd     #0
        jsr     comparacion_4cifras


                
;Comparacion del tercer premio
comparacion_tercero:
        ldx     #valor_decimos
        ldy     #tercer.premio
compara_bucle3:
	lda     ,x+     
	beq     compara_igual3          
	cmpa    ,y+
	beq     compara_bucle3
compara_distinto3:
        jsr     comparacion_4cifras    

compara_igual3:
        ldd     #200
        std     puntuaje
        ldx     #tercero_5cifras
        jsr     imprime_cadena
        bra     fin_comparacion3

fin_comparacion3:
        std     puntuaje_total
        clr     puntuaje
        ldd     #0
        jsr     comparacion_4cifras



;Comparacion de numeros de 4 cifras
comparacion_4cifras:
        ldx     #valor_decimos
        leay    1,x
        ldy     #cuatro.cifras
compara_bucle4:
	lda     ,x+     
	beq     compara_igual4          
	cmpa    ,y+
	beq     compara_bucle4
compara_distinto4:
	bra     fin_comparacion4    

compara_igual4:
        ldd     #50
        std     puntuaje
        ldx     #cifras4
        jsr     imprime_cadena
        bra     fin_comparacion4

fin_comparacion4:
        std     puntuaje_total
        clr     puntuaje
        ldd     #0
        rts
