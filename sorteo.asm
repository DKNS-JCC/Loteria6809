    .module sorteo

    .globl sorteo_introducir_3premios
    .globl sorteo_introducir_4cifras
    .globl sorteo_introducir_3cifras
    .globl sorteo_introducir_2cifras
    .globl sorteo_introducir_reintegros
    .globl imprime_cadena

m_sorteo:       .ascii  "\33[33m=========SORTEO========== \n"
                .ascii  "\33[34m1. Ver Resultados\n"
                .ascii  "\33[35m2. Introducir Resultados\n"
                .asciz  "\33[36m3. Volver\n"

m_sorteo2:      .ascii  "\33[35m=========INTRODUCIR RESULTADOS==========\n"
                .ascii  "\33[31m1. 3 Primeros premios\n"
                .ascii  "\33[32m2. Terminaciones 4 cifras\n"
                .ascii  "\33[33m3. Terminaciones 3 cifras\n"
                .ascii  "\33[34m4. Terminaciones 2 cifras\n"
                .ascii  "\33[35m5. Reintegros\n"
                .asciz  "\33[36m6. Volver\n"

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
    