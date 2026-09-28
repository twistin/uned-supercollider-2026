/* =========================================================
   SuperCollider — Código de Sesión 6
   Módulo 2: Música en tiempo real
   Sesión 6: Live Coding con NodeProxy y Ndef
   =========================================================

   INSTRUCCIONES:
   - Evalúa s.boot primero
   - Evalúa el bloque de SynthDefs antes de los Ndef
   - Este archivo está pensado para ejecutarse SECCIÓN A SECCIÓN
   - La última sección (8) es un punto de partida para tu proyecto

*/

/* ---------------------------------------------------------
   0. SETUP
   --------------------------------------------------------- */

s.boot;

// SynthDefs base (los mismos de Sesión 4 y 5)
(
SynthDef(\nota, {
    var freq = \freq.kr(440);
    var amp  = \amp.kr(0.1);
    var pan  = \pan.kr(0);
    var rel  = \rel.kr(0.3);
    var env  = EnvGen.kr(Env.perc(0.01, rel), doneAction: 2);
    var sig  = SinOsc.ar(freq) * env * amp;
    Out.ar(0, Pan2.ar(sig, pan));
}).add;

SynthDef(\pad, {
    var freq  = \freq.kr(220);
    var amp   = \amp.kr(0.05);
    var gate  = \gate.kr(1);
    var env   = EnvGen.kr(Env.adsr(0.5, 0.2, 0.8, 1.5), gate: gate, doneAction: 2);
    var sig   = Saw.ar([freq, freq * 1.003]) * env * amp;
    Out.ar(0, sig);
}).add;

SynthDef(\kick, {
    var freq = EnvGen.kr(Env([150, 60], [0.15], \exp));
    var env  = EnvGen.kr(Env.perc(0.001, 0.4), doneAction: 2);
    Out.ar(0, (SinOsc.ar(freq) * env * 0.5) ! 2);
}).add;

SynthDef(\hihat, {
    var env = EnvGen.kr(Env.perc(0.001, 0.06), doneAction: 2);
    Out.ar(0, (HPF.ar(WhiteNoise.ar, 8000) * env * 0.15) ! 2);
}).add;
)

/* ---------------------------------------------------------
   1. Ndef BÁSICO
   --------------------------------------------------------- */

// Crear y lanzar
Ndef(\x, { SinOsc.ar(440) * 0.1 }).play;

// Reemplazar el contenido sin interrumpir
Ndef(\x, { Saw.ar(220) * 0.1 });
Ndef(\x, { Pulse.ar(330) * 0.1 });
Ndef(\x, { PinkNoise.ar * 0.05 });

// Parar con fade-out
Ndef(\x).stop(2);

/* ---------------------------------------------------------
   2. fadeTime — transiciones suaves entre fuentes
   --------------------------------------------------------- */

Ndef(\x).fadeTime = 4;    // 4 segundos de transición

Ndef(\x, { SinOsc.ar(220) * 0.1 }).play;
Ndef(\x, { Saw.ar(440) * 0.1 });           // transición de 4s
Ndef(\x, { PinkNoise.ar * 0.05 });          // transición de 4s
Ndef(\x, { SinOsc.ar([220,330,440]) * 0.04 });  // acorde

Ndef(\x).stop(4);

/* ---------------------------------------------------------
   3. Ndef CON ARGUMENTOS
   --------------------------------------------------------- */

(
Ndef(\x, { |freq = 440, amp = 0.1|
    SinOsc.ar(freq) * amp
}).play;
)

Ndef(\x).set(\freq, 660);
Ndef(\x).set(\amp, 0.05);
Ndef(\x).set(\freq, 220, \amp, 0.15);
Ndef(\x).stop;

/* ---------------------------------------------------------
   4. Ndef CON PBIND
   --------------------------------------------------------- */

// Ndef puede contener un Pbind como fuente
Ndef(\melodia, Pbind(
    \instrument, \nota,
    \midinote,   Pseq([60, 62, 64, 67, 69], inf),
    \dur,        0.25,
    \amp,        0.1
)).play;

