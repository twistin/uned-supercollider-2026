# Tarea — Módulo 1, Sesión 1
## El entorno y el lenguaje

> **Módulo 1 — Componer con código: introducción a la música algorítmica con SuperCollider**

---

### Antes de empezar

Asegúrate de que SuperCollider está instalado y de que puedes arrancar el servidor con `s.boot` sin errores. Si tienes problemas de instalación, consulta el foro del curso o la [guía oficial de instalación](https://supercollider.github.io/).

---

### Ejercicio 1 — Exploración básica del lenguaje

Escribe un bloque de código (entre paréntesis) que:

1. Cree una variable de entorno `~miNumero` con el valor `13`
2. Lo eleve al cuadrado
3. Le reste 1
4. Compruebe si el resultado es primo con `.isPrime`
5. Devuelva el resultado booleano

**Resultado esperado en la Post Window:** `true` o `false` dependiendo del cálculo.

---

### Ejercicio 2 — Orden de operaciones

Predice el resultado de cada expresión **antes de evaluarla**. Anota tu predicción y luego evalúa para comprobar:

```supercollider
3 + 4 * 2;
3 + (4 * 2);
10 - 3.squared;
(10 - 3).squared;
2.pow(3) + 1;
```

¿Qué regla describes a partir de los resultados?

---

### Ejercicio 3 — Tipos de datos

Escribe una línea de código que convierta cada elemento al tipo indicado:

| Original | Convertir a |
|----------|-------------|
| `42` | Float |
| `3.7` | Integer (redondeado abajo) |
| `"supercollider"` | Symbol |
| `\musica` | String |
| `true` | Integer (¿qué valor tiene?) |

*Pista: busca los métodos `asFloat`, `asInteger`, `asSymbol`, `asString` en la ayuda.*

---

### Entrega

No hay entrega formal — estos ejercicios son para tu práctica personal. En la próxima sesión abriremos con 10 minutos de puesta en común: ¿qué funcionó bien, qué dio problemas?

**Tiempo estimado:** 30-45 minutos

---

*Módulo 1 · Tarea Sesión 1 — Componer con código*
