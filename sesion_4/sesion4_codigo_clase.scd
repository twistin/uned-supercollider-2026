/* =========================================================
   SuperCollider — Código de Sesión 4
   Módulo 2: Música en tiempo real
   Sesión 4: Instrumentos con SynthDef
   =========================================================

   INSTRUCCIONES:
   - Evalúa primero s.boot
   - Los SynthDef deben evaluarse ANTES de crear instancias con Synth
   - Usa s.plotTree para ver los nodos activos

*/

/* ---------------------------------------------------------
   0. SETUP
   --------------------------------------------------------- */

s.boot;
s.plotTree;    // árbol visual de nodos activos

/* ---------------------------------------------------------
   1. DE Function.play A SynthDef
   --------------------------------------------------------- */

// Forma antigua (atajo)
{ SinOsc.ar(440) * 0.1 ! 2 }.play;

// Forma explícita: SynthDef + Synth
SynthDef(\tono1, {
    var sig;
    sig = SinOsc.ar(440) * 0.1;
    Out.ar(0, sig ! 2);
}).add;

x = Synth(\tono1);   // crear instancia
x.free;              // liberar

/* ---------------------------------------------------------
   2. ARGUMENTOS EN SynthDef
   --------------------------------------------------------- */

SynthDef(\tono2, {
    arg freq = 440, amp = 0.1, pan = 0;
    var sig;
    sig = SinOsc.ar(freq) * amp;
    sig = Pan2.ar(sig, pan);
    Out.ar(0, sig);
}).add;

// Crear con parámetros
x = Synth(\tono2, [\freq, 660, \amp, 0.05]);

// Modificar en tiempo real
x.set(\freq, 880);
x.set(\pan, -0.8);
x.set(\amp, 0.15);
x.set(\freq, 220, \pan, 0.8);

x.free;

/* ---------------------------------------------------------
   3. ARGUMENTOS TIPADOS (forma recomendada)
   --------------------------------------------------------- */

SynthDef(\tono3, {
    var freq  = \freq.kr(440);
    var amp   = \amp.kr(0.1);
    var pan   = \pan.kr(0);
    var sig;

    sig = SinOsc.ar(freq) * amp;
    sig = Pan2.ar(sig, pan);
    Out.ar(0, sig);
}).add;

x = Synth(\tono3);
x.set(\freq, 550, \pan, 0.5);
x.free;

/* ---------------------------------------------------------
   4. doneAction Y CICLO DE VIDA
   --------------------------------------------------------- */

// SynthDef con envolvente y doneAction
SynthDef(\perc, {
    var freq  = \freq.kr(440);
    var amp   = \amp.kr(0.2);
    var atk   = \atk.kr(0.01);
    var rel   = \rel.kr(1);
    var env   = EnvGen.kr(Env.perc(atk, rel), doneAction: 2);  // ← se libera solo
    var sig;

    sig = SinOsc.ar(freq) * env * amp;
    Out.ar(0, sig ! 2);
}).add;

// Disparar — se destruye solo al terminar la envolvente
Synth(\perc, [\freq, 440]);
Synth(\perc, [\freq, 660, \rel, 0.3]);
Synth(\perc, [\freq, 880, \atk, 0.1, \rel, 2]);

// Verificar en s.plotTree que no quedan nodos residuales

/* ---------------------------------------------------------
   5. ENVOLVENTE RE-TRIGGERABLE
   --------------------------------------------------------- */

SynthDef(\retrigg, {
    var freq  = \freq.kr(440);
    var amp   = \amp.kr(0.2);
    var trig  = \trig.tr(1);    // trigger: se activa un ciclo y vuelve a 0
    var env   = EnvGen.kr(
        Env.perc(0.01, 0.5),
        trigger: trig,
        doneAction: 0    // NO liberar — el synth persiste
    );
    var sig;

    sig = SinOsc.ar(freq) * env * amp;
    Out.ar(0, sig ! 2);
}).add;

x = Synth(\retrigg);

