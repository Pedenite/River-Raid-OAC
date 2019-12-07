#################################################################
# Controla Combustível						#
# Imprime e diminui a quantidade de combustível			#
#################################################################

.data
PorCento: .string "%"
.include "../data/debug.data"

.text
FuelCtrl:	la a0, debug
		li a1, 204
		li a2, 100
		mv t6, ra
		jal SetPixels
		mv ra, t6
		li t0, 5000
		div a0, s9, t0
		li a1, 100
		li a2, 204
		li a3, 118
		li a4, 0
		li a7, 101
		ecall
		la a0, PorCento
		li a1, 124
		li a7, 104
		ecall
		li t0, 500000
		bgt s9, t0, ResetaFuel
		addi s9, s9, -1
		ret
ResetaFuel:	li s9, 500000
		ret
		
		