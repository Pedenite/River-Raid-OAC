#########################################################################################
# MENU											#
# Função que pinta o menu na tela							#
#########################################################################################

.text
MENU:	li t1,0xFF00E100	# endereco inicial do menu
	li t2,0xFF012C00	# endereco final 
	li t3,0xa4a4a4a4	# cor cinza
LOOPMN: beq t1,t2,FORAMN	# Se for o último endereço então sai do loop
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	j LOOPMN		# volta a verificar
FORAMN:	ret