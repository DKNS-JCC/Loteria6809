                
                .module decimos

fin     	.equ 	0xFF01
teclado		.equ	0xFF02
pantalla 	.equ 	0xFF00

decimos:    .asciz  "65401"
            .asciz  "15315"
            .asciz  "56454"
            .asciz  "65401"
            .asciz  "54545"
            .asciz  "14575"
            .asciz  "48571"
            .asciz  "54523"
            .asciz  "65453"
            .asciz  "54435"
            .asciz  "94461"

decimos_MAX: .byte 10
decimos_NUM: .byte 10

ver:     .asciz "Los decimos actuales son...\n"


                .globl ver_decimos
                .globl imprime_cadena

ver_decimos:
    ldx #ver
    jsr imprime_cadena
    rts



