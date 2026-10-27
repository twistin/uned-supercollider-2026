/* ================================================================
   SETUP AUDIO UNED: SUPERCOLLIDER + TEAMS
   ================================================================
   INSTRUCCIONES:
   1. Asegúrate de que el Audio MIDI Setup del Mac esté a 48kHz.
   2. Ejecuta el primer bloque (BLOQUE A) para empezar la clase.
   3. Ejecuta el BLOQUE C para abrir el limitador y el cronómetro.
   4. Ejecuta el BLOQUE B al terminar para volver a tu Scarlett sola.
*/

// --- BLOQUE A: INICIO DE CLASE (Monitorización + Streaming) ---
(
// Si venimos de hacer Live Coding (ProxySpace activo), volvemos al entorno estándar
if(currentEnvironment.isKindOf(ProxySpace)) {
    "Saliendo de ProxySpace y volviendo al entorno base...".postln;
    currentEnvironment.pop;
};

s.quit;
s.options.outDevice = "Monitor_y_Streaming_UNED"; // Tu dispositivo de salida múltiple
s.options.numOutputBusChannels = 2;
s.options.numInputBusChannels = 0; // Evita conflictos de Sample Rate con el micro de Teams
s.options.sampleRate = 48000;      // Frecuencia estándar para Teams
s.waitForBoot({
    "=========================================".postln;
    " SERVIDOR CONFIGURADO PARA CLASE UNED ".postln;
    " Escuchas por: Scarlett 2i2 ".postln;
    " Envías a Teams por: BlackHole ".postln;
    "=========================================".postln;

    // Test rápido de sonido (un pitido percusivo)
    { SinOsc.ar(440, 0, 0.05) * EnvGen.kr(Env.perc, doneAction: 2) }.play;
});
)


