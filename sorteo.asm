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
    .globl acumulador
    .globl compara_bucle

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

introducir_primerpremio_txt:  .asciz "Introduzca el primer premio:\n"
introducir_segundopremio_txt: .asciz "Introduzca el segundo premio:\n"
introducir_tercerpremio_txt:  .asciz "Introduzca el tercer premio:\n"
introducir_terminacion4_txt:  .asciz "Introduzca las terminaciones de 4 cifras:\n"
introducir_terminacion3_txt:  .asciz "Introduzca las terminaciones de 3 cifras:\n"
introducir_terminacion2_txt:  .asciz "Introduzca las terminaciones de 2 cifras:\n"
introducir_reintegro_txt:     .asciz "Introduzca los reintegros:\n"

temp_sorteo:    .byte 0
cuenteo_sorteo: .byte 0


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

sorteo_introducir:
    ldx #m_sorteo2
    jsr imprime_cadena
    lda teclado
    ldx #limpia_pantalla
    jsr imprime_cadena 
    cmpa #'1 ; 1. 3 primeros premios
    lbeq sorteo_introducir_3premios; Si es 1, va a sorteo_introducir_3premios
    cmpa #'2 ; 2. Terminaciones 4 cifras
    lbeq sorteo_introducir_4cifras; Si es 2, va a sorteo_introducir_2
    cmpa #'3 ; 3. Terminaciones 3 cifras
    lbeq sorteo_introducir_3cifras; Si es 3, va a sorteo_introducir_3
    cmpa #'4 ; 4. Terminaciones 2 cifras
    lbeq sorteo_introducir_2cifras; Si es 4, va a sorteo_introducir_4
    cmpa #'5 ; 5. Reintegros
    lbeq sorteo_introducir_reintegros; Si es 5, va a sorteo_introducir_5
    cmpa #'6 ; 6. Volver
    lbeq sorteo;    ; Si es 6, vuelve al menu sorteo
    ldx #error_switch
    jsr imprime_cadena
    bra sorteo_introducir

sorteo_introducir_3premios:
    ldx #introducir_primerpremio_txt
    jsr imprime_cadena

    ldx #primer.premio
    stx temp_sorteo
    lda #1      ;cantidad de premio

for_intro1:

        clr acumulador
        sta acumulador

intro_1er_premio:

        lda #5        ; 5 numeros por decimo
        sta cuenteo_sorteo   ; n_digitos = 5

digitos1:

        lda teclado ; Cargamos el numero introducido por teclado
        sta ,x+     ; Lo guardamos en la direccion de memoria de temp        
        dec cuenteo_sorteo ; Decrementamos el contador
        bne digitos1 ; Si el contador es distinto de 0, repetimos el bucle
        ldx temp_sorteo    ; Cargamos la direccion de memoria de temp_sorteo en x
        leax 6, x   ; Le sumamos 6 a x para que apunte al siguiente decimo
        stx temp_sorteo    ; Guardamos la direccion de memoria de temp_sorteo en temp_sorteo
        ldb #'\n        ; Cargamos el salto de linea en b
        stb pantalla    ; Guardamos el salto de linea en pantalla
        dec acumulador      ; Decrementamos el acumulador
        bne intro_1er_premio   ; Si el acumulador es distinto de 0, repetimos el bucle


segundo_sorteo:
        ldx #introducir_segundopremio_txt
        jsr imprime_cadena

        ldx #segundo.premio
        stx temp_sorteo
        lda #1      ;cantidad de premio

for_intro2:

        clr acumulador
        sta acumulador

intro_2do_premio:
            
        lda #5        ; 5 numeros por decimo
        sta cuenteo_sorteo   ; n_digitos = 5

