// Espera hasta que se presione la tecla 'd'
(LOOP)
    @KBD        // Dirección del teclado
    D=M        // Leer la tecla presionada
    @DRAW      // Si es 'd' (100 en ASCII), ir a dibujar
    D;JEQ      
    @LOOP      // Si no, seguir esperando
    0;JMP

// Dibuja el bitmap en la pantalla
(DRAW)
    @SCREEN    // Dirección base de la pantalla (16384)
    D=A        
    @bitmap    // Guarda la dirección en bitmap
    M=D        
    
    @bitmap    // Primera fila del bitmap
    A=M        
    M=-1       // Dibuja píxeles
    
    @bitmap    // Segunda fila
    D=M
    @32
    D=D+A
    @bitmap
    M=D
    A=M
    M=-1
    
    // Puedes continuar con más filas aquí...
    
    @LOOP      // Vuelve a esperar entrada del usuario
    0;JMP

