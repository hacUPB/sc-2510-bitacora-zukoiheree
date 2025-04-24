Sesión 2: ubicación en memoria de datos y métodos
---
### **¿Dónde se almacenan los datos y métodos de una clase en C++?**

#### 1. **Atributos (datos de instancia)**
- **Stack**: si creas un objeto así `MiClase obj;`, sus atributos (como `int a`, `float x`) se almacenan en el **stack**.
- **Heap**: si usas `MiClase* obj = new MiClase();`, el objeto completo (atributos incluidos) vive en el **heap**.
- En ambos casos, los **atributos no estáticos** son parte del objeto, y ocupan espacio *por cada instancia*.

#### 2. **Datos estáticos**
- Son compartidos por todas las instancias.
- Se almacenan en la **zona de datos estáticos** o **global**, no en el stack ni en el heap, y no afectan el tamaño del objeto.

#### 3. **Métodos**
- El código de los métodos (funciones miembro) reside en la **sección de código (text segment)** del programa.
- Esta sección es **única** y **compartida** por todas las instancias. No se copia en cada objeto.


### **¿Qué es una VTable y cómo se relaciona con los métodos virtuales?**

#### VTable (Virtual Table)
- Es una **estructura interna** generada automáticamente por el compilador cuando una clase tiene al menos un **método virtual**.
- Contiene **punteros a las funciones virtuales** de la clase.
- Permite implementar **polimorfismo dinámico**: decidir en tiempo de ejecución qué versión del método se debe ejecutar, dependiendo del tipo real del objeto.

#### Cómo funciona:
- Cada instancia de una clase con métodos virtuales guarda un **puntero oculto** llamado **vptr** (virtual pointer), que apunta a su **vtable**.
- Cuando llamas a un método virtual, el compilador usa el **vptr** para buscar en la **vtable** la dirección de la función que debe ejecutarse.
- Esto hace posible que un puntero de tipo base (`Base*`) pueda invocar correctamente un método sobrescrito en una subclase (`Derived`).

El compilador usará el **vptr** de `b` para acceder a la función correcta (la de `Derived`), incluso si `b` es de tipo `Base*`.

---
### **Exploración de métodos virtuales**

Excelente, estás tocando uno de los puntos más fascinantes del funcionamiento interno del polimorfismo en C++. Vamos paso a paso para desentrañar lo que realmente ocurre “bajo el capó” con las **vtable**, los **métodos virtuales**, y cómo esto impacta el rendimiento y la memoria:

---

### **¿Cómo se implementan los métodos virtuales en C++?**

Cuando declaras un método como `virtual` en una clase, el compilador implementa el polimorfismo dinámico mediante una **vtable** (*virtual table*). Veamos cómo:

### ¿Dónde está la vtable en memoria?

- La **vtable** en sí reside en la **zona de datos del programa** (global o estática).
- Cada objeto de una clase con métodos virtuales tiene un **puntero oculto**, llamado comúnmente `vptr`, que apunta a la vtable correspondiente a su tipo.
- Este `vptr` está **dentro del objeto**, típicamente como el primer campo (aunque no lo ves directamente).
- Por eso, cuando haces:  

   ```cpp
  Base* b = new Derived();
  b->display();  // Se resuelve en tiempo de ejecución
  ```
  …el programa usa el `vptr` del objeto apuntado por `b` para acceder a la función correcta (la de `Derived`).

---

### ¿Cómo afecta esto al tamaño del objeto?

- La presencia de al menos un método virtual **agrega un puntero extra (vptr)** al objeto.
- En una arquitectura de 64 bits, ese puntero suele ocupar **8 bytes**.
- Si comparas:
  ```cpp
  class SinVirtual { int a; };
  class ConVirtual { virtual void f(); int a; };
  ```
  `sizeof(SinVirtual)` puede ser 4, mientras que `sizeof(ConVirtual)` será 8 o más, por el `vptr`.

---

### ¿Qué papel juegan las vtables en el polimorfismo?

- Permiten que una función miembro pueda comportarse de manera diferente **dependiendo del objeto real** que la invoque.
- Sin vtable, C++ no podría hacer **resolución dinámica** (run-time dispatch), y todas las llamadas serían resueltas en **tiempo de compilación** (como en funciones no virtuales).

### ¿Cómo se implementan los métodos virtuales en C++?
Cuando declaras un método como virtual en una clase, el compilador implementa el polimorfismo dinámico mediante una vtable (virtual table).

---
### **Uso de punteros y referencias**

