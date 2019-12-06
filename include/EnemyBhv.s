#################################################################################
# Enemy Behavior								#
# Define como os inimigos se comportam						#
#################################################################################

.eqv VelMapa 1
.eqv VelE1 1
.eqv VelE2 2
.eqv VelE3 4

.text
EnemyBhv:	beq sp, tp, SemInimigo
		lw t0, 4(sp)
		srli t1, t0, 1
		li t2, 1
		beq t1, t2, En1Ctrl
		li t2, 2
		#beq t1, t2, En2Ctrl
		li t2, 3
		#beq t1, t2, En3Ctrl
SemInimigo:	ret

#############################################Inimigo 1##########################################################
En1Ctrl:	andi t0, t0, 1			# verifica a direção do inimigo
		lw t1, (sp)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# carrega posição do inimigo
		la a0, enemy1_l
		mv a1, t2
		mv a2, t1
		beq t0, zero, En1L
En1R:		mv t6, ra
		jal SetRevPixels
		mv ra, t6
		lw t1, (sp)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posição do inimigo
		addi t1, t1, VelE1
		addi t2, t2, VelMapa
		slli t2, t2, 16
		or t1, t2, t1
		sw t1, (sp)
		ret
En1L:		mv t6, ra
		jal SetPixels
		mv ra, t6
		lw t1, (sp)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posição do inimigo
		addi t1, t1, -VelE1
		addi t2, t2, VelMapa
		slli t2, t2, 16
		or t1, t2, t1
		sw t1, (sp)
		ret
		
#############################################Inimigo 2##########################################################

#############################################Inimigo 3##########################################################