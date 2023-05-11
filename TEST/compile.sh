#!/bin/bash

# Compile the program
as6809 -o -l manejo_cadenas.asm
as6809 -o -l decimos.asm
as6809 -o -l loteria.asm

# Link the program
aslink -m -s -w -u loteria.s19 manejo_cadenas.rel loteria.rel decimos.rel

m6809-run loteria.s19
