# Arrays, Lists y Dictionaries en SuperCollider

En SuperCollider estos tres son los contenedores de datos más importantes. Te los explico con sus diferencias reales y cómo los usas en contexto de live coding.

---

## Array

Una colección **ordenada de tamaño fijo**. El tamaño se define al crearlo y no cambia. Se accede por índice numérico.

```supercollider
// Crear
a = [10, 20, 30, 40, 50];

// Acceder por índice (empieza en 0)
a[0];        // → 10
a[2];        // → 30
a.last;      // → 50
a.first;     // → 10

// Tamaño
a.size;      // → 5

// Iterar
a.do({ |item, i| [i, item].postln });

// Métodos útiles en live coding
a.choose;    // elemento aleatorio → muy usado con buffers
a.reverse;
a.scramble;  // orden aleatorio
a.rotate(1); // rota los elementos
a.mirror;    // [10,20,30,40,50,40,30,20,10]

// Seleccionar elementos
a.select({ |x| x > 20 });  // → [30, 40, 50]
a.reject({ |x| x > 20 });  // → [10, 20]
```

En tu librería, cuando cargas buffers, **cada valor del Dictionary es un Array**:
```supercollider
d[\kick]        // → Array de buffers
d[\kick][0]     // → primer buffer
d[\kick].choose // → buffer aleatorio ← lo más usado en sets
```

---

## List

Una colección **ordenada de tamaño dinámico**. Igual que Array pero puedes añadir y quitar elementos en cualquier momento. Más flexible, algo más lenta.

```supercollider
// Crear
l = List.new;
l = List[10, 20, 30];

// Añadir elementos — esto no existe en Array
l.add(40);
l.addFirst(0);

// Acceder — igual que Array
l[0];
l.last;
l.choose;

// Quitar
l.remove(20);    // quita el elemento 20
l.pop;           // quita y devuelve el último

// Convertir a Array cuando necesites métodos de Array
l.asArray;
```

En la práctica en live coding **usas Array casi siempre** y List solo cuando necesitas una colección que crece dinámicamente en tiempo real, por ejemplo para acumular eventos o construir secuencias al vuelo.

---

## Dictionary

Una colección de pares **clave → valor**, sin orden. Se accede por clave, no por índice. Es exactamente lo que usas en tu setup con `d`.

```supercollider
// Crear
d = Dictionary.new;

// Añadir pares clave→valor
d.add(\kick -> [buf1, buf2, buf3]);
d.add(\snare -> [buf5, buf6]);
d[\tempo] = 120;          // sintaxis alternativa

// Acceder por clave
d[\kick];                 // → el array de buffers
d[\kick][0];              // → primer buffer de kick
d[\kick].choose;          // → buffer aleatorio de kick

// Comprobar si existe una clave
d.includesKey(\kick);     // → true/false

// Ver todas las claves
d.keys;                   // → Set[kick, snare, tempo ...]

// Ver todos los valores
d.values;

// Iterar
d.keysValuesDo({ |key, val|
    (key.asString ++ ": " ++ val.size).postln
});

// Quitar una entrada
d.removeAt(\tempo);
```

---

## Diferencias clave

| | Array | List | Dictionary |
|---|---|---|---|
| Acceso | por índice `[0]` | por índice `[0]` | por clave `[\kick]` |
| Tamaño | fijo | dinámico | dinámico |
| Orden | sí | sí | no |
| Uso típico | buffers, secuencias | colecciones que crecen | organizar por nombre |
| Velocidad | más rápido | medio | medio |

---

## Cómo conviven los tres en tu setup

```supercollider
// d es un Dictionary
d = Dictionary.new;

// cada valor es un Array de Buffers
d.add(\kick -> [buf1, buf2, buf3]);

// en un Pbind usas .choose del Array
Pbind(
    \instrument, \playbuf,
    \buf, Prand(d[\kick], inf),  // Prand ya maneja el Array
    \dur, 0.5
).play;

// o directamente
d[\kick].choose;    // un buffer aleatorio
d[\kick][0];        // siempre el primero
d[\kick].size;      // cuántos kicks tienes cargados
```

La relación es: el **Dictionary** organiza por nombre, dentro de cada entrada hay un **Array** con todos los buffers de esa categoría, y `.choose` es el método del Array que más vas a escribir en un set.