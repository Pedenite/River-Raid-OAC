#################################################################################
# TIRO										#
# Função que controla o tiro do avião						#
#################################################################################
.eqv VelTiro 5

.text
TIRO:	li t1, 320
	li t2, -VelTiro
	#mul t0, t1, t2
	sub s7, s7, t1
	ble s7, zero, DestroiTiro
	la a0, bullet
	mv a1, s7
	mv a2, s6
	jal SetPixels
	j FimTiro
DestroiTiro:
	li s7, 200
	li s6, 0
FimTiro:
	ret