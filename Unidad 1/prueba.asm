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

