// Inicialización
@0
D=A
@tecla_presionada
M=D // Variable para indicar si se presionó la tecla "d"

// Bucle principal para verificar tecla
(LOOP_TECLA)
    @24576 // Dirección del teclado
    D=M
    @100 // Valor ASCII de "d"
    D=D-A
    @DIBUJAR // Si se presionó "d", salta a dibujar
    D;JEQ

    @LOOP_TECLA // Si no se presionó "d", vuelve a verificar
    0;JMP

// Rutina para dibujar el bitmap
(DIBUJAR)
    // Asumiendo que el bitmap está diseñado en las direcciones
    // que se modifican a continuación. Ajusta según sea necesario.
    @16384 // Dirección de la pantalla
    D=A
    @12
    AD=D+M
    @8
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @16404
    D=D+A
    A=D-A
    M=D-A

    AD=A+1
    @2048
    D=D+A
    A=D-A
    M=D-A

    AD=A+1
    @2
    D=D+A
    A=D-A
    M=D-A

    D=A
    @30
    AD=D+A
    @8201
    D=D+A
    A=D-A
    M=D-A

    AD=A+1
    @4096
    D=D+A
    A=D-A
    M=D-A

    AD=A+1
    @33
    D=D+A
    A=D-A
    M=D-A

    D=A
    @30
    AD=D+A
    @5600
    D=D+A
    A=D-A
    M=D-A

    @LOOP_TECLA // Vuelve al bucle principal
    0;JMP


