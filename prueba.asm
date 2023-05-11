                
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

opcion_Comprobar:
  jsr limpiarPantalla
  ldx #textoPuntosAlDecimo
  jsr imprimirCadena
  ldx #titulosColumnas
  jsr imprimirCadena
  ldx #filaSeparadora
  jsr imprimirCadena

  ldd #0
  std total_acumulado
  ldd #1
  ldx #decimos
opcion_Comprobar_bucle:
  ;imprimir NUM y decimo
  cmpb decimos_N
  lbhi opcion_Comprobar_bucle_fin
  jsr imprimir_decimal_3cifras
  pshs a
  lda #')
  sta pantalla
  lda #32
  sta pantalla
  puls a
  stx decimo_a_comparar
  jsr imprimirCadena
  incb
  pshs d,x

  ;comprobar y sumar puntos
  ldd #0
  std puntos_decimo
  ldx decimo_a_comparar
  ;comprobar con 1er premio
  ldy #Premio1
  lda #0
  jsr comparar_cadena_ncaracteres
  cmpb #1
  beq es_primer
  ldx #cadena_con_5_espacios
  jsr imprimirCadena
  bra primer_seguir
es_primer:
  ldd puntos_decimo
  addd #1000
  std puntos_decimo
  ldx #cadena_primer
  jsr imprimirCadena
  jmp tercer_seguir ;si es 1er no puede ser ni 2do ni 3er
primer_seguir:
  ;comprobar con 2do premio
  ldy #Premio2
  lda #0
  ldx decimo_a_comparar
  jsr comparar_cadena_ncaracteres
  cmpb #1
  beq es_segundo
  ldx #cadena_con_4_espacios
  jsr imprimirCadena
  bra segundo_seguir
es_segundo:
  ldd puntos_decimo
  addd #500
  std puntos_decimo
  ldx #cadena_segundo
  jsr imprimirCadena
  jmp tercer_seguir ;si es 2do no puede ser tambien 3er
segundo_seguir:
  ;comprobar con 3er premio
  ldy #Premio3
  lda #0
  ldx decimo_a_comparar
  jsr comparar_cadena_ncaracteres
  cmpb #1
  beq es_tercer
  ldx #cadena_con_4_espacios
  jsr imprimirCadena
  bra tercer_seguir
es_tercer:
  ldd puntos_decimo
  addd #200
  std puntos_decimo
  ldx #cadena_tercer
  jsr imprimirCadena
  jmp tercer_seguir
tercer_seguir:

  ;comparar con extraccion de 4 cifras
  ldb #0 ;contador
bucle_extr_4:
  cmpb #1
  bhi no_extr_4
  ldy #Extraccion4Cifras
  lda #5 ;en cada iteracion avanzamos 5 bytes
  pshs b
  mul
  leay d,y
  ldx decimo_a_comparar
  lda #1 ;no se compara la primera cifra
  jsr comparar_cadena_ncaracteres
  cmpb #1
  beq es_extr_4 ;si encontramos una terminacion igual salimos del bucle
  puls b ;recuperamos contador
  incb
  bra bucle_extr_4

no_extr_4:
  ldx #cadena_con_4_espacios
  jsr imprimirCadena
  bra extr_4_seguir
es_extr_4:
  puls b ;ya no necesitamos el valor que habia en b
  ldd puntos_decimo
  addd #50
  std puntos_decimo
  ldx #cadena_TE4
  jsr imprimirCadena
extr_4_seguir:

  ;comparar con extraccion de 3 cifras
  ldb #0 ;contador
bucle_extr_3:
  cmpb #13
  bhi no_extr_3
  ldy #Extraccion3Cifras
  lda #4 ;en cada iteracion avanzamos 4 bytes
  pshs b
  mul
  leay d,y
  ldx decimo_a_comparar
  lda #2 ;no se comparan las dos primeras cifras
  jsr comparar_cadena_ncaracteres
  cmpb #1
  beq es_extr_3 ;si encontramos una terminacion igual salimos del bucle
  puls b ;recuperamos contador
  incb
  bra bucle_extr_3

no_extr_3:
  ldx #cadena_con_4_espacios
  jsr imprimirCadena
  bra extr_3_seguir
es_extr_3:
  puls b ;ya no necesitamos el valor que habia en b
  ldd puntos_decimo
  addd #10
  std puntos_decimo
  ldx #cadena_TE3
  jsr imprimirCadena
extr_3_seguir:

  ;comparar con extraccion de 2 cifras
  ldb #0 ;contador
bucle_extr_2:
  cmpb #4
  bhi no_extr_2
  ldy #Extraccion2Cifras
  lda #3 ;en cada iteracion avanzamos 3 bytes
  pshs b
  mul
  leay d,y
  ldx decimo_a_comparar
  lda #3 ;no se comparan las tes primeras cifras
  jsr comparar_cadena_ncaracteres
  cmpb #1
  beq es_extr_2 ;si encontramos una terminacion igual salimos del bucle
  puls b ;recuperamos contador
  incb
  bra bucle_extr_2

no_extr_2:
  ldx #cadena_con_4_espacios
  jsr imprimirCadena
  bra extr_2_seguir
es_extr_2:
  puls b ;ya no necesitamos el valor que habia en b
  ldd puntos_decimo
  addd #5
  std puntos_decimo
  ldx #cadena_TE2
  jsr imprimirCadena
extr_2_seguir:

  ;comparar con reintegro
  ldb #0 ;contador
bucle_extr_1:
  cmpb #2
  bhi no_extr_1
  ldy #Reintegro
  lda #2 ;en cada iteracion avanzamos 2 bytes
  pshs b
  mul
  leay d,y
  ldx decimo_a_comparar
  lda #4 ;no se comparan las 4 primeras cifras
  jsr comparar_cadena_ncaracteres
  cmpb #1
  beq es_extr_1 ;si encontramos una terminacion igual salimos del bucle
  puls b ;recuperamos contador
  incb
  bra bucle_extr_1

no_extr_1:
  ldx #cadena_con_4_espacios
  jsr imprimirCadena
  bra extr_1_seguir
es_extr_1:
  puls b ;ya no necesitamos el valor que habia en b
  ldd puntos_decimo
  addd #1
  std puntos_decimo
  ldx #cadena_REI
  jsr imprimirCadena
extr_1_seguir:

  ldx #cadena_flecha
  jsr imprimirCadena

  ldd puntos_decimo
  jsr imprimir_decimal_4cifras

  ldd total_acumulado ;sumamos al total acumulado los puntos de cada decimo
  addd puntos_decimo
  std total_acumulado
 
  puls d,x ;recuperamos en d el contador y en x la cadena siguiente
  jsr saltoLinea
  jmp opcion_Comprobar_bucle
opcion_Comprobar_bucle_fin:
	 ldx #filaSeparadora
	 jsr imprimirCadena
	 ;mostrar TOTAL ACUMULADO
  ldx #cadena_total_acumulado
  jsr imprimirCadena
  ldd total_acumulado
  jsr imprimir_decimal_4cifras
 
  jsr saltoLinea
    jmp Menu_Inicial_sin_limpiar_patalla ;vuelve automaticamente a menu principal