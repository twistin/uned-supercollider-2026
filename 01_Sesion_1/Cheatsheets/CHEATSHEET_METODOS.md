# SuperCollider Cheatsheet - Métodos Comunes

---

## Números (Number methods)

### Operaciones básicas

```supercollider
4.squared      // → 16 (4^2)
4.cubed        // → 64 (4^3)

4.sqrt         // → 2.0 (raíz cuadrada)

4.neg          // → -4 (negativo)
4.abs          // → 4 (valor absoluto)
(-4).abs       // → 4

4.round        // → 4 (redondeo)
4.7.round      // → 5
4.3.round      // → 4

4.ceil         // → 4 (hacia arriba)
4.7.ceil       // → 5

4.floor        // → 4 (hacia abajo)
4.7.floor      // → 4

4.7.midicps    // → 293.66 (MIDI a Hz)
440 cpsmidi    // → 69.0 (Hz a MIDI)

4.dbamp        // → 1.5849 (dB a amplitud)
0.5.ampdb      // → -6.0206 (amplitud a dB)
```

### Operadores binarios (evalúan de izquierda a derecha)

```supercollider
2 * 9 + 6      // → 24 (2*9=18, 18+6=24)
2 + 9 * 6      // → 66 (2+9=11, 11*6=66)
2 + (9 * 6)    // → 56 (paréntesis primero)
```

**Importante:** SC evalúa operadores de izquierda a derecha, no siguiendo reglas matemáticas tradicionales

### Pruebas numéricas

```supercollider
6.isPrime      // → false
7.isPrime      // → true

6.isInteger    // → true
6.5.isInteger  // → false

6.5.isFloat    // → true

2.even         // → true
3.odd          // → true
```

---

## Operadores de Comparación

```supercollider
// Igualdad
2 == 2         // → true
2 == 3         // → false

// Desigualdad
2 != 3         // → true
2 != 2         // → false

// Mayor/Menor
2 > 1          // → true
2 < 3          // → true

// Mayor o igual / Menor o igual
2 >= 2         // → true
2 <= 3         // → true
```

---

## Booleanos (Boolean)

```supercollider
true.not       // → false
false.not      // → true

true.and(false) // → false (y)
true.or(false)  // → true (o)

true.and(true)  // → true
false.and(false) // → false
```

---

## Rangos (Range)

```supercollider
(1..10)        // → [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
(10..1)        // → [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
(1, 3..9)      // → [1, 3, 5, 7, 9]
```

```supercollider
r = (1..10);
r.size         // → 10
r.reverse      // → [10, 9, 8, ...]
[r]            // → [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]] (array de un rango)
```

---

## Random (Aleatoriedad)

```supercollider
// Aleatorio uniforme entre min y max
rrand(1, 10)     // → 7 (entero)
rrand(1.0, 10.0) // → 3.456 (float)

// Aleatorio exponencial (distribución logarítmica)
exprand(1, 100)  // → 2.345 (tiende a valores pequeños)

// Aleatorio de 0 a 1
1.0.rand         // → 0.734

// Aleatorio entre 0 y n
10.rand          // → 7
10.0.rand        // → 7.234
```

### Duplicación con aleatoriedad

```supercollider
// ❌ TRAMPA: evalúa una vez y duplica ese valor
rrand(1, 10).dup(5)  // → [7, 7, 7, 7, 7]

// ✅ BIEN: envuelve en función
{ rrand(1, 10) }.dup(5)  // → [7, 3, 9, 2, 5]
```

---

## Funciones (Function)

### Crear y ejecutar

```supercollider
// Crear función
f = {
    arg x;
    x.squared;
};

// Ejecutar
f.value(4)     // → 16
f.(4)          // → 16 (atajo)
```

### Sintaxis de argumentos

```supercollider
// Forma 1: con pipes
f = { |x| x.squared };

// Forma 2: con arg
f = { arg x; x.squared };
```

### Valores por defecto

```supercollider
f = { |x = 0| x.squared };

f.();          // → 0 (usa valor por defecto)
f.(5);         // → 25 (sobrescribe)
```

---

## String (Cadenas de texto)

### Básicos

```supercollider
s = "hola mundo";

s.size         // → 11 (número de caracteres)
s.isEmpty      // → false

s.reverse      // → "odnum aloh"

s.split($ )    // → ["hola", "mundo"] (separa por espacio)
```

### Acceso a caracteres

```supercollider
s[0]           // → $h (primer caracter)
s[1]           // → $o (segundo caracter)
```

### Manipulación

```supercollider
s.toUpper      // → "HOLA MUNDO"
s.toLower      // → "hola mundo"

s.replace("mundo", "SC")  // → "hola SC"

s.scramble     // → "mdou oalh" (mezcla aleatoria)
```

---

## Symbol (Símbolos)

### Crear símbolos

```supercollider
// Forma 1: comillas simples
\hola          // símbolo 'hola'

// Forma 2: barra invertida
\hola          // símbolo 'hola'
```

### Conversión

```supercollider
"hola".asSymbol  // → 'hola'
\hola.asString   // → "hola"
```

### Diferencia con String

```supercollider
s = "hola";
sy = \hola;

s = "hola";
sy = \hola

s.size         // → 4
sy.size        // → 0 (los símbolos tienen tamaño 0)
```

---

## Conversión de Tipos

