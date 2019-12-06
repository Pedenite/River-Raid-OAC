#################################################################################
# TIRO										#
# Função que controla o tiro do avião						#
#################################################################################
.eqv VelTiro 5

.text
TIRO:	addi s7, s7, -VelTiro
	ble s7, zero, DestroiTiro
	la a0, bullet
	mv a1, s7
	mv a2, s6
	mv t6, ra
	jal SetPixels
	mv ra, t6
	j FimTiro
DestroiTiro:
	li s7, 300
	li s6, 0
FimTiro:
	ret
