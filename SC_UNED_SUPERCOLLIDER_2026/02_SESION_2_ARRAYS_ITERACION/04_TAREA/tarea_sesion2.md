# Tarea — Módulo 1, Sesión 2
## Generar material musical

> **Módulo 1 — Componer con código: introducción a la música algorítmica con SuperCollider**

---

### Ejercicio 1 — Generador de escalas

Escribe una función `~hacerEscala` que:

1. Reciba dos argumentos: `root` (raíz en MIDI, por defecto `60`) y `tipo` (por defecto `\mayor`)
2. Si `tipo` es `\mayor`, use la escala `[0, 2, 4, 5, 7, 9, 11]`
3. Si `tipo` es `\menor`, use la escala `[0, 2, 3, 5, 7, 8, 10]`
4. Devuelva la escala transpuesta a la raíz indicada

*Pista: usa `if(condición, { ... }, { ... })` para la lógica condicional.*

Prueba:
```supercollider
~hacerEscala.(60, \mayor);   // Do mayor
~hacerEscala.(69, \menor);   // La menor
~hacerEscala.(62, \mayor);   // Re mayor
```

---

### Ejercicio 2 — Material rítmico aleatorio

Escribe una función `~makeRhythm` que:

1. Reciba un argumento `numNotas` (por defecto `8`)
2. Use `Array.fill` para crear un array de duraciones aleatorias
3. Las duraciones deben ser solo `0.25`, `0.5` o `1` (corchea, negra, redonda)
4. Devuelva el array

*Pista: crea un array con las opciones `[0.25, 0.5, 1]` y usa `.choose` dentro de `Array.fill`.*

---

### Ejercicio 3 — Transposición colectiva

Dado este array de notas:
```supercollider
~melodia = [60, 62, 64, 65, 67, 69, 71, 72];
```

Usa `collect` para:
1. Transponer cada nota un semitono aleatorio entre -2 y +2
2. Guardar el resultado en `~melodiaVariada`
3. Compara los dos arrays con `.postln`

¿El resultado cambia cada vez que lo evalúas? ¿Por qué?

---

### Desafío opcional — makeChord

Crea una función `~makeChord` que genere un acorde de N notas a partir de los intervalos de una tríada mayor (`[0, 4, 7]`). La función debe:
- Aceptar `root` (raíz en MIDI) y `voicings` (número de voces, por defecto 3)
- Distribuir las voces por octavas si `voicings > 3`

**Tiempo estimado:** 45-60 minutos

---

*Módulo 1 · Tarea Sesión 2 — Componer con código*
