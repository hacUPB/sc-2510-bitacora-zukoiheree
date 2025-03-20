// Dirección base de la pantalla
@16384
D=A
@SCREEN
M=D

// Bucle principal
(LOOP)
    // Leer entrada del teclado
    @24576
    D=M
    @DRAW
    D;JEQ    // Si no hay tecla presionada, borrar pantalla

    // Comparar con la tecla 'd' (ASCII 68)
    @68
    D=D-A
    @DRAW
    D;JEQ    // Si es 'd', dibujar bitmap

    // Si no es 'd', volver al loop
    @LOOP
    0;JMP

// Rutina para dibujar bitmap
(DRAW)
    @SCREEN
    D=M

    // Primera fila
    @12
    AD=D+A
    @8
    D=D+A
    A=D-A
    M=D-A

    // Segunda fila
    D=A
    @32
    AD=D+A
    @16404
    D=D+A
    A=D-A
    M=D-A

    // Tercera fila
    AD=A+1
    @2048
    D=D+A
    A=D-A
    M=D-A

    // Cuarta fila
    AD=A+1
    @2
    D=D+A
    A=D-A
    M=D-A

    // Quinta fila
    D=A
    @30
    AD=D+A
    @8201
    D=D+A
    A=D-A
    M=D-A

    // Sexta fila
    AD=A+1
    @4096
    D=D+A
    A=D-A
    M=D-A

    // Séptima fila
    AD=A+1
    @33
    D=D+A
    A=D-A
    M=D-A

    // Octava fila
    D=A
    @30
    AD=D+A
    @5600
    D=D+A
    A=D-A
    M=D-A

    // Volver al bucle principal
    @LOOP
    0;JMP