digitos2:

        lda teclado ; Cargamos el numero introducido por teclado
        sta ,x+     ; Lo guardamos en la direccion de memoria de temp_sorteo        
        dec cuenteo_sorteo ; Decrementamos el contador
        bne digitos2 ; Si el contador es distinto de 0, repetimos el bucle
        ldx temp_sorteo    ; Cargamos la direccion de memoria de temp_sorteo en x
        leax 6, x   ; Le sumamos 6 a x para que apunte al siguiente decimo
        stx temp_sorteo    ; Guardamos la direccion de memoria de temp_sorteo en temp_sorteo
        ldb #'\n        ; Cargamos el salto de linea en b
        stb pantalla    ; Guardamos el salto de linea en pantalla
        dec acumulador      ; Decrementamos el acumulador
        bne intro_2do_premio   ; Si el acumulador es distinto de 0, repetimos el bucle

        ldx #segundo.premio
        ldy #primer.premio
        jsr compara_bucle
        cmpb #0
        lbeq tercer_sorteo
        cmpb #1
        ldx #error_switch
        jsr imprime_cadena
        lbra segundo_sorteo

tercer_sorteo:
        ldx #introducir_tercerpremio_txt
        jsr imprime_cadena

        ldx #tercer.premio
        stx temp_sorteo
        lda #1      ;cantidad de premio

for_intro3:
    
        clr acumulador
        sta acumulador

intro_3er_premio:
                    
        lda #5        ; 5 numeros por decimo
        sta cuenteo_sorteo   ; n_digitos = 5

digitos3:

        lda teclado ; Cargamos el numero introducido por teclado
        sta ,x+     ; Lo guardamos en la direccion de memoria de temp_sorteo        
        dec cuenteo_sorteo ; Decrementamos el contador
        bne digitos3 ; Si el contador es distinto de 0, repetimos el bucle
        ldx temp_sorteo    ; Cargamos la direccion de memoria de temp_sorteo en x
        leax 6, x   ; Le sumamos 6 a x para que apunte al siguiente decimo
        stx temp_sorteo    ; Guardamos la direccion de memoria de temp_sorteo en temp_sorteo
        ldb #'\n        ; Cargamos el salto de linea en b
        stb pantalla    ; Guardamos el salto de linea en pantalla
        dec acumulador      ; Decrementamos el acumulador
        bne intro_3er_premio   ; Si el acumulador es distinto de 0, repetimos el bucle
        
        ldx #primer.premio
        ldy #segundo.premio
        jsr compara_bucle
        cmpb #0
        lbeq segundo_test
        cmpb #1
        ldx #error_switch
        jsr imprime_cadena
        lbra sorteo_introducir_3premios

segundo_test:
        ldx #segundo.premio
        ldy #tercer.premio
        jsr compara_bucle
        cmpb #0
        lbeq fin_introducir1
        cmpb #1
        ldx #error_switch
        jsr imprime_cadena
        lbra tercer_sorteo

fin_introducir1:
        lbra sorteo_introducir  ; Volvemos a sorteo_introducir

sorteo_introducir_4cifras:
    ldx #introducir_terminacion4_txt
    jsr imprime_cadena

    ldx #cuatro.cifras
    stx temp_sorteo


for_intro4:

        clr acumulador
        lda #2       
        sta acumulador

intro_4cifras:
    
            lda #4        
            sta cuenteo_sorteo   ; n_digitos = 4

digitos4:

            lda teclado         ; Cargamos el numero introducido por teclado
            sta ,x+             ; Lo guardamos en la direccion de memoria de temp_sorteo        
            dec cuenteo_sorteo  ; Decrementamos el contador
            bne digitos4        ; Si el contador es distinto de 0, repetimos el bucle
            ldx temp_sorteo     ; Cargamos la direccion de memoria de temp_sorteo en x
            leax 5, x           ; Le sumamos 5 a x para que apunte al siguiente decimo
            stx temp_sorteo     ; Guardamos la direccion de memoria de temp_sorteo en temp_sorteo
            ldb #'\n            ; Cargamos el salto de linea en b
            stb pantalla        ; Guardamos el salto de linea en pantalla
            dec acumulador      ; Decrementamos el acumulador
            bne intro_4cifras   ; Si el acumulador es distinto de 0, repetimos el bucle
            jsr sorteo

