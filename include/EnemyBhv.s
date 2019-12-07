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
		srli t1, t0, 1			# pega o tipo do inimigo
		li t2, 1
		beq t1, t2, En1Ctrl
		li t2, 2
		beq t1, t2, En2Ctrl1
		li t2, 3
		beq t1, t2, En2Ctrl2
SemInimigo:	ret

#############################################Inimigo 1##########################################################
# largura = 32
# altura = 8
En1Ctrl:	andi t0, t0, 1			# verifica a direção do inimigo
		lw t1, (sp)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# carrega posição do inimigo
		la a0, enemy1_l
		mv a1, t2
		mv a2, t1
		beq t0, zero, En1L
		
En1R:		mv t6, ra			# case 1
		jal SetRevPixels
		mv ra, t6
		lw t1, (sp)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posição do inimigo
		addi t1, t1, VelE1
		addi t2, t2, VelMapa
		slli t2, t2, 16
		li t3, 224			
		bge t1, t3, ViraEn1		# se chegar à parede direita (256-32)
		j ContinuaEn1
		
En1L:		mv t6, ra			# case 0
		jal SetPixels
		mv ra, t6
		lw t1, (sp)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posição do inimigo
		addi t1, t1, -VelE1
		addi t2, t2, VelMapa
		slli t2, t2, 16
		li t3, 64
		ble t1, t3, ViraEn1		# se chegar à parede esquerda
		j ContinuaEn1
		
ViraEn1:	lw t0, 4(sp)
		xori t0, t0, 1			# inverte apenas o ultimo bit (direção)
		sw t0, 4(sp)
ContinuaEn1:	or t1, t2, t1
		sw t1, (sp)
		ret
		
#############################################Inimigo 2##########################################################
# largura = 16
# altura = 10
En2Ctrl1:	andi t0, t0, 1			# verifica a direção do inimigo
		lw t1, (sp)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# carrega posição do inimigo
		la a0, enemy2_a1r
		mv a1, t2
		mv a2, t1
		beq t0, zero, En2R
		j En2L
		
En2Ctrl2:	andi t0, t0, 1			# verifica a direção do inimigo
		lw t1, (sp)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# carrega posição do inimigo
		la a0, enemy2_a2r
		mv a1, t2
		mv a2, t1
		beq t0, zero, En2R		
		
En2L:		mv t6, ra			# case 1
		jal SetRevPixels
		mv ra, t6
		lw t1, (sp)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posição do inimigo
		addi t1, t1, -VelE2
		addi t2, t2, VelMapa
		slli t2, t2, 16
		li t3, 64						
		ble t1, t3, ViraEn2		# se chegar à parede esquerda
		j ContinuaEn2
		
En2R:		mv t6, ra			# case 0
		jal SetPixels
		mv ra, t6
		lw t1, (sp)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posição do inimigo
		addi t1, t1, VelE2
		addi t2, t2, VelMapa
		slli t2, t2, 16
		li t3, 240
		bge t1, t3, ViraEn2		# se chegar à parede direita (256-16)
		j ContinuaEn2
		
ViraEn2:	lw t0, 4(sp)
		xori t0, t0, 1			# inverte apenas o ultimo bit (direção)
		sw t0, 4(sp)
ContinuaEn2:	or t1, t2, t1
		lw t0, 4(sp)
		xori t0, t0, 2			# troca animação
		sw t0, 4(sp)
		sw t1, (sp)
		ret
		
#############################################Inimigo 3##########################################################
