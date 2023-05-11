    .module sorteo

fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00


    .globl  primer.premio
    .globl  segundo.premio
    .globl  tercer.premio
    .globl  cuatro.cifras
    .globl  tres.cifras
    .globl  dos.cifras
    .globl  reintegro

    
    .globl  cantidad_4cifras
    .globl  cantidad_3cifras
    .globl  cantidad_2cifras
    .globl  cantidad_reintegro

    .globl imprime_cadena
    .globl limpia_pantalla
    .globl error_switch
    .globl programa
    .globl salir
    .globl imprime_num
    .globl barra

    .globl sorteo




m_sorteo:       .ascii  "\n\33[33m=========SORTEO========== \n"
                .ascii  "\33[34m1. Ver Resultados\n"
                .ascii  "\33[35m2. Introducir Resultados\n"
                .asciz  "\33[36m3. Volver\n"

m_sorteo2:      .ascii  "\n\33[35m=========INTRODUCIR RESULTADOS==========\n"
                .ascii  "\33[31m1. 3 Primeros premios\n"
                .ascii  "\33[32m2. Terminaciones 4 cifras\n"
                .ascii  "\33[33m3. Terminaciones 3 cifras\n"
                .ascii  "\33[34m4. Terminaciones 2 cifras\n"
                .ascii  "\33[35m5. Reintegros\n"
                .asciz  "\33[36m6. Volver\n"


primerpremio_txt:  .asciz "PRIMER PREMIO:\t"
segundopremio_txt: .asciz "SEGUNDO PREMIO:\t"
tercerpremio_txt: .asciz  "TERCER PREMIO:\t"
terminacion4_txt: .asciz  "\33[32mTERMINACION 4 CIFRAS:\n"
terminacion3_txt: .asciz  "TERMINACION 3 CIFRAS:\n"
terminacion2_txt: .asciz  "TERMINACION 2 CIFRAS:\n"
reintegro_txt:    .asciz  "\33[35mREINTEGRO:\n"


sorteo:
    ldx #m_sorteo
    jsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    jsr imprime_cadena 
    cmpa #'1 ; 1. Ver resultados
    lbeq sorteo_ver; Si es 1, va a sorteo_ver
    cmpa #'2 ; 2. Introducir resultados
    lbeq sorteo_introducir; Si es 2, va a sorteo_introducir
    cmpa #'3 ; 3. Volver
    lbeq programa_sorteo  ; Si es 3, vuelve al menu principal
    ldx #error_switch
    jsr imprime_cadena
    bra sorteo

programa_sorteo:
    jsr programa

sorteo_ver:

    ldx #limpia_pantalla
    jsr imprime_cadena
    ldb #'\n
    stb pantalla

    ldx #primerpremio_txt
    jsr imprime_cadena
    ldx #primer.premio
    jsr imprime_cadena
    ldb #'\n
    stb pantalla

    ldx #segundopremio_txt
    jsr imprime_cadena
    ldx #segundo.premio
    jsr imprime_cadena
    ldb #'\n
    stb pantalla

    ldx #tercerpremio_txt
    jsr imprime_cadena
    ldx #tercer.premio
    jsr imprime_cadena
    ldb #'\n
    stb pantalla

    ldx #barra
    jsr imprime_cadena

    ldx #terminacion4_txt
    jsr imprime_cadena
    ldx #cuatro.cifras
    ldb cantidad_4cifras
    jsr imprime_num
    ldb #'\n
    stb pantalla

    ldx #terminacion3_txt
    jsr imprime_cadena
    ldx #tres.cifras
    ldb cantidad_3cifras
    jsr imprime_num
    ldb #'\n
    stb pantalla

    ldx #terminacion2_txt
    jsr imprime_cadena
    ldx #dos.cifras
    ldb cantidad_2cifras
    jsr imprime_num
    ldb #'\n
    stb pantalla

    ldx #barra
    jsr imprime_cadena

    ldx #reintegro_txt
    jsr imprime_cadena
    ldx #reintegro
    ldb cantidad_reintegro
    jsr imprime_num

    ldx #barra
    jsr imprime_cadena

salir_ver_sorteo:
    ldx #salir
    jsr imprime_cadena
    lda teclado
    cmpa #'c
    lbeq sorteo
    cmpa #'C
    lbeq sorteo
    ldx #error_switch
    jsr imprime_cadena
    lbra salir_ver_sorteo


    
for_4cifras:
    cmpa #2
    bge for_3cifras
    jsr imprime_cadena
    adda #1
    ldb #'\n
    stb pantalla
    bra for_4cifras

reset_4cifras:
    lda #0

for_3cifras:

    cmpa #14
    bge for_2cifras
    jsr imprime_cadena
    adda #1
    ldb #'\n
    stb pantalla
    bra for_3cifras

reset_3cifras:

    lda #0

for_2cifras:
    cmpa #5
    bge for_reintegros
    jsr imprime_cadena
    adda #1
    ldb #'\n
    stb pantalla
    bra for_2cifras

reset_2cifras:
    lda #0

for_reintegros:

    cmpa #3
    bge salir_bucle
    jsr imprime_cadena
    adda #1
    ldb #'\n
    stb pantalla
    bra for_reintegros

salir_bucle:
    ldx #salir
    jsr imprime_cadena
    lda teclado
    cmpa #'c
    lbeq sorteo
    cmpa #'C
    lbeq sorteo
    ldx #error_switch
    jsr imprime_cadena
    jsr sorteo

sorteo_introducir:
    ldx #m_sorteo2
    jsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    jsr imprime_cadena 
    cmpa #'1 ; 1. 3 primeros premios
    lbeq sorteo_ver; Si es 1, va a sorteo_introducir_3premios
    cmpa #'2 ; 2. Terminaciones 4 cifras
    lbeq sorteo_ver; Si es 2, va a sorteo_introducir_2
    cmpa #'3 ; 3. Terminaciones 3 cifras
    lbeq sorteo_ver; Si es 3, va a sorteo_introducir_3
    cmpa #'4 ; 4. Terminaciones 2 cifras
    lbeq sorteo_ver; Si es 4, va a sorteo_introducir_4
    cmpa #'5 ; 5. Reintegros
    lbeq sorteo_ver; Si es 5, va a sorteo_introducir_5
    cmpa #'6 ; 6. Volver
    lbeq sorteo;    ; Si es 6, vuelve al menu sorteo
    ldx #error_switch
    jsr imprime_cadena
    bra sorteo_introducir

sorteo_introducir_3premios:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce los 3 premios
    rts

sorteo_introducir_4cifras:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce las terminaciones de 4 cifras
    rts

sorteo_introducir_3cifras:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce las terminaciones de 3 cifras
    rts

sorteo_introducir_2cifras:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce las terminaciones de 2 cifras
    rts

sorteo_introducir_reintegros:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce los reintegros
    rts
    