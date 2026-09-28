/* =========================================================
   SuperCollider – Patterns Essentials
   Cuaderno de trabajo (.scd)
   =========================================================

   Los Patterns son objetos que generan valores en el tiempo.
   Se usan principalmente para secuenciación musical.

   Pattern -> Stream -> valores sucesivos
*/

/* ---------------------------------------------------------
   1. Conceptos básicos
   ---------------------------------------------------------

   Pattern: descripción de una secuencia
   Stream: ejecución de esa secuencia
   Event: diccionario con parámetros musicales

   La mayoría de los Patterns se usan dentro de Pbind.
*/

/* ---------------------------------------------------------
   2. Pbind (el más importante)
   --------------------------------------------------------- */

(
Pbind(
    \instrument, \default,
    \freq, 440,
    \dur, 0.5
).play;
)

/* ---------------------------------------------------------
   3. Value Patterns (generan valores)
   --------------------------------------------------------- */

// Secuencia fija
Pseq([60, 62, 64, 67], inf);

// Valores aleatorios
Prand([60, 62, 64, 67], inf);

// Valores aleatorios sin repetición
Pxrand([60, 62, 64, 67], inf);

// Serie aritmética
Pseries(60, 2, 8);

// Repetición de un valor
Pdup(4, 0.25);

/* ---------------------------------------------------------
   4. Usar Patterns dentro de Pbind
   --------------------------------------------------------- */

(
Pbind(
    \instrument, \default,
    \midinote, Pseq([60, 62, 64, 67], inf),
    \dur, Pseq([0.25, 0.5, 1], inf),
    \amp, 0.1
).play;
)

/* ---------------------------------------------------------
   5. Conversión MIDI / Frecuencia
   --------------------------------------------------------- */

(
Pbind(
    \freq, Pseq([60, 62, 64, 67], inf).midicps,
    \dur, 0.25
).play;
)

/* ---------------------------------------------------------
   6. Control de repeticiones
   --------------------------------------------------------- */

// Número fijo de repeticiones
Pseq([1, 2, 3], 2);

// Repetición infinita
Pseq([1, 2, 3], inf);

/* ---------------------------------------------------------
   7. Ritmo y tiempo
   --------------------------------------------------------- */

(
Pbind(
    \dur, Pseq([0.25, 0.25, 0.5], inf),
    \midinote, Prand([60, 67, 72], inf),
    \amp, 0.1
).play;
)

/* ---------------------------------------------------------
   8. Patrones anidados
   --------------------------------------------------------- */

Pseq([
    Pseq([60, 62, 64], 1),
    Pseq([67, 69], 1)
], inf);

/* ---------------------------------------------------------
   9. Dinámica y control
   --------------------------------------------------------- */

(
Pbind(
    \midinote, Pseq([60, 62, 64, 67], inf),
    \amp, Pseq([0.05, 0.1, 0.2, 0.1], inf),
    \dur, 0.25
).play;
)

/* ---------------------------------------------------------
   10. Tempo y Clock
   --------------------------------------------------------- */

// Crear un TempoClock
t = TempoClock.new(120/60);

// Usar el clock
(
Pbind(
    \midinote, Pseq([60, 62, 64, 67], inf),
    \dur, 0.5
).play(t);
)

/* ---------------------------------------------------------
   11. Stop / Play
   --------------------------------------------------------- */

p = Pbind(
    \midinote, Prand([60, 62, 64, 67], inf),
    \dur, 0.25
).play;

// detener
p.stop;

/* ---------------------------------------------------------
   12. Event keys más usadas
   ---------------------------------------------------------

   \instrument  -> nombre del SynthDef
   \freq        -> frecuencia (Hz)
   \midinote    -> nota MIDI
   \dur         -> duración (en beats)
   \amp         -> amplitud
   \pan         -> panorámica
*/

/* ---------------------------------------------------------
   13. Pattern como partitura
   ---------------------------------------------------------

   Un Pattern no hace sonido por sí mismo.
   Describe cómo los valores cambian en el tiempo.
   Pbind convierte esa descripción en sonido.
*/

/* ---------------------------------------------------------
   Regla práctica:
   - Arrays describen material
   - Patterns organizan el material en el tiempo
   --------------------------------------------------------- */
