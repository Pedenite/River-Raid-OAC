#################################################################################
# MAPA										#
# Função que desenha o mapa padrão do river raid				#
#################################################################################
.eqv leftBound 16
.eqv rightBound 64

.text
MAPA:	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF00DFC0	# endereco inicial do menu 
	li t3,0x91919191	# cor água
	li t4,0x63636363	# cor chão
	li t5,-1		# contador
	li t6,leftBound
	li a0,rightBound
	li a1,80
LOOP: 	beq t1,t2,FORA		# Se for o último endereço então sai do loop
	addi t5,t5,1
	rem a2,t5,a1
	blt a2,t6,TERRA
	bge a2,a0,TERRA
AGUA:	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	j LOOP			# volta a verificar
TERRA:	sw t4,0(t1)
	addi t1,t1,4
	j LOOP
FORA:	ret
