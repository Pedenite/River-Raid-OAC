#################################################################################
# Gerador de Inimigos								#
# Vai dar spawn em um inimigo e salvar seu tipo e posi��o na pilha.		#
# Assim, na pilha ficar� um espa�o de word para o tipo e dire��o que o inimigo	#
# andar� e outro com os 16 bits	mais significativos armazenando			#
# a posi��o y e o resto, a posi��o x						#
#################################################################################

.eqv QtdEnemies 4			# quantidade de tipos de inimigos +1

.text
EnemySpawn:	li a7, 41
		ecall			# Rand
		li t0, QtdEnemies
		remu t0, a0, t0
		li t1, 1
		beq t0, t1, GeraEn1
		li t1, 2
		beq t0, t1, GeraEn2
		li t1, 3
		beq t0, t1, GeraEn3
NoEnemy:	ret

GeraPosXEn:	li t1, 172		# gera posi��o x do inimigo (Inimigo mais longo = 20)=>192-20
		remu t1, a0, t1
		addi t1, t1, 64		# parede esquerda
		jalr zero, t0, 0
		
GeraPosYEn:	li t1, 120		# gera posi��o y do inimigo
		remu t1, a0, t1
		jalr zero, t0, 0
		
GeraEn1:	li t0, 1		# tipo
		slli t0, t0, 1		# dire��o = 0
		addi sp, sp, -8
		sw t0, 4(sp)		# guarda o tipo de inimigo na pilha
		jal t0, GeraPosXEn
		sw t0, (sp)		# vai guardar na pilha a posi��o y = 0 e a posi��o x do inimigo
		ret
		
GeraEn2:	li t0, 2		# tipo
		slli t0, t0, 1		# dire��o = 0
		addi sp, sp, -8
		sw t0, 4(sp)		# guarda o tipo de inimigo na pilha
		jal t0, GeraPosXEn	
		sw t0, (sp)		# vai guardar na pilha a posi��o y = 0 e a posi��o x do inimigo
		ret
		
GeraEn3:	li t0, 4		# tipo
		slli t0, t0, 1		# dire��o = 0
		addi sp, sp, -8
		sw t0, 4(sp)		# guarda o tipo de inimigo na pilha
		jal t0, GeraPosYEn
		slli t1, t1, 16		
		li t0, 304		# posi��o x
		or t0, t1, t0
		sw t0, (sp)		# vai guardar na pilha a posi��o y e a posi��o x do inimigo
		ret
