.module comprobar
.globl imprimir_cadena
.globl imprimir_numeros
.globl imprimir_decimal
.globl comparar_numeros
.globl comparar_premios_decimo
.globl introducir_multiples_terminaciones

fin .equ 0xFF01
teclado .equ 0xFF02
pantalla .equ 0xFF00
total: .word 0
direccion_retorno: .word 0
contadorc: .byte 0

prim_premio_marca: .asciz "1ER\t"
segun_premio_marca: .asciz "2ND\t"
ter_premio_marca: .asciz "3ER\t"
termin_cuatro_marca: .asciz "TE4\t"
termin_tres_marca: .asciz "TE3\t"
termin_dos_marca: .asciz "TE2\t"
reintegros_marca: .asciz "REI\t"  

;comparar_numeros
;compara dos cadenas de caracteres, si son iguales devuelve 1, sino 0
;entrada x primera cadena, y segunda cadena, a numero de caracteres que comparamos
;salida b 1 si iguales, 0 si distintos
;registros afectados: a,y,x,b

comparar_numeros:
	leax a,x
cn_bucle:	
	lda ,x+
	beq cn_igual
	cmpa ,y+
	beq cn_bucle
cn_distinto:
	ldb #0
	bra cn_final
cn_igual:
	ldb #1
cn_final:
rts

;comparar_premios_decimo
;comparar un decimos con todos los premios y mostrar los puntos obtenidos
;entrada x direccion decimo
;salida ninguna
;registros afectados a,b,y,x

comparar_premios_decimo:
	ldd #0
	std total
	lda #0
	puls y
	sty direccion_retorno
	puls y
	pshs x
	jsr comparar_numeros
	puls x
	cmpb #1
	beq prim_premio_igual
	ldb #9
	stb pantalla
	bra cmp_segun_premio
prim_premio_igual:
	pshs x
	ldx #prim_premio_marca
	jsr imprimir_cadena
	puls x
	ldd #1000
	std total
cmp_segun_premio:
	lda #0
	puls y
	pshs x
	jsr comparar_numeros
	puls x
	cmpb #1
	beq segun_premio_igual
	ldb #9
	stb pantalla
	bra cmp_ter_premio
segun_premio_igual:
	pshs x
	ldx #segun_premio_marca
	jsr imprimir_cadena
	puls x
	ldd #500
	addd total
	stb total
cmp_ter_premio:
	lda #0
	puls y 
	pshs x
	jsr comparar_numeros
	puls x
	cmpb #1
	beq ter_premio_igual
	ldb #9
	stb pantalla
	bra cmp_termin_cuatro
ter_premio_igual:
	pshs x
	ldx #ter_premio_marca
	jsr imprimir_cadena
	puls x
	ldd #200
	addd total
	std total
cmp_termin_cuatro:
	lda #1
	ldb  #0
	stb contadorc
	puls y
	bucle_termin_cuatro:
		ldb contadorc
		cmpb #2
		beq bucle_fin_distinto_cuatro
		pshs x
		jsr comparar_numeros
		puls x
		cmpb #1
		beq bucle_fin_igual_cuatro
		leay  ,y+
		ldb contadorc
		incb
		stb contadorc
		bra bucle_termin_cuatro
bucle_fin_igual_cuatro:
	pshs x
	ldx #termin_cuatro_marca
	jsr imprimir_cadena
	puls x
	ldd #50
	addd total
	std total
	bra cmp_termin_tres
bucle_fin_distinto_cuatro:
	lda #9
	sta pantalla
cmp_termin_tres:
	lda #2
	ldb  #0
	stb contadorc
	puls y
	bucle_termin_tres:
		ldb contadorc
		cmpb #15
		beq bucle_fin_distinto_tres
		pshs x
		jsr comparar_numeros
		puls x
		cmpb #1
		beq bucle_fin_igual_tres
		leay  ,y+
		ldb contadorc
		incb
		stb contadorc
		bra bucle_termin_tres
bucle_fin_igual_tres:
	pshs x
	ldx #termin_tres_marca
	jsr imprimir_cadena
	puls x
	ldd #10
	addd total
	std total
	bra cmp_termin_dos
bucle_fin_distinto_tres:
	lda #9
	sta pantalla
cmp_termin_dos:
	lda #3
	ldb  #0
	stb contadorc
	puls y
	bucle_termin_dos:
		ldb contadorc
		cmpb #5
		beq bucle_fin_distinto_dos
		pshs x
		jsr comparar_numeros
		puls x
		cmpb #1
		beq bucle_fin_igual_dos
		leay  ,y+
		ldb contadorc
		incb
		stb contadorc
		bra bucle_termin_dos
bucle_fin_igual_dos:
	pshs x
	ldx #termin_dos_marca
	jsr imprimir_cadena
	puls x
	ldd #5
	addd total
	std total
	bra cmp_reintegros
bucle_fin_distinto_dos:
	lda #9
	sta pantalla
cmp_reintegros:
	lda #4
	ldb  #0
	stb contadorc
	puls y
	bucle_reintegros:
		ldb contadorc
		cmpb #3
		beq bucle_fin_distinto_reintegros
		pshs x
		jsr comparar_numeros
		puls x
		cmpb #1
		beq bucle_fin_igual_reintegros
		leay  ,y+
		ldb contadorc
		incb
		stb contadorc
		bra bucle_reintegros
bucle_fin_igual_reintegros:
	pshs x
	ldx #reintegros_marca
	jsr imprimir_cadena
	puls x
	ldd #1
	addd total
	std total
	bra imprime_final_comp
bucle_fin_distinto_reintegros:
	lda #9
	sta pantalla	
imprime_final_comp:
	ldd total
	jsr imprimir_decimal
	lda #10
	sta pantalla
	ldy direccion_retorno
	pshs y
rts


		
