/* =========================================================
   SuperCollider – Arrays Essentials
   Cuaderno de trabajo (.scd)
   =========================================================

   Un Array es una colección ordenada de objetos.
   En SuperCollider, los Arrays se usan constantemente
   para representar alturas, ritmos, parámetros, procesos
   y estructuras musicales.
*/

/* ---------------------------------------------------------
   1. Crear Arrays
   --------------------------------------------------------- */

// Array literal
a = [1, 2, 3, 4];

// Array con texto
b = ["do", "re", "mi"];

// Array vacío de tamaño fijo
Array.new(5);   // [nil, nil, nil, nil, nil]

// Array con valores repetidos
Array.fill(5, 0);

// Array generado por función
Array.fill(5, { |i| i * 2 });
// [0, 2, 4, 6, 8]

/* ---------------------------------------------------------
   2. Acceso por índice
   --------------------------------------------------------- */

a = [10, 20, 30, 40];

a[0];    // primer elemento
a[1];
a[-1];   // último elemento

/* ---------------------------------------------------------
   3. Modificar elementos
   --------------------------------------------------------- */

a[2] = 99;
a;

/* ---------------------------------------------------------
   4. Tamaño del Array
   --------------------------------------------------------- */

a.size;

/* ---------------------------------------------------------
   5. Iterar sobre Arrays
   --------------------------------------------------------- */

// do -> ejecutar algo
a.do { |item|
    item.postln;
};

// collect -> crear nuevo Array
b = a.collect { |item|
    item * 2;
};
b;

/* ---------------------------------------------------------
   6. Operaciones habituales
   --------------------------------------------------------- */

a.sum;
a.mean;
a.minItem;
a.maxItem;
a.reverse;
a.scramble;

/* ---------------------------------------------------------
   7. Concatenar Arrays
   --------------------------------------------------------- */

x = [1, 2, 3];
y = [4, 5];

x ++ y;

/* ---------------------------------------------------------
   8. Subarrays
   --------------------------------------------------------- */

a = [10, 20, 30, 40, 50];

a.copyRange(1, 3);   // [20, 30, 40]

/* ---------------------------------------------------------
   9. Arrays musicales
   --------------------------------------------------------- */

// Alturas MIDI
notes = [60, 62, 64, 67];

// Elegir una nota al azar
notes.choose;

// Ritmos
durs = [0.25, 0.5, 1];

// Ejemplo con Routine
Routine({
    8.do {
        notes.choose.postln;
        0.25.wait;
    }
}).play;

/* ---------------------------------------------------------
   10. Operaciones matemáticas (element-wise)
   --------------------------------------------------------- */

[1, 2, 3] * 2;
[1, 2, 3] + [10, 20, 30];

/* ---------------------------------------------------------
   11. Aleatoriedad
   --------------------------------------------------------- */

// Elección simple
notes.choose;

// Elección ponderada
notes.wchoose([0.1, 0.3, 0.6]);

/* ---------------------------------------------------------
   12. Conversión y utilidades
   --------------------------------------------------------- */

[1, 2, 2, 3].asSet;
[3, 1, 4, 2].sort;
[[1, 2], [3, 4]].flatten;

/* ---------------------------------------------------------
   13. Arrays anidados
   --------------------------------------------------------- */

a = [[60, 62], [64, 67]];

a[0];
a[0][1];

/* ---------------------------------------------------------
   14. Arrays y multicanal
   --------------------------------------------------------- */

{
    SinOsc.ar([440, 660, 880]) * 0.1
}.play;

/* ---------------------------------------------------------
   15. Ejemplo musical completo
   --------------------------------------------------------- */

(
Routine({
    var notes = [60, 62, 64, 67];
    var durs  = [0.25, 0.5, 1];

    12.do {
        {
            SinOsc.ar(
                notes.choose.midicps,
                0,
                0.1
            )
            * EnvGen.kr(Env.perc, doneAction: 2)
        }.play;

        durs.choose.wait;
    }
}).play;
)

/* ---------------------------------------------------------
   Ideas clave:
   - Un Array puede ser una escala
   - Un Array puede ser un ritmo
   - Un Array puede ser una paleta sonora
   - Un Array puede ser una partitura abstracta

   Regla práctica:
   do -> recorrer
   collect -> transformar
   --------------------------------------------------------- */
