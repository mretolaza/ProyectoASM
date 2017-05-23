@ -----------------------------------
@ Universidad del Valle de Guatemala
@ Organizacion de Computadoras y Assembler 
@ Autor: Maria Mercedes Retolaza Reyna, 16339 
@ Autor: Diego Fernandez,16344  
@ ----------------------------------
@ Build:
@ -----------------------------------

nada de esto esta probado 
@ Subrutina que fija la hora a la que sonara la alarma
@ Parametros:
@   - Ninguno
@ Retorno:
@   - Nada
.global set_alarm
set_alarm:  
    push {lr}
    
    @ Colocar bandera que debe sonar alarma 
    ldr r0, =alarma_activada
    mov r1, #1
    str r1, [r0]

    @ Esperar cambios en entradas GPIO
    leerHoras:
        ldr r0, =0xC8       @ Esperar 250 milisegundo entre cada ciclo
        bl delay

        ldr r8, =horaAlarma_hora
        ldr r7, [r8]        @ Cargar la posible hora de alarma
        
        bl readGPIOs        @ Leer las entradas
        cmp r0, #1
        subeq r7, #1

        cmp r0, #2
        addeq r7, #1

        cmp r7, #0
        movlt r7, #23        @ Aegurarse que se quede en 0

        cmp r7, #23
        movgt r7, #0        @ Aegurarse que se quede en 24

        str r7, [r8]

        cmp r0, #3
        beq leerMinutos

        b leerHoras

    leerMinutos:
        ldr r0, =0xC8       @ Esperar 250 milisegundo entre cada ciclo
        bl delay

        ldr r8, =horaAlarma_minutos
        ldr r7, [r8]        @ Cargar la posible minutos de alarma
        
        bl readGPIOs        @ Leer las entradas
        cmp r0, #1
        subeq r7, #1

        cmp r0, #2
        addeq r7, #1

        cmp r7, #0
        movlt r7, #59        @ Asegurarse que se quede en 60

        cmp r7, #59
        movgt r7, #0        @ Aegurarse que se quede en 0
        str r7, [r8]

        cmp r0, #3
        beq return

        b leerMinutos

    return:
    ldr r0, =0xC8       @ Esperar 250 milisegundo entre cada ciclo
    bl delay

    mov r0, #5          @ Bandera de cambio
    pop {pc}

@ Subrutina que activa la alarma 
@ Parametros:
@   - Ninguno
@ Retorno:
@   - Nada

.global activate_alarm
activate_alarm:
    push {lr}
    ldr r0, =alarma_luces
    bl play_music

    ldr r0, =sound1
    bl play_music

    loopSonar:
        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        @ Leds pseudo-aleatorios
        mov r0, #5 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #5 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #6 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #6 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #13 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #5 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #13 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #19 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #19 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #26 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #5 
        mov r1, #0            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #26 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #21 
        mov r1, #1            @ Encender
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir

        mov r0, #21 
        mov r1, #0            @ Apagar
        bl SetGpio

        ldr r0, =0x64       @ Esperar 1/2 de segundo entre cada ciclo
        bl delay

        bl readGPIOs        @ Leer las entradas
        cmp r0, #4
        bleq stop_music
        beq loopSonarSalir
        b loopSonar

    loopSonarSalir:
    @ Apagar leds 
    bl set_buttons

    @ Colocar bandera que ya se desactivo la alarma 
    ldr r0, =alarma_activada
    mov r1, #0
    str r1, [r0]

    pop {pc}


@ Subrutina que verifica si se debe activar la alarma 
@ Parametros:
@   - Ninguno
@ Retorno:
@   - r0: 0: Si no se debe activar; 1: Si se debe activar 

.global check_alarm
check_alarm:
    push {lr}
    @ Comparar hora
    bl getHoras
    mov r3, r0
    ldr r2, =horaAlarma_hora
    ldr r2, [r2]
    mov r0, #0          @ Bandera en caso de que no se active
    cmp r3, r2
    bne not_activated

    @ Comparar minutos
    bl getMinutos
    mov r3, r0
    ldr r2, =horaAlarma_minutos
    ldr r2, [r2]
    mov r0, #0          @ Bandera en caso de que no se active
    cmp r3, r2
    bne not_activated

    @ Verificar si la alarma esta activada o desactivada
    ldr r0, =alarma_activada
    ldr r0, [r0]
    cmp r0, #1
    bne not_activated

    @ Indicar que se debe sonar alarma
    mov r0, #1

    not_activated:
    pop {pc}