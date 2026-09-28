/* =========================================================
   SuperCollider – UGens Essentials Cheat Sheet
   Curso: Introducción a SuperCollider
   =========================================================

   UGen (Unit Generator) = bloque básico que genera o procesa
   señales de audio o de control.
*/

/* ---------------------------------------------------------
   1. Tasas de cálculo (MUY IMPORTANTE)
   ---------------------------------------------------------

   .ar  -> audio rate (sonido audible)
   .kr  -> control rate (modulación lenta)
   .ir  -> init rate (valor fijo al crear el Synth)
*/

SinOsc.ar(440);
LFNoise1.kr(2);

/* ---------------------------------------------------------
   2. Osciladores básicos (generadores de sonido)
   --------------------------------------------------------- */

// Seno
SinOsc.ar(freq: 440, mul: 0.2);

// Diente de sierra
Saw.ar(220, 0.2);

// Pulso (cuadrada con ancho variable)
Pulse.ar(110, width: 0.3, mul: 0.2);

// Triangular
LFTri.ar(330, mul: 0.2);

/* ---------------------------------------------------------
   3. Ruido (texturas)
   --------------------------------------------------------- */

WhiteNoise.ar(0.2);   // ruido blanco
PinkNoise.ar(0.2);    // ruido rosa
BrownNoise.ar(0.2);   // ruido marrón

/* ---------------------------------------------------------
   4. Modulación (LFOs)
   --------------------------------------------------------- */

// Seno como LFO
SinOsc.kr(0.5).range(200, 800);

// Ruido suave
LFNoise1.kr(3).range(300, 600);

// Ruido a saltos
LFNoise0.kr(5).range(0, 1);

/* ---------------------------------------------------------
   5. Envolventes
   --------------------------------------------------------- */

// Envolvente percusiva
EnvGen.kr(
    Env.perc(0.01, 1),
    doneAction: 2
);

// ADSR
Env.adsr(0.01, 0.2, 0.5, 1);

/* ---------------------------------------------------------
   6. Control de amplitud
   --------------------------------------------------------- */

// Control manual
sig * 0.1;

// Seguimiento de amplitud
Amplitude.kr(sig);

/* ---------------------------------------------------------
   7. Filtros
   --------------------------------------------------------- */

// Paso bajo
LPF.ar(sig, 1000);

// Paso alto
HPF.ar(sig, 500);

// Paso banda
BPF.ar(sig, freq: 800, rq: 0.2);

/* ---------------------------------------------------------
   8. Efectos esenciales
   --------------------------------------------------------- */

// Delay corto
DelayC.ar(sig, 0.3, 0.2);

// Eco resonante
CombN.ar(sig, 0.3, 0.2, 2);

// Reverb
FreeVerb.ar(sig, mix: 0.3, room: 0.5);

/* ---------------------------------------------------------
   9. Panorámica y estéreo
   --------------------------------------------------------- */

// Mono a estéreo
Pan2.ar(sig, 0);   // -1 izquierda, 1 derecha

// Distribución estéreo de arrays
Splay.ar([sig1, sig2, sig3]);

/* ---------------------------------------------------------
   10. Triggers y eventos
   --------------------------------------------------------- */

// Pulso regular
Impulse.kr(2);

// Impulsos aleatorios
Dust.kr(4);

/* ---------------------------------------------------------
   11. Multicanal
   --------------------------------------------------------- */

SinOsc.ar([440, 660, 880]);

/* ---------------------------------------------------------
   12. Receta mínima de Synth
   --------------------------------------------------------- */

{
    var env;
    env = EnvGen.kr(Env.perc, doneAction: 2);
    SinOsc.ar(440) * env * 0.2
}.play;

/* ---------------------------------------------------------
   Regla de oro:
   Si no suena, revisa:
   - la tasa (.ar / .kr)
   - la amplitud
   - la envolvente
   --------------------------------------------------------- */