```supercollider
// Número → String
4.asString                    // → "4"

// String → Número
"4".interpret                // → 4.0

// Integer → Float
4.asFloat                    // → 4.0

// Float → Integer
4.7.asInteger                // → 4 (trunca)
4.7.round.asInteger          // → 5 (redondea)

// MIDI a Hz
60.midicps                   // → 261.6256

// Hz a MIDI
261.6256.cpsmidi             // → 60.0

// dB a amplitud
-12.dbamp                    // → 0.2512

// Amplitud a dB
0.2512.ampdb                 // → -12.0

// Número → Symbol
4.asSymbol                   // → '4'

// Symbol → String
\hola.asString               // → "hola"

// String → Symbol
"hola".asSymbol              // → 'hola'
```

---

## Range (Reescalado)

```supercollider
// Reescalar de -1..1 a min..max
LFTri.kr(1).range(200, 800)  // → oscila entre 200 y 880 Hz

// Reescalar de 0..1 a min..max
LFNoise1.kr(2).range(0.1, 0.5)  // → entre 0.1 y 0.5 amplitud
```

---

## Arrays (Métodos clave)

### Acceso

```supercollider
x = [1, 2, 3, 4, 5];

x[0]           // → 1 (índice 0)
x.at(2)        // → 3 (índice 2)
x.first        // → 1
x.last         // → 5
x.choose       // → aleatorio (ej: 3)
x.mid          // → 3 (medio)
```

### Información

```supercollider
x.size         // → 5
x.isEmpty      // → false
x.minItem      // → 1
x.maxItem      // → 5
x.mean         // → 3
x.sum          // → 15
```

### Transformación

```supercollider
x.reverse      // → [5, 4, 3, 2, 1]
x.scramble     // → [3, 1, 5, 2, 4]
x.rotate(2)    // → [3, 4, 5, 1, 2]

x + 1          // → [2, 3, 4, 5, 6]
x * 2          // → [2, 4, 6, 8, 10]

x.keep(3)      // → [1, 2, 3]
x.drop(2)      // → [3, 4, 5]
```

### Ordenar y encontrar

```supercollider
x.sort         // → [1, 2, 3, 4, 5]
x.indexOf(3)   // → 2
x.includes(3)  // → true

x.select { |i| i > 3 }  // → [4, 5]
x.reject { |i| i.odd }  // → [2, 4]
```

### Iteración

```supercollider
// do: devuelve array original
x.do { |item| item.postln; }

// collect: devuelve array nuevo
y = x.collect { |item| item * 2 }  // → [2, 4, 6, 8, 10]
```

---

## Ejercicios Prácticos

### Ejercicio 1: Operaciones numéricas

```supercollider
// Tomar un número, elevarlo al cuadrado, restar 5
x = 7.squared - 5;  // → 44

// Convertir de MIDI a Hz y luego a dB
midi = 60;
hz = midi.midicps;     // → 261.6256
dB = hz.ampdb;         // → -11.3
```

### Ejercicio 2: Arrays y aleatoriedad

```supercollider
// Crear array de 10 notas aleatorias entre C4 y C5
~notes = Array.rand(10, 60, 72);

// Mezclar y mantener primeras 5
~melody = ~notes.scramble.keep(5);
```

### Ejercicio 3: Función con argumentos

```supercollider
// Función que transpone una escala
~transpose = { |scale, root|
    scale + root;
};

// Usar
~major = [0, 2, 4, 5, 7, 9, 11];
~eb = ~transpose.(~major, 3);  // → [3, 5, 7, 8, 10, 12, 14]
```

---

## Errores Comunes

### Error 1: Confundir método con función

```supercollider
// ❌ x espera número, recibe función
4.squared

// ✅ bien
4.squared
```

### Error 2: Olvidar argumento

```supercollider
// ❌
4.pow

// ✅
4.pow(2)
```

### Error 3: Operadores de izquierda a derecha

```supercollider
// ❌ Esperas 56, pero SC hace esto:
2 + 9 * 6    // 2+9=11, 11*6=66 → 66

// ✅ Usa paréntesis
2 + (9 * 6)  // → 56
```

### Error 4: Tipo incorrecto para método

```supercollider
// ❌ isPrime solo funciona con integers
6.0.isPrime   // ERROR

// ✅
6.isPrime     // → false
```

---

## Referencias Rápidas

### Números

| Método | Efecto |
|--------|--------|
| `squared` | x² |
| `cubed` | x³ |
| `sqrt` | √x |
| `neg` | -x |
| `abs` | \|x\| |
| `round` | Redondear |
| `midicps` | MIDI → Hz |
| `dbamp` | dB → amp |
| `ampdb` | amp → dB |

### Operadores

| Operador | Significado |
|----------|-------------|
| `+` | Suma |
| `-` | Resta |
| `*` | Multiplicación |
| `/` | División |
| `==` | Igualdad |
| `!=` | Desigualdad |
| `>` | Mayor que |
| `<` | Menor que |

### Aleatoriedad

| Método | Rango |
|--------|-------|
| `n.rand` | 0 a n |
| `rrand(a, b)` | a a b |
| `exprand(a, b)` | exponencial |

---

**¿Buscas más?**
- Cmd + D sobre cualquier método para ver su ayuda
- Ver también cheatsheets de Arrays, UGens y Envolventes
- Consulta ejemplos en Help Browser

---

*Actualizado para curso UNED - Sesión 1*