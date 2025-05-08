Sesión 2: ubicación en memoria de datos y métodos
---
### - ¿Dónde se almacenan los datos y métodos de una clase en C++?

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


### **- ¿Qué es una VTable y cómo se relaciona con los métodos virtuales?**

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

### - ¿Cómo se implementan los métodos virtuales en C++?

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

### - ¿Cómo afecta esto al tamaño del objeto?
- La presencia de al menos un método virtual **agrega un puntero extra (vptr)** al objeto.
- En una arquitectura de 64 bits, ese puntero suele ocupar **8 bytes**.
- Si comparas:
- 
  ```cpp
  class SinVirtual { int a; };
  class ConVirtual { virtual void f(); int a; };
  ```
  `sizeof(SinVirtual)` puede ser 4, mientras que `sizeof(ConVirtual)` será 8 o más, por el `vptr`.

### - ¿Qué papel juegan las vtables en el polimorfismo?
- Permiten que una función miembro pueda comportarse de manera diferente **dependiendo del objeto real** que la invoque.
- Sin vtable, C++ no podría hacer **resolución dinámica** (run-time dispatch), y todas las llamadas serían resueltas en **tiempo de compilación** (como en funciones no virtuales).

### - ¿Cómo se implementan los métodos virtuales en C++?
Cuando declaras un método como virtual en una clase, el compilador implementa el polimorfismo dinámico mediante una vtable (virtual table).

---
### **Uso de punteros y referencias**

### - ¿Qué está pasando?
- `funcPtr` es un **puntero a función global o estática** que no depende de un objeto.
- `staticFunction` es una función estática: no accede a miembros del objeto ni usa `this`.
- `assignFunction` asigna el puntero.

### Impacto en la memoria

- Tamaño del objeto (`sizeof(FunctionPointerExample)`)
  - **`funcPtr`** es el único miembro **no estático**.
  - Este puntero ocupa típicamente 8 bytes en sistemas de 64 bits.
  - Los métodos, como `staticFunction()` y `assignFunction()`, **no afectan directamente el tamaño** del objeto: residen en la **sección de código** del ejecutable, compartida por todas las instancias.

- ¿Dónde se almacena el puntero?
  - `funcPtr` se almacena dentro del objeto en el **stack o heap**, dependiendo de cómo se instancie el objeto.
  - El contenido del puntero apunta a la **sección de código**, donde vive `staticFunction`.

### - ¿Cuál es la relación entre punteros a métodos y la `vtable`?

- Si un método es `virtual`, C++ crea una **tabla virtual (vtable)**.
- Cada instancia tiene un **puntero a vtable (vptr)** que se guarda como parte oculta del objeto.
- Cuando se llama un método virtual, el programa:
  1. Usa el vptr para encontrar la vtable.
  2. Busca la dirección del método en esa tabla.
  3. Lo invoca.

**Punteros a funciones no virtuales** (como `funcPtr`) no interactúan con la vtable. Son llamados directamente.

### - ¿Cómo afectan estos mecanismos al rendimiento?

| Mecanismo                         | Llamada directa | Rendimiento | Flexibilidad |
|----------------------------------|-----------------|-------------|--------------|
| Puntero a función estática       | Si es directa   |   Rápido   |  No accede a atributos |
| Puntero a método miembro         |  (usa `this`)  |   Más lento |  Accede a atributos |
| Método virtual (con vtable)      |  (resuelve en tiempo de ejecución) |  Lento |  Polimorfismo dinámico |

- El **tiempo de ejecución** se incrementa cuando se debe **resolver contexto (`this`)** o hacer **búsquedas en vtables**.
- **Punteros a funciones** son los más rápidos, pero también los menos flexibles.

**Conclusión técnica**
- Punteros a funciones: ocupan espacio en cada objeto si se declaran como miembros. Son simples y rápidos.
- Punteros a métodos miembro: permiten llamar métodos específicos de una instancia, pero requieren más pasos.
- Métodos virtuales: requieren vtables y son esenciales para el polimorfismo, pero añaden una ligera sobrecarga de memoria y rendimiento.

---
### **Reflexión Individual**

#### 1. ¿Dónde residen los datos y métodos de una clase en la memoria?

Los distintos componentes de una clase se almacenan en **regiones separadas** de la memoria:

- **Datos no estáticos (atributos):**  
  Se almacenan en la memoria **del objeto**, que puede estar en el **stack** (si la instancia es automática) o en el **heap** (si se usa `new`). Cada objeto tiene su propia copia.

- **Datos estáticos:**  
  Se almacenan en la **zona de datos estáticos/globales**, una región que existe durante toda la ejecución del programa. Hay **una sola copia**, compartida por todas las instancias.

- **Métodos (funciones miembro):**  
  Residen en la **sección de código** del ejecutable (también llamada **text segment**). Esta es una zona de memoria **compartida**, no se copia por cada instancia.

- **Tabla de métodos virtuales (vtable):**  
  Si la clase tiene métodos `virtual`, cada instancia contiene un **puntero oculto (vptr)** que apunta a una vtable.  
  La **vtable** está ubicada en la memoria global o de texto, y contiene **punteros a funciones** para implementar el **polimorfismo dinámico**.

#### 2. ¿Cómo interactúan las diferentes partes en tiempo de ejecución?

- Cuando se accede a un **atributo**, se usa la dirección base del objeto (`this`) y se suma un offset para ubicarlo.
- Al llamar un **método no virtual**, el compilador inserta una llamada directa a su dirección en la sección de código.
- Para un **método virtual**, el compilador:
  1. Accede al `vptr` del objeto.
  2. Usa ese puntero para buscar en la `vtable` el método correspondiente.
  3. Realiza una llamada indirecta.

Esta arquitectura permite que:
- Cada objeto pueda comportarse de manera diferente, incluso bajo un mismo tipo base.
- El sistema sea **modular**, **flexible** y capaz de **extenderse sin modificar código existente** (principio abierto/cerrado).

#### 3. Conclusión: ¿Cómo esta comprensión afecta el diseño de sistemas?

Entender **cómo y dónde se almacenan los componentes de una clase** es crucial para diseñar software eficiente y seguro:

- **Diseño eficiente:**  
  Saber qué ocupa memoria en cada instancia evita sobrecargar objetos con datos innecesarios (ej. uso excesivo de variables no estáticas).

- **Seguridad y estabilidad:**  
  Comprender la vida útil del `heap` y del `stack` ayuda a evitar fugas de memoria y errores como `use-after-free`.

- **Polimorfismo bien usado:**  
  Usar virtuales solo donde se necesita, ya que generan sobrecarga de memoria y rendimiento (vptr + llamadas indirectas).

- **Arquitectura clara:**  
  Diferenciar bien lo **compartido (estático)** de lo **específico (no estático)** permite un diseño coherente y mantenible.



