# SuperCollider — Módulo 1, Sesión 2: Generar material musical
## Arrays, funciones, aleatoriedad e iteración

> **Módulo 1 — Componer con código: introducción a la música algorítmica con SuperCollider**

---

## 🎯 Objetivos de la Sesión

Al finalizar esta sesión, serás capaz de:

- ✅ Crear y manipular arrays como contenedores de material musical
- ✅ Construir funciones reutilizables con argumentos y valores por defecto
- ✅ Usar la aleatoriedad de forma controlada (`rrand`, `exprand`, `scramble`)
- ✅ Recorrer colecciones con `do` y `collect`
- ✅ Construir `~makeNotes`: una función que genera acordes en cualquier tonalidad

---

## 📚 Estructura de la Sesión

### 1. Arrays — 30 min
### 2. Funciones — 30 min
### 3. Aleatoriedad e iteración — 25 min
### 4. Ejercicio musical: `~makeNotes` — 25 min *(en directo con el grupo)*

---

# 1. Arrays y Estructuras de Datos

## 1.1 ¿Qué es un Array?

Un **array** es una **colección ordenada de cosas**.

```supercollider
x = [2, -5, 7, 11];     // Array de números
```

En música, los arrays son ideales para:
- un conjunto de alturas (pitch set)
- valores métricos (duraciones)
- secuencias de parámetros

En lugar de crear 10 variables distintas, las agrupas en un array.

## 1.2 Operaciones básicas

```supercollider
x.size        // → 4 (número de elementos)
x.reverse     // → [11, 7, -5, 2] (invierte orden)
x.scramble    // → mezcla aleatoriamente
x.choose      // → un elemento aleatorio
```

## 1.3 Índices (empiezan en 0)

```supercollider
x[0]           // → 2 (primer elemento)
x[3]           // → 11 (cuarto elemento)
x.at(3)        // equivalente a x[3]
x.first        // → 2
x.last         // → 11
```

## 1.4 Crear arrays rápidamente

### Rangos
```supercollider
(1..10)        // → [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
(1, 3..9)      // → [1, 3, 5, 7, 9] (de 2 en 2)
```

### Array.series
```supercollider
Array.series(8, 60, 2);
// 8 elementos, empieza en 60, incremento de 2
// → [60, 62, 64, 66, 68, 70, 72, 74]
```

### Array.fill
```supercollider
Array.fill(8, { |i| 60 + (i * 2) });
// equivalente al anterior usando una función
```

## 1.5 Los arrays pueden mezclar tipos

```supercollider
x = [2, -5, \foo, nil, false, "bee"];  // Válido en SC
```

## 1.6 Métodos útiles para música

```supercollider
x.keep(4)         // → mantiene los primeros 4 elementos
x.drop(2)         // → descarta los 2 primeros
x.select { |n| n > 0 }   // → solo los positivos
x.reject { |n| n > 0 }   // → solo los no-positivos
x.mirror          // → [1,2,3,4,3,2,1] (espejo)
x.rotate(1)       // → rota los elementos
x + 3             // → suma 3 a cada elemento
```

---

# 2. Funciones

## 2.1 ¿Qué es una función?

Una **función** es una **unidad reutilizable de código**: la encapsulas una vez y la ejecutas cuando y donde quieras.

```supercollider
x = {
    var num;
    num = 8;
    num = num.squared;
    num = num - 1;
};  // → devuelve "Function" (aún no se ejecuta)
```

### Ejecutar la función

```supercollider
x.value;    // → 63
x.();       // atajo equivalente
```

## 2.2 Funciones con argumentos

```supercollider
x = { |num|
    num = num.squared;
    num = num - 1;
};

x.value(6);    // → 35
x.(6);         // atajo equivalente
```

### Valores por defecto

```supercollider
x = { |num = 0|
    num = num.squared;
    num = num - 1;
};

x.();      // → -1 (usa valor por defecto 0)
x.(5);     // → 24
```

## 2.3 Dos sintaxis para argumentos

```supercollider
{ |num| ... }       // Forma 1: pipes (más común)
{ arg num; ... }    // Forma 2: palabra reservada arg
```

Ambas son equivalentes. Usa la que te resulte más legible.

## 2.4 Cuándo usar una función

> *Si te descubres copiando y pegando el mismo código una y otra vez… para y escribe una función.*

---

# 3. Aleatoriedad e Iteración

## 3.1 `rrand` — aleatorio uniforme

```supercollider
rrand(1, 10);        // entero entre 1 y 10
rrand(0.1, 0.9);     // float entre 0.1 y 0.9
```

