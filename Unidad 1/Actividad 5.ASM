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
//- La variable i está almacenada en la RAM. La dirección exacta no se especifica, pero probablemente sea a partir de la dirección 16 en adelante.
//- @0, @1, @2 y @3
//- La primera instrucción es @1000. Esta se ejecuta desde la ROM en la dirección 0.
//- Son etiquetas que marcan puntos específicos en el código. LOOP es el inicio del ciclo, y CONT es el punto al que se salta cuando i == 0.
//- i es una variable almacenada en memoria, mientras que CONT es una etiqueta que define una ubicación en el código.

//12. Implemente en ensamblador:
R4 = R1 + R2 + 69 

@2
D=M 
@3 
M=D 
@2 
D=M 
@3 
D=D+M 
@69 
D=D+A 
@4 
M=D 
(@4 es R4, @2 es R2  y @1 es R1)

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
D=M
@R4 
M=D        

//15. Implementa en ensamblador el siguiente problema. En la posición R0 está almacenada la dirección inicial de una región de memoria. 
En la posición R1 está almacenado el tamaño de la región de memoria. Almacena un -1 en esa región de memoria.//

@R1       // Cargar en D el valor almacenado en la dirección R1 (tamaño de la región de memoria)
D=M       
@R0       // Apuntar a la dirección inicial de la región de memoria
A=M       
M=-1      // Almacenar -1 en la dirección actual de memoria
@R0       // Incrementar la dirección en R0 para apuntar a la siguiente posición
M=M+1     
D=D-1     // Decrementar el contador D (tamaño restante)
@2        // Si D aún es mayor que 0, repetir el proceso
D;JGT

//16. Implementa en lenguaje ensamblador el siguiente programa:
int[] arr = new int[10];
int sum = 0;
for (int j = 0; j < 10; j++) {
    sum = sum + arr[j];
}

//17. Implementa en lenguaje ensamblador: if ( (D - 7) == 0) goto a la instrucción en ROM[69]

@69
M=A 
@7
D=D-A
@69
D;JEQ

//18. Utiliza esta herramienta para dibujar un bitmap en la pantalla.

function void draw(int location) {
	var int memAddress; 
	let memAddress = 16384+location;
	// column 0
	do Memory.poke(memAddress, 2);
	do Memory.poke(memAddress +32, 519);
	do Memory.poke(memAddress +64, 258);
	do Memory.poke(memAddress +96, 14496);
	do Memory.poke(memAddress +128, 17582);
	do Memory.poke(memAddress +160, 17585);
	do Memory.poke(memAddress +192, 16545);
	do Memory.poke(memAddress +224, 8357);
	do Memory.poke(memAddress +256, 4258);
	do Memory.poke(memAddress +288, 2217);
	do Memory.poke(memAddress +320, 1206);
	do Memory.poke(memAddress +352, 256);
	do Memory.poke(memAddress +384, 512);
	// column 1
	do Memory.poke(memAddress +1, 16384);
	do Memory.poke(memAddress +33, 256);
	do Memory.poke(memAddress +65, -7646);
	do Memory.poke(memAddress +97, 5185);
	do Memory.poke(memAddress +129, 5140);
	do Memory.poke(memAddress +161, 1032);
	do Memory.poke(memAddress +193, -31744);
	do Memory.poke(memAddress +225, 17408);
	do Memory.poke(memAddress +257, 9216);
	do Memory.poke(memAddress +289, 5120);
	do Memory.poke(memAddress +321, 1024);
	do Memory.poke(memAddress +353, 512);
	do Memory.poke(memAddress +385, 256);
	// column 2
	do Memory.poke(memAddress +34, 8);
	do Memory.poke(memAddress +66, 20);
	do Memory.poke(memAddress +98, 9);
	do Memory.poke(memAddress +130, 1);
	do Memory.poke(memAddress +162, 1);
	return;
}

//19. Analiza el siguiente programa en lenguaje de máquina: ¿que hace este programa?

@16384        // 0100000000000000  - Cargar la dirección base de la pantalla en A
D=A           // 1110110000010000  - Guardar en D
@16           // 0000000000010000  - Cargar 16 en A
M=D           // 1110001100001000  - Guardar D en la dirección 16

@24576        // 0110000000000000  - Cargar 24576 (teclado) en A
D=M           // 1111110000010000  - Leer valor del teclado y guardar en D
@19           // 0000000000010011  - Cargar 19 en A
D;JEQ         // 1110001100000101  - Si D == 0, saltar a la instrucción en 19

@16           // 0000000000010000  - Cargar 16 en A
D=M           // 1111110000010000  - Leer el valor de la dirección 16
@16384        // 0100000000000000  - Cargar la dirección base de la pantalla
M=D           // 1110010011010000  - Escribir el valor en la pantalla

@4            // 0000000000000100  - Cargar 4 en A
D;JLT         // 1110001100000110  - Si D < 0, saltar a la instrucción en 4

