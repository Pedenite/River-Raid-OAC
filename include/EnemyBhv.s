#################################################################################
# Enemy Behavior								#
# Define como os inimigos se comportam						#
#################################################################################

.eqv VelMapa 1
.eqv VelE1 1
.eqv VelE2 2
.eqv VelE3 4

.text
EnemyBhv:	mv a3, sp
LoopEB:		beq a3, s8, SemInimigo
		lw t0, 4(a3)
		srli t1, t0, 1			# pega o tipo do inimigo
		li t2, 1
		beq t1, t2, En1Ctrl
		li t2, 2
		beq t1, t2, En2Ctrl1
		li t2, 3
		beq t1, t2, En2Ctrl2
		li t2, 4
		beq t1, t2, En3Ctrl
		li t2, 5
		beq t1, t2, FCtrl
VoltaEB:	addi a3, a3, 8
		j LoopEB
SemInimigo:	ret

EnemyFlee:	sw zero, (a3)
		sw zero, 4(a3)
		lw t0, (sp)
		bne t0, zero, LoopED
		addi sp, sp, 8			# caso o inimigo esteja no topo da pilha
		j VoltaEB
LoopED:		lw t1, 4(sp)			# faz um swap de inimigos caso o destruido n�o esteja no topo
		sw t0, (a3)
		sw t1, 4(a3)
		sw x0, (sp)
		sw x0, 4(sp)
		addi sp, sp, 8
		j VoltaEB
		
PlayerDeath:	li s7, 300			# destroi tiro
		la a0, explosion5
		mv a1, t2
		mv a2, t1
		mv t6, ra
		jal SetPixels
		mv ra, t6
		sw zero, (a3)
		sw zero, 4(a3)
		lw t0, (sp)
		bne t0, zero, LoopEDA
		addi sp, sp, 8			# caso o inimigo esteja no topo da pilha
		j MORTE
LoopEDA:	lw t1, 4(sp)			# faz um swap de inimigos caso o destruido n�o esteja no topo
		sw t0, (a3)
		sw t1, 4(a3)
		sw x0, (sp)
		sw x0, 4(sp)
		addi sp, sp, 8
		j MORTE

#############################################Inimigo 1##########################################################
# largura = 32
# altura = 8
# pontos = 60
En1Ctrl:	andi t0, t0, 1			# verifica a dire��o do inimigo
		lw t1, (a3)
		srli t2, t1, 16			# posi��o y
		andi t1, t1, 0x7ff		# posi��o x
		li t3, 172			# 240-60-8
		bge t2, t3, EnemyFlee		# Remove o inimigo da pilha
		addi t3, t2, 8			# soma altura do inimigo		
		andi t4, s7, 0x7ff		# obt�m a coordenada y do tiro (est� ao contr�rio)
		blt t3, t4, En1Vivo
		addi t4, t4, 8
		bgt t2, t4, En1Vivo
		srli t4, s7, 16			# obt�m a posi��o x do tiro
		bgt t1, t4, En1Vivo
		addi t3, t1, 32
		blt t3, t4, En1Vivo
		j DestroyEn1
En1Vivo:	li t3, 160
		addi t4, t2, 8
		blt t4, t3, En1VivoA
		addi t3, s2, 160		# obt�m a posi��o x do avi�o
		addi t4, t1, 32
		blt t4, t3, En1VivoA
		addi t3, t3, 12			# soma a largura do avi�o
		bgt t1, t3, En1VivoA
		addi s5, s5, 60
		j PlayerDeath
En1VivoA:	la a0, enemy1_l
		mv a1, t2
		mv a2, t1
		beq t0, zero, En1L
		
En1R:		mv t6, ra			# case 1
		jal SetRevPixels
		mv ra, t6
		lw t1, (a3)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posi��o do inimigo
		addi t1, t1, VelE1
		addi t2, t2, VelMapa
		slli t2, t2, 16
		li t3, 224			
		bge t1, t3, ViraEn1		# se chegar � parede direita (256-32)
		j ContinuaEn1
		
En1L:		mv t6, ra			# case 0
		jal SetPixels
		mv ra, t6
		lw t1, (a3)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posi��o do inimigo
		addi t1, t1, -VelE1
		addi t2, t2, VelMapa
		slli t2, t2, 16
		li t3, 64
		ble t1, t3, ViraEn1		# se chegar � parede esquerda
		j ContinuaEn1
		
