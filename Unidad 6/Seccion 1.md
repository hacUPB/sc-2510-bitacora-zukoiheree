**Seccion 1**
---
### **Factory Method**

El *Factory Method* es un patrón creacional que permite delegar la creación de objetos a una clase especializada, evitando así usar directamente el operador `new` por todas partes. Esto permite instanciar diferentes objetos sin acoplar el código a clases concretas.

**En el codigo:**
La clase `ParticleFactory` tiene un método estático `createParticle(string type)` que genera diferentes tipos de partículas (`star`, `shooting_star`, `planet`, etc.) con distintas propiedades como tamaño, color y velocidad. Si más adelante quisieras agregar nuevos tipos de partículas, lo harías allí, sin tener que modificar la lógica de la aplicación principal (`ofApp`).


### **Observer**

El patrón *Observer* define una relación en la que un objeto (el *sujeto*) notifica automáticamente a otros objetos (*observadores*) sobre cambios de estado o eventos. Se utiliza cuando múltiples objetos deben reaccionar ante un mismo suceso sin que estén fuertemente acoplados entre sí.

**En el codigo:**
La clase `ofApp` actúa como *Subject*. Las partículas (`Particle`) son *Observers*. Cuando presionas una tecla (por ejemplo, `'a'` o `'s'`), `ofApp` envía un evento (`notify("attract")` o `notify("stop")`) a todos los observadores registrados. Cada partícula reacciona cambiando su estado interno.


### **State**

El patrón *State* permite que un objeto cambie su comportamiento en tiempo de ejecución según su estado interno. En vez de usar condicionales largos (`if` o `switch`), el comportamiento se delega a objetos que representan cada estado.

**En el codigo:**
Cada `Particle` tiene un puntero a un objeto de tipo `State`. Al cambiar el estado (por ejemplo, a `AttractState`, `RepelState`, `StopState` o `WobbleState`), cambia completamente la lógica de movimiento de esa partícula sin tener que alterar directamente su clase. Esto hace el código más flexible, extensible y limpio.


