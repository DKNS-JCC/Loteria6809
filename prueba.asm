              .module comprobar
      	.globl imprime_cadena
      	.globl imprime_num
      	.globl imprime_decimal
      	.globl compara_bucle
      	.globl comparacion_decimos
	  	.globl compara_bucle
	  	.globl  primer.premio
     	.globl  segundo.premio
      	.globl  tercer.premio
      	.globl  cuatro.cifras
    	.globl  tres.cifras
    	.globl  dos.cifras
       	.globl  reintegro
	   	.globl comparaciones
		.globl valor_decimos
		.globl decimos_NUM
		.globl programa

fin         .equ 0xFF01
teclado      .equ 0xFF02
pantalla     .equ 0xFF00

;Variables
puntuaje_total: .word 0
return: .word 0
acumulado: .byte 0

;Comparaciones
primer_5cifras: .asciz "1ER\t"
segundo_5cifras: .asciz "2ND\t"
tercero_5cifras: .asciz "3ER\t"
cifras4: .asciz "TE4\t"
cifras3: .asciz "TE3\t"
cifras2: .asciz "TE2\t"
cifra1: .asciz "REI\t"  

tabla: .ascii "Decimo  1ER\t2ND\t3RD\tTE4\tTE3\tTE2\tREI\tTotal\n"
		 .asciz "=====================================================================\n"

comparaciones:
	lda #10 
	sta pantalla
	ldx #tabla
	jsr imprime_cadena
	ldb #0
	ldx #valor_decimos
	decimos0:
	pshs x
	jsr imprime_cadena
	puls x
	lda #9
	sta pantalla
	pshs b	
	ldy #reintegro
	pshs y
	ldy #dos.cifras
	pshs y
	ldy #tres.cifras
	pshs y
	ldy #cuatro.cifras
	pshs y
	ldy #tercer.premio
	pshs y
	ldy #segundo.premio
	pshs y
	ldy #primer.premio
	pshs y
	jsr comparacion_decimos
	ldb #6
	ABX
	puls b
	incb
	cmpb decimos_NUM
	blo decimos0
	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;comparacion_decimos                                                                                      ;
; compara todos los decimos con todos los boletos y terinaciones premiados                                 ;
; entrada: X direccion decimo
; salida: Ninguna
; registros afectados: A,B,Y,X
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,;;;;;
comparacion_decimos:
	    ldd     #0
	    std     puntuaje_total
	    lda     #0
	    puls    y
	    sty     return
	    puls    y
	    pshs    x
	    jsr     compara_bucle
	    puls    x
	    cmpb    #1
	    beq     primer_igual
	    ldb     #9
	    stb     pantalla
	    bra     bucle_segundo
              primer_igual:
	            pshs    x
	            ldx     #primer_5cifras
	            jsr     imprime_cadena
	            puls    x
	            ldd     #1000
	            std     puntuaje_total
      
      bucle_segundo:
	    lda     #0
	    puls    y
	    pshs    x
	    jsr     compara_bucle
	    puls    x
	    cmpb    #1
	    beq     igual_segundo
	    ldb     #9
	    stb     pantalla
	    bra     bucle_tercero
              igual_segundo:
	            pshs   x
	            ldx    #segundo_5cifras
	            jsr    imprime_cadena
	            puls   x
	            ldd    #500
	            addd  puntuaje_total
	            stb   puntuaje_total
      
      bucle_tercero:
	    lda     #0
	    puls    y 
	    pshs    x
	    jsr     compara_bucle
	    puls    x
	    cmpb    #1
	    beq     igual_tercero
	    ldb     #9
	    stb     pantalla
	    bra     bucle_numeros4cifras
              igual_tercero:
	            pshs    x
	            ldx     #tercero_5cifras
	            jsr     imprime_cadena
	            puls    x
	            ldd     #200
	            addd    puntuaje_total
	            std     puntuaje_total
      
      bucle_numeros4cifras:
	    lda     #1
	    ldb     #0
	    stb     acumulado
	    puls    y
	            bucle_cuatro_n:
		          ldb     acumulado
		          cmpb    #2
		          beq     distinto_4cifras
		          pshs    x
		          jsr     compara_bucle
		          puls    x
		          cmpb    #1
		          beq     igual_4cifras
		          leay    ,y+
		          ldb     acumulado
		          incb
		          stb     acumulado
		          bra       bucle_cuatro_n
              igual_4cifras:
	            pshs    x
	            ldx     #cifras4
	            jsr     imprime_cadena
	            puls    x
	            ldd     #50
	            addd    puntuaje_total
	            std     puntuaje_total
	            bra     bucle_numeros3cifras
              distinto_4cifras:
	            lda     #9
	            sta     pantalla
      
      bucle_numeros3cifras:
	    lda     #2
	    ldb     #0
	    stb     acumulado
	    puls    y
	            bucle_tres_n:
		          ldb     acumulado
		          cmpb    #15
		          beq     distinto_3cifras
		          pshs    x
		          jsr     compara_bucle
		          puls    x
		          cmpb    #1
		          beq     igual_3cifras
		          leay    ,y+
		          ldb     acumulado
		          incb
		          stb     acumulado
		          bra     bucle_tres_n
              igual_3cifras:
	            pshs    x
	            ldx     #cifras3
	            jsr     imprime_cadena
	            puls    x
	            ldd     #10
	            addd    puntuaje_total
	            std     puntuaje_total
	            bra     bucle_numeros2cifras
              distinto_3cifras:
	            lda     #9
	            sta     pantalla

      bucle_numeros2cifras:
	    lda     #3
	    ldb     #0
	    stb     acumulado
	    puls    y
	            bucle_dos_n:
		          ldb     acumulado
		          cmpb    #5
		          beq     distinto_2cifras
		          pshs    x
		          jsr     compara_bucle
		          puls    x
		          cmpb    #1
		          beq     igual_2cifras
		          leay     ,y+
		          ldb     acumulado
		          incb
		          stb     acumulado
		          bra     bucle_dos_n
              igual_2cifras:
	            pshs    x
	            ldx     #cifras2
	            jsr     imprime_cadena
	            puls    x
	            ldd     #5
	            addd    puntuaje_total
	            std     puntuaje_total
	            bra     bucle_reintegros
              distinto_2cifras:
	            lda     #9
	            sta     pantalla

      bucle_reintegros:
	    lda     #4
	    ldb     #0
	    stb     acumulado
	    puls    y
	            bucle_una_n:
		          ldb     acumulado
		          cmpb    #3
		          beq     distinto_1cifras
		          pshs    x
		          jsr     compara_bucle
		          puls    x
		          cmpb    #1
		          beq     igual_1cifras
		          leay    ,y+
		          ldb     acumulado
		          incb
		          stb     acumulado
		          bra     bucle_una_n
              igual_1cifras:
	            pshs    x
	            ldx     #cifra1
	            jsr     imprime_cadena
	            puls    x
	            ldd     #1
	            addd    puntuaje_total
	            std     puntuaje_total
	            bra     termina
              distinto_1cifras:
	            lda     #9
	            sta     pantalla	

      termina:
	    ldd     puntuaje_total
	    jsr     imprime_decimal
	    lda     #10
	    sta     pantalla
	    ldy     return
	    pshs    y
      	rts

