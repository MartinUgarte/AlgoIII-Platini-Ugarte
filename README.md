# Ejercicio

**01 - Avispas y Abejas**

**Alumnos:** Rocio Platini y Martin Ugarte

**Materia:** Algoritmos y Programación III

## Sobre implementar funcionalidad

>Los tests 01, 02 y 03 demuestran la funcionalidad de cómo se incrementa la cantidad de huevos de avispas a medida que los van dejando. Cuando los implementaste, ¿esos tests pasaron (los tres) de una? ¿podrías haber implementado esta funcionalidad de a partes, haciendo que pase el 01, luego el 01 y el 02 y por último el 01, 02 y 03? ¿se te ocurre cómo? Y si lograste hacerlo, ¿qué pensas de implementar esa funcionalidad de esa forma?

**RTA:** Los test no pasaron a la primera ya que los fuimos probando por partes, es decir, primero nos aseguramos que pase el test 1, luego el test 2, luego probamos nuevamente el 1 (por si este se rompía), y así sucesivamente para garantizar que hasta ese punto el programa funcionara correctamente.

## Sobre código repetido

> ¿les quedó código repetido? ¿dónde? ¿Se animan a adivinar qué cosa del dominio les faltó representar (y por eso tienen código repetido)? Responsabilidad de dejar un huevo consumiendo otro insecto ¿Quién les quedó, en su modelo, que es el responsable de ver si hay suficientes polillas u orugas y entonces dejar un huevo? ¿el insecto (Polly, Oriana, etc) o el hábitat? ¿por qué? ¿por qué tendría sentido que fuera de la otra forma? ¿con cuál nos quedamos?

**RTA:** Al principio nos encontramos con código repetido, por ejemplo, la implementación del método _intentar reproducirse_ era prácticamente similar en cada objeto de Avispa. Esto lo arreglamos haciendo que una avispa sea el padre de las otras, y que esta tenga el método mencionado. De esta manera cada una podrá responder al mensaje asociado al mismo cuando se desea reproducir, y si es necesario se podrá redefinir en caso que haya alguna variante.

Asimismo, nos parece que el responsable de analizar si hay polillas o orugas suficientes es el Hábitat, y no cada avispa. Eso se podría solucionar creando un método que se llame _verificarOrugasSuficientes_ o _verificarPolillasSuficientes_ propio del Hábitat, y que cada avispa simplemente colabore con el Habitat para ver si se puede reproducir o no.

## Sobre codigo repetido 2

> Con lo que vimos en la clase del Jueves (en la parte teórica, prototipos vs clases) ¿cómo sacarían este código? Sobre la implementación ¿cómo resolvieron guardar los huevos? ¿Usaron colecciones? ¿Diccionarios? ¿Uno, varios? ¿con qué indexaban? Pero la pregunta más importante: ¿es lo más sencillo que hacía falta? ¿o se podía hacer menos y todo andaba?

**RTA:** Sobre la implementación, como se mencionó anteriormente, podríamos hacer que una avispa sola sepa responder al mensaje _intentar reproducirse_, y luego que los demás tipos de avispas sean hijas de ella ya que cumplen las mismas funcionalidades pero con algunas leves diferencias.

En cuanto a los diccionarios, implementamos uno que como clave tenga el nombre de cada avispa del Hábitat y como valor la cantidad de huevos asignada. De esta manera tendríamos la información más organizada, pudiendo acceder facilmente a la cantidad total de huevos sumando todos los valores del diccionario. Un ejemplo de diccionario sería:

```python
huevosDeAvispa = 
{
    Ornella: 4,
    Oriana: 2,
    Polly: 3,
    Lara: 1
}
```

Cuando Lara intenta reproducirse y hay huevos disponibles, se puede acceder fácilmente al valor de la cantidad de huevos con firma de Ornella y Oriana, preguntar si tienen, y en caso afirmativo decrementarlo en uno e incrementar la cantidad de huevos con firma de Lara.
