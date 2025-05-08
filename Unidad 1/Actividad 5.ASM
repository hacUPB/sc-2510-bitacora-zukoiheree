//1. Carga en D el valor 1978.
@1978
D=A

//2. Guarda en la posición 100 de la RAM el número 69.
@69
D=A
@100
M=D

//3. Guarda en la posición 200 de la RAM el contenido de la posición 24 de la RAM
@24
D=M
@200
M=D

//4. Lee lo que hay en la posición 100 de la RAM, resta 15 y guarda el resultado en la posición 100 de la RAM.
@100
D=M
@15
D=D-A
@100
M=D

//5. Suma el contenido de la posición 0 de la RAM, el contenido de la posición 1 de la RAM y con la constante 69. Guarda el resultado en la posición 2 de la RAM.
@0
D=M
@1
D=D+M
@69
D=D+A
@2
M=D

//6. Si el valor almacenado en D es igual a 0 salta a la posición 100 de la ROM.
@100
D;JEQ

//7. Si el valor almacenado en la posición 100 de la RAM es menor a 100 salta a la posición 20 de la ROM.
@100 
D=M
@100
D=D-A
@20
D;JLT

//8. Considera el siguiente programa: - ¿Qué hace este programa?
- En qué posición de la memoria está `var1`, `var2` y `var3`? ¿Por qué en esas posiciones?//
@var1
D = M
@var2
D = D + M
@var3
M = D
//- Este programa toma el valor de almacenamiento de dos lugares aleatorios (var1 y var2) y los suma a la RAM para despues mover el resultado a la posicion var3.
- Por que se encuentran en la posicion 16, 17 y 18, lo que indica que los espacios del 0 al 15 se encuentran en la RAM//

//9. Considera el siguiente programa: - ¿Qué hace este programa?
- ¿En qué parte de la memoria RAM está la variable `i` y `sum`? ¿Por qué en esas posiciones?//
i = 1
sum = 0
sum = sum + i
i = i + 1
//- Suma la cantidad existente de la primera variable a la segunda de la RAM
- Por lo que i y sum son las variables 16 y 17//
//Optimizacion:
i=i + 1
@i
M=M+1

//10. Las posiciones de memoria RAM de 0 a 15 tienen los nombres simbólico R0 a R15. Escribe un programa en lenguaje ensamblador que guarde en R1 la operación 2 * R0.
@0
D=M
@4
M=D
@4
D=D+M
@1
M=D

//11. Considera el siguiente programa:
- ¿Qué hace este programa?
- ¿En qué memoria está almacenada la variable i? ¿En qué dirección de esa memoria?
- ¿En qué memoria y en qué dirección de memoria está almacenado el comentario //`i = 1000?`
- ¿Cuál es la primera instrucción del programa anterior? ¿En qué memoria y en qué dirección de memoria está almacenada esa instrucción?
- ¿Qué son CONT y LOOP?
- ¿Cuál es la diferencia entre los símbolos `i` y `CONT`?//
// i = 1000
@1000
D=A
@i
M=D
(LOOP)
// if (i == 0) goto CONT
@i
D=M
@CONT
D;JEQ
// i = i - 1
@i
M=M-1
// goto LOOP
@LOOP
0;JMP
(CONT)

//- Decrementa la variable i desde 1000 hasta 0, y cuando llega a 0, salta a CONT para acabar el bucle.
//- La variable i está almacenada en la RAM, lo que significa que se encuentra en la RAM[16]
//- La primera instrucción es @1000. Esta se ejecuta desde la ROM en la dirección 0.
//- Son etiquetas que marcan puntos específicos en el código. LOOP es el inicio del ciclo, y CONT es el punto al que se salta cuando i == 0.
//- i es una variable almacenada en memoria, mientras que CONT es una etiqueta que define una ubicación en el código.

//12. Implemente en ensamblador:
R4 = R1 + R2 + 69 

@R2
D=M 
@R3 
M=D 
@R2 
D=M 
@3 
D=D+M 
@69 
D=D+A 
@R4 
M=D 

//13. Implementa en ensamblador:
if R0 >= 0 then R1 = 1
else R1 = –1

(LOOP)
goto LOOP

@0 
D=M 
@9 
D;JLT 
@1 
D=A 
@1 
M=D 
@0
0;JMP
@1 
D=A 
@2 
D=D-A 
@1 
M=D 
@0
0;JMP

//14. Implementa en ensamblador:
R4 = RAM[R1]

@R1  
D=M      // Cargar el valor de R1 (dirección de memoria) en D  
A=D      // Apuntar a la dirección almacenada en R1  
D=M      // Cargar en D el valor almacenado en esa dirección  
@R4  
M=D      // Guardar el valor en R4  
// Este código copia el contenido de la posición de memoria indicada en R1 y lo almacena en R4.


//15. Implementa en ensamblador el siguiente problema. En la posición R0 está almacenada la dirección inicial de una región de memoria. 
En la posición R1 está almacenado el tamaño de la región de memoria. Almacena un -1 en esa región de memoria.//

@R1      
D=M       
@R0    
A=M       
M=-1    
@R0    
M=M+1     
D=D-1     
@2       
D;JGT

//Este programa llena un bloque de memoria con -1, comenzando desde la dirección almacenada en R0, y repitiéndose R1 veces.

//16. Implementa en lenguaje ensamblador el siguiente programa:
int[] arr = new int[10];
int sum = 0;
for (int j = 0; j < 10; j++) {
    sum = sum + arr[j];
}

