#################################################################################################
# Pontos											#
# Imprime no menu, a pontua��o do jogador							#
#################################################################################################

.text
PONTOS:	mv a0, s5
	li a1, 100
	li a2, 190
	li a3, 0xff
	li a4, 0
	li a7, 101
	ecall
	ret