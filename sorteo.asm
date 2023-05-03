    .module sorteo

    .globl

sorteo_introducir_3premios:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce los 3 premios
    jmp programa

sorteo_introducir_4cifras:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce las terminaciones de 4 cifras
    jmp programa

sorteo_introducir_3cifras:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce las terminaciones de 3 cifras
    jmp programa

sorteo_introducir_2cifras:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce las terminaciones de 2 cifras
    jmp programa

sorteo_introducir_reintegros:
    ldx #m_sorteo2
    jsr imprime_cadena
    ;;llamar a la funcion que introduce los reintegros
    jmp programa
    