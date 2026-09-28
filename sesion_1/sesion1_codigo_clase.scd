// Módulo 1 · Sesión 1 · SuperCollider
// Evalúa una línea con Shift+Return. Para una región entre paréntesis,
// sitúa el cursor dentro y pulsa Cmd+Return (Mac) / Ctrl+Return (Windows/Linux).
// Antes de reproducir: baja el volumen y usa auriculares.


// 01 · Primer sonido
s.boot;
{ SinOsc.ar(440, 0, 0.1) }.play;
// Cmd+. / Ctrl+. detiene todos los sonidos.
// Prueba 330 y 660 de uno en uno. Detén el sonido antes de repetir.


// 02–03 · Editor, lenguaje y servidor
2 + 3;
// Esta expresión funciona incluso si el servidor de audio no está arrancado.


// 04 · Expresiones y métodos
4.squared;
4.squared.neg;
(7.squared - 1).postln;
4.pow(3);


// 05 · Región: paréntesis exteriores en líneas separadas
(
3.squared.postln;
5.squared.postln;
)


// 06 · Variables
x = 4;
x = x.squared;
x.postln;

(
var numero;
numero = 7;
(numero.squared - 1).postln;
)


// 07 · Tipos
7.class;
7.0.class;
"hola".class;
\tono.class;
true.class;


// 08 · Ayuda y error inocuo
// Pon el cursor en SinOsc y usa Cmd+D / Ctrl+D.
SinOsc;
// 4.cuadrado;   // Descomenta solo para ver un error y luego corrígelo.
4.squared;


// 09 · Sonido controlable
s.boot;   // no hace falta repetir si ya está arrancado
x = { SinOsc.ar(220, 0, 0.1) }.play;
x.free;
// Cambia 220 por 660 y vuelve a evaluar las dos líneas anteriores.


// 10 · Comprobación
(7.squared - 1).postln;
// Comenta aquí qué frecuencia has elegido y qué has oído.