// Reemplazar el Pbind en tiempo real (el tempo continúa)
Ndef(\melodia, Pbind(
    \instrument, \nota,
    \midinote,   Prand([60, 63, 65, 70, 72], inf),
    \dur,        Prand([0.125, 0.25, 0.5], inf),
    \amp,        0.08
));

Ndef(\melodia).stop;

/* ---------------------------------------------------------
   5. CAPAS SIMULTÁNEAS
   --------------------------------------------------------- */

Ndef(\pad,     { SinOsc.ar([220, 275, 330]) * 0.04 }).play;
Ndef(\melodia, Pbind(\instrument, \nota, \midinote, Prand([60,64,67,71],inf), \dur, 0.25)).play;
Ndef(\kick,    Pbind(\instrument, \kick, \dur, 1)).play;
Ndef(\hihat,   Pbind(\instrument, \hihat, \dur, 0.25)).play;

// Silenciar capas individualmente
Ndef(\pad).stop(2);
Ndef(\melodia).stop;
Ndef(\kick).stop;
Ndef(\hihat).stop;

// Limpiar todo
Ndef.clear;

/* ---------------------------------------------------------
   6. MODIFICAR CAPAS EN TIEMPO REAL
   --------------------------------------------------------- */

Ndef(\x).fadeTime = 2;
Ndef(\x, { SinOsc.ar([220, 330, 440]) * 0.05 }).play;

// Reescribir el oscilador mientras suena
Ndef(\x, { Saw.ar([220, 330, 440]) * 0.05 });

// Añadir modulación
Ndef(\x, {
    var freq = [220, 330, 440] + LFNoise1.kr(0.3 ! 3).range(-5, 5);
    Saw.ar(freq) * 0.05
});

// Filtrar
Ndef(\x, {
    var freq = [220, 330, 440];
    var sig  = Saw.ar(freq) * 0.1;
    RLPF.ar(sig, LFNoise1.kr(0.2).range(300, 2000), 0.3)
});

Ndef(\x).stop(3);

/* ---------------------------------------------------------
   7. ESQUELETO DE SESIÓN DE LIVE CODING
   =========================================================

   Esta sección es una plantilla para tu sesión de proyecto.
   Evalúa los bloques en orden para construir la música capas.
   Adapta el contenido a tu gusto.

   Flujo sugerido:
   0. SILENCIO — cargar todo sin lanzar nada
   1. Primera capa — el pulso o el pad base
   2. Segunda capa — melodía o contrapunto
   3. Modificación — cambiar algo en tiempo real
   4. Tercera capa — elemento adicional
   5. Deconstrucción — silenciar capas de una en una
   6. SILENCIO

   --------------------------------------------------------- */

// --- SETUP (evalúa antes de empezar) ---
(
~clock = TempoClock(120/60);
~clock.permanent = true;
Ndef.defaultServer = s;
)

// --- CAPA 1: pad base ---
(
Ndef(\base).fadeTime = 3;
Ndef(\base, {
    var sig = Saw.ar([220, 220.3]) * 0.04;
    RLPF.ar(sig, 600, 0.5)
}).play;
)

// --- CAPA 2: melodía ---
(
Ndef(\mel, Pbind(
    \instrument, \nota,
    \midinote,   Pseq([60, 62, 64, 67], inf),
    \dur,        0.5,
    \amp,        0.1,
    \rel,        0.4
)).play(~clock, quant: 4);
)

// --- MODIFICAR EN TIEMPO REAL ---
Ndef(\mel, Pbind(
    \instrument, \nota,
    \midinote,   Prand([60, 62, 64, 65, 67, 69], inf),
    \dur,        Prand([0.25, 0.5, 0.25, 1], inf),
    \amp,        Pseq([0.1, 0.07, 0.12, 0.05], inf)
));

// --- CAPA 3: pulso rítmico ---
Ndef(\ritmo, Pbind(\instrument, \kick, \dur, 1)).play(~clock, quant: 4);
Ndef(\hh,    Pbind(\instrument, \hihat, \dur, 0.25)).play(~clock, quant: 4);

// --- DECONSTRUCCIÓN ---
Ndef(\mel).stop(2);
Ndef(\hh).stop;
Ndef(\ritmo).stop(2);
Ndef(\base).stop(4);

// --- SILENCIO ---
// Cmd + . como garantía final
