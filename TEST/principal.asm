.module principal

fin .equ 0xFF01
teclado .equ 0xFF02
pantalla .equ 0xFF00


Max_Decimos: .byte 20

num_decimos: .byte 20

decimos: .asciz "23042"
	 .asciz "42014"
	 .asciz "50213"
	 .asciz "05213"
	 .asciz "04195"
	 .asciz "04201"
	 .asciz "41405"
	 .asciz "61316"
	 .asciz "84912"
	 .asciz "56296"
	 .asciz "39412"
	 .asciz "72415"
	 .asciz "40151"
	 .asciz "81341"
	 .asciz "24318"
	 .asciz "04718"
	 .asciz "82093"
	 .asciz "59230"
	 .asciz "61940"
	 .asciz "31949"
	 .asciz "84193"

prim_premio: .asciz "05213"
segun_premio: .asciz "82193"
ter_premio: .asciz "23042"

terminaciones_cuatro: .asciz "4193"
		      .asciz "4318"

terminaciones_tres:	.asciz "949"
			.asciz "316"
			.asciz "201"
			.asciz "912"
			.asciz "042"
			.asciz "014"
			.asciz "526"
			.asciz "813"
			.asciz "415"
			.asciz "230"
			.asciz "195"
			.asciz "001"
			.asciz "815"
			.asciz "112"
			.asciz "296"

terminaciones_dos:	.asciz "01"
			.asciz "93"
			.asciz "00"
			.asciz "18"
			.asciz "42"

reintegros:	.asciz "3"
		.asciz "5"
		.asciz "0"

menu:   .ascii "\nSORTEO DE LOTERIA\n"
	.ascii "\nSELECCIONE UNA OPCION:\n"
	.ascii "1) DECIMOS\n"
	.ascii "2) SORTEO\n"
	.ascii "3) COMPROBAR\n"
	.asciz "4) SALIR\n"

menu_decimos: 	.ascii "\nSELECCIONE UNA OPCION:\n"
		.ascii "1) VER\n"
		.ascii "2) INTRODUCIR\n"
		.asciz "3) VOLVER\n"
menu_sorteo: 	.ascii "\nSELECCIONE UNA OPCION:\n"
		.ascii "1) VER RESULTADOS\n"
		.ascii "2) INTRODUCIR RESULTADOS\n"
		.asciz "3) VOLVER\n"
menu_result_sorteo:  	.ascii "\nSELECCIONE UNA OPCION:\n"
			.ascii "1) 1ER, 2ND, 3ER PREMIOS\n"
			.ascii "2) TERMINACIONES CUATRO CIFRAS\n"
			.ascii "3) TERMINACIONES TRES CIFRAS\n"
			.ascii "4) TERMINACIONES DOS CIFRAS\n"
			.ascii "5) REINTEGROS\n"
			.asciz "6) VOLVER\n"
error1: .asciz " Opcion no valida\n"
error2: .asciz " Numeros no valido(repetido)"
pedir_num_decimos: .asciz "Introduzca el numero de decimos a introducir (Maximo 20): "
tabla_comprobar: .ascii "Decimo  1ER\t2ND\t3RD\tTE4\tTE3\tTE2\tREI\tTotal\n"
		 .asciz "=====================================================================\n"
primer_premio_texto: .asciz "Primer premio:\n"
segun_premio_texto: .asciz "Segundo premio:\n"
tercer_premio_texto: .asciz "Tercer premio:\n"
termin_cuatro_texto: .asciz "Terminaciones de cuatro cifras:\n"
termin_tres_texto: .asciz "Terminaciones de tres cifras:\n"
termin_dos_texto: .asciz "Terminaciones de dos cifras:\n"
reintegros_texto: .asciz "Reintegros:\n"

.globl programa
.globl imprimir_cadena
.globl imprimir_numeros
.globl imprimir_decimal
.globl lectura_cadena_n
.globl comparar_numeros
.globl comparar_premios_decimo
.globl introducir_multiples_terminaciones

programa:
lds #0xFF00

presenta_menu:
clra
ldx #menu
jsr imprimir_cadena
lda teclado
cmpa #'1
beq elegir_opcion_decimos
cmpa #'2
beq elegir_opcion_sorteo
cmpa #'3
beq comprobar
cmpa #'4 
beq ir_a_acabar 
ldx #error1
jsr imprimir_cadena
bra presenta_menu

comprobar:
 lbra comprobar_f
 
ir_a_acabar:
	lbra acabar

elegir_opcion_decimos: 
ldx #menu_decimos
jsr imprimir_cadena
clra
lda teclado
cmpa #'1
beq ver_decimos
cmpa #'2
beq introducir_decimos
cmpa #'3
beq presenta_menu
ldx #error1
jsr imprimir_cadena
bra elegir_opcion_decimos

elegir_opcion_sorteo:
clra
ldx #menu_sorteo
jsr imprimir_cadena
lda teclado
cmpa #'1
beq ver_resultados
cmpa #'2
beq introducir_resultados
cmpa #'3
beq presenta_menu
ldx #error1
jsr imprimir_cadena
bra elegir_opcion_sorteo

introducir_resultados:
clra
ldx #menu_result_sorteo
jsr imprimir_cadena
lda teclado
cmpa #'1
beq introducir_premios
cmpa #'2
beq introducir_terminaciones_cuatro
cmpa #'3
beq introducir_terminaciones_tres
cmpa #'4
beq introducir_terminaciones_dos
cmpa #'5
beq introducir_reintegros
cmpa #'6
beq elegir_opcion_sorteo
ldx #error1
jsr imprimir_cadena
bra introducir_resultados

