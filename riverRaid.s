# agua = 0x91 = 145
# aviao = 0x76 = 118
# terra = 0x63 = 99
.eqv VelPlane 3

.data
.include "include/plane.data"
.include "include/plane_l.data"
.include "include/plane_r.data"
.include "include/menu.data"

.text
MAIN:
	la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
 	csrrw zero,5,tp 	# seta utvec (reg 5) para o endereço tp
 	csrrsi zero,0,1 	# seta o bit de habilitação de interrupção em ustatus (reg 0)	
	
	li s0, 97		# ascii a
	li s1, 100		# ascii d
	li s2, 0		# deslocamento do aviao
	li s3, 0		# tecla pressionada
	li s4, 1		# vidas
	li s5, 0		# pontos
	
	la a0, menu
	li a1, 180
	li a2, 0
	jal SetPixels

GAMELOOP:
	beq s4, zero, GAME_OVER
	jal MAPA		# desenha mapa
	
	la a0, plane
	li a1, 160		# altura
	li a2, 160		# posição 
	add a2, a2, s2		# deslocamento
	bne s3, s0, PULA1	# verifica se 'a' está pressionado
	la a0, plane_l
	addi s2, s2, -VelPlane
PULA1:	bne s3, s1, PULA2	# verifica se 'd' está pressionado
	la a0, plane_r
	addi s2, s2, VelPlane
PULA2:	jal SetPixels		# Desenha avião

	jal ControlaVida
	li s3,0
	jal KEY2		# recebe input do teclado
				
	li a0,16   
	li a7,132
	ecall			# sleep 16ms
j GAMELOOP
GAME_OVER:	li a7, 10
		ecall

.include "include/SetPixels.s"
.include "include/teclado.s"
.include "include/controlaVida.s"
.include "include/mapa.s"
.include "include/menu.s"
.include "include/SYSTEMv17.s"
