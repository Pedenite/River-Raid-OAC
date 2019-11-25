#####################################################################
# GetAxis															#
# Função que verifica a posição do joystick							#
#####################################################################

.text
GetAxis:	li t0,0xFF200200		# endereco do CH0
			li t1,0x0010
			li t2,0x0ff0

			lw t3,0(t0)				# x
			lw t4,4(t0)				# y
			ble t3, t1, AxisEsq
			bge t3, t2, AxisDir
			ret

AxisEsq:	mv s3, s0
			ret
AxisDir:	mv s3, s1
			ret
