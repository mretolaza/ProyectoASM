
@ -----------------------------------
@ Universidad del Valle de Guatemala
@ Organizacion de Computadoras y Assembler 
@ Autor: Maria Mercedes Retolaza Reyna, 16339 
@ Autor: Diego Fernandez,16344  
@ ----------------------------------
@ En esta sección del programa se programarán las entradas de los botones, la division de los numeros 
@ las entradas que se utilizaran 
@ Los requisitos para que esto se cumpla es establecer los GpioS para el funcionamiento previo 
@ -----------------------------------


@ Subrutina que revisa si algún boton se encuentra apachado.
@ Requisito: Ya se deben de haber establecido los GPIOS como de lectura para utilizar esta funcion.
@ Parametros:
@   - Nulo
@ Retorna:
@   - r0: 0: Si no se apacho ninguno; 1: Si se apacho boton 1 (17); 2: si fue el boton 2 (27); 3: si fue el boton 3 (22)
@ Uso de registros:
@   - r2: Resultado
.global readGPIOs
readGPIOs:
    push {lr}
        mov r2, #0          @ Limpiar registro 

        mov r0, #17         @ Revisar boton 1
        bl GetGpio          @ Devuelve en r0: 1, apachado; 0, libre
        cmp r0, #1          @ Asignar resultado
        moveq r2, #1
        bleq ReturnReadGpio     @ Finalizar funcion

        mov r0, #27         @ Revisar boton 2
        bl GetGpio          @ Devuelve en r0: 1, apachado; 0, libre
        cmp r0, #1
        moveq r2, #2        @ Asignar resultado
        bleq ReturnReadGpio     @ Finalizar funcion

        mov r0, #22         @ Revisar boton 3
        bl GetGpio          @ Devuelve en r0: 1, apachado; 0, libre
        cmp r0, #1
        moveq r2, #3        @ Asignar resultado
        bleq ReturnReadGpio     @ Finalizar funcion

        mov r0, #23         @ Revisar boton 4
        bl GetGpio          @ Devuelve en r0: 1, apachado; 0, libre
        cmp r0, #1
        moveq r2, #4        @ Asignar resultado
        bleq ReturnReadGpio     @ Finalizar funcion

        mov r2, #0          @ Retornar 0 si no se ha apachado ninguno.

        ReturnReadGpio:
        mov r0, r2          @ Retornar correctamente el resultado 
        pop {pc}


@ Subrutina que enciende y apaga luces
@ Requisito: Ya se deben de haber establecido los GPIOS como de escritura para utilizar esta funcion.
@ Parametros:
@   - Nulo
@ Retorna:
@   - Nulo
@ Uso de registros:
@   - r2: Resultado
.global LucesLedAleatorias
LucesLedAleatorias:
    push {lr}
        mov r0, #5 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #5 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #6 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #6 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #13 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #5 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #13 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #19 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #19 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #26 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #5 
        mov r1, #0            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #26 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #21 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        mov r0, #21 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        pop {pc}



@ Subrutina que realiza una division entre 2 numeros (A/B)
@ Parametros:
@   - r0: numero 1 (A)
@   - r1: numero 2 (B)
@ Retorna:
@   - r0: resultado
@   - r1: residuo
.global Dividir
Dividir:
    push {lr}
    mov r2, #0      @ Limpiar registros
    mov r3, r0      @ Asignamos el residuo como A
    
    inicio_div:
        cmp r3,r1
        blt fin_div     @ Terminar ya que B es mas grande que el residuo
        sub r3,r3,r1    @ Residuo = residuo-B 
        add r2,r2,#1    @ Resultado = resultado+1
        b inicio_div

    fin_div:
        mov r0, r2
        mov r1, r3
    pop {pc}