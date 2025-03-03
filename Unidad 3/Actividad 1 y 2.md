**Actividad 1**
- ¿Cuál es el resultado que se obtiene al ejecutar este programa?
Se obtiene un puntero

**Actividad 2**
- ¿Qué incluimos en el archivo .h?

Declaración de la clase *ofApp* con métodos públicos (*setup()*, *update()*, *draw()*, *mouseMoved()*, *mousePressed()*) y variables privadas (*particles*, *particleColor*).

- ¿Cómo funciona la aplicación?

La aplicación crea una ventana gráfica donde se pueden agregar partículas al mover el ratón. El color de las partículas cambia al presionar un botón del ratón.

- ¿Qué hace la función mouseMoved?

Agrega una partícula en la posición actual del ratón y elimina la primera partícula si supera el límite de 100 partículas.

- ¿Qué hace la función mousePressed?

Cambia el color de las partículas a un color aleatorio.

- ¿Qué hace la función setup?

Configura el fondo de la ventana a negro y establece el color inicial de las partículas en blanco.

- ¿Qué hace la función update?

Actualmente no realiza nada, pero se puede usar para actualizar el estado de la aplicación.

- ¿Qué hace la función draw?

Dibuja cada partícula almacenada como un círculo en la pantalla.