// Re-disparar sin crear nuevo synth
x.set(\trig, 1);
x.set(\freq, 660);
x.set(\trig, 1);
x.set(\freq, 880);
x.set(\trig, 1);

x.free;

/* ---------------------------------------------------------
   6. ENVOLVENTE ADSR (sostenida con gate)
   --------------------------------------------------------- */

SynthDef(\pad, {
    var freq  = \freq.kr(440);
    var amp   = \amp.kr(0.1);
    var gate  = \gate.kr(1);    // 1=sostenido, 0=release
    var env   = EnvGen.kr(
        Env.adsr(0.3, 0.2, 0.7, 1.0),
        gate: gate,
        doneAction: 2
    );
    var sig;

    sig = Saw.ar([freq, freq * 1.005]) * env * amp;  // ligero detune estéreo
    Out.ar(0, sig);
}).add;

x = Synth(\pad, [\freq, 220]);    // empieza A→D→S
x.set(\gate, 0);                   // inicia R (release)

// Acorde
(
x = [220, 275, 330, 440].collect { |f|
    Synth(\pad, [\freq, f, \amp, 0.05])
};
)

x.do { |s| s.set(\gate, 0) };   // liberar todo el acorde

/* ---------------------------------------------------------
   7. LAG — TRANSICIONES SUAVES
   --------------------------------------------------------- */

SynthDef(\conLag, {
    var freq  = \freq.kr(440).lag(1);    // 1 segundo de glissando
    var amp   = \amp.kr(0.1).lag(0.2);
    var sig;

    sig = SinOsc.ar(freq) * amp;
    Out.ar(0, sig ! 2);
}).add;

x = Synth(\conLag);
x.set(\freq, 880);    // glissando suave de 1s hacia 880
x.set(\freq, 220);    // y baja de vuelta
x.set(\freq, 660);
x.free;

/* ---------------------------------------------------------
   8. BATERÍA BÁSICA — tres SynthDefs
   --------------------------------------------------------- */

// Kick — seno descendente
SynthDef(\kick, {
    var freq  = EnvGen.kr(Env([150, 60], [0.15], \exp));
    var amp   = \amp.kr(0.5);
    var env   = EnvGen.kr(Env.perc(0.001, 0.4), doneAction: 2);
    var sig   = SinOsc.ar(freq) * env * amp;
    Out.ar(0, sig ! 2);
}).add;

// Snare — seno + ruido
SynthDef(\snare, {
    var amp  = \amp.kr(0.3);
    var env  = EnvGen.kr(Env.perc(0.001, 0.2), doneAction: 2);
    var tone = SinOsc.ar(200);
    var noise = WhiteNoise.ar;
    var sig  = (tone * 0.4 + noise * 0.6) * env * amp;
    Out.ar(0, sig ! 2);
}).add;

// Hihat — ruido filtrado
SynthDef(\hihat, {
    var amp  = \amp.kr(0.15);
    var env  = EnvGen.kr(Env.perc(0.001, 0.08), doneAction: 2);
    var sig  = HPF.ar(WhiteNoise.ar, 8000) * env * amp;
    Out.ar(0, sig ! 2);
}).add;

// Probar
Synth(\kick);
Synth(\snare);
Synth(\hihat);

/* ---------------------------------------------------------
   9. PLANTILLA LIMPIA PARA TUS SynthDefs
   --------------------------------------------------------- */

SynthDef(\miInstrumento, {

    // Argumentos
    var freq  = \freq.kr(440);
    var amp   = \amp.kr(0.1);
    var pan   = \pan.kr(0);
    var gate  = \gate.kr(1);
    var atk   = \atk.kr(0.01);
    var rel   = \rel.kr(1);

    // Envolvente
    var env = EnvGen.kr(
        Env.perc(atk, rel),
        doneAction: 2
    );

    // Señal
    var sig = SinOsc.ar(freq) * env * amp;

    // Salida
    Out.ar(0, Pan2.ar(sig, pan));

}).add;

Synth(\miInstrumento, [\freq, 440]);