ver_resultados:
	lbra ver_resultados_f
introducir_premios:
	lbra introducir_premios_f
introducir_terminaciones_cuatro:
	lbra introducir_terminaciones_cuatro_f
introducir_terminaciones_tres:
	lbra introducir_terminaciones_tres_f
introducir_terminaciones_dos:
	lbra introducir_terminaciones_dos_f
introducir_reintegros:
	lbra introducir_reintegros_f

ver_decimos: 
	lda #'\n
	sta pantalla
	
	ldx #decimos
	ldb num_decimos
	jsr imprimir_numeros
	lbra elegir_opcion_decimos

introducir_decimos:
	ldx #pedir_num_decimos
	jsr imprimir_cadena
	lda teclado
	suba #'0
	sta num_decimos
	lda teclado
	clra
	ldb #0
	ldx #decimos
bucle_introducir_decimos:
	lda #6
	jsr lectura_cadena_n
	pshs b
	ldb #1
	abx
	puls b
	incb
	cmpb num_decimos
	beq volver_elegir_decimos
	lda #10
	sta pantalla
	bra bucle_introducir_decimos

volver_elegir_decimos:
	lbra elegir_opcion_decimos

ver_resultados_f: 
	lda #10
	sta pantalla
	ldx #primer_premio_texto
	jsr imprimir_cadena
	ldx #prim_premio
	jsr imprimir_cadena
	lda #10
	sta pantalla

	ldx #segun_premio_texto
	jsr imprimir_cadena
	ldx #segun_premio
	jsr imprimir_cadena
	lda #10
	sta pantalla
	
	ldx #tercer_premio_texto
	jsr imprimir_cadena
	ldx #ter_premio
	jsr imprimir_cadena
	lda #10
	sta pantalla
	
	ldx #termin_cuatro_texto
	jsr imprimir_cadena	
	ldx #terminaciones_cuatro
	lda #0
	ldb #1
	jsr imprimir_numeros 

	ldx #termin_tres_texto
	jsr imprimir_cadena
	ldx #terminaciones_tres
	lda #0
	ldb #13
	jsr imprimir_numeros

	ldx #termin_dos_texto
	jsr imprimir_cadena
	ldx #terminaciones_dos
	lda #0
	ldb #4
	jsr imprimir_numeros

	ldx #reintegros_texto
	jsr imprimir_cadena
	ldx #reintegros
	lda #0
	ldb #2
	jsr imprimir_numeros
	lbra elegir_opcion_sorteo

introducir_premios_f:
	lda #10
	sta pantalla
	ldx #primer_premio_texto
	jsr imprimir_cadena
	ldx #prim_premio
	lda #6
	jsr lectura_cadena_n
introducir_segun_premio:
	lda #10
	sta pantalla
	ldx #segun_premio_texto
	jsr imprimir_cadena
	ldx #segun_premio
	lda #6
	jsr lectura_cadena_n
	ldx #segun_premio
	ldy #prim_premio
	lda #0
	jsr comparar_numeros	
	cmpb #0
	beq introducir_ter_premio
	ldx #error2
	jsr imprimir_cadena
	bra introducir_segun_premio
introducir_ter_premio:
	lda #10
	sta pantalla
	ldx #tercer_premio_texto
	jsr imprimir_cadena
	ldx #ter_premio
	lda #6
	jsr lectura_cadena_n
	ldx #ter_premio
	ldy #prim_premio
	lda #0
	jsr comparar_numeros
	cmpb #0
	beq comp_ter_premio
	ldx #error2
	jsr imprimir_cadena
	bra introducir_ter_premio
comp_ter_premio:
	ldx #ter_premio
	ldy #segun_premio
	lda #0
	jsr comparar_numeros
	cmpb #0
	beq fin_introducir_premios
	ldx #error2
	jsr imprimir_cadena
	bra introducir_ter_premio
fin_introducir_premios:
	lbra introducir_resultados
	
introducir_terminaciones_cuatro_f:
	ldx #terminaciones_cuatro
	ldy #terminaciones_cuatro
	lda #5
	ldb #2
	jsr introducir_multiples_terminaciones
	lbra introducir_resultados

introducir_terminaciones_tres_f:
	ldx #terminaciones_tres
	ldy #terminaciones_tres
	lda #4
	ldb #14
	jsr introducir_multiples_terminaciones
	lbra introducir_resultados

introducir_terminaciones_dos_f:
	ldx #terminaciones_dos
	ldy #terminaciones_dos
	lda #3
	ldb #5
	jsr introducir_multiples_terminaciones
	lbra introducir_resultados

introducir_reintegros_f:
	ldx #reintegros
	ldy #reintegros
	lda #2
	ldb #3
	jsr introducir_multiples_terminaciones
	lbra introducir_resultados
	
comprobar_f:
	lda #10 
	sta pantalla
	ldx #tabla_comprobar
	jsr imprimir_cadena
	ldb #0
	ldx #decimos
bucle_comp_decimos:
	pshs x
	jsr imprimir_cadena
	puls x
	lda #9
	sta pantalla
	pshs b	
	ldy #reintegros
	pshs y
	ldy #terminaciones_dos
	pshs y
	ldy #terminaciones_tres
	pshs y
	ldy #terminaciones_cuatro
	pshs y
	ldy #ter_premio
	pshs y
	ldy #segun_premio
	pshs y
	ldy #prim_premio
	pshs y
	jsr comparar_premios_decimo
	ldb #6
	ABX
	puls b
	incb
	cmpb num_decimos
	blo bucle_comp_decimos
	lbra presenta_menu
acabar:
	clra
	sta fin

.area FIJA(ABS)
.org 0xFFFE
.word programa
