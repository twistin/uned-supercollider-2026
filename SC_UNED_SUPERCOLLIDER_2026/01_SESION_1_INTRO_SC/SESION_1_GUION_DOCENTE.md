# Sesión 1 · Guion docente para una grabación con diez bloques

Este documento acompaña la escaleta de `PLAN_GRABACION.md`. **La UNED ha indicado que debe haber una única grabación por sesión.** Los diez apartados siguientes son bloques internos, sin detener y reiniciar Teams. Los tiempos son orientativos; anota los inicios reales para el índice. El código ejecutable se encuentra en `sesion1_codigo_clase.scd`. Mantén visible la Post Window cuando muestres resultados y aumenta la letra del editor antes de grabar.

---

## Bloque 01 · Primer sonido · 10 min · desde 00:00

**Abre:** «Vamos a conseguir un sonido antes de aprender las reglas del lenguaje». Muestra auriculares, volumen bajo, `s.boot;`, espera el mensaje de servidor listo y ejecuta el oscilador. Explica solo `440` y `0.1`. Detén con Cmd/Ctrl+.; repite con 330. **Transición:** «Puedes pausar el vídeo, probar 660 y detener el audio. Seguimos con el entorno». Si falla el servidor, muestra cómo reconocer el fallo en Post Window, sin convertir este bloque en una guía de instalación.

---

## Bloque 02 · Conocer el IDE · 10 min · desde 10:00

**Pregunta:** «¿Dónde escribo y dónde aparece la respuesta?». Enseña editor, Post Window, ayuda, estado de servidor y Guardar como. Ejecuta `2 + 3;`; señala la respuesta. Reorganiza un panel para mostrar que las posiciones varían. **Transición:** localizar los cuatro elementos en su propia pantalla.

---

## Bloque 03 · Tres piezas · 12 min · desde 20:00

Con servidor parado, ejecuta `2 + 3;`. Luego arráncalo y ejecuta un sonido. Dibuja brevemente IDE → lenguaje → servidor; explica que los cálculos los interpreta el lenguaje y el servidor produce audio. Vuelve a parar. **Transición:** el alumnado escribe una frase propia para cada pieza.

---

## Bloque 04 · Expresiones · 12 min · desde 32:00

Predice `4.squared`, ejecútalo, encadena `.neg`; pide predecir `(7.squared - 1)`. Muestra `.postln`. Usa palabras «valor», «mensaje» y «resultado»; no un árbol de herencia. **Transición:** predicción de 48 y comprobación.

---

## Bloque 05 · Leer y ejecutar · 12 min · desde 44:00

Subraya punto, `;`, paréntesis y comentario en dos líneas reales. Muestra `Shift+Return` en línea y `Cmd/Ctrl+Return` dentro de región con paréntesis en líneas separadas. Provoca un fallo sencillo quitando un cierre, lee el error y recupéralo. **Transición:** tres evaluaciones independientes.

---

## Bloque 06 · Variables · 13 min · desde 56:00

Usa `x = 4;`, `x = x.squared;`, `x.postln;`. Después escribe un bloque con `var numero;` y muestra por qué `var` se declara al comienzo. Compara cambiar el valor inicial y volver a ejecutar. **Transición:** modificar 7 por 10 y anticipar 99. No introducir `~num` aquí.

---

## Bloque 07 · Tipos · 13 min · desde 1:09:00

Ejecuta `.class` sobre `7`, `7.0`, `"hola"`, `\tono`, `true`. Conecta cada uno con una futura tarea musical sin explicar toda la herencia. Compara `7` y `7.0`. **Transición:** identificar cuatro ejemplos dados.

---

## Bloque 08 · Ayuda y error · 12 min · desde 1:22:00

Abre la ayuda de `SinOsc`; localiza `freq`, `phase`, `mul`, `add` y un ejemplo. Ejecuta un método inexistente (`4.cuadrado;`), localiza «ERROR» y corrige a `squared`. **Transición:** buscar un argumento de `SinOsc` sin leer toda la documentación.

---

## Bloque 09 · Variar el sonido · 13 min · desde 1:34:00

Guarda un synth en `x`, muestra `x.free`. Alterna 220 y 660 con volumen prudente. Contrasta frecuencia y amplitud; nunca reproduzcas a la vez muchos ejemplos de la misma amplitud. **Transición:** anotar qué cambio afectó a altura y cuál a intensidad.

---

## Bloque 10 · Reto y cierre · 13 min · desde 1:47:00

Resuelve los cinco pasos del reto final modelando el razonamiento y mostrando una dificultad pequeña. Deja el código limpio y guardado. Repite las tres reglas: evaluar una línea, parar el audio y pedir ayuda. Anuncia que en la sesión 2 las colecciones de notas sustituirán los números aislados. **Cierra:** instrucciones de autocontrol y canal de dudas indicado por la UNED.

---

## Transiciones e índice

Al comenzar cada bloque, anuncia su número y título en voz alta. Al final: «Puedes pausar el vídeo y probar...» con una única acción, y pasa al bloque siguiente. Mantén la misma numeración en el handout y el código. Evita transiciones largas, música de fondo y texto pequeño. Después de grabar, sustituye en el índice los tiempos previstos por los reales. Si el reproductor institucional ofrece capítulos manuales, añádelos a la única grabación.
