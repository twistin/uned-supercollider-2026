

# SuperCollider – Array Cheat Sheet

## 1️⃣ ¿Qué es un Array?

Un **Array** es una **colección ordenada de elementos** (números, símbolos, funciones, sonidos…).

```supercollider
a = [1, 2, 3, 4];
b = ["do", "re", "mi"];
```

- Empiezan en índice **0**
- Pueden contener **cualquier tipo de objeto**
- Son muy usados para **alturas, ritmos, parámetros, procesos**

------

## 2️⃣ Crear Arrays

### Literal

```supercollider
a = [10, 20, 30];
```

### Con tamaño fijo

```supercollider
Array.new(5);        // [nil, nil, nil, nil, nil]
```

### Con valores repetidos

```supercollider
Array.fill(5, 0);    // [0, 0, 0, 0, 0]
```

### Con función (muy potente)

```supercollider
Array.fill(5, { |i| i * 2 });
// [0, 2, 4, 6, 8]
```

------

## 3️⃣ Acceder a elementos

```supercollider
a = [10, 20, 30];

a[0];   // 10
a[1];   // 20
a[-1];  // 30 (último elemento)
```

------

## 4️⃣ Modificar elementos

```supercollider
a[1] = 99;
a;  // [10, 99, 30]
```

------

## 5️⃣ Tamaño del Array

```supercollider
a.size;    // número de elementos
```

------

## 6️⃣ Recorrer Arrays (Iteración)

### `do` → ejecutar algo

```supercollider
a.do { |item| item.postln };
```

### `collect` → crear un nuevo Array

```supercollider
b = a.collect { |item| item * 2 };
```

📌 **Regla clave**

- `do` → efectos
- `collect` → transformación

------

## 7️⃣ Operaciones comunes

```supercollider
a.sum;        // suma
a.mean;       // media
a.minItem;    // mínimo
a.maxItem;    // máximo
a.reverse;    // invertir
a.scramble;   // desordenar
```

------

## 8️⃣ Concatenar y combinar

```supercollider
a = [1, 2];
b = [3, 4];

a ++ b;   // [1, 2, 3, 4]
```

------

## 9️⃣ Subarrays (segmentos)

```supercollider
a = [10, 20, 30, 40];

a.copyRange(1, 2);   // [20, 30]
```

------

## 🔟 Arrays musicales (muy usados)

### Alturas

```supercollider
notes = [60, 62, 64, 67];
notes.choose;   // elige una al azar
```

### Ritmos

```supercollider
durations = [0.25, 0.5, 1];
```

### Multicanal

```supercollider
SinOsc.ar([440, 660]);
```

------

## 1️⃣1️⃣ Operaciones matemáticas (element-wise)

```supercollider
[1, 2, 3] * 2;        // [2, 4, 6]
[1, 2, 3] + [10, 20, 30]; // [11, 22, 33]
```

------

## 1️⃣2️⃣ Arrays + Aleatoriedad

```supercollider
a.choose;     // elemento aleatorio
a.wchoose([0.1, 0.3, 0.6]);  // elección ponderada
```

------

## 1️⃣3️⃣ Conversión y utilidades

```supercollider
a.asSet;      // elimina duplicados
a.sort;       // ordena
a.flatten;    // aplana arrays anidados
```

------

## 1️⃣4️⃣ Arrays anidados

```supercollider
a = [[1, 2], [3, 4]];

a[0];      // [1, 2]
a[0][1];   // 2
```

------

## 🧠 Ideas pedagógicas rápidas

- Array = **escala**
- Array = **ritmo**
- Array = **paleta sonora**
- Array = **estructura formal**
- Array = **partitura abstracta**

------