ViraEn1:	lw t0, 4(a3)
		xori t0, t0, 1			# inverte apenas o ultimo bit (dire��o)
		sw t0, 4(a3)
ContinuaEn1:	or t1, t2, t1
		sw t1, (a3)
		j VoltaEB
		
DestroyEn1:	li s7, 300			# destroi tiro
		addi s5, s5, 60			# ganha 60 pontos
		la a0, explosion5
		mv a1, t2
		mv a2, t1
		mv t6, ra
		jal SetPixels
		mv ra, t6
		j EnemyFlee
		
#############################################Inimigo 2##########################################################
# largura = 16
# altura = 10
# pontos = 120
En2Ctrl1:	andi t0, t0, 1			# verifica a dire��o do inimigo
		lw t1, (a3)
		srli t2, t1, 16			# posi��o y
		andi t1, t1, 0x7ff		# posi��o x
		li t3, 170			# 240-6-10
		bge t2, t3, EnemyFlee		# Remove o inimigo da pilha
		addi t3, t2, 10			# soma altura do inimigo		
		andi t4, s7, 0x7ff		# obt�m a coordenada y do tiro (est� ao contr�rio)
		blt t3, t4, En2Vivo1
		addi t4, t4, 8
		bgt t2, t4, En2Vivo1
		srli t4, s7, 16			# obt�m a posi��o x do tiro
		bgt t1, t4, En2Vivo1
		addi t3, t1, 16
		blt t3, t4, En2Vivo1
		j DestroyEn2
En2Vivo1:	li t3, 160
		addi t4, t2, 10
		blt t4, t3, En2VivoA1
		addi t3, s2, 160		# obt�m a posi��o x do avi�o
		addi t4, t1, 16
		blt t4, t3, En2VivoA1
		addi t3, t3, 12			# soma a largura do avi�o
		bgt t1, t3, En2VivoA1
		addi s5, s5, 120
		j PlayerDeath
En2VivoA1:	la a0, enemy2_a1r
		mv a1, t2
		mv a2, t1
		beq t0, zero, En2R
		j En2L
		
En2Ctrl2:	andi t0, t0, 1			# verifica a dire��o do inimigo
		lw t1, (a3)
		srli t2, t1, 16			# posi��o y
		andi t1, t1, 0x7ff		# posi��o x
		li t3, 170			# 240-6-10
		bge t2, t3, EnemyFlee		# Remove o inimigo da pilha
		addi t3, t2, 10			# soma altura do inimigo		
		andi t4, s7, 0x7ff		# obt�m a coordenada y do tiro (est� ao contr�rio)
		blt t3, t4, En2Vivo2
		addi t4, t4, 8
		bgt t2, t4, En2Vivo2
		srli t4, s7, 16			# obt�m a posi��o x do tiro
		bgt t1, t4, En2Vivo2
		addi t3, t1, 16
		blt t3, t4, En2Vivo2
		j DestroyEn2
En2Vivo2:	li t3, 160
		addi t4, t2, 10
		blt t4, t3, En2VivoA2
		addi t3, s2, 160		# obt�m a posi��o x do avi�o
		addi t4, t1, 16
		blt t4, t3, En2VivoA2
		addi t3, t3, 12			# soma a largura do avi�o
		bgt t1, t3, En2VivoA2
		addi s5, s5, 120
		j PlayerDeath
En2VivoA2:	la a0, enemy2_a2r
		mv a1, t2
		mv a2, t1
		beq t0, zero, En2R		
		
En2L:		mv t6, ra			# case 1
		jal SetRevPixels
		mv ra, t6
		lw t1, (a3)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posi��o do inimigo
		addi t1, t1, -VelE2
		addi t2, t2, VelMapa
		slli t2, t2, 16
		li t3, 64						
		ble t1, t3, ViraEn2		# se chegar � parede esquerda
		j ContinuaEn2
		
En2R:		mv t6, ra			# case 0
		jal SetPixels
		mv ra, t6
		lw t1, (a3)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posi��o do inimigo
		addi t1, t1, VelE2
		addi t2, t2, VelMapa
		slli t2, t2, 16
		li t3, 240
		bge t1, t3, ViraEn2		# se chegar � parede direita (256-16)
		j ContinuaEn2
		
ViraEn2:	lw t0, 4(a3)
		xori t0, t0, 1			# inverte apenas o ultimo bit (dire��o)
		sw t0, 4(a3)
