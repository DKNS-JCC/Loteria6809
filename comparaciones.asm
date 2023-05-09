       .module comparaciones
       pantalla     .equ   0xFF00
       teclado      .equ   0xFF02
                    
;Premios por categoria
primer_5cifras: .asciz "Primer premio de 5 cifras equivale a 1000 puntos\n"
segundo_5cifras:.asciz "Segundo premio de 5 cifras equivale a 500 puntos\n"
tercero_5cifras:.asciz "Tercer premio de 5 cifras equivale a 200 puntos\n"
cuatro_cifras:  .asciz "Terminacion de 4 cifras equivale a 50 puntos\n"
tres_cifras:    .asciz "Terminacion de 3 cifras equivale a 10 puntos\n"
dos_cifras:     .asciz "Terminacion de 2 cifras equivale a 5 puntos\n"
una_cifra:     .asciz "Terminacion de 1 cifra (reintegro) equivale a 1 punto\n"

;Declaraciones
puntuaje:       .word 0
puntuaje_total: .word 0
numeros.cuatrocifras: .byte 0
numeros.trescifras: .byte 0
numeros.doscifras: .byte  0
numeros.reintegro: .byte 0

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
                .globl  comparacion_3cifras
                .globl  comparacion_2cifras
                

;Itinerancia de los numeros del sorteo


;Comparacion del primer premio
comparacion_primero:
                ldx     #31231
                ldy     #primer.premio
compara_bucle1:
		lda     ,x+
		beq     compara_igual1
		cmpa    ,y+
		beq     compara_bucle1
compara_distinto1:
                ldd     #0
		jsr    comparacion_segundo
compara_igual1:
		ldd     puntuaje
                addd    #1000
                std     puntuaje
                jsr     comparacion_4cifras
                
compara_fin1:
		addd    #'0
		stb     pantalla			
                ldb     #'\n
		stb     pantalla
                jsr     comparacion_4cifras



;Comparacion del segundo premio
comparacion_segundo:
                ldx     #31231
                ldy     #segundo.premio
compara_bucle2:
		lda     ,x+
		beq     compara_igual2
		cmpa    ,y+
		beq     compara_bucle2
compara_distinto2:
                ldd     #0
		jsr     comparacion_tercero
compara_igual2:
		ldd     puntuaje
                addd    #500
                std     puntuaje
                jsr     comparacion_4cifras
                
compara_fin2:
		addd    #'0
		stb     pantalla			
                ldb     #'\n
		stb     pantalla
                jsr     comparacion_4cifras



;Comparacion del tercer premio
comparacion_tercero:
                ldx     #31231
                ldy     #tercer.premio
compara_bucle3:
		lda     ,x+
		beq     compara_igual3
		cmpa    ,y+
		beq     compara_bucle3
compara_distinto3:
                ldd     #0
		jsr     comparacion_4cifras
compara_igual3:
		ldd     puntuaje
                addd    #200
                std     puntuaje
                jsr     comparacion_4cifras
                
compara_fin3:
		addd    #'0
		stb     pantalla			
                ldb     #'\n
		stb     pantalla
                jsr     comparacion_4cifras


;Comparacion de numeros de 4 cifras
comparacion_4cifras:
                ldx     #31231
                leax    1, x  
                ldy     #tres.cifras

                pshs    a
                lda     #2
                sta     numeros.trescifras
                puls    a
compara_bucle4:
		lda     ,x+
		beq     compara_igual4
		cmpa    ,y+
		beq     compara_bucle4

                dec     numeros.trescifras
                bne     compara_bucle4
compara_distinto4:
                ldd     #0
		jsr     comparacion_3cifras
compara_igual4:
		ldd     puntuaje
                addd    #50
                std     puntuaje
                jsr     comparacion_3cifras
                
compara_fin4:
		addd    #'0
		stb     pantalla			
                ldb     #'\n
		stb     pantalla
                jsr     comparacion_3cifras



;Comparacion de numeros de 3 cifras
comparacion_3cifras:
                ldx     #31231
                leax    1, x  
                ldy     #tres.cifras

                pshs    a
                lda     #14
                sta     numeros.trescifras
                puls    a
compara_bucle5:
		lda     ,x+
		beq     compara_igual5
		cmpa    ,y+
		beq     compara_bucle4

                dec     numeros.doscifras
                bne     compara_bucle5
compara_distinto5:
                ldd     #0
		jsr     comparacion_2cifras
compara_igual5:
		ldd     puntuaje
                addd    #10
                std     puntuaje
                jsr     comparacion_2cifras
                
compara_fin5:
		addd    #'0
		stb     pantalla			
                ldb     #'\n
		stb     pantalla
                jsr     comparacion_2cifras



;Comparacion de terminaciones de 2 cifras
comparacion_2cifras:
                ldx     #31231
                leax    1, x  
                ldy     #cuatro.cifras

                pshs    a
                lda     #5
                sta     numeros.doscifras
                puls    a
compara_bucle6:
		lda     ,x+
		beq     compara_igual6
		cmpa    ,y+
		beq     compara_bucle6

                dec     numeros.doscifras
                bne     compara_bucle6
compara_distinto6:
                ldd     #0
		jsr     comparacion_reintegros
compara_igual6:
		ldd     puntuaje
                addd    #5
                std     puntuaje
                jsr     comparacion_reintegros
                
compara_fin6:
		addd    #'0
		stb     pantalla			
                ldb     #'\n
		stb     pantalla
                jsr     comparacion_reintegros



;Comparaciones de reintegros
comparacion_reintegros:
                ldx     #31231
                leax    1, x  
                ldy     #reintegro

                pshs    a
                lda     #3
                sta     numeros.reintegro
                puls    a
compara_bucle7:
		lda     ,x+
		beq     compara_igual7
		cmpa    ,y+
		beq     compara_bucle7

                dec     cuatro.cifras
                bne     compara_bucle7
compara_distinto7:
                ldd     #0
		jsr     
compara_igual7:
		ldd     puntuaje
                addd    #1
                std     puntuaje
                jsr     
                
compara_fin7:
		addd    #'0
		stb     pantalla			
                ldb     #'\n
		stb     pantalla
                jsr
