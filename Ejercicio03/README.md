# Ejercicio

## 03 - Números

**Alumnos:** Rocio Platini y Martin Ugarte

**Materia:** Algoritmos y Programación III

## Aporte de los mensajes de DD
> En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?

**RTA:** Al utilizar dos métodos con el mismo nombre, se logra obtener un comportamiento diferente para cada tipo de número en particular. Por ejemplo el método beAddedToAnInteger permite sumar un entero a otro entero o a una fracción dependiendo la subclase que llame a ese método.

## Lógica de instanciado
> Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?

**RTA:** La lógica de cómo instanciar un objeto debería ser responsabilidad de cada subclase. Cada una de ellas debe saber como instanciarse a si misma. En este ejercicio, el encargado de crear instancias de Entero es la clase Entero, y lo mismo pasa con las fracciones.

## Nombres de las categorías de métodos
> Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

**RTA:** Para categorizar métodos se suele utilizar el criterio privado/público. Los métodos que son privados tienen acceso a los colaboradores internos y la implementación de la lógica de la clase, mientras que los públicos no. 

## Subclass Responsibility
> Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

**RTA:** Básicamente el método que lleva self subclassResposability tiene el mismo propósito en todas las subclases pero está implementado de una forma diferente en cada una. De esa forma la superclase "delega" la responsabilidad a las mismas.

## No rompas
> ¿Por qué está mal/qué problemas trae romper encapsulamiento?

**RTA:** Los objetos no deberían exponer sus colaboradores internos. Esto rompe la encapsulación, lo que resulta en complicaciones a la hora de mantener el código. Si todos los objetos exponen los colaboradores, todos empezarían a "hablar" con todos, lo que resulta en un alto acoplamiento. Asimismo, al usar muchos getters y setters, es probable que dejemos de seguir el paradigma de orientación a objetos.