ContinuaEn2:	or t1, t2, t1
		lw t0, 4(a3)
		xori t0, t0, 2			# troca anima��o
		sw t0, 4(a3)
		sw t1, (a3)
		j VoltaEB
		
DestroyEn2:	li s7, 300			# destroi tiro
		addi s5, s5, 120		# ganha 120 pontos
		la a0, explosion4
		mv a1, t2
		mv a2, t1
		mv t6, ra
		jal SetPixels
		mv ra, t6
		j EnemyFlee
		
#############################################Inimigo 3##########################################################
# largura = 16
# altura = 6
# pontos = 200
En3Ctrl:	lw t1, (a3)
		srli t2, t1, 16			# posi��o y
		andi t1, t1, 0x7ff		# posi��o x
		ble t1, x0, EnemyFlee		# Remove o inimigo da pilha
		li t3, 174			# 240-60-6
		bge t2, t3, EnemyFlee		
		addi t3, t2, 6			# soma altura do inimigo		
		andi t4, s7, 0x7ff		# obt�m a coordenada y do tiro (est� ao contr�rio)
		blt t3, t4, En3Vivo
		addi t4, t4, 8
		bgt t2, t4, En3Vivo
		srli t4, s7, 16			# obt�m a posi��o x do tiro
		bgt t1, t4, En3Vivo
		addi t3, t1, 16
		blt t3, t4, En3Vivo
		j DestroyEn3
En3Vivo:	li t3, 160
		addi t4, t2, 6
		blt t4, t3, En3VivoA
		addi t3, s2, 160		# obt�m a posi��o x do avi�o
		addi t4, t1, 16
		blt t4, t3, En3VivoA
		addi t3, t3, 12			# soma a largura do avi�o
		bgt t1, t3, En3VivoA
		addi s5, s5, 200
		j PlayerDeath
En3VivoA:	la a0, enemy3_l
		mv a1, t2
		mv a2, t1
		
En3L:		mv t6, ra
		jal SetPixels
		mv ra, t6
		lw t1, (a3)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posi��o do inimigo
		addi t1, t1, -VelE3
		addi t2, t2, VelMapa
		slli t2, t2, 16

ContinuaEn3:	or t1, t2, t1
		sw t1, (a3)
		j VoltaEB
		
DestroyEn3:	li s7, 300			# destroi tiro
		addi s5, s5, 200		# ganha 200 pontos
		la a0, explosion3
		mv a1, t2
		mv a2, t1
		mv t6, ra
		jal SetPixels
		mv ra, t6
		j EnemyFlee
		
#############################################Inimigo 3##########################################################
# largura = 14
# altura = 24
# pontos = 160
FCtrl:		lw t1, (a3)
		srli t2, t1, 16			# posi��o y
		andi t1, t1, 0x7ff		# posi��o x
		li t3, 156			# 240-60-24
		bge t2, t3, EnemyFlee		# Remove o inimigo da pilha
		addi t3, t2, 24			# soma altura do inimigo		
		andi t4, s7, 0x7ff		# obt�m a coordenada y do tiro (est� ao contr�rio)
		blt t3, t4, FVivo
		addi t4, t4, 8
		bgt t2, t4, FVivo
		srli t4, s7, 16			# obt�m a posi��o x do tiro
		bgt t1, t4, FVivo
		addi t3, t1, 32
		blt t3, t4, FVivo
		j DestroyF
FVivo:		li t3, 160
		addi t4, t2, 24
		blt t4, t3, FVivoA
		addi t3, s2, 160		# obt�m a posi��o x do avi�o
		addi t4, t1, 14
		blt t4, t3, FVivoA
		addi t3, t3, 12			# soma a largura do avi�o
		bgt t1, t3, FVivoA
		addi s9, s9, 500
		
FVivoA:		la a0, fuel
		mv a1, t2
		mv a2, t1
		
		mv t6, ra
		jal SetPixels
		mv ra, t6
		lw t1, (a3)
		srli t2, t1, 16
		andi t1, t1, 0x7ff		# recarrega posi��o do inimigo
		addi t2, t2, VelMapa
		slli t2, t2, 16
		
ContinuaF:	or t1, t2, t1
		sw t1, (a3)
		j VoltaEB
		
DestroyF:	li s7, 300			# destroi tiro
		addi s5, s5, 160		# ganha 160 pontos
		la a0, explosion5
		mv a1, t2
		mv a2, t1
		mv t6, ra
		jal SetPixels
		mv ra, t6
		j EnemyFlee