#################################################################################
# Enemy 1 Behavior								#
# Define como o inimigo 1 se comporta						#
#################################################################################

.text
Enemy1Bhv:	la a0, enemy1_l
		li a1, 0
		li a2, 160
		jal SetPixels