# agua = 0x91 = 145
# aviao = 0x76 = 118
# terra = 0x63 = 99
# frequ�ncia na FPGA (PIPELINE): dividida por 4
.eqv VelPlane 3

.data
.include "include/plane.data"
.include "include/plane_l.data"
.include "include/plane_r.data"
.include "include/explosion1.data"
.include "include/bullet.data"
.include "include/menu.data"

.text
MAIN:
	la tp,exceptionHandling	# carrega em tp o endere�o base das rotinas do sistema ECALL
 	csrrw zero,5,tp 	# seta utvec (reg 5) para o endere�o tp
 	csrrsi zero,0,1 	# seta o bit de habilita��o de interrup��o em ustatus (reg 0)	
	
	li s0, 97		# ascii a
	li s1, 100		# ascii d
	li s2, 0		# deslocamento do aviao
	li s3, 0		# tecla pressionada
	li s4, 1		# vidas
	li s5, 0		# pontos
	li s6, 0		# tiro x
	li s7, 200		# tiro y
	li s11, 32		# ascii <space>
	
TELAINICIO:	beq s3, s11, SaiTelaInicio	# a tela inicial ser� carregada diretamente na frame 0 da FPGA devido a limita��es de mem�ria
		jal KEY2
		j TELAINICIO
SaiTelaInicio:	li s3, 0
	la a0, menu
	li a1, 180
	li a2, 0
	jal SetPixels

GAMELOOP:
	beq s4, zero, GAME_OVER
	jal MAPA		# desenha mapa
	li t0, 200
	beq s7, t0, SemTiro
	jal TIRO
SemTiro:	
	#jal GetAxis		# para testar no rars deve comentar esta linha
	la a0, plane
	li a1, 160		# altura
	li a2, 160		# posi��o 
	add a2, a2, s2		# deslocamento
	bne s3, s0, PULA1	# verifica se 'a' est� pressionado
	la a0, plane_l
	addi s2, s2, -VelPlane
PULA1:	bne s3, s1, PULA2	# verifica se 'd' est� pressionado
	la a0, plane_r
	addi s2, s2, VelPlane
PULA2:	jal SetPixels		# Desenha avi�o
	
	bne s3, s11, PULA3
	li t0, 160
	blt s7, t0, PULA3
	li s7, 160
	li s6, 166
	add s6, s6, s2
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
		li a7, 10
		ecall

.include "include/SetPixels.s"
.include "include/teclado.s"
.include "include/GetAxis.s"
.include "include/controlaVida.s"
.include "include/tiro.s"
.include "include/mapa.s"
.include "include/SYSTEMv17.s"
