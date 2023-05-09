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

                .globl  primer.premio
                .globl  segundo.premio
                .globl  tercer.premio
                .globl  cuatro.cifras
                .globl  tres.cifras
                .globl  dos.cifras
                .globl  reintegro
                .globl  imprime_cadena
                .globl  mis_boletos
                .globl  comparacion_primero
                .globl  comparacion_segundo
                .globl  comparacion_tercero
                .globl  comparacion_cuatrocifras

comparacion_primero:
                ldx     mis_boletos
                ldy     #primer.premio
compara_bucle1:
		lda     ,x+
		beq     compara_igual1
		cmpa    ,y+
		beq     compara_bucle1
compara_distinto1:
                ldd     #0
		jrs    comparacion_segundo
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



comparacion_segundo:
                ldx     #mis_boletos
                ldy     #segundo.premio
compara_bucle2:
		lda     ,x+
		beq     compara_igual2
		cmpa    ,y+
		beq     compara_bucle2
compara_distinto2:
                ldd     #0
		jrs     comparacion_tercero
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

comparacion_tercero:
                ldx     #mis_boletos
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



comparacion_4cifras:
                ldx     #mis_boletos
                leax    1, x  
                ldy     #cuatro.cifras
compara_bucle4:
		lda     ,x+
		beq     compara_igual3
		cmpa    ,y+
		beq     compara_bucle3
compara_distinto4:
                ldd     #0
		bra     comparacion_4cifras
compara_igual4:
		ldd     puntuaje
                addd    #200
                std     puntuaje
                jsr     comparacion_4cifras
                
compara_fin4:
		addd    #'0
		stb     pantalla			
                ldb     #'\n
		stb     pantalla
                jsr     comparacion_4cifras