## 3.2 `exprand` — aleatorio exponencial

```supercollider
exprand(100, 800);   // más probable cerca de 100
```

Útil para frecuencias y amplitudes, porque el oído percibe de forma logarítmica.

## 3.3 Trampa con `dup`

```supercollider
rrand(1, 10).dup(8)     // ❌ repite UN número 8 veces
{ rrand(1, 10) }.dup(8) // ✅ genera 8 números distintos
```

## 3.4 `do` — iterar sin devolver

```supercollider
[60, 62, 64, 67].do { |nota, i|
    ("Nota " ++ i ++ ": " ++ nota).postln;
};
```

## 3.5 `collect` — iterar y transformar

```supercollider
[0, 2, 4, 5, 7, 9, 11].collect { |item|
    item + rrand(0, 1)    // transpone cada nota un semitono aleatorio
};
```

A diferencia de `do`, `collect` **devuelve un nuevo array** con los resultados.

---

# 4. Ejercicio Musical: `~makeNotes`

Vamos a construir juntos una función que genera un conjunto de notas diatónicas en cualquier tonalidad.

## Diseño antes de programar

- **Entrada:** `root` (raíz en semitonos, 0 = Do), `numNotes` (cuántas notas queremos)
- **Salida:** array de notas MIDI

## Implementación

```supercollider
(
~makeNotes = { |root = 0, numNotes = 4|
    var scale, notes;

    // Escala mayor en semitonos desde la tónica
    scale = [0, 2, 4, 5, 7, 9, 11];

    // Transponer a la raíz elegida
    scale = scale + root;

    // Mezclar y quedarnos con numNotes notas
    notes = scale.scramble.keep(numNotes);

    notes;
};
)
```

## Usos

```supercollider
~makeNotes.();           // Do mayor, 4 notas
~makeNotes.(5, 6);       // Fa mayor, 6 notas
~makeNotes.(3, 3);       // Mi♭ mayor, 3 notas
~makeNotes.(9, 5);       // La mayor, 5 notas
```

## Convertir a nombres de nota

```supercollider
~makeNotes.(0, 4).collect { |n| n.midiname };
```

---

# 5. Errores Comunes

## Error 1: `dup` con aleatoriedad

```supercollider
rrand(1, 10).dup(8)     // ❌ 8 copias del mismo número
{ rrand(1, 10) }.dup(8) // ✅ 8 números distintos
```

## Error 2: calcular vs. guardar

```supercollider
z.scramble.keep(4);     // calcula pero NO guarda
z = z.scramble.keep(4); // ✅ guarda el resultado en z
```

## Error 3: `collect` vs. `do`

```supercollider
x.do { |n| n * 2 }      // procesa pero no devuelve nada útil
x.collect { |n| n * 2 } // ✅ devuelve nuevo array
```

---

# 6. Ejercicios

## Ejercicio 1: Escala y transposición

1. Crea un array con la escala menor armónica: `[0, 2, 3, 5, 7, 8, 11]`
2. Transpónla a Sol (7 semitonos)
3. Mezcla el resultado con `scramble`
4. Guarda las primeras 5 notas

## Ejercicio 2: Función de transposición aleatoria

Escribe una función `~transponeRand` que:
1. Reciba un array de notas y un rango máximo de transposición
2. Transponga cada nota un número aleatorio de semitonos dentro de ese rango
3. Devuelva el nuevo array

## Ejercicio 3: Extiende `~makeNotes`

Modifica `~makeNotes` para que:
1. Acepte un tercer argumento `octave` (por defecto 0)
2. Sume `octave * 12` a cada nota antes de devolverla
3. Prueba: `~makeNotes.(0, 4, 1)` — Do mayor, 4 notas, una octava arriba

## Ejercicio 4: Colección de acordes

Usa `Array.fill` y `~makeNotes` para generar 4 acordes distintos en tonalidades diferentes.

---

# 7. Próxima Sesión

En la **Sesión 3** arrancamos el servidor de audio y conectamos todo lo que hemos aprendido con sonido real:

- El servidor de audio y cómo gestionarlo
- **UGens** — los generadores de sonido de SuperCollider
- Envolventes y control de amplitud
- Primeras síntesis: osciladores, ruido, filtros

---

## 📝 Recursos

- [Documentación oficial de SuperCollider](https://doc.sccode.org/)
- Cheatsheet de Arrays (en los materiales del curso)
- [SC-Forum](https://scsynth.org/)

---

**Arrays + funciones + aleatoriedad = material musical infinito** 🎲

*Módulo 1 · Sesión 2 de 3 — Componer con código*
