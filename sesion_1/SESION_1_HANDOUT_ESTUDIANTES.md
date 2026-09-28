# SuperCollider · Módulo 1 · Sesión 1
## Del primer sonido al código

> **Módulo 1 — Componer con código: introducción a la música algorítmica con SuperCollider**

---

**Antes de empezar:** instala SuperCollider, conecta auriculares, baja el volumen y abre un documento nuevo. Guarda tu trabajo como `sesion_1_trabajo.scd`. Descarga el archivo complementario `sesion1_codigo_clase.scd`. La sesión se ofrece en **una grabación de dos horas**, con diez bloques internos. Cuando se indique **«Pausa y prueba»**, detén la reproducción y ejecuta el código en tu equipo. No necesitas experiencia previa en programación.

**Índice de la grabación** *(tiempos previstos; se actualizarán con los reales antes de publicar):*

`00:00` primer sonido · `10:00` IDE · `20:00` tres piezas · `32:00` expresiones · `44:00` leer y ejecutar · `56:00` variables · `1:09:00` tipos · `1:22:00` ayuda y error · `1:34:00` variar el sonido · `1:47:00` reto y cierre

---

## 🎯 Al terminar podrás

- Arrancar y parar el servidor de audio
- Reconocer el editor, la Post Window, la ayuda, el lenguaje y el servidor
- Evaluar una línea o un bloque y leer el resultado
- Cambiar un valor, guardarlo en una variable y reconocer tipos sencillos
- Buscar un UGen en la ayuda y hacer una pequeña modificación sonora

---

## 1. Primer sonido *(bloque 01)*

Evalúa cada línea con `Shift+Return`. Espera a que el servidor esté listo antes de iniciar el sonido.

```supercollider
s.boot;
{ SinOsc.ar(440, 0, 0.1) }.play;
```

`440` es la frecuencia en hercios y `0.1` una amplitud prudente. `Cmd+.` (Mac) o `Ctrl+.` (Windows/Linux) detiene todo el sonido. Si no oyes nada, revisa volumen, dispositivo de salida y mensajes de arranque antes de cambiar el código.

> **Pausa y prueba:** cambia `440` por `330` y luego por `660`. ¿Qué cambia al oído? Detén el sonido después de cada prueba.

---

## 2. Tres piezas que cooperan *(bloques 02–03)*

| Pieza | Qué hace | Cómo la reconoces |
|-------|----------|--------------------|
| **IDE** | Editas código, ves mensajes y consultas la ayuda | Ventana de SuperCollider |
| **Lenguaje (sclang)** | Evalúa expresiones y envía instrucciones | Un cálculo funciona sin arrancar el servidor |
| **Servidor (scsynth)** | Calcula el audio en tiempo real | Hay sonido después de `s.boot` |

La Post Window muestra resultados, errores y mensajes de arranque. Su ubicación puede variar según cómo tengas dispuesto el IDE. Prueba `2 + 3;`: la respuesta aparece aunque el servidor no esté arrancado. Para producir sonido, sí necesitas el servidor.

---

## 3. Una expresión produce un resultado *(bloques 04–05)*

```supercollider
4.squared;              // → 16
4.squared.neg;          // → -16
(7.squared - 1).postln; // imprime 48 en Post Window
```

Un **objeto** (por ejemplo, `4`) recibe un **mensaje** o método (`squared`) y produce un **resultado**. El punto conecta receptor y método; `()` pasan argumentos cuando los hay; `;` separa expresiones; `//` introduce un comentario. `4.pow(3)` eleva cuatro al cubo. No necesitas memorizar una jerarquía de clases en esta primera sesión.

**Evaluar código:**
- `Shift+Return` — evalúa la línea actual o la selección
- `Cmd+Return` (Mac) / `Ctrl+Return` (Windows/Linux) — evalúa la línea, la selección o una región delimitada por paréntesis en sus propias líneas

Guarda las pruebas con frecuencia.

> **Pausa y prueba:** antes de ejecutarlo, predice el resultado de `(7.squared - 1).postln;`.

---

## 4. Variables y tipos *(bloques 06–07)*

Una variable guarda un valor que puedes recuperar o cambiar. Para empezar, usa una letra minúscula:

```supercollider
x = 4;
x = x.squared;
x.postln;    // → 16
```

En un bloque puedes declarar nombres más largos con `var` al comienzo:

```supercollider
(
var numero;
numero = 7;
(numero.squared - 1).postln;
)
```

Sitúa el cursor dentro del bloque y usa `Cmd+Return` / `Ctrl+Return`. Verás `48`. Más adelante usaremos variables de entorno con `~` para conservar ejemplos musicales entre ejecuciones; por ahora basta con estas dos formas.

```supercollider
7.class;      // → Integer
7.0.class;    // → Float
"hola".class; // → String
\tono.class;  // → Symbol
true.class;   // → True (pertenece a la familia Boolean)
```

Los números nos servirán para frecuencias y duraciones; los símbolos para nombres estables; las cadenas para texto.

> **Pausa y prueba:** cambia `numero` a `10` y predice la salida antes de evaluar.

---

## 5. Pedir ayuda y leer un error *(bloque 08)*

Escribe `SinOsc`, sitúa el cursor en la palabra y pulsa `Cmd+D` / `Ctrl+D`. Localiza `ar` y los argumentos `freq`, `phase`, `mul` y `add`. No leas toda la página: busca la información que necesites para modificar un ejemplo.

Si aparece un error, lee primero la línea que dice `ERROR`, vuelve al fragmento evaluado y revisa nombre, mayúsculas y paréntesis. Para experimentar con seguridad, escribe `4.cuadrado;` y observa que SuperCollider no reconoce el método; después corrígelo a `4.squared;`.

---

## 6. Volver al sonido *(bloques 09–10)*

```supercollider
s.boot;   // solo si el servidor no está arrancado

x = { SinOsc.ar(440, 0, 0.1) }.play;
x.free;   // detiene solo este sonido
```

Prueba una versión grave (`220`) y otra más aguda (`660`), de una en una. Mantén la amplitud moderada (`0.05–0.15`). Si pierdes el control del sonido: `Cmd/Ctrl+.`

---

## ✅ Reto final

1. Ejecuta un cálculo que imprima `48`
2. Arranca el servidor y produce un sonido suave
3. Cambia su frecuencia y explica qué oyes
4. Detén el sonido y busca `SinOsc` en la ayuda
5. Guarda tu archivo con un comentario de dos líneas: qué has cambiado y qué sucedió

---

## Autocontrol

Puedo señalar qué acción corresponde al IDE, al lenguaje y al servidor; sé dónde aparece un error; sé cómo parar el audio.

Si algo no funciona, envía una duda con **sistema operativo**, **línea evaluada** y **primeras líneas del mensaje de error**. No hace falta enviar capturas de todo el escritorio.

---

**Siguiente sesión:** arrays, funciones y azar controlado para generar material musical.

## 📝 Recursos

- [Documentación oficial de SuperCollider](https://doc.sccode.org/)
- [Foro de SuperCollider](https://scsynth.org/)

---

*Módulo 1 · Sesión 1 de 3 — Componer con código*
