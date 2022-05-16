# Ejercicio

**04** - Stack

**Alumnos:** Rocio Platini y Martin Ugarte

**Materia:** Algoritmos y Programación III

## Extra
> Se pide extender el modelo para que además de representar al stack ilimitado ya construido, se puedan construir instancias de un stack limitado. Es decir, uno de que tenga una cantidad limitada de celdas y que no se puedan pushear más elementos que los disponibles en su capacidad. Analizar cuál de los modelos anteriores cree que es más sencillo extender para representarla y hacerlo.

**RTA:** Es más sencillo partir del modelo del stack ilimitado para construir el limitado ya que este último tiene un comportamiento practicamente igual al del primero, excepto cuando se quiere agregar un elemento y el stack está lleno. Entonces una vez modelado el stack ilimitado, solo se debería subclasificar al Stack en StackLimitado y StackIlimitado. De esta forma, ambos heredan varios mensajes como top y pop, y solo se implementa push de manera particular en cada subclase. Si fuera al reves, es decir, pasar del stack limitado al ilimitado, habría que eliminar el colaborador interno de capacidad del stack y los mensajes exclusivos del mismo, debido a que el stack ilimitado no debería tener esas responsabilidades.