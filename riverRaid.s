.eqv Water 0x0d1	# 209, aviao = 7f 127
.eqv Land 0x063

.data
.include "include/plane.s"

.text
MAIN:
	la tp,exceptionHandling	# carrega em tp o endereço base das rotinas do sistema ECALL
 	csrrw zero,5,tp 	# seta utvec (reg 5) para o endereço tp
 	csrrsi zero,0,1 	# seta o bit de habilitação de interrupção em ustatus (reg 0)	
	
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	li t3,0xd1d1d1d1	# cor
LOOP: 	beq t1,t2,FORA		# Se for o último endereço então sai do loop
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	j LOOP			# volta a verificar
FORA:	
	li s0, 97		# ascii a
	li s1, 100		# ascii d
	li s2, 0		# deslocamento do aviao

GAMELOOP:
	la a0, plane
	li a1, 200		# altura
	li a2, 160		# posição 
	add a2, a2, s2		# deslocamento
	bne t2, s0, PULA1
	addi s2, s2, -1
PULA1:	bne t2, s1, PULA2
	addi s2, s2, 1
PULA2:	jal SetPixels
	### Apenas verifica se há tecla pressionada
KEY2:	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM   	   	# Se não há tecla pressionada então vai para FIM
  	lw t2,4(t1)  			# le o valor da tecla tecla
	sw t2,12(t1)  			# escreve a tecla pressionada no display
FIM:					
	#li a0,10   
	#li a7,132
	#ecall
j GAMELOOP

.include "include/SetPixels.s"
.include "include/SYSTEMv17.s"
