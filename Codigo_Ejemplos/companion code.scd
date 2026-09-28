/* =========================================================
   SuperCollider – Companion Code por Sesiones
   Curso: Introducción a SuperCollider
   =========================================================

   Este archivo acompaña todo el curso.
   Cada sesión añade capas nuevas.
   Evalúa SOLO la sesión correspondiente.
*/

/* =========================================================
   SESIÓN 1
   Primeros pasos en SuperCollider I
   Entorno, lenguaje y pensamiento computacional
   ========================================================= */

/* --- Servidor --- */
s.boot;

/* --- Sonido mínimo --- */
{ SinOsc.ar(440) * 0.1 }.play;

/* --- Variables y funciones --- */
~freq = 440;

~beep = { |f = 440|
    SinOsc.ar(f) * 0.1
};

~beep.(660).play;

/* =========================================================
   SESIÓN 2
   Primeros pasos en SuperCollider II
   Estructuras, funciones y generación de datos
   ========================================================= */

/* --- Arrays como material musical --- */
~notes = [60, 62, 64, 67];
~durs  = [0.25, 0.5, 1];

~notes.choose;
~durs.choose;

/* --- Iteración simple --- */
~notes.do { |n| n.postln };

/* --- Generación sin sonido --- */
Array.fill(8, { |i| 60 + (i * 2) });

/* =========================================================
   SESIÓN 3
   Producción sonora I
   Servidor, UGens y control básico
   ========================================================= */

/* --- Envolvente básica --- */
~envPerc = Env.perc(0.01, 1);

{
    SinOsc.ar(440)
    * EnvGen.kr(~envPerc, doneAction: 2)
    * 0.2
}.play;

/* --- Modulación básica --- */
{
    var mod;
    mod = SinOsc.kr(0.3).range(200, 800);
    SinOsc.ar(mod) * 0.1
}.play;

/* =========================================================
   SESIÓN 4
   Producción sonora II
   Envolventes, control avanzado y SynthDef
   ========================================================= */

/* --- SynthDef básico --- */
SynthDef(\simpleTone, { |freq = 440, amp = 0.1|
    var env, sig;
    env = EnvGen.kr(Env.perc, doneAction: 2);
    sig = SinOsc.ar(freq) * env * amp;
    Out.ar(0, sig ! 2);
}).add;

/* --- Disparar Synths --- */
Synth(\simpleTone, [\freq, 660]);
Synth(\simpleTone, [\freq, 550]);

/* =========================================================
   SESIÓN 5
   Tiempo y estructura musical
   Routines y Patterns
   ========================================================= */

/* --- Routine --- */
(
Routine({
    12.do {
        Synth(
            \simpleTone,
            [\freq, ~notes.choose.midicps]
        );
        ~durs.choose.wait;
    }
}).play;
)

/* --- Patterns --- */
(
Pbind(
    \instrument, \simpleTone,
    \midinote, Pseq(~notes, inf),
    \dur, Prand(~durs, inf),
    \amp, 0.1
).play;
)

/* --- TempoClock --- */
t = TempoClock.new(90/60);

/* =========================================================
   SESIÓN 6
   Live Coding
   Creación musical en tiempo real
   ========================================================= */

/* --- Modificación en vivo --- */
~notes = [60, 63, 65, 70];
~durs  = [0.125, 0.25];

/* --- NodeProxy --- */
Ndef(\sound, {
    var freq;
    freq = LFNoise1.kr(1).range(200, 600);
    SinOsc.ar(freq) * 0.1
}).play;

/* --- Cambiar en tiempo real --- */
Ndef(\sound, {
    Saw.ar(LFNoise1.kr(2).range(100, 400)) * 0.1
});

/* --- Detener --- */
Ndef(\sound).stop;

/* =========================================================
   MAPA CONCEPTUAL FINAL

   Sesión 1 -> sonido mínimo, funciones
   Sesión 2 -> arrays y material
   Sesión 3 -> UGens + envolventes
   Sesión 4 -> instrumentos (SynthDef)
   Sesión 5 -> tiempo (Routines, Patterns)
   Sesión 6 -> live coding (NodeProxy)

   Todo el curso se construye combinando esto.
   ========================================================= */
