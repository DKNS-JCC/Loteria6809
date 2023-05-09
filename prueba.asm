                
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

resultado_txt:  .ascii "El resultado es: "

;Declaraciones
puntuaje:       .word 1000
puntuaje_total: .word 0

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

                .globl comparacion_primero


comparacion_primero:
            clr     puntuaje
            ldx     #valor_decimos
            ldy     #primer.premio
compara_bucle1:
		lda     ,x+     
		beq     compara_igual1          
		cmpa    ,y+
		beq     compara_bucle1
compara_distinto1:
        ldd     #0
	    bra     fin_comparacion    

compara_igual1:
        ldd     #1
        std     puntuaje

fin_comparacion:
        addd #'0
        ldd puntuaje
        std pantalla
        ldd #'\n
        std pantalla
        jsr programa

                

