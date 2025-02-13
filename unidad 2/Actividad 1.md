**Actividad 1**

- ¿Qué es la entrada-salida mapeada a memoria?

R// Es una técnica donde los dispositivos de E/S se acceden como si fueran ubicaciones de memoria.

- ¿Cómo se implementa en la plataforma Hack?

R// En la plataforma Hack, la MMIO se implementa asignando direcciones específicas de memoria a dos dispositivos de E/S:
Pantalla: Se mapea un bloque de memoria a la pantalla. Escribir valores en estas direcciones de memoria modifica los píxeles mostrados en la pantalla.
Teclado: Una única dirección de memoria se mapea al teclado. Leer de esta dirección devuelve el código ASCII de la tecla que se ha presionado más recientemente. Si no se ha presionado ninguna tecla, devuelve 0.

- Inventa un programa que haga uso de la entrada-salida mapeada a memoria.
- Investiga el funcionamiento del programa con el simulador.
