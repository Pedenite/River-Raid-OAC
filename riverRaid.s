# agua = 0x91 = 145
# aviao = 0x76 = 118
# terra = 0x63 = 99
# frequência na FPGA (PIPELINE): dividida por 2
.eqv VelPlane 3

.data
.include "data/plane.data"
.include "data/plane_l.data"
.include "data/plane_r.data"
.include "data/enemy1_l.data"
.include "data/enemy2_a1r.data"
.include "data/enemy2_a2r.data"
.include "data/enemy3_l.data"
.include "data/explosion1.data"
.include "data/explosion2.data"
.include "data/explosion3.data"
.include "data/explosion4.data"
.include "data/explosion5.data"
.include "data/bullet.data"
.include "data/menu.data"
.include "data/V0.data"
.include "data/V1.data"
.include "data/V2.data"
.include "data/V3.data"

.text
MAIN:
	la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
 	csrrw zero,5,tp 	# seta utvec (reg 5) para o endereço tp
 	csrrsi zero,0,1 	# seta o bit de habilitação de interrupção em ustatus (reg 0)	
	
	li s0, 97		# ascii a
	li s1, 100		# ascii d
	li s2, 0		# deslocamento do aviao
	li s3, 0		# tecla pressionada
	li s4, 3		# vidas
	li s5, 0		# pontos
	li s6, 0		# contador para gerador de inimigos
	li s7, 300		# coordenadas do tiro xy(obs: 300 = sem tiro)
	mv s8, sp		# guarda sp inicial
	li s11, 32		# ascii <space>
	
	addi sp, sp, -16	# adiciona 2 inimigos iniciais
	li t0, 4		# inimigo 2
	li t1, 100		# y=0, x=100
	sw t0, 4(sp)
	sw t1, (sp)
	li t0, 2		# inimigo 1
	li t1, 0x003c008c	# y=60, x=140
	sw t0, 12(sp)
	sw t1, 8(sp)		
	
TELAINICIO:	beq s3, s11, SaiTelaInicio	# a tela inicial será carregada diretamente na frame 0 da FPGA devido a limitações de memória
		jal KEY2
		j TELAINICIO
SaiTelaInicio:	li s3, 0
		la a0, menu
		li a1, 180
		li a2, 0
		jal SetPixels	# pinta menu
		li s2, 0
		li s7, 300
		
		li a1, 220
		li a2, 100
		li t0, 3
		bne s4, t0, Vida2
		la a0, V3
		j PrintaVidas
Vida2:		li t0, 2
		bne s4, t0, Vida1
		la a0, V2
		j PrintaVidas
Vida1:		li t0, 1
		bne s4, t0, Vida0
		la a0, V1
		j PrintaVidas
Vida0:		la a0, V0
PrintaVidas:	jal SetPixels
		
GAMELOOP:
		jal PONTOS
		jal MAPA		# desenha mapa
		li t0, 300
		beq s7, t0, SemTiro
		jal TIRO
SemTiro:	
		jal EnemySpawn
		jal EnemyBhv
		#jal GetAxis		# para testar no rars deve comentar esta linha
		la a0, plane
		li a1, 160		# altura
		li a2, 160		# posição 
		add a2, a2, s2		# deslocamento
		bne s3, s0, PULA1	# verifica se 'a' está pressionado
		la a0, plane_l
		addi s2, s2, -VelPlane
PULA1:		bne s3, s1, PULA2	# verifica se 'd' está pressionado
		la a0, plane_r
		addi s2, s2, VelPlane
PULA2:		jal SetPixels		# Desenha avião
	
		bne s3, s11, PULA3	# verifica se espaço foi pressionado
		li t0, 160
		andi t1, s7, 0x7ff
		blt t1, t0, PULA3	# permite apenas 1 tiro de cada vez
		li s7, 160
		li t0, 166
		add t0, t0, s2
		slli t0, t0, 16
		or s7, t0, s7		# junta as coordenadas do tiro
PULA3:
		jal ControlaVida
		li s3,0
		jal KEY2		# recebe input do teclado
				
		li a0,16  
		li a7,132
		ecall			# sleep 16ms
j GAMELOOP
		
GAME_OVER:	la a0, explosion1
		li a1, 160
		li a2, 160
		add a2, a2, s2
		jal SetPixels
		bne s4, zero, TELAINICIO
		la a0, V0
		li a1, 220
		li a2, 100
		jal SetPixels
		li a7, 10
		ecall

.include "include/SetPixels.s"
.include "include/SetRevPixels.s"
.include "include/EnemyBhv.s"
.include "include/EnemySpawn.s"
.include "include/teclado.s"
.include "include/GetAxis.s"
.include "include/controlaVida.s"
.include "include/tiro.s"
.include "include/mapa.s"
.include "include/pontos.s"
.include "include/SYSTEMv17.s"
