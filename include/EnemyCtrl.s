#############################################################################
# Controla Inimigos
# 
#############################################################################

.eqv QtdEnemies 4			# quantidade de inimigos +1
.eqv VelE1 1
.eqv VelE2 2
.eqv VelE3 4

.text
EnemyCtrl:	li a7, 41
		ecall			# Rand
		li t0, QtdEnemies
		rem t0, a0, t0
		li t1, 1
		beq t0, t1, GeraEn1
		li t1, 2
		beq t0, t1, GeraEn2
		li t1, 3
		beq t0, t1, GeraEn3
NoEnemy:	ret

GeraPosEn:	li t1, 172		# gera posição x do inimigo (Inimigo mais longo = 20)=>192-20
		rem t1, a0, t1
		addi t1, t1, 64		# parede esquerda
		jalr zero, t0, 0
		
GeraEn1:	jal t0, GeraPosEn
		
		