// --- BLOQUE C: GRABACIÓN ÚNICA EN TEAMS (limitador + índice de bloques) ---
/*
   Ejecutar después del BLOQUE A y ANTES de pulsar "Grabar" en Teams.
   Funciona igual si se ejecuta con el servidor apagado o arrancado.

   1. Limitador en la salida principal: protege contra saturaciones (+0 dB)
      y valores infinitos/NaN. Se recupera solo tras pulsar Cmd+.
   2. Centrado estéreo: en sesiones 1–3 duplica el audio mono al centro
      para que en la grabación de Teams se escuche por ambos oídos.
   3. Ventana "Grabación": cronómetro flotante siempre visible.
      Pulsar "Empezar" al iniciar Teams y "Siguiente bloque" al avanzar.
      Genera automáticamente el archivo con las marcas de tiempo reales.
*/
(
var sesion = 1;                     // <-- CAMBIAR ANTES DE CADA CLASE (1 a 6)
var centrarAudio = (sesion <= 3).asInteger;
var dir = thisProcess.nowExecutingPath !? { |p| p.dirname } ?? { Platform.userHomeDir };
var defLimitador;
var escaletas;
var abrirPanel;

// 0. Si hay un ProxySpace activo (de sesiones de live coding), volver al entorno normal
if(currentEnvironment.isKindOf(ProxySpace)) {
    "Aviso: Se detectó ProxySpace activo. Volviendo al entorno base para la grabación...".postln;
    currentEnvironment.pop;
};

// 1. SynthDef del limitador maestro
defLimitador = SynthDef(\limitadorMaster, { |nivel = 0.89, centrar = 0|
    var sig = Sanitize.ar(In.ar(0, 2));
    sig = Select.ar(centrar, [sig, (sig.sum * 0.71) ! 2]);
    sig = Limiter.ar(LeakDC.ar(sig), nivel, 0.01);
    ReplaceOut.ar(0, sig);
});

// Escaleta de bloques previstos por sesión [título, minuto previsto de inicio]
escaletas = (
    1: [
        ["Primer sonido", 0], ["Conocer el IDE", 10], ["Tres piezas", 20],
        ["Expresiones", 32], ["Leer y ejecutar", 44], ["Variables", 56],
        ["Tipos útiles", 69], ["Ayuda y error", 82], ["Volver al sonido", 94],
        ["Reto y cierre", 107]
    ],
    2: [
        ["Repaso y arrays", 0], ["Operaciones con arrays", 12], ["Funciones básicas", 25],
        ["Argumentos y retorno", 38], ["Azar: rrand y exprand", 50], ["Azar con funciones", 62],
        ["Iteración: do", 75], ["Iteración: collect", 88], ["Función musical makeNotes", 100],
        ["Reto y cierre", 110]
    ],
    3: [
        ["Servidor y primer UGen", 0], ["Tasas: ar vs kr", 12], ["Osciladores y formas de onda", 25],
        ["Fuentes de ruido", 38], ["Modulación LFO", 50], ["Envolvente Env.perc", 62],
        ["Envolvente por etapas", 75], ["Control con argumentos set", 88],
        ["Pequeño instrumento", 100], ["Reto y cierre", 110]
    ],
    4: [
        ["De Function.play a SynthDef", 0], ["Anatomía de un SynthDef", 15],
        ["Argumentos tipados kr", 30], ["doneAction y ciclo de vida", 45],
        ["Envolventes retriggerables", 60], ["Envolventes ADSR sostenidas", 75],
        ["Polifonía con Synth", 90], ["Reto y cierre", 105]
    ],
    5: [
        ["Rutinas y espera temporal", 0], ["TempoClock y BPM", 15],
        ["Introducción a Patterns", 30], ["Pbind y claves de eventos", 45],
        ["Pseq y Prand", 60], ["Pseries y transformaciones", 75],
        ["Cuantización y polirritmia", 90], ["Reto y cierre", 105]
    ],
    6: [
        ["Filosofía del live coding", 0], ["NodeProxy y Ndef", 20],
        ["Reescritura en caliente fadeTime", 40], ["Patterns dentro de Ndef", 60],
        ["Estructura de una sesión", 80], ["Proyecto final y cierre", 100]
    ]
);

// 2. Limitador persistente (sobrevive a Cmd+.)
topEnvironment[\uned_ponerLimitador] !? { |f| ServerTree.remove(f) };
topEnvironment[\uned_ponerLimitador] = { |srv|
    defLimitador.send(srv,
        Synth.basicNew(\limitadorMaster, srv)
        .newMsg(RootNode(srv), [\centrar, centrarAudio], \addToTail)
    );
};
ServerTree.add(topEnvironment[\uned_ponerLimitador]);
if(s.serverRunning) { topEnvironment[\uned_ponerLimitador].(s) };

// 3. Ventana flotante de bloques y cronómetro
abrirPanel = {
    var esc = escaletas[sesion] ?? { 10.collect { |i| ["Bloque %".format(i + 1), nil] } };
    var ruta = dir +/+ "INDICE_SESION_%_%.md".format(sesion, Date.getDate.stamp);
    var t0, actual = -1, marcas = List.new;
    var w, lblBloque, lblReloj, lblPlan, bEmpezar, bSig, bDeshacer;
    var fmt, guardar, refrescar, marcar;

    fmt = { |secs|
        var t = secs.abs.asInteger;
        [t div: 3600, (t % 3600) div: 60, t % 60]
        .collect { |n| n.asString.padLeft(2, "0") }.join(":")
    };

    guardar = {
        File.use(ruta, "w", { |f|
            f.write("# Sesión % — Índice real de la grabación\n\n".format(sesion));
            f.write("> Fecha: %\n\n".format(Date.getDate.format("%Y-%m-%d %H:%M")));
            marcas.do { |m| f.write("- **%** — %\n".format(fmt.(m[0]), m[1])) };
        });
    };

    refrescar = {
        var trans, sig, prev;
        if(t0.isNil) {
            lblBloque.string = "Sesión % · % bloques · lista para iniciar".format(sesion, esc.size);
            lblReloj.string = "--:--:--";
            lblPlan.string = "Pulsa 'Empezar' cuando Teams comience a grabar";
        } {
            trans = Main.elapsedTime - t0;
            sig = esc[actual + 1];
            prev = sig !? { sig[1] } !? { |m| m * 60 };
            lblBloque.string = "Bloque %/% · %".format(actual + 1, esc.size, esc[actual][0]);
            lblReloj.string = fmt.(trans);
            lblPlan.string = case
            { sig.isNil } { "Último bloque de la sesión" }
            { prev.isNil } { "Siguiente: %".format(sig[0]) }
            { prev >= trans } { "Siguiente: % a las % (faltan %)".format(sig[0], fmt.(prev), fmt.(prev - trans)) }
            { "Siguiente: % a las % (vas % tarde)".format(sig[0], fmt.(prev), fmt.(trans - prev)) };
        };
    };

    marcar = {
        if(actual < (esc.size - 1)) {
            actual = actual + 1;
            marcas.add([Main.elapsedTime - t0,
                "%. %".format((actual + 1).asString.padLeft(2, "0"), esc[actual][0])]);
            guardar.();
            bSig.enabled = actual < (esc.size - 1);
            bDeshacer.enabled = actual > 0;
            refrescar.();
        };
    };

    w = Window("Grabación · Sesión %".format(sesion), Rect(40, 40, 460, 160)).alwaysOnTop_(true);
    lblBloque = StaticText().font_(Font.sansSerif(14, true));
    lblReloj  = StaticText().font_(Font.monospace(28));
    lblPlan   = StaticText().font_(Font.sansSerif(12));
    bEmpezar  = Button().states_([["Empezar (Teams grabando)"]]);
    bSig      = Button().states_([["Siguiente bloque →"]]).enabled_(false);
    bDeshacer = Button().states_([["Deshacer paso"]]).enabled_(false);

    bEmpezar.action = {
        t0 = Main.elapsedTime;
        bEmpezar.enabled = false;
        marcar.();
    };
    bSig.action = { marcar.() };
    bDeshacer.action = {
        marcas.pop;
        actual = actual - 1;
        guardar.();
        bSig.enabled = true;
        bDeshacer.enabled = actual > 0;
        refrescar.();
    };

    w.layout = VLayout(lblBloque, lblReloj, lblPlan, HLayout(bEmpezar, bSig, bDeshacer));
    refrescar.();
    SkipJack(refrescar, 0.5, { w.isClosed }, "relojGrabacionUNED");
    w.front;
};

abrirPanel.();
)


// --- BLOQUE B: VOLVER A LA NORMALIDAD (Solo Scarlett) ---
/*
(
s.quit;
s.options.outDevice = "Scarlett 2i2 USB";
s.options.numInputBusChannels = 2;
s.options.sampleRate = nil; // Frecuencia estándar del sistema
s.boot;
)
*/
