# SuperCollider Cheatsheet - Arrays y Colecciones

## ¿Qué es un Array?

Un **array** es una **colección ordenada de objetos** en SuperCollider.

```supercollider
x = [1, 2, 3, 4, 5];  // Array de 5 elementos
```

**Ventajas:**
- ✅ Expresar muchas cosas como una sola
- ✅ Operar en todos los elementos a la vez
- ✅ Ideal para conjuntos de notas, valores, parámetros

---

## Crear Arrays

### Literal

```supercollider
// Array literal
x = [1, 2, 3];

// Array vacío
x = [];

// Con tipos mezclados
x = [1, "hola", \foo, nil, true];
```

### Rangos

```supercollider
(1..10)        // → [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

(10..1)        // → [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
                // (hacia atrás)

(1, 3..9)      // → [1, 3, 5, 7, 9]
                // (cada 2)

(0, 2..10)     // → [0, 2, 4, 6, 8, 10]
```

### Métodos de creación

```supercollider
// Array de n elementos con el mismo valor
5.dup(4)       // → [5, 5, 5, 5]

// Atajo
5 ! 4          // → [5, 5, 5, 5]

// Serie aritmética
Array.series(10, 1, 1)  // 10 elementos, empieza en 1, incrementa 1
                       // → [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// Array geométrico
Array.geom(5, 1, 2)     // 5 elementos, empieza en 1, multiplica por 2
                       // → [1, 2, 4, 8, 16]

// Array con función generadora
Array.fill(10, { arg i; i * 2 })  // → [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]

// Array con random
Array.rand(5, 100, 500)   // 5 elementos, entre 100 y 500
```

---

## Acceder Elementos

### Índices (empiezan en 0)

```supercollider
x = [10, 20, 30, 40, 50];

x[0]           // → 10 (primer elemento)
x[2]           // → 30 (tercer elemento)
x[4]           // → 50 (quinto elemento)
```

### Métodos de acceso

```supercollider
x.at(2)        // → 30 (equivalente a x[2])

x.first        // → 10 (primer elemento)
x.last         // → 50 (último elemento)

x.mid          // → 30 (elemento medio)

x.choose       // → aleatorio (ej: 20)
```

### Índices negativos

```supercollider
x = [10, 20, 30, 40, 50];

x[-1]          // → 50 (último)
x[-2]          // → 40 (penúltimo)
```

---

## Propiedades del Array

```supercollider
x = [1, 2, 3, 4, 5];

x.size         // → 5 (número de elementos)
x.isEmpty      // → false

x.minItem      // → 1
x.maxItem      // → 5

x.sum          // → 15 (suma de todos)
x.mean         // → 3 (promedio)
```

---

## Operaciones Básicas

### Modificación del array

```supercollider
x = [1, 2, 3, 4, 5];

x.reverse      // → [5, 4, 3, 2, 1] (invierte)
x.scramble     // → [3, 1, 5, 2, 4] (mezcla aleatoria)
x.rotate(2)    // → [3, 4, 5, 1, 2] (rota 2 posiciones)

x + 1          // → [2, 3, 4, 5, 6] (suma 1 a cada elemento)
x * 2          // → [2, 4, 6, 8, 10] (multiplica cada elemento)
```

### Mantener/Eliminar elementos

```supercollider
x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

x.keep(5)      // → [1, 2, 3, 4, 5] (primeros 5)
x.drop(3)      // → [4, 5, 6, 7, 8, 9, 10] (descarta primeros 3)

x.keepFirst(3) // → [1, 2, 3]
x.keepLast(3)  // → [8, 9, 10]

x.dropFirst(3) // → [4, 5, 6, 7, 8, 9, 10]
x.dropLast(3)  // → [1, 2, 3, 4, 5, 6, 7]
```

### Añadir/Eliminar elementos

```supercollider
x = [1, 2, 3];

x.add(4)       // → [1, 2, 3, 4] (añade al final)
x.insert(1, 99) // → [1, 99, 2, 3] (inserta en índice 1)
```

---

## Ordenar y Encontrar

### Ordenar

```supercollider
x = [5, 1, 4, 2, 3];

x.sort         // → [1, 2, 3, 4, 5]

x.sort { |a, b| a > b }  // → [5, 4, 3, 2, 1] (inverso)
```

### Encontrar

```supercollider
x = [10, 20, 30, 40, 50];

x.indexOf(30)  // → 2 (índice de 30)
x.includes(30) // → true
x.includes(99) // → false

x.detect { |item| item > 25 }  // → 30 (primero que cumple)
```

### Filtrar

```supercollider
x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

x.select { |item| item.even }  // → [2, 4, 6, 8, 10]
x.reject { |item| item.odd }   // → [2, 4, 6, 8, 10]
```

---

## Iteración

### do (ejecutar acción)

```supercollider
x = [1, 2, 3, 4, 5];

// Imprimir cada elemento
x.do { |item|
    item.postln;
};

// Con índice
x.do { |item, i|
    ("Índice: " ++ i ++ ", valores: " ++ item).postln;
};
```

**Importante:** `do` devuelve el array original (no crea uno nuevo)

### collect (crear nuevo array)

```supercollider
x = [1, 2, 3, 4, 5];

// Duplicar cada elemento
y = x.collect { |item|
    item * 2
};
// → [2, 4, 6, 8, 10]

// Convertir a strings
y = x.collect { |item|
    item.asString
};
// → ["1", "2", "3", "4", "5"]
```

**Importante:** `collect` devuelve un array nuevo

