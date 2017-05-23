@ Basado en el curso de la U. de Cambridge de Alex Chadwick
@ puertosES_2.s prueba con puertos de entrada y salida
@ Funciona con cualquier puerto, utilizando biblioteca gpio0_2.s

 .text
 .align 2
 .global main
main:
	
loop1:
	/* cero */
	cmp r7, #0
	moveq r7, #1
	ldreq r8,=cero7dig1
	ldreq r6,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
	/* uno */
	cmp r7, #1
	moveq r7, #2
	ldreq r8,=uno7dig1
	ldreq r6,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
	/* dos */
	cmp r7, #2
	moveq r7, #3
	ldreq r8,=dos7dig1
	ldreq r6,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
	/* tres */
	cmp r7, #3
	moveq r7, #4
	ldreq r8,=tres7dig1
	ldreq r6,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
	/* cuatro */
	cmp r7, #4
	moveq r7, #5
	ldreq r8,=cuatro7dig1
	ldreq r6,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1

	/* cinco */
	cmp r7, #5
	moveq r7, #6
	ldreq r8,=cinco7dig1
	ldreq r6,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
	/* seis */
	cmp r7, #6
	moveq r7, #7
	ldreq r8,=seis7dig1
	ldreq r6,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
	/* siete */
	cmp r7, #7
	moveq r7, #8
	ldreq r8,=siete7dig1
	ldreq r6,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
		
	/* ocho */
	cmp r7, #8
	moveq r7, #9
	ldreq r8,=ocho7dig1
	ldreq r6,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1

	/* nueve */
	cmp r7, #9
	moveq r7, #10
	ldreq r8,=nueve7dig1
	ldreq r6,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
encenderR1:
	
	/* verifica si seguir */
	cmp r6, #0
	bl wait
	bl wait
	bl wait
	beq loop
	add r6, r6,#-1
	
	/* encender dicho gpios */
	mov r0, r5
	mov r1, #0
	bl SetGpio
	ldr r8, [r8,#4]
	ldr r5, [r8,#4]
	bl encenderR1
	
apagarR1:

	@Apagar GPIO 12
	mov r0,#12
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 16
	mov r0,#16
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 20
	mov r0,#20
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 21
	mov r0,#21
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 14
	mov r0,#14
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 15
	mov r0,#15
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 18
	mov r0,#18
	mov r1,#0
	bl SetGpio
	
	bl encenderR1

@ brief pause routine
wait:
	mov r0, #0x4000000 @ big number
sleepLoop:
	subs r0,#1
	bne sleepLoop @ loop delay
	mov pc,lr

.data
.align 2
.global myloc
myloc: 
	.word 0
cero7dig1:
	.word 6,12,16,20,14,15,18
uno7dig1:
	.word 2,12,14
dos7dig1:
	.word 5,12,16,21,15,18
tres7dig1:
	.word 5,12,16,21,15,14
cuatro7dig1:
	.word 4,12,20,21,14
cinco7dig1:
	.word 5,16,20,21,14,15
seis7dig1:
	.word 6,16,20,21,14,15,18
siete7dig1:
	.word 3,12,14,16
ocho7dig1:
	.word 7,12,16,20,21,14,15,18
nueve7dig1:
	.word 5,12,16,20,21,14
 .end