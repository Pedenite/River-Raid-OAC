#################################################################################
# ControlaVida									#
# Função recebe posição do avião para verificar se está nos limites da água	#
# a2 = posição x								#
#################################################################################

.text
ControlaVida:	li t0, 10000
		remu t0, s5, t0
		beq t0, zero, VidaExtra	# ganha vida extra a cada 10000 pontos
ContinuaVida:	li t0, 64		# limite esquerda
		li t1, 256		# limite direita
		blt a2, t0, MORTE	# morte por parede esquerda
		addi a2, a2, 14		# largura do avião
		bgt a2, t1, MORTE	# morte por parede direita
AINDAVIVO:	ret
MORTE:		addi s4, s4, -1
		j GAME_OVER
		
VidaExtra:	li t0, 3
		beq s4, t0, ContinuaVida	# máximo de vidas = 3
		addi s4, s4, 1
		j ContinuaVida
		

