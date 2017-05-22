
@ -----------------------------------
@ Universidad del Valle de Guatemala
@ Organizacion de Computadoras y Assembler 
@ Autor: Maria Mercedes Retolaza Reyna, 16339 
@ Autor: Diego Fernandez,16344  
@ ----------------------------------
@ Build:
@ gcc -o main main.s readGPIOs.s gpio0_2.s phys_to_virt.c timeLib.c
@ -----------------------------------

@@ Clase que asigna la configuracion que tendran los pines GPIO para su funcionamiento. Osea, indica
@@      cuales pines seran de escritura y letura para que se puedan usar las funciones creadas en readGPIOS.s

.global set_buttons
set_buttons:
push {lr}
    @ Generar direccion de memoria virtual para alterar GPIO
    bl GetGpioAddress

    @ Configurar GPIO's para lectura de botones frontales
    mov r0, #17         @ GPIO 1
    mov r1, #0          @ Read
    bl SetGpioFunction

    mov r0, #27         @ GPIO 2
    mov r1, #0          @ Read
    bl SetGpioFunction

    mov r0, #22         @ GPIO 3
    mov r1, #0          @ Read
    bl SetGpioFunction

    mov r0, #23         @ GPIO 4
    mov r1, #0          @ Read
    bl SetGpioFunction

    @ Configurar GPIO's para escritura de los LED's
    mov r0, #5          @ GPIO: Led mas alto 6 (Cable verde)
    mov r1, #1          @ Write
    bl SetGpioFunction

    mov r0, #6          @ GPIO Led 5 
    mov r1, #1          @ Write
    bl SetGpioFunction

    mov r0, #13         @ GPIO Led 4 
    mov r1, #1          @ Write
    bl SetGpioFunction

    mov r0, #19         @ GPIO Led 3 
    mov r1, #1          @ Write
    bl SetGpioFunction

    mov r0, #26         @ GPIO Led 2 
    mov r1, #1          @ Write
    bl SetGpioFunction

    mov r0, #21         @ GPIO Led 1 
    mov r1, #1          @ Write
    bl SetGpioFunction


    @ Colocar todos los LED's en apagado
        mov r0, #5          @ GPIO: Led mas alto 6
        mov r1, #0          
        bl SetGpio

        mov r0, #6          @ GPIO Led 5
        mov r1, #0          
        bl SetGpio

        mov r0, #13         @ GPIO Led 4
        mov r1, #0          
        bl SetGpio

        mov r0, #19         @ GPIO Led 3
        mov r1, #0          
        bl SetGpio

        mov r0, #26         @ GPIO 2
        mov r1, #0          @ Off
        bl SetGpio

        mov r0, #21         @ GPIO 1
        mov r1, #0          @ Off
        bl SetGpio

    pop {pc}

    

.data
  
    .global myloc
    myloc: 
        .word 0