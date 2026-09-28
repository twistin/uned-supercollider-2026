/* ================================================================
   SETUP AUDIO UNED: SUPERCOLLIDER + TEAMS
   ================================================================
   INSTRUCCIONES:
   1. Asegúrate de que el Audio MIDI Setup del Mac esté a 48kHz.
   2. Ejecuta el primer bloque para empezar la clase.
   3. Ejecuta el segundo bloque al terminar para usar tu Scarlett sola.
*/

// --- BLOQUE A: INICIO DE CLASE (Monitorización + Streaming) ---
(
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

   1. Limitador en la salida principal. Se vuelve a colocar solo
      tras Cmd+. y tras s.quit / s.boot (bloque 03 de la sesión 1).
      Evita saturaciones y NaN en la única grabación de cada sesión.
   2. ~centrar: en las sesiones 1–3 casi todos los ejemplos son mono y
      solo suenan por el canal izquierdo. Para la grabación se envían a
      los dos canales (el alumnado, en su ordenador, seguirá oyéndolos
      solo por la izquierda).
   3. Ventana "Grabación": pulsa "Empezar" cuando Teams indique que está
      grabando y "Siguiente bloque" al anunciar cada bloque. Muestra el
      tiempo transcurrido y si vas adelantado o retrasado respecto a la
      escaleta. Cada pulsación guarda INDICE_SESION_N_<fecha>.md junto a
      este archivo: el índice con tiempos reales para el handout y los
      capítulos del vídeo. No escribe nada en la Post Window.
*/
(
var dir = thisProcess.nowExecutingPath !? { |p| p.dirname } ?? { Platform.userHomeDir };
var defLimitador = SynthDef(\limitadorMaster, { |nivel = 0.89, centrar = 0|
    var sig = Sanitize.ar(In.ar(0, 2));
    sig = Select.ar(centrar, [sig, (sig.sum * 0.71) ! 2]);
    sig = Limiter.ar(LeakDC.ar(sig), nivel, 0.01);
    ReplaceOut.ar(0, sig);
});

~sesion = 1;                    // <-- CAMBIAR antes de cada clase
~centrar = (~sesion <= 3).asInteger;

// Escaleta: [título, minuto previsto de inicio] (PLAN_GRABACION.md)
~escaletas = (
    1: [
        ["Primer sonido", 0], ["Conocer el IDE", 10], ["Tres piezas", 20],
        ["Expresiones", 32], ["Leer y ejecutar", 44], ["Variables", 56],
        ["Tipos útiles", 69], ["Ayuda y error", 82], ["Volver al sonido", 94],
        ["Reto y cierre", 107]
    ]
    // 2: [ ... ], al cerrar la escaleta de cada sesión
);

// ---- 1. Limitador persistente ----
if(~ponerLimitador.notNil) { ServerTree.remove(~ponerLimitador) };
~ponerLimitador = { |srv|
    // el Synth se crea cuando el servidor ya ha recibido la SynthDef
    defLimitador.send(srv,
        Synth.basicNew(\limitadorMaster, srv)
        .newMsg(RootNode(srv), [\centrar, ~centrar], \addToTail)
    );
};
ServerTree.add(~ponerLimitador);
if(s.serverRunning) { ~ponerLimitador.(s) };

// ---- 2. Ventana de bloques y cronómetro ----
~abrirPanel = {
    var sesion = ~sesion;
    var esc = ~escaletas[sesion] ?? { 10.collect { |i| ["Bloque %".format(i + 1), nil] } };
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
            f.write("# Sesión % — índice de la grabación\n\n".format(sesion));
            marcas.do { |m| f.write("- **%** — %\n".format(fmt.(m[0]), m[1])) };
        });
    };

    refrescar = {
        var trans, sig, prev;
        if(t0.isNil) {
            lblBloque.string = "Sesión % · % bloques · sin empezar".format(sesion, esc.size);
            lblReloj.string = "--:--:--";
            lblPlan.string = "Pulsa Empezar cuando Teams esté grabando";
        } {
            trans = Main.elapsedTime - t0;
            sig = esc[actual + 1];
            prev = sig !? { sig[1] } !? { |m| m * 60 };
            lblBloque.string = "Bloque %/% · %".format(actual + 1, esc.size, esc[actual][0]);
            lblReloj.string = fmt.(trans);
            lblPlan.string = case
            { sig.isNil } { "Último bloque" }
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

    w = Window("Grabación · Sesión %".format(sesion), Rect(40, 40, 440, 150)).alwaysOnTop_(true);
    lblBloque = StaticText().font_(Font.sansSerif(14, true));
    lblReloj  = StaticText().font_(Font.monospace(28));
    lblPlan   = StaticText().font_(Font.sansSerif(12));
    bEmpezar  = Button().states_([["Empezar (Teams grabando)"]]);
    bSig      = Button().states_([["Siguiente bloque →"]]).enabled_(false);
    bDeshacer = Button().states_([["Deshacer"]]).enabled_(false);

    bEmpezar.action = {
        t0 = Main.elapsedTime;
        bEmpezar.enabled = false;
        marcar.();
    };
    bSig.action = { marcar.() };
    bDeshacer.action = {           // por si se pulsa "Siguiente" por error
        marcas.pop;
        actual = actual - 1;
        guardar.();
        bSig.enabled = true;
        bDeshacer.enabled = actual > 0;
        refrescar.();
    };

    w.layout = VLayout(lblBloque, lblReloj, lblPlan, HLayout(bEmpezar, bSig, bDeshacer));
    refrescar.();
    SkipJack(refrescar, 0.5, { w.isClosed }, "relojGrabacion");   // sobrevive a Cmd+.
    w.front;
};

~abrirPanel.();
)


// --- BLOQUE B: VOLVER A LA NORMALIDAD (Solo Scarlett) ---
/*
(
s.quit;
s.options.outDevice = "Scarlett 2i2 USB";
s.options.numInputBusChannels = 2;
s.options.sampleRate = nil; // O 44100 si es tu estándar personal
s.boot;
)
*/