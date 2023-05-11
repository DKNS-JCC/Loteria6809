              .module comprobar
      .globl imprime_cadena
      .globl imprime_num
      .globl imprime_decimal
      .globl compara_bucle
      .globl programa_comparaciones
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

fin         .equ 0xFF01
teclado      .equ 0xFF02
pantalla     .equ 0xFF00

;Variables
puntuaje_total: .word 0
return: .word 0
acumulado: .byte 0

;Comparaciones
primer_5cifras: .asciz "1\t"
segundo_5cifras: .asciz "2\t"
tercero_5cifras: .asciz "3\t"
cifras4: .asciz "T4\t"
cifras3: .asciz "T3\t"
cifras2: .asciz "T2\t"
cifra1: .asciz "RI\t"  

tabla: .ascii "Decimo  1\t 2\t 3\t T\t  T\t T\t RI\t Total\n"
		 .asciz "=====================================================================\n"



comprobaciones::
	lda #10 
	sta pantalla
	ldx #tabla
	jsr imprime_cadena
	ldb #0
	ldx #valor_decimos
    bucle_decimos:
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
  	jsr programa_comparaciones
    ldb #6
	  ABX
	  puls b
	  incb
	  cmpb decimos_NUM
	  blo bucle_decimos
	  rts



;programa comparacion
;comparar un decimos con todos los premios y mostrar los puntos obtenidos
;entrada x direccion decimo
;salida ninguna
;registros afectados a,b,y,x

programa_comparaciones:
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
		          beq     igual_1cifra
		          leay    ,y+
		          ldb     acumulado
		          incb
		          stb     acumulado
		          bra     bucle_una_n
              igual_1cifra:
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