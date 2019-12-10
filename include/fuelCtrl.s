#################################################################
# Controla Combust�vel						#
# Imprime e diminui a quantidade de combust�vel			#
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
		li t0, 20
		div a0, s9, t0
		li a1, 100
		li a2, 204
		li a3, 118
		li a4, 0
		li a7, 101
		ecall
		
		li a0, 1000
		div a0, s5, a0
		sub a0, a0, s10
		
		la a0, PorCento
		li a1, 124
		li a7, 104
		ecall
		li t0, 2000
		bgt s9, t0, ResetaFuel		# n�o permite mais de 100% de combust�vel
		addi s9, s9, -1
		ret
ResetaFuel:	li s9, 2000
		ret
		
		