---

## Operaciones Matemáticas

```supercollider
x = [1, 2, 3];
y = [10, 20, 30];

x + y          // → [11, 22, 33] (suma elemento a elemento)
x - y          // → [-9, -18, -27]
x * y          // → [10, 40, 90]
x / y          // → [0.1, 0.1, 0.1]

x + 1          // → [2, 3, 4] (suma a cada elemento)
x * 5          // → [5, 10, 15]
```

---

## Arrays Anidados

```supercollider
// Array de arrays
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
];

// Acceder
matrix[0]       // → [1, 2, 3]
matrix[0][1]    // → 2

// Aplanar
matrix.flatten  // → [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

---

## Arrays y Strings

### Strings como arrays de caracteres

```supercollider
s = "hola";

s.size         // → 4
s[0]           // → $h
s[1]           // → $o

s.reverse      // → "aloh"
s.scramble     // → "olah" (aleatorio)
```

### Conversión

```supercollider
// String → Array de caracteres
"hola".asArray  // → [$h, $o, $l, $a]

// Array → String
[$h, $o, $l, $a].asString  // → "hola"

// String → Array de enteros MIDI
"C4".noteToDegree  // → 0
"C4".midicps       // → 261.6256
```

---

## Patrones Comunes

### Generar escala

```supercollider
// Escala mayor
~majorScale = [0, 2, 4, 5, 7, 9, 11];

// Transponer a Mi♭
~ebMajor = ~majorScale + 3;  // → [3, 5, 7, 8, 10, 12, 14]

// Generar notas
~notes = Array.rand(10, 60, 72);  // 10 notas entre Do4 y Do5
```

### Mezcla aleatoria sin repetición

```supercollider
~scale = [0, 2, 4, 5, 7, 9, 11];
~notes = ~scale.scramble.keep(5);  // 5 notas únicas
```

### Transponer todos los elementos

```supercollider
~notes = [60, 62, 64, 65, 67];
~transposed = ~notes + 12;  // → [72, 74, 76, 77, 79]
```

---

## Arrays y UGens

### Multi-channel expansion

```supercollider
// Array de frecuencias crea múltiples osciladores
{ SinOsc.ar([440, 442]) * 0.1 }.play
// → estéreo (L: 440 Hz, R: 442 Hz)

// Más canales
{ SinOsc.ar([440, 442, 444, 446]) * 0.1 }.play
// → 4 canales (panoramía automática)
```

### Panorámica con arrays

```supercollider
~freqs = [440, 442, 444, 446];
~pitches = ~freqs.collect { |freq| freq.midicps };

{ SinOsc.ar(~pitches) * 0.1 }.play
```

### Mezclar múltiples voces

```supercollider
~vox = 10.collect { |i|
    SinOsc.ar(440 + (i * 10), 0, 0.01)
};

~sig = Splay.ar(~vox);  // Mezcla y panautomático
~sig.play;
```

---

## Errores Comunes

### Error 1: Índice fuera de rango

```supercollider
x = [1, 2, 3];
x[5]           // ❌ Índice 5 no existe (solo 0, 1, 2)
```

### Error 2: Usar método en array equivocado

```supercollider
// ❌ collect devuelve array nuevo, x no cambia
x = [1, 2, 3];
x.collect { |item| item * 2 }  // → [2, 4, 6]
// x sigue siendo [1, 2, 3]

// ✅ Guardar resultado
x = x.collect { |item| item * 2 }
```

### Error 3: Operaciones entre arrays de diferente tamaño

```supercollider
x = [1, 2, 3];
y = [10, 20];

x + y          // ❌ ERROR: arrays de diferente tamaño
```

### Error 4: Confundir do y collect

```supercollider
// ❌ do devuelve array original, no el resultado de la función
x.do { |item| item * 2 }  // → [1, 2, 3] (no cambia)

// ✅ collect devuelve array nuevo
x.collect { |item| item * 2 }  // → [2, 4, 6]
```

---

## Referencias Rápidas

### Métodos de selección

| Método | Función |
|--------|---------|
| `x` | Elemento en índice x |
| `x.at(y)` | Elemento en índice y |
| `first` | Primer elemento |
| `last` | Último elemento |
| `choose` | Elemento aleatorio |
| `mid` | Elemento medio |

### Métodos de transformación

| Método | Función |
|--------|---------|
| `reverse` | Invierte orden |
| `scramble` | Mezcla aleatoriamente |
| `rotate(n)` | Rota n posiciones |
| `sort` | Ordena ascendente |
| `keep(n)` | Primeros n elementos |
| `drop(n)` | Descarta primeros n |
| `flatten` | Aplanar arrays anidados |

### Iteración

| Método | Devuelve |
|--------|----------|
| `do { }` | Array original |
| `collect { }` | Array nuevo |

---

## Comparación: String vs Array

```supercollider
// String (más allá de caracteres)
s = "hola";
s.size         // → 4
s[0]           // → $h (Character)
s.reverse      // → "aloh"

// Array
x = [1, 2, 3, 4];
x.size         // → 4
x[0]           // → 1 (Integer)
x.reverse      // → [4, 3, 2, 1]

// Conversión
s.asArray      // → [$h, $o, $l, $a]
x.asString     // → "1234"
```

---

**¿Buscas más?**
- Cmd + D sobre `Array` para ver documentación completa
- Ver también cheatsheet de UGens y Envolventes
- Consulta ejemplos en Help Browser

---

*Actualizado para curso UNED - Sesión 1*