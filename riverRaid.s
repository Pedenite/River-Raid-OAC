.eqv Water 0x0d2	# 210, aviao = 7f 127
.eqv Land 0x063

.data
.include "include/plane.s"

.text
MAIN:
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	li t3,0xd2d2d2d2		# cor 
LOOP: 	beq t1,t2,FORA		# Se for o último endereço então sai do loop
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	j LOOP			# volta a verificar
FORA:	
	la a0, plane
	li a1, 200
	li a2, 160
	jal SetPixels

li a7, 10
ecall

.include "include/SYSTEMv17.s"
.include "include/SetPixels.s"
