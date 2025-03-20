// Esperar hasta que se presione la tecla 'd'
(ESPERAR_TECLA)
    @KBD
    D=M
    @ESPERAR_TECLA
    D;JEQ       // Si no se presiona ninguna tecla, seguir esperando
    @100        // Código ASCII de 'd'
    D=D-A
    @DIBUJAR
    D;JEQ       // Si la tecla es 'd', ir a DIBUJAR
    @ESPERAR_TECLA
    0;JMP       // Si no es 'd', seguir esperando

// Dibujar en la pantalla
(DIBUJAR)
    @16384      // Dirección inicial de la pantalla
    D=A
    @R0
    M=D         // R0 almacena la dirección actual en SCREEN

    @255        // Valor para encender píxeles (8 píxeles encendidos)
    D=A
    @R1
    M=D         // R1 almacena el valor a dibujar

    @8          // Cantidad de líneas a dibujar
    D=A
    @R2
    M=D         // R2 almacena el contador de líneas

(DIBUJAR_LOOP)
    @R0
    A=M
    M=R1        // Escribir en la memoria de pantalla

    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D         // Moverse a la siguiente línea de la pantalla

    @R2
    M=M-1       // Decrementar contador de líneas
    @DIBUJAR_LOOP
    D=M
    @DIBUJAR_LOOP
    D;JGT       // Si R2 > 0, seguir dibujando

// Fin del programa
(FIN)
    @FIN
    0;JMP       // Bucle infinito

