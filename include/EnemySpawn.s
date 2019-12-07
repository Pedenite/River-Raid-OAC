#################################################################################
# Gerador de Inimigos								#
# Vai dar spawn em um inimigo e salvar seu tipo e posição na pilha.		#
# Assim, na pilha ficará um espaço de word para o tipo e direção que o inimigo	#
# andará e outro com os 16 bits	mais significativos armazenando			#
# a posição y e o resto, a posição x						#
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

GeraPosXEn:	li t1, 172		# gera posição x do inimigo (Inimigo mais longo = 20)=>192-20
		remu t1, a0, t1
		addi t1, t1, 64		# parede esquerda
		jalr zero, t0, 0
		
GeraPosYEn:	li t1, 120		# gera posição y do inimigo
		remu t1, a0, t1
		jalr zero, t0, 0
		
GeraEn1:	li t0, 1		# tipo
		slli t0, t0, 1		# direção = 0
		addi sp, sp, -8
		sw t0, 4(sp)		# guarda o tipo de inimigo na pilha
		jal t0, GeraPosXEn
		sw t0, (sp)		# vai guardar na pilha a posição y = 0 e a posição x do inimigo
		ret
		
GeraEn2:	li t0, 2		# tipo
		slli t0, t0, 1		# direção = 0
		addi sp, sp, -8
		sw t0, 4(sp)		# guarda o tipo de inimigo na pilha
		jal t0, GeraPosXEn	
		sw t0, (sp)		# vai guardar na pilha a posição y = 0 e a posição x do inimigo
		ret
		
GeraEn3:	li t0, 4		# tipo
		slli t0, t0, 1		# direção = 0
		addi sp, sp, -8
		sw t0, 4(sp)		# guarda o tipo de inimigo na pilha
		jal t0, GeraPosYEn
		slli t1, t1, 16		
		li t0, 304		# posição x
		or t0, t1, t0
		sw t0, (sp)		# vai guardar na pilha a posição y e a posição x do inimigo
		ret
