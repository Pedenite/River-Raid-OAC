#################################################################
# Set Reverse Pixels						#
# Função pega um arquivo convertido de .bmp para .data e o	#
# imprime ao contrário no bitmap display			#
# a0 = endereço do que será desenhado				#
# a1 = altura a desenhar					#
# a2 = distancia à esquerda a desenhar				#
#################################################################

.text
SetRevPixels:	li t0, 0xff000000
		li t1, 320
		mul a1, a1, t1		# Calcula a altura
		add t0, t0, a1		# Soma altura ao endereço inicial
		add t0, t0, a2		# Soma posição ao endereço inicial
		lw t2, 0(a0)		# largura do objeto
		add t0, t0, t2		# ultima coluna do objeto
		lw t3, 4(a0)		# altura do objeto
		mul t1, t1, t3		
		add t1, t1, t0		# Calcula endereço final da imagem
		add t4, t2, t0		# Calcula endereço final da linha
		addi a0, a0, 8		# Pega o primeiro pixel da figura
LOOPR1:		bge t0, t1, FORAR1
LOOPR2:		beq t0, t4, FORAR2
		lbu t3, 0(a0)
		sb t3, 0(t0)
		addi t0, t0, -1
		addi a0, a0, 1
		j LOOP2
FORAR2:		addi t4, t4, 320
		sub t0, t0, t2
		addi t0, t0, 320
		j LOOP1
FORAR1:		ret