@16           // 0000000000010000  - Cargar 16 en A
M=M+1         // 1111110010101000  - Incrementar el valor en la dirección 16

D=0           // 1110101010001000  - D = 0
@4            // 0000000000000100  - Cargar 4 en A
D;JGT         // 1110101010000111  - Si D > 0, saltar a la instrucción en 4

@16           // 0000000000010000  - Cargar 16 en A
D=M           // 1111110000010000  - Leer el valor de la dirección 16

@24576        // 0110000000000000  - Cargar 24576 (teclado) en A
M=D           // 1110010011010000  - Guardar el valor en la dirección 24576 (teclado)

@4            // 0000000000000100  - Cargar 4 en A
D;JLE         // 1110001100000011  - Si D <= 0, saltar a la instrucción en 4

@16           // 0000000000010000  - Cargar 16 en A
M=M-1         // 1111110000100000  - Decrementar el valor en la dirección 16

D=M           // 1110111010001000  - Guardar en D el valor de la dirección 16

@16           // 0000000000010000  - Cargar 16 en A
M=M-1         // 1111110111001000  - Decrementar nuevamente el valor en la dirección 16

@4            // 0000000000000100  - Cargar 4 en A
D;JGT         // 1110101010000111  - Si D > 0, saltar a la instrucción en 4

// Este programa parece implementar un contador basado en la entrada del teclado, actualizando la pantalla en consecuencia. 
Si se presiona una tecla, probablemente se altere el comportamiento del contador.//

//20. Implementa un programa en lenguaje ensamblador que dibuje el bitmap que diseñaste en la pantalla solo si se presiona la tecla “d”.

// Programa en ensamblador de nand2tetris para dibujar un bitmap al presionar 'd'

@24576       // Dirección del teclado
D=M          // Leer entrada del teclado
@DRAW        // Si se presionó 'd' (valor 68 en ASCII), saltar a dibujar
D;JEQ
@END         // Si no, finalizar
0;JMP

(DRAW)
@R0          // Dirección base de la pantalla
D=M
@16384       // Dirección inicial de la pantalla
D=D+A
@ADDR        // Guardar en ADDR
M=D

// Dibujar columna 0
@ADDR
D=M
@2
M=D          // Poke(memAddress, 2)
@32
D=D+A
@519
M=D          // Poke(memAddress +32, 519)
@64
D=D+A
@258
M=D          // Poke(memAddress +64, 258)
@96
D=D+A
@14496
M=D          // Poke(memAddress +96, 14496)
@128
D=D+A
@17582
M=D          // Poke(memAddress +128, 17582)
@160
D=D+A
@17585
M=D          // Poke(memAddress +160, 17585)
@192
D=D+A
@16545
M=D          // Poke(memAddress +192, 16545)
@224
D=D+A
@8357
M=D          // Poke(memAddress +224, 8357)
@256
D=D+A
@4258
M=D          // Poke(memAddress +256, 4258)
@288
D=D+A
@2217
M=D          // Poke(memAddress +288, 2217)
@320
D=D+A
@1206
M=D          // Poke(memAddress +320, 1206)
@352
D=D+A
@256
M=D          // Poke(memAddress +352, 256)
@384
D=D+A
@512
M=D          // Poke(memAddress +384, 512)

// Dibujar columna 1
@ADDR
D=M+1
@16384
M=D          // Poke(memAddress +1, 16384)
@33
D=D+A
@256
M=D          // Poke(memAddress +33, 256)
@65
D=D+A
@-7646
M=D          // Poke(memAddress +65, -7646)
@97
D=D+A
@5185
M=D          // Poke(memAddress +97, 5185)
@129
D=D+A
@5140
M=D          // Poke(memAddress +129, 5140)
@161
D=D+A
@1032
M=D          // Poke(memAddress +161, 1032)
@193
D=D+A
@-31744
M=D          // Poke(memAddress +193, -31744)
@225
D=D+A
@17408
M=D          // Poke(memAddress +225, 17408)
@257
D=D+A
@9216
M=D          // Poke(memAddress +257, 9216)
@289
D=D+A
@5120
M=D          // Poke(memAddress +289, 5120)
@321
D=D+A
@1024
M=D          // Poke(memAddress +321, 1024)
@353
D=D+A
@512
M=D          // Poke(memAddress +353, 512)
@385
D=D+A
@256
M=D          // Poke(memAddress +385, 256)

// Dibujar columna 2
@ADDR
D=M+34
@8
M=D          // Poke(memAddress +34, 8)
@66
D=D+A
@20
M=D          // Poke(memAddress +66, 20)
@98
D=D+A
@9
M=D          // Poke(memAddress +98, 9)
@130
D=D+A
@1
M=D          // Poke(memAddress +130, 1)
@162
D=D+A
@1
M=D          // Poke(memAddress +162, 1)

(END)
@END
0;JMP        // Bucle infinito

// Variables
(ADDR)
@0        // Dirección base del bitmap






