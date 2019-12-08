#################################################################################
# Gerador de Inimigos								#
# Vai dar spawn em um inimigo e salvar seu tipo e posição na pilha.		#
# Assim, na pilha ficará um espaço de word para o tipo e direção que o inimigo	#
# andará e outro com os 16 bits	mais significativos armazenando			#
# a posição y e o resto, a posição x						#
#################################################################################

.eqv QtdEnemies 8			# quantidade de tipos de inimigos + Fuel +1

.text
EnemySpawn:	addi s6, s6, 1
Easy:		li t0, 60
		li t1, 1000
		blt s5, t1, Difficulty
Medium:		li t0, 40
		li t1, 5000
		blt s5, t1, Difficulty
Hard:		li t0, 20
		li t1, 15000
		blt s5, t1, Difficulty
UltraHard:	li t0, 10

Difficulty:	blt s6, t0, NoEnemy	# permite o spawn de inimigos no easy, aproximadamete a cada 1 segundo (na FPGA)
		li s6, 0
		li a7, 41
		ecall			# Rand
		li t0, QtdEnemies
E_EASY:		li t1, 1000
		bgt s5, t1, E_MEDIUM
		addi t0, t0, -3
		j E_Continua
E_MEDIUM:	li t1, 2000
		bgt s5, t1, E_HARD
		addi t0, t0, -2
		j E_Continua
E_HARD:		li t1, 10000
		bgt s5, t1, E_ULTRAHARD
		addi t0, t0, -1
		j E_Continua
E_ULTRAHARD:	
E_Continua:	remu t0, a0, t0		# no easy, apenas os 3 inimigos originais e o fuel poderão sdar spawn
		li t1, 1
		beq t0, t1, GeraEn1
		li t1, 2
		beq t0, t1, GeraEn2
		li t1, 3
		beq t0, t1, GeraEn3
		li t1, 4
		beq t0, t1, GeraFuel
		li t1, 5
		beq t0, t1, GeraEn4
		li t1, 6
		beq t0, t1, GeraEn5
		li t1, 7
		beq t0, t1, GeraEn6
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
		sw t1, (sp)		# vai guardar na pilha a posição y = 0 e a posição x do inimigo
		ret
		
GeraEn2:	li t0, 2		# tipo
		slli t0, t0, 1		# direção = 0
		addi sp, sp, -8
		sw t0, 4(sp)		# guarda o tipo de inimigo na pilha
		jal t0, GeraPosXEn	
		sw t1, (sp)		# vai guardar na pilha a posição y = 0 e a posição x do inimigo
		ret
		
GeraEn3:	li t0, 4		# tipo
		slli t0, t0, 1		# direção = 0
		addi sp, sp, -8
		sw t0, 4(sp)		# guarda o tipo de inimigo na pilha
		jal t0, GeraPosYEn
		addi t1, t1, 20
		slli t1, t1, 16		
		li t0, 304		# posição x
		or t0, t1, t0
		sw t0, (sp)		# vai guardar na pilha a posição y e a posição x do inimigo
		ret

GeraFuel:	li t0, 5
		slli t0, t0, 1
		addi sp, sp, -8
		sw t0, 4(sp)
		jal t0, GeraPosXEn
		sw t1, (sp)
		ret
		
GeraEn4:	li t0, 6		# tipo
		slli t0, t0, 1		# direção = 0
		addi sp, sp, -8
		sw t0, 4(sp)		# guarda o tipo de inimigo na pilha
		jal t0, GeraPosYEn
		addi t1, t1, 20
		slli t1, t1, 16		
		li t0, 0		# posição x
		or t0, t1, t0
		sw t0, (sp)		# vai guardar na pilha a posição y e a posição x do inimigo
		ret

GeraEn5:	li t0, 7		# tipo
		slli t0, t0, 1		# direção = 0
		addi sp, sp, -8
		sw t0, 4(sp)		# guarda o tipo de inimigo na pilha
		jal t0, GeraPosXEn
		sw t1, (sp)		# vai guardar na pilha a posição y = 0 e a posição x do inimigo
		ret
		
GeraEn6:	li t0, 8		# tipo
		slli t0, t0, 1		# direção = 0
		addi sp, sp, -8
		sw t0, 4(sp)		# guarda o tipo de inimigo na pilha
		jal t0, GeraPosXEn
		sw t1, (sp)		# vai guardar na pilha a posição y = 0 e a posição x do inimigo
		ret
