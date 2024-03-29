#################################################################################
# TIRO										#
# Fun��o que imprime e controla o tiro do avi�o					#
#################################################################################
.eqv VelTiro 5

.data
TIRO_EXECUTA: .word 0

.text
TIRO:	srli t0, s7, 16
	andi s7, s7, 0x7ff		# separa as coordenadas do tiro
	addi s7, s7, -VelTiro
	ble s7, zero, DestroiTiro
	la a0, bullet
	mv a1, s7
	mv a2, t0
	slli t0, t0, 16
	or s7, t0, s7			# junta as coordenadas do tiro
	mv t6, ra
	jal SetPixels
	mv ra, t6
	
	la a0, TIRO_EXECUTA
	lw a0, 0(a0)
	bne a0, zero, FimTiro
	la a0, TIRO_EXECUTA
	li a1, 1
	sw a1, 0(a0)
	li a0, 76
	li a1, 1000
	li a2, 1
	li a3, 200
	li a7, 31
	ecall
	
	j FimTiro
DestroiTiro:
	li s7, 300
	li s6, 0
	la a0, TIRO_EXECUTA
	li a1, 0
	sw a1, 0(a0)
FimTiro:
	ret
