**Actividad 5**
--------

- ¿Cuál es la definición de un puntero?

Un puntero es una variable que almacena la dirección de memoria de otra variable u objeto, permitiendo acceder y modificar el contenido de dicha dirección.

--------

- ¿Dónde está el puntero?

Los punteros están en:

```
vector<Sphere*> spheres;
Sphere* selectedSphere;
```

**vector<Sphere> spheres;** :Es un vector de punteros a objetos Sphere, almacenando direcciones de esferas creadas dinámicamente.
**Sphere selectedSphere;** :Es un puntero que apunta a la esfera seleccionada con el mouse.

---------

- ¿Cómo se inicializa el puntero?
  
**selectedSphere** se inicializa en **setup()** como **nullptr**, indicando que no hay ninguna esfera seleccionada
```
selectedSphere = nullptr;
```

En **mousePressed()**, si el usuario hace clic en una esfera, el puntero apunta a esa esfera
```
selectedSphere = sphere;

```

--------

¿Para qué se está usando el puntero?

-**spheres**: almacena las direcciones de las esferas creadas dinámicamente.

**selectedSphere**: se usa para rastrear la esfera seleccionada y moverla con el ratón en update().

--------

¿Qué es exactamente lo que está almacenado en el puntero?

-**spheres**: almacena direcciones de memoria de objetos Sphere creados con new Sphere(...).

**selectedSphere**: contiene la dirección de la esfera actualmente seleccionada, o nullptr si ninguna está seleccionada.

--------

**Actividad 6**
--------
- El código anterior tiene un problema. ¿Puedes identificar cuál es? ¿Cómo lo solucionarías? Recuerda que deberías poder seleccionar una esfera y moverla con el mouse.

Cuando se hace clic en una esfera, se guarda un puntero de esa esfera y luego la esfera seleccionada siempre sigue al mouse.
Pero nunca hay una condición para "soltarla" cuando se deja de presionar.

Necesitamos agregar una función *mouseReleased()* que se llame cuando el usuario suelte el botón del mouse.
```
void mouseReleased(int x, int y, int button);
```
Esto declara la función en el encabezado para que podamos definirla en ofApp.cpp.

Y definimos en ofApp.cpp
```
void ofApp::mouseReleased(int x, int y, int button) {
    if (button == OF_MOUSE_BUTTON_LEFT) {
        selectedSphere = nullptr;  // Se suelta la esfera cuando el usuario deja de hacer clic
    }
}
```
Si el usuario suelta el botón izquierdo del mouse, selectedSphere se borra (nullptr).
Esto significa que la esfera ya no seguirá al mouse en update().
































