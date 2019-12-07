#################################################################################
# TIRO										#
# Função que imprime e controla o tiro do avião					#
#################################################################################
.eqv VelTiro 5

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
	j FimTiro
DestroiTiro:
	li s7, 300
	li s6, 0
FimTiro:
	ret
