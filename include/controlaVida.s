#################################################################################
# ControlaVida									#
# Fun��o recebe posi��o do avi�o para verificar se est� nos limites da �gua	#
# a2 = posi��o x								#
#################################################################################

.text
ControlaVida:	li t0, 64		# limite esquerda
		li t1, 256		# limite direita
		blt a2, t0, MORTE
		addi a2, a2, 14		# largura do avi�o
		bgt a2, t1, MORTE
AINDAVIVO:	ret
MORTE:		addi s4, s4, -1
		j GAME_OVER