@arr  // Dirección base
D=A

@sum  // Inicializar sum
M=0
@j  // j=0
M=0

(LOOP)
@j
D=M
@10
D=D-A
@END
D;JGE

@arr
A=D+M
D=M
@sum
M=D+M

@j
M=M+1

@LOOP
0;JMP

(END)

//¿Qué hace este programa?
Declara un arreglo de 10 enteros (arr), inicializa sum en 0, recorre el arreglo sumando cada elemento a sum.

//¿Cuál es la dirección base de arr en la memoria RAM?
Almacena variables en RAM a partir de la dirección 16.
arr es un arreglo, por lo que su primera posición en RAM es RAM[16].
EJ: arr[0] en RAM[16], arr[1] en RAM[17]...

//¿Cuál es la dirección base de sum en la memoria RAM y por qué?
como arr[9] (que termina en RAM[25]), la siguiente variable es sum, así que:
sum se almacena en RAM[26]. 

//¿Cuál es la dirección base de j en la memoria RAM y por qué?
j es la última variable en declararse y se almacena después de sum, en RAM[27].


//17. Implementa en lenguaje ensamblador: if ( (D - 7) == 0) goto a la instrucción en ROM[69]

@69
M=A 
@7
D=D-A
@69
D;JEQ
//guarda el dato 69 en la memroria 69, le resta 7 a D y si da 0 salta a la direccion 69

//18. Utiliza esta herramienta para dibujar un bitmap en la pantalla.

@16384 
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

//19. Analiza el siguiente programa en lenguaje de máquina: ¿que hace este programa?
0100000000000000
1110110000010000
0000000000010000
1110001100001000
0110000000000000
1111110000010000
0000000000010011
1110001100000101
0000000000010000
1111110000010000
0100000000000000
1110010011010000
0000000000000100
1110001100000110
0000000000010000
1111110010101000
1110101010001000
0000000000000100
1110101010000111
0000000000010000
1111110000010000
0110000000000000
1110010011010000
0000000000000100
1110001100000011
0000000000010000
1111110000100000
1110111010001000
0000000000010000
1111110111001000
0000000000000100
1110101010000111

@16384   // Dirección de pantalla
D=A      // Asigna el valor 16384 al registro D.

@16     
M=D      // Guarda el valor de D (16384) en la dirección de memoria RAM[16].  

@24576   // KBD = Dirección de teclado
D=M      // Carga en D el valor almacenado en la dirección RAM[24576] (que es la dirección del teclado en Hack).  

@19  
D;JNE    // Si D no es igual a 0 (es decir, si se está presionando una tecla), salta a la línea 19.  

@16  
D=M      // Carga en D el valor de la RAM[16] (que originalmente guardaba 16384).  

@16384  
D=D-A    // Resta D - 16384. Si D es menor o igual a 0, significa que la posición ya está en el límite superior.  

@4  
D;JLE    // Si el resultado de la resta es menor o igual a 0, salta a la línea 4 (probablemente para reiniciar el cursor).  

@16  
AM=M-1   // Resta 1 al valor almacenado en RAM[16] y actualiza tanto A como M.  

M=0      // Escribe 0 en la posición de memoria RAM[16].  

@32  
0;JMP    // Salta incondicionalmente a la línea 32.  

@16  
D=M      // Carga en D el valor de RAM[16].  

@24576  
D=D-A    // Resta el valor de la dirección del teclado (24576) al contenido de RAM[16].  

@4  
D;JGE    // Si D es mayor o igual a 0, salta a la línea 4 (probablemente para manejar otro caso de límite).  

@16  
A=M      // Usa el valor de RAM[16] como dirección de memoria y lo almacena en A.  

M=-1     // Escribe -1 en la dirección de memoria determinada por RAM[16]. Esto probablemente enciende un píxel en la pantalla.  

@16  
#ERR      // Parece un comentario o marcador de error.  

@4  
0;JMP    // Salta incondicionalmente a la línea 4, lo que podría ser para reiniciar el proceso o manejar una condición de error.

// Este programa parece implementar un contador basado en la entrada del teclado, actualizando la pantalla en consecuencia. 
Si se presiona una tecla, probablemente se altere el comportamiento del contador.//

//20. Implementa un programa en lenguaje ensamblador que dibuje el bitmap que diseñaste en la pantalla solo si se presiona la tecla “d”.

@16384   // Cargamos la dirección base de la pantalla
D=A      // Guardamos la dirección en D
@baseDir // Cargamos la dirección de una variable
M=D      // Guardamos el valor de D en baseDir

(LOOP)
    // Leer el teclado
    @24576
    D=M
    @DRAW
    D;JEQ  // Si no hay tecla presionada, saltar al LOOP

    @68   // Código ASCII de 'd'
    D=D-A
    @DRAW
    D;JEQ  // Si la tecla presionada es 'd', dibujar

    @LOOP
    0;JMP  // Repetir

(DRAW)
    @baseDir
    D=M
    @12
    AD=D+A
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

    @LOOP
    0;JMP  // Volver a comprobar la tecla


//Bucle de verificación de tecla: El programa permanece en un bucle verificando si se presionó la tecla "d". Si se presiona, salta a la rutina de dibujado.
Rutina de dibujado: Esta parte del programa es donde se escriben los valores en la memoria de la pantalla para dibujar el bitmap. Las direcciones y valores utilizados deben ajustarse según el diseño específico del bitmap.
Regreso al bucle principal: Después de dibujar, el programa regresa al bucle principal para esperar la próxima interacción del usuario.//










