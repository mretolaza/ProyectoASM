@ Basado en el curso de la U. de Cambridge de Alex Chadwick
@ puertosES_2.s prueba con puertos de entrada y salida
@ Funciona con cualquier puerto, utilizando biblioteca gpio0_2.s

/*	Uso de registros:
	R4 - Marca largo del vector
	R5 - Valro del vector a utilizar
	R7 - Contador
*/
 .text
 .align 2
 .global main
main:
	@utilizando la biblioteca GPIO (gpio0_2.s)
	bl GetGpioAddress @solo se llama una vez

	@ GPIO para lectura puerto 23
	@ Entrada Boton empezar programa
	mov r0,#23
	mov r1,#0                                
	bl SetGpioFunction
	
	@ GPIO para lectura puerto 24
	@ Entrada Boton
	mov r0,#24
	mov r1,#0                                
	bl SetGpioFunction

	@ GPIO para lectura puerto 25
	@ Entrada Boton
	mov r0,#25
	mov r1,#0                                
	bl SetGpioFunction

	@ GPIO para salida puerto 4
	mov r0,#4
	mov r1,#1                            
	bl SetGpioFunction

	/* Display Izquierdo */
	@GPIO para escritura (salida) puerto 12 
	@|..|...|*.|
	mov r0,#12
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para escritura (salida) puerto 16
	@|..|*..|..|
	mov r0,#16
	mov r1,#1
	bl SetGpioFunction

	@GPIO para lectura (salida) puerto 20 
	@|*.|...|..|
	mov r0,#20
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para lectura (salida) puerto 21 
	@|..|.*.|..|
	mov r0,#21
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para lectura (salida) puerto 14 
	@|..|...|.*|
	mov r0,#14
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para escritura (salida) puerto 15
	@|..|..*|..|
	mov r0,#15
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para escritura (salida) puerto 18
	@|.*|...|..|
	mov r0,#18
	mov r1,#1
	bl SetGpioFunction

	/* Display Derecho */
	@GPIO para escritura (salida) puerto 26
	@|..|...|*.|
	mov r0,#26
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para escritura (salida) puerto 19
	@|..|*..|..|
	mov r0,#19
	mov r1,#1
	bl SetGpioFunction

	@GPIO para lectura (salida) puerto 13
	@|*.|...|..|
	mov r0,#13
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para lectura (salida) puerto 6
	@|..|.*.|..|
	mov r0,#6
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para lectura (salida) puerto 17
	@|..|...|.*|
	mov r0,#17
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para escritura (salida) puerto 27
	@|..|..*|..|
	mov r0,#27
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para escritura (salida) puerto 22
	@|.*|...|..|
	mov r0,#22
	mov r1,#1
	bl SetGpioFunction
	
	mov r0, #4
	mov r1, #1
	bl SetGpio
	
	/* Boton para empezar */
	@Revision del boton
	ldr r6, =myloc
 	ldr r0, [r6]		@ obtener direccion de la memoria virtual 
	ldr r5,[r0,#0x34]	@Direccion r0+0x34:lee en r5 estado de puertos de entrada
	mov r7,#1
	lsl r7,#23
	and r5,r7 		@se revisa el bit 23 (puerto de entrada)
	
	@ Si se presiona el boton (0), se pasa a la siguiente rutina
	teq r5,#0
	bne buttonUp

	/* Boton set alarma segundos */
	@Revision del boton
	ldr r6, =myloc
 	ldr r0, [r6]		@ obtener direccion de la memoria virtual 
	ldr r5,[r0,#0x34]	@Direccion r0+0x34:lee en r5 estado de puertos de entrada
	mov r7,#1
	lsl r7,#24
	and r5,r7 		@se revisa el bit 24 (puerto de entrada)
	
	@ Si se presiona el boton (0), se pasa a la siguiente rutina
	teq r5,#0
	bne unSegundo

	/* Boton set alarma decena */
	@Revision del boton
	ldr r6, =myloc
 	ldr r0, [r6]		@ obtener direccion de la memoria virtual 
	ldr r5,[r0,#0x34]	@Direccion r0+0x34:lee en r5 estado de puertos de entrada
	mov r7,#1
	lsl r7,#25
	and r5,r7 		@se revisa el bit 25 (puerto de entrada)
	
	@ Si se presiona el boton (0), se pasa a la siguiente rutina
	teq r5,#0
	bne decenaSegundo

	bl wait
	bl main

buttonUp:

	@Revision del boton 23
	ldr r6, =myloc
 	ldr r0, [r6]		@ obtener direccion de la memoria virtual 
	ldr r5,[r0,#0x34]	@Direccion r0+0x34:lee en r5 estado de puertos de entrada
	mov r7,#1
	lsl r7,#23
	and r5,r7 		@se revisa el bit 23 (puerto de entrada)
	
	@ Si se deja de presionar el boton , se pasa a la siguiente rutina
	teq r5,#0
	moveq r7, #0
	beq loop1

	bl buttonUp

buttonUp2:
	@Revision del boton 25
	ldr r6, =myloc
 	ldr r0, [r6]		@ obtener direccion de la memoria virtual 
	ldr r5,[r0,#0x34]	@Direccion r0+0x34:lee en r5 estado de puertos de entrada
	mov r7,#1
	lsl r7,#24
	and r5,r7 		@se revisa el bit 24 (puerto de entrada)
	
	@ Si se deja de presionar el boton , se pasa a la siguiente rutina
	teq r5,#0
	beq main

	bl buttonUp2

buttonUp3:
	@Revision del boton 25
	ldr r6, =myloc
 	ldr r0, [r6]		@ obtener direccion de la memoria virtual 
	ldr r5,[r0,#0x34]	@Direccion r0+0x34:lee en r5 estado de puertos de entrada
	mov r7,#1
	lsl r7,#25
	and r5,r7 		@se revisa el bit 25 (puerto de entrada)
	
	@ Si se deja de presionar el boton , se pasa a la siguiente rutina
	teq r5,#0
	beq main

	bl buttonUp3

unSegundo:

	ldr r0,=alarma
	ldr r0,[r0]
	mov r1, #1
	add r1,r1,r0
	ldr r0,=alarma
	str r1,[r0]

	ldr r0,=alarma
	ldr r1,[r0]
	ldr r0,=este
	bl printf
	
	bl buttonUp2

decenaSegundo:

	ldr r0,=alarma
	ldr r0,[r0]
	mov r1, #10
	add r1,r1,r0
	ldr r0,=alarma
	str r1,[r0]

	ldr r0,=alarma
	ldr r1,[r0]
	ldr r0,=este
	bl printf

	bl buttonUp3

loop1:
	ldr r0,=decenas
	ldr r1,[r0]
	add r1,r1,r7
	ldr r0,=este
	cmp r7, #10
	blne printf
	
	mov r9, #4	

	/* cero */
	cmp r7, #0
	moveq r7, #1
	ldreq r8,=cero7dig1
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1

	/* uno */
	cmp r7, #1
	moveq r7, #2
	ldreq r8,=uno7dig1
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
	/* dos */
	cmp r7, #2
	moveq r7, #3
	ldreq r8,=dos7dig1
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
	/* tres */
	cmp r7, #3
	moveq r7, #4
	ldreq r8,=tres7dig1
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
	/* cuatro */
	cmp r7, #4
	moveq r7, #5
	ldreq r8,=cuatro7dig1
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1

	/* cinco */
	cmp r7, #5
	moveq r7, #6
	ldreq r8,=cinco7dig1
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
	/* seis */
	cmp r7, #6
	moveq r7, #7
	ldreq r8,=seis7dig1
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
	
	/* siete */
	cmp r7, #7
	moveq r7, #8
	ldreq r8,=siete7dig1
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1
		
	/* ocho */
	cmp r7, #8
	moveq r7, #9
	ldreq r8,=ocho7dig1
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1

	/* nueve */
	cmp r7, #9
	moveq r7, #10
	ldreq r8,=nueve7dig1
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR1

	ldr r0,=decenas
	ldr r0,[r0]
	mov r1, #10
	add r1,r1,r0
	ldr r0,=decenas
	str r1,[r0]

	bl ceroR1

loop2:

	ldr r8,=decenas
	ldr r7,[r8]
	
	mov r9, #4	

	/* cero */
	cmp r7, #0
	ldreq r8,=cero7dig2
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR2

	/* uno */
	cmp r7, #10
	ldreq r8,=uno7dig2
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR2
	
	/* dos */
	cmp r7, #20
	ldreq r8,=dos7dig2
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR2
	
	/* tres */
	cmp r7, #30
	ldreq r8,=tres7dig2
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR2
	
	/* cuatro */
	cmp r7, #40
	ldreq r8,=cuatro7dig2
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR2

	/* cinco */
	cmp r7, #50
	ldreq r8,=cinco7dig2
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR2
	
	/* seis */
	cmp r7, #60
	ldreq r8,=seis7dig2
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR2
	
	/* siete */
	cmp r7, #70
	ldreq r8,=siete7dig2
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR2
		
	/* ocho */
	cmp r7, #80
	ldreq r8,=ocho7dig2
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR2

	/* nueve */
	cmp r7, #90
	ldreq r8,=nueve7dig2
	ldreq r4,[r8]
	ldreq r5, [r8,#4]
	beq apagarR2

encenderR1:	
	
	/* verifica si seguir */
	cmp r4, #0
	bleq wait
	bleq wait
	bleq wait
	bleq wait
	bleq wait
	beq loop1
	addeq r7,r7,#1

	sub r4, r4,#1	
	
	/* encender dicho gpios */
	ldr r5, [r8],r9
	mov r0, r5
	mov r1, #0
	bl SetGpio
	
	bl encenderR1
	
encenderR2:	
	
	/* verifica si seguir */
	cmp r4, #0
	bleq wait
	bleq wait
	bleq wait
	bleq wait
	bleq wait
	beq loop1
	addeq r7,r7,#1

	sub r4, r4,#1	
	
	/* encender dicho gpios */
	ldr r5, [r8],r9
	mov r0, r5
	mov r1, #1
	bl SetGpio
	
	bl encenderR2

	
apagarR1:

	@Apagar GPIO 12
	mov r0,#12
	mov r1,#1
	bl SetGpio
	@Apagar GPIO 16
	mov r0,#16
	mov r1,#1
	bl SetGpio
	@Apagar GPIO 20
	mov r0,#20
	mov r1,#1
	bl SetGpio
	@Apagar GPIO 21
	mov r0,#21
	mov r1,#1
	bl SetGpio
	@Apagar GPIO 14
	mov r0,#14
	mov r1,#1
	bl SetGpio
	@Apagar GPIO 15
	mov r0,#15
	mov r1,#1
	bl SetGpio
	@Apagar GPIO 18
	mov r0,#18
	mov r1,#1
	bl SetGpio
	
	ldr r5, [r8],r9
	bl encenderR1

apagarR2:

	mov r7, #1

	@Apagar GPIO 26
	mov r0,#26
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 19
	mov r0,#19
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 13
	mov r0,#13
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 6
	mov r0,#6
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 17
	mov r0,#17
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 27
	mov r0,#27
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 22
	mov r0,#22
	mov r1,#0
	bl SetGpio
	
	ldr r5, [r8],r9
	bl encenderR2

ceroR1:

	@Enciende GPIO 12
	mov r0,#12
	mov r1,#0
	bl SetGpio
	@Enciende GPIO 16
	mov r0,#16
	mov r1,#0
	bl SetGpio
	@Enciende GPIO 20
	mov r0,#20
	mov r1,#0
	bl SetGpio
	@Apagar GPIO 21
	mov r0,#21
	mov r1,#1
	bl SetGpio
	@Enciende GPIO 14
	mov r0,#14
	mov r1,#0
	bl SetGpio
	@Enciende GPIO 15
	mov r0,#15
	mov r1,#0
	bl SetGpio
	@Enciende GPIO 18
	mov r0,#18
	mov r1,#0
	bl SetGpio
	
	bl loop2

@ brief pause routine
wait:
	mov r0, #0xF000000 @ big number
sleepLoop:
	subs r0,#1
	bne sleepLoop @ loop delay
	mov pc,lr

.data
.align 2
.global myloc
myloc: 
	.word 0
hola:
	.asciz "Hola"
este:
	.asciz "Segundos: %d \n"
boton:
	.asciz "Boton %d \n"
boton3:
	.asciz "Boton 3 %d \n"
boton2:
	.asciz "Boton 2 %d \n"
decenas:
	.word 0
alarma:
	.word 0

/* Vectores Display 1 */
cero7dig1:
	.word 7,12,16,20,14,15,18
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

/* Vectores Display 2 */
cero7dig2:
	.word 7,26,19,13,17,27,22
uno7dig2:
	.word 2,26,17
dos7dig2:
	.word 5,26,19,6,27,22
tres7dig2:
	.word 5,26,19,6,27,17
cuatro7dig2:
	.word 4,26,13,6,17
cinco7dig2:
	.word 5,19,13,6,17,27
seis7dig2:
	.word 6,19,13,6,17,27,22
siete7dig2:
	.word 3,26,19,17
ocho7dig2:
	.word 7,26,19,13,6,17,27,22
nueve7dig2:
	.word 5,26,19,13,6,17
 .end
