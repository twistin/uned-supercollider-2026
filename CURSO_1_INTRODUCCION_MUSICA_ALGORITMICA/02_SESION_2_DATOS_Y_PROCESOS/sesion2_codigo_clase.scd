/* =========================================================
   SuperCollider — Código de Sesión 2
   Módulo 1: Componer con código
   Sesión 2: Generar material musical
   =========================================================

   INSTRUCCIONES:
   - Evalúa cada bloque por separado (Cmd/Ctrl + Enter)
   - El servidor NO necesita estar arrancado para esta sesión
   - Todo es cálculo en el lenguaje — sin sonido todavía

*/

/* ---------------------------------------------------------
   1. ARRAYS — colecciones ordenadas
   --------------------------------------------------------- */

// Crear arrays
x = [2, -5, 7, 11];
x = [60, 62, 64, 65, 67, 69, 71];   // escala de Do mayor en MIDI

// Operaciones básicas
x.size;       // → número de elementos
x.reverse;    // → orden invertido
x.scramble;   // → mezcla aleatoria
x.choose;     // → un elemento aleatorio
x.sort;       // → ordenado de menor a mayor

// Acceso por índice (empiezan en 0)
x[0];         // primer elemento
x[3];         // cuarto elemento
x.first;      // primer elemento
x.last;       // último elemento

// Crear arrays de forma rápida
(1..10);                      // → [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
(0, 2..10);                   // → [0, 2, 4, 6, 8, 10] (de 2 en 2)
Array.series(8, 60, 2);       // → [60, 62, 64, 66, 68, 70, 72, 74]
Array.fill(8, { rrand(60, 80) }); // → 8 números aleatorios entre 60 y 80

/* ---------------------------------------------------------
   2. OPERACIONES MUSICALES CON ARRAYS
   --------------------------------------------------------- */

// Transposición (suma a todos los elementos)
~escala = [0, 2, 4, 5, 7, 9, 11];
~escala + 60;    // → trasposición a Do4 en MIDI
~escala + 62;    // → trasposición a Re4

// Seleccionar y filtrar
~escala.keep(4);              // → primeros 4 elementos
~escala.drop(3);              // → descarta los 3 primeros
~escala.select { |n| n > 4 }; // → solo los mayores que 4
~escala.reject { |n| n > 4 }; // → solo los menores o iguales a 4

// Métodos musicales especiales
~escala.mirror;               // → espejo: [0,2,4,5,7,9,11,9,7,5,4,2,0]
~escala.rotate(2);            // → rota 2 posiciones
~escala.scramble.keep(4);     // → 4 notas aleatorias de la escala

/* ---------------------------------------------------------
   3. FUNCIONES
   --------------------------------------------------------- */

// Función básica (sin argumentos)
(
f = {
    var num;
    num = 8;
    num = num.squared;
    num = num - 1;
};
)

f.value;    // → 63
f.();       // atajo equivalente

// Función con argumento
(
f = { |num|
    num.squared - 1
};
)

f.(5);     // → 24
f.(10);    // → 99

// Función con valor por defecto
(
f = { |num = 0|
    num.squared - 1
};
)

f.();      // → -1 (usa valor por defecto)
f.(4);     // → 15

// Función con múltiples argumentos
(
f = { |base = 60, semitono = 0|
    base + semitono
};
)

f.();          // → 60 (Do4)
f.(60, 4);     // → 64 (Mi4)
f.(62, 7);     // → 69 (La4)

/* ---------------------------------------------------------
   4. ALEATORIEDAD
   --------------------------------------------------------- */

// Uniforme — igual probabilidad para todos los valores
rrand(1, 10);        // entero entre 1 y 10
rrand(0.0, 1.0);     // float entre 0 y 1

// Exponencial — más probable cerca del mínimo
exprand(100, 800);   // útil para frecuencias (oído logarítmico)
exprand(0.01, 0.5);  // útil para amplitudes

// Trampa clásica con dup
rrand(1,10).dup(5);         // ❌ un número repetido 5 veces
{ rrand(1,10) }.dup(5);     // ✅ 5 números distintos

// Array.fill con aleatoriedad
Array.fill(8, { rrand(60, 84) });    // 8 notas MIDI aleatorias
Array.fill(8, { exprand(0.1, 0.5) }); // 8 amplitudes aleatorias

/* ---------------------------------------------------------
   5. ITERACIÓN
   --------------------------------------------------------- */

// do — ejecutar algo por cada elemento
[60, 62, 64, 67].do { |nota, indice|
    ("Nota " ++ indice ++ ": " ++ nota).postln;
};

// collect — transformar y devolver nuevo array
~escala = [0, 2, 4, 5, 7, 9, 11];

// Transponer irregularmente (cada nota diferente offset)
~transpuesta = ~escala.collect { |item|
    item + rrand(0, 2)
};
~transpuesta.postln;

// Convertir semitonos a frecuencias Hz
~freqs = ~escala.collect { |item|
    (item + 60).midicps   // MIDI a Hz
};
~freqs.postln;

/* ---------------------------------------------------------
   6. EJERCICIO MUSICAL: makeNotes
   --------------------------------------------------------- */

// Versión básica
(
~makeNotes = { |root = 0, numNotes = 4|
    var scale, notes;
    scale = [0, 2, 4, 5, 7, 9, 11];  // escala mayor
    scale = scale + root;              // transposición
    notes = scale.scramble.keep(numNotes); // mezcla y recorta
    notes;
};
)

// Uso
~makeNotes.();         // Do mayor, 4 notas (semitonos 0-11)
~makeNotes.(5, 6);     // Fa mayor, 6 notas
~makeNotes.(3, 3);     // Mi♭ mayor, 3 notas
~makeNotes.(9, 5);     // La mayor, 5 notas

// Convertir a notas MIDI absolutas (octava 4)
~makeNotes.(0, 4) + 60;
~makeNotes.(0, 4).collect { |n| (n + 60).midiname };  // nombres de notas

/* ---------------------------------------------------------
   7. VARIACIONES DE makeNotes
   --------------------------------------------------------- */

// Con octava configurable
(
~makeNotes2 = { |root = 60, numNotes = 4|
    var scale, notes;
    scale = [0, 2, 4, 5, 7, 9, 11];
    notes = Array.fill(numNotes, { root + scale.choose });
    notes;
};
)

~makeNotes2.(60, 4);    // Do mayor
~makeNotes2.(69, 6);    // La mayor

// Versión para escala menor natural
(
~makeMinor = { |root = 60, numNotes = 4|
    var scale;
    scale = [0, 2, 3, 5, 7, 8, 10];  // menor natural
    Array.fill(numNotes, { root + scale.choose });
};
)

~makeMinor.(60, 4);
