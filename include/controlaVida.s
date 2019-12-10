#################################################################################
# ControlaVida									#
# Função recebe posição do avião para verificar se está nos limites da água	#
# a2 = posição x								#
#################################################################################

.data
SalvaVidaExtra:	.word 0

.text
ControlaVida:	
		la a0, SalvaVidaExtra
		lw a1, 0(a0)
		sub a1, s5, a1
		li t0, 10000
		bge a1, t0, VidaExtra	# ganha vida extra a cada 10000 pontos
		
ContinuaVida:	addi a2, s2, 160
		li t0, 64		# limite esquerda
		li t1, 256		# limite direita
		blt a2, t0, MORTE	# morte por parede esquerda
		addi a2, a2, 14		# largura do avião
		bgt a2, t1, MORTE	# morte por parede direita
		ble s9, zero, MORTE	# morte por falta de combustível
AINDAVIVO:	ret
MORTE:		addi s4, s4, -1
		li a0, 40
		li a1, 500
		li a2, 1
		li a3, 200
		li a7, 31
		ecall
		j GAME_OVER
		
VidaExtra:	
		lw a1, 0(a0)
		li t1, 10000
		add a1, a1, t1
		sw a1, 0(a0)
		li t0, 4
		bge s4, t0, ContinuaVida	# máximo de vidas = 3 + vida 0
		addi s4, s4, 1
		j ContinuaVida
		

