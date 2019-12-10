.data
    MUSICA_ESTADO: .word 0
    MUSICA_TEMPO: .word 0
.text
MUSICA:
la a0, MUSICA_ESTADO
lw a0, 0(a0)
la a1, MUSICA_TEMPO
lw a1, 0(a1)

csrrs a2, 3073, zero
sub a2, a2, a1

##### ESTADO 0 #####
li a3, 0
bne a0, a3, MUSICA_ESTADO_1
li a3, 500
bltu a2, a3, MUSICA_FIM 

li a0, 64
li a1, 1000
li a2, 1
li a3, 100
li a7, 31
ecall

li a0, 1
la a1, MUSICA_ESTADO
sw a0, 0(a1)
csrrs a0, 3073, zero
la a1, MUSICA_TEMPO
sw a0, 0(a1)

j MUSICA_FIM

#li a0, 250
#li a7, 32
#ecall

##### ESTADO 1 #####
MUSICA_ESTADO_1:
li a3, 1
bne a0, a3, MUSICA_ESTADO_2
li a3, 250
bltu a2, a3, MUSICA_FIM 

li a0, 64
li a1, 1000
li a2, 1
li a3, 100
li a7, 31
ecall

li a0, 2
la a1, MUSICA_ESTADO
sw a0, 0(a1)
csrrs a0, 3073, zero
la a1, MUSICA_TEMPO
sw a0, 0(a1)

j MUSICA_FIM

#li a0, 250
#li a7, 32
#ecall

##### ESTADO 2 #####
MUSICA_ESTADO_2:
li a3, 2
bne a0, a3, MUSICA_ESTADO_3
li a3, 250
bltu a2, a3, MUSICA_FIM 

li a0, 64
li a1, 1000
li a2, 1
li a3, 100
li a7, 31
ecall

li a0, 3
la a1, MUSICA_ESTADO
sw a0, 0(a1)
csrrs a0, 3073, zero
la a1, MUSICA_TEMPO
sw a0, 0(a1)

j MUSICA_FIM

#li a0, 250
#li a7, 32
#ecall

##### ESTADO 3 #####
MUSICA_ESTADO_3:
li a3, 3
bne a0, a3, MUSICA_ESTADO_4
li a3, 250
bltu a2, a3, MUSICA_FIM 

li a0, 52
li a1, 1000
li a2, 1
li a3, 100
li a7, 31
ecall

li a0, 4
la a1, MUSICA_ESTADO
sw a0, 0(a1)
csrrs a0, 3073, zero
la a1, MUSICA_TEMPO
sw a0, 0(a1)

j MUSICA_FIM

#li a0, 125
#li a7, 32
#ecall

##### ESTADO 4 #####
MUSICA_ESTADO_4:
li a3, 4
bne a0, a3, MUSICA_ESTADO_5
li a3, 125
bltu a2, a3, MUSICA_FIM 

li a0, 64
li a1, 1000
li a2, 1
li a3, 100
li a7, 31
ecall

li a0, 5
la a1, MUSICA_ESTADO
sw a0, 0(a1)
csrrs a0, 3073, zero
la a1, MUSICA_TEMPO
sw a0, 0(a1)

j MUSICA_FIM

#li a0, 250
#li a7, 32
#ecall

##### ESTADO 5 #####
MUSICA_ESTADO_5:
li a3, 5
bne a0, a3, MUSICA_ESTADO_6
li a3, 250
bltu a2, a3, MUSICA_FIM 

li a0, 52
li a1, 1000
li a2, 1
li a3, 100
li a7, 31
ecall

li a0, 6
la a1, MUSICA_ESTADO
sw a0, 0(a1)
csrrs a0, 3073, zero
la a1, MUSICA_TEMPO
sw a0, 0(a1)

j MUSICA_FIM

#li a0, 125
#li a7, 32
#ecall

##### ESTADO 6 #####
MUSICA_ESTADO_6:
li a3, 6
bne a0, a3, MUSICA_ESTADO_7
li a3, 125
bltu a2, a3, MUSICA_FIM 

li a0, 64
li a1, 1000
li a2, 1
li a3, 100
li a7, 31
ecall

li a0, 7
la a1, MUSICA_ESTADO
sw a0, 0(a1)
csrrs a0, 3073, zero
la a1, MUSICA_TEMPO
sw a0, 0(a1)

j MUSICA_FIM

#li a0, 250
#li a7, 32
#ecall

##### ESTADO 7 #####
MUSICA_ESTADO_7:
li a3, 250
bltu a2, a3, MUSICA_FIM 

li a0, 64
li a1, 1000
li a2, 1
li a3, 100
li a7, 31
ecall

li a0, 0
la a1, MUSICA_ESTADO
sw a0, 0(a1)
csrrs a0, 3073, zero
la a1, MUSICA_TEMPO
sw a0, 0(a1)

#li a0, 500
#li a7, 32
#ecall

MUSICA_FIM:
ret