sorteo_introducir_3cifras:
    ldx #introducir_terminacion3_txt
    jsr imprime_cadena

    ldx #tres.cifras
    stx temp_sorteo
    lda #14      ;cantidad de premio

for_intro5:

        clr acumulador
        sta acumulador

intro_3cifras:
    
            lda #3         
            sta cuenteo_sorteo   ; n_digitos = 3

digitos5:

            lda teclado         ; Cargamos el numero introducido por teclado
            sta ,x+             ; Lo guardamos en la direccion de memoria de temp_sorteo        
            dec cuenteo_sorteo  ; Decrementamos el contador
            bne digitos5        ; Si el contador es distinto de 0, repetimos el bucle
            ldx temp_sorteo     ; Cargamos la direccion de memoria de temp_sorteo en x
            leax 4, x           ; Le sumamos 4 a x para que apunte al siguiente decimo
            stx temp_sorteo     ; Guardamos la direccion de memoria de temp_sorteo en temp_sorteo
            ldb #'\n            ; Cargamos el salto de linea en b
            stb pantalla        ; Guardamos el salto de linea en pantalla
            dec acumulador      ; Decrementamos el acumulador
            bne intro_3cifras   ; Si el acumulador es distinto de 0, repetimos el bucle
            jsr sorteo_introducir

sorteo_introducir_2cifras:
    ldx #introducir_terminacion2_txt
    jsr imprime_cadena

    ldx #dos.cifras
    stx temp_sorteo
    lda #14      ;cantidad de premio

for_intro6:

        clr acumulador
        sta acumulador

intro_2cifras:
    
            lda #2        ; 2 numeros por decimo
            sta cuenteo_sorteo   ; n_digitos = 2

digitos6:
    
                lda teclado ; Cargamos el numero introducido por teclado
                sta ,x+     ; Lo guardamos en la direccion de memoria de temp_sorteo        
                dec cuenteo_sorteo ; Decrementamos el contador
                bne digitos6 ; Si el contador es distinto de 0, repetimos el bucle
                ldx temp_sorteo    ; Cargamos la direccion de memoria de temp_sorteo en x
                leax 3, x   ; Le sumamos 3 a x para que apunte al siguiente decimo
                stx temp_sorteo    ; Guardamos la direccion de memoria de temp_sorteo en temp_sorteo
                ldb #'\n        ; Cargamos el salto de linea en b
                stb pantalla    ; Guardamos el salto de linea en pantalla
                dec acumulador      ; Decrementamos el acumulador
                bne intro_2cifras   ; Si el acumulador es distinto de 0, repetimos el bucle
                jsr sorteo_introducir

sorteo_introducir_reintegros:
    ldx #introducir_reintegro_txt
    jsr imprime_cadena

    ldx #reintegro
    stx temp_sorteo
    lda #3      ;cantidad de premio

for_intro7:

        clr acumulador
        sta acumulador

intro_reintegro:
    
            lda #1        ; 1 numeros por decimo
            sta cuenteo_sorteo   ; n_digitos = 1

digitos7:
    
                lda teclado ; Cargamos el numero introducido por teclado
                sta ,x+     ; Lo guardamos en la direccion de memoria de temp_sorteo        
                dec cuenteo_sorteo ; Decrementamos el contador
                bne digitos7 ; Si el contador es distinto de 0, repetimos el bucle
                ldx temp_sorteo    ; Cargamos la direccion de memoria de temp_sorteo en x
                leax 2, x   ; Le sumamos 2 a x para que apunte al siguiente decimo
                stx temp_sorteo    ; Guardamos la direccion de memoria de temp_sorteo en temp_sorteo
                ldb #'\n        ; Cargamos el salto de linea en b
                stb pantalla    ; Guardamos el salto de linea en pantalla
                dec acumulador      ; Decrementamos el acumulador
                bne intro_reintegro   ; Si el acumulador es distinto de 0, repetimos el bucle
                jsr sorteo_introducir