**Actividad 1**

- ¿Qué es la entrada-salida mapeada a memoria?

R// La entrada-salida mapeada a memoria es un método de implementar la comunicación entre la CPU y los dispositivos de entrada/salida en un sistema informático. En este enfoque, se asignan direcciones de memoria específicas a los dispositivos de E/S, permitiendo que la CPU acceda a ellos utilizando las mismas instrucciones que usa para acceder a la memoria principal.

- ¿Cómo se implementa en la plataforma Hack?

R// En la plataforma Hack, la MMIO se implementa asignando direcciones específicas de memoria a dos dispositivos de E/S:
En la plataforma Hack de Nand2Tetris, la entrada-salida mapeada a memoria se implementa asignando direcciones específicas de memoria a los dispositivos de E/S. Por ejemplo, la pantalla se encuentra en la dirección 16384, y el teclado en la dirección 24576. Al escribir o leer en estas direcciones, se interactúa directamente con los dispositivos correspondientes

- Inventa un programa que haga uso de la entrada-salida mapeada a memoria.

```
// Inicialización
@0
D=A
@tecla_presionada
M=D // Variable para indicar si se presionó una tecla

// Bucle principal para verificar tecla
(LOOP_TECLA)
    @24576 // Dirección del teclado
    D=M
    @0
    D=D-A
    @MOSTRAR_MENSAJE // Si se presionó una tecla, salta a mostrar mensaje
    D;JNE

    @LOOP_TECLA // Si no se presionó una tecla, vuelve a verificar
    0;JMP

// Rutina para mostrar un mensaje en la pantalla
(MOSTRAR_MENSAJE)
    @16384 // Dirección de la pantalla
    D=A
    @0
    M=D // Inicializa el puntero de pantalla

    // Escribe el mensaje "Hola" en la pantalla
    @72 // Código ASCII de 'H'
    M=D
    @16385
    @111 // Código ASCII de 'o'
    M=D
    @16386
    @108 // Código ASCII de 'l'
    M=D
    @16387
    @97 // Código ASCII de 'a'
    M=D

    @LOOP_TECLA // Vuelve al bucle principal
    0;JMP
```
- Investiga el funcionamiento del programa con el simulador.
En el simulador, presiona una tecla para simular la entrada del teclado. Después de presionar la tecla, deberías ver el mensaje "Hola" aparecer en la pantalla del simulador, Utiliza las herramientas del simulador para ver paso a paso cómo se ejecuta el programa y cómo interactúa con la memoria mapeada para E/S.
