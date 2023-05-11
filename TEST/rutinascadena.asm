.module rutinascadena
.globl imprimir_cadena
.globl imprimir_numeros
.globl imprimir_decimal
.globl lectura_cadena_n
.globl comparar_numeros
.globl comparar_premios_decimo
.globl introducir_multiples_terminaciones

fin .equ 0xFF01
teclado .equ 0xFF02
pantalla .equ 0xFF00
contador: .byte 0
contador2: .byte 0
direccion: .word 0
cifras: .byte 0
cantidad_termin: .byte 0
error3: .asciz "Numero no valido (repetido)"

;imprimir_cadena
;	imprime por pantalla cadenas hasta encontrar \0
;entrada: x direccion inicio cadena
;salida: ninguna
;registros afectados: X

imprimir_cadena:
	pshs a,b
ic_sgte:
	lda ,x+
	beq ic_retorno
	sta pantalla
	bra ic_sgte
ic_retorno:
	puls a,b
rts


;imprimir_numeros
;imprime por pantalla numeros como cadenas de caracteres
;entrada: x direccion primer numero, b numero de iteraciones, a empieza a 0 para inciar
;salida: ninguna
;registros afectados: x, a, b

imprimir_numeros:
	stb contador
in_sgte:
	leax ,x+
	jsr imprimir_cadena
	ldb #10
	stb pantalla
	cmpa contador
	beq in_fin_bucle
	inca
	bra in_sgte
in_fin_bucle:
rts

;lectura_cadena_n
;entrada x direccion cadena ,a num maximo caracteres
;salida a num caracteres
;reg: x,a
lcn_max: .byte 0
lectura_cadena_n:
	pshs b
	tsta
	beq lcn_retorno
	deca
	sta lcn_max
	clra
lcn_lectura:
	cmpa lcn_max
	bhs lcn_fin_lectura_n
	ldb teclado
	stb ,x+
	cmpb #'\n
	beq lcn_fin_lectura
	inca
	bra lcn_lectura
lcn_fin_lectura:
	clr ,-x
	bra lcn_retorno
lcn_fin_lectura_n:
	clr ,x
lcn_retorno:
	puls b
rts

;imprimir_decimal
; imprime un numero separando sus cifras
;entradas: d numero en decimal
;salida ninguna
;registros afectados: a,b,x

imprimir_decimal:
pshs x
	ldx #0
	id_primera_cifra:
		cmpd #1000
		blo id_imp_primera
		subd #1000
		leax 1,x
		bra id_primera_cifra
	id_imp_primera:
		exg x,d
		addb #'0
		stb pantalla
		exg x,d
		ldx #0
	id_segunda_cifra:
		cmpd #100
		blo id_imp_segunda
		subd #100
		leax 1,x
		bra id_segunda_cifra
	id_imp_segunda:
		exg x,d
		addb #'0
		stb pantalla
		exg x,d
		ldx #0
	id_tercera_cifra:
		cmpd #10
		blo id_imp_tercera
		subd #10
		leax 1,x
		bra id_tercera_cifra
	id_imp_tercera:
		exg x,d
		addb #'0
		stb pantalla
		exg x,d
		ldx #0
	id_imp_cuarta:
		addb #'0
		stb pantalla
		ldb #32
		stb pantalla
puls x
rts

;introducir_multiples_terminaciones
; introduce varias terminaciones sin repetidos
;entrada: x e y direccion del primer elemento de la lista, a numero de cifras, b numero de numeros
;salida: ninguna
;registros afectados: x,y,a,b

introducir_multiples_terminaciones:
	sta cifras
	sty direccion
	stb cantidad_termin
	ldb #1
	stb contador
	ldb #10
	stb pantalla
	lda cifras
	jsr lectura_cadena_n
	ldb #1
	ABX
bucle_introducir_terminaciones:
	ldb #10
	stb pantalla
	lda cifras
	pshs x
	jsr lectura_cadena_n
	puls x
	ldb #0
	stb contador2
bucle_comparar_terminaciones:
	pshs x
	lda #0
	jsr comparar_numeros
	puls x
	cmpb #1
	beq terminaciones_iguales
	pshs x
	tfr y,x
	ldb cifras
	decb
	ABX
	tfr x,y
	puls x
	ldb contador2
	incb 
	cmpb contador
	beq terminaciones_distintas
	stb contador2
	bra bucle_comparar_terminaciones
terminaciones_distintas:
	ldy direccion
	ldb cifras
	ABX
	ldb contador
	incb
	cmpb cantidad_termin
	beq final_funcion
	stb contador
	bra bucle_introducir_terminaciones
terminaciones_iguales:
	ldy direccion
	pshs x
	ldx #error3
	jsr imprimir_cadena
	puls x                                                                                                              
	bra bucle_introducir_terminaciones
final_funcion:
	rts
	
	
	
	
	
	
	
	
	
	
