# SuperCollider — Módulo 1, Sesión 1: El entorno y el lenguaje
## Introducción a SuperCollider: del primer sonido al código

> **Módulo 1 — Componer con código: introducción a la música algorítmica con SuperCollider**

---

## 🎯 Objetivos de la Sesión

Al finalizar esta sesión, serás capaz de:

- ✅ Producir tu primer sonido en SuperCollider
- ✅ Identificar las tres partes que componen el entorno (IDE, intérprete, servidor)
- ✅ Escribir y evaluar expresiones básicas en el lenguaje
- ✅ Entender qué son los objetos, los métodos y la herencia
- ✅ Declarar variables y trabajar con los tipos básicos (Integer, Float, String, Symbol, Boolean)
- ✅ Utilizar el sistema de ayuda y documentación

> **Nota:** Arrays, funciones, aleatoriedad e iteración se verán en la Sesión 2.

---

## 📚 Estructura de la Sesión

### 0. Primer sonido — 5 min *(gancho)*
### 1. Interfaz de SuperCollider — 15 min
### 2. SuperCollider como tres programas — 10 min
### 3. Fundamentos de Programación — 35 min
### 4. Clases básicas y tipos de datos — 20 min
### 5. Ayuda y Documentación — 15 min

---

# 0. Primer sonido 🔊

Antes de explicar nada, hagamos esto:

```supercollider
s.boot;
```

Arranca el servidor de audio. Espera a que en la Post Window aparezca `Server 'localhost' running`.

Ahora evalúa esto:

```supercollider
{ SinOsc.ar(440) * 0.1 }.play;
```

**¡Ya estás haciendo sonido con código.**

Para parar: **Cmd + .** (Mac) o **Ctrl + .** (Windows) — la parada de emergencia.

Prueba a cambiar el número `440` por otro valor y vuelve a ejecutar. Eso que acabas de hacer — escribir código que produce sonido en tiempo real — es exactamente lo que vamos a explorar en este curso.

> *No te preocupes si no entiendes la sintaxis todavía. En los próximos minutos veremos qué significa cada parte.*

---

# 1. Interfaz de SuperCollider


## Tres programas en uno

SuperCollider no es un único programa — son **tres piezas distintas** que trabajan juntas:

```
┌─────────────────────────────────────────┐
│              IDE (SCIDE)                │  ← Lo que ves en pantalla
│  ┌───────────┐  ┌──────────────┐      │
│  │ Workspace │  │ Documentation│      │
│  │ (izquierda)│  │ (arriba der.)│      │
│  └───────────┘  └──────────────┘      │
│  ┌──────────────┐                     │
│  │  Post Window │  ← Mensajes del servidor
│  └──────────────┘                     │
└─────────────────────────────────────────┘
              ↕ comunican
┌─────────────────────────────────────────┐
│         Intérprete (Language)          │  ← Ejecuta el código
│         Lenguaje de programación        │
└─────────────────────────────────────────┘
              ↕
┌─────────────────────────────────────────┐
│         Servidor de Audio               │  ← Genera sonido
│         Motor de síntesis               │
└─────────────────────────────────────────┘
```

### Áreas Principales

| Área | Ubicación | Función |
|------|-----------|---------|
| **Workspace** | Izquierda | Escribes y evalúas código |
| **Documentación** | Arriba derecha | Ayuda y manuales online |
| **Post Window** | Abajo derecha | Resultados, errores, mensajes |

### Preferencias Importantes

**Cmd + .** (Mac) / **Ctrl + .** (Windows)
- 🚨 **PARADA DE EMERGENCIA** - Detiene todo el sonido

**Cmd + Shift + P**
- Limpia la ventana de mensajes

---

# 2. Fundamentos de Programación

## 2.1 Orientación a Objetos

SuperCollider es un lenguaje **orientado a objetos** e **interpretado**.

### Jerarquía de Clases

```
┌─────────────────┐
│      Object      │  ← Todo hereda de aquí
└─────────────────┘
         │
    ┌────┴────┐
    │         │
┌──────────┐ ┌──────────────┐
│Magnitude │ │  Collection  │
└──────────┘ └──────────────┘
    │            │
┌──────────┐ ┌──────────────┐
│  Number  │ │Sequenceable  │
└──────────┘ │ Collection   │
    │       └──────────────┘
  ┌─┴─┐           │
┌───┐ ┌───┐   ┌──────────┬──────────┐
│Int│ │Flt│   │   Array  │  String  │
└───┘ └───┘   └──────────┴──────────┘
```

### Regla Clave

> *"Cuanto más arriba, más general es la clase."*
> *"Cuanto más abajo, más específica es la clase."*

## 2.2 Sintaxis Básica

### Forma: `receiver.method`

```supercollider
4.squared;           // → 16
4.squared.neg;       // → -16
```

### Ejecutar Código

- **Shift + Enter** - Ejecuta la línea actual
- **Cmd + Enter** (Mac) / **Ctrl + Enter** (Windows) - Ejecuta bloque completo

## 2.3 Variables

### Variables del Intérprete (una letra, minúscula)

```supercollider
(
x = 4;           // Asignación
x = x.squared;   // Sobreescritura
x = x.neg;       // Sobreescritura
x;               // Última expresión → valor de retorno
)
```

### Variables con múltiples caracteres (requieren `var`)

```supercollider
(
var numero;
numero = 4;
numero = numero.squared;
numero = numero.neg;
numero;
)
```

### Variables de Entorno (persisten entre pestañas)

```supercollider
~valor = 4;
~valor = ~valor.squared;
~valor;
```

## 2.4 Métodos con Argumentos

```supercollider
4.pow(3);         // 4 elevado a la 3 → 64
4.squared();      // Sin argumentos necesario
```

### Error común

```supercollider
4.pow;            // ERROR: falta el argumento
```

---

# 3. Ejercicios de la Sesión

## Ejercicio 1: Primeros pasos con el lenguaje

Escribe código que:
1. Tome el número 7
2. Lo eleve al cuadrado
3. Le reste 1
4. Muestre el resultado en la Post Window

## Ejercicio 2: Variables

Repite el ejercicio anterior usando una variable llamada `~num`. Observa la diferencia entre `var num` y `~num`.

## Ejercicio 3: Explora con la ayuda

Escribe `SinOsc` en el workspace, coloca el cursor sobre la palabra y pulsa **Cmd+D**. Explora la documentación. ¿Qué otros argumentos acepta además de la frecuencia?

## Ejercicio 4: Modifica el primer sonido

Vuelve al ejemplo de apertura y prueba a:
1. Cambiar la frecuencia (el número `440`)
2. Cambiar la amplitud (el número `0.1`, no pases de `0.3`)
3. Añadir `.neg` a la amplitud — ¿qué ocurre?

---

# 4. Atajos de Teclado Esenciales

| Atajo (Mac) | Atajo (Windows) | Función |
|-------------|-----------------|---------| 
| **Cmd + .** | **Ctrl + .** | 🚨 PARADA DE EMERGENCIA |
| **Shift + Enter** | **Shift + Enter** | Ejecutar línea |
| **Cmd + Enter** | **Ctrl + Enter** | Ejecutar bloque |
| **Cmd + D** | **Ctrl + D** | Abrir ayuda |
| **Shift + Cmd + D** | **Shift + Ctrl + D** | Buscar documentación |
| **Cmd + I** | **Ctrl + I** | Ver implementación |
| **Cmd + Shift + P** | **Ctrl + Shift + P** | Limpiar Post Window |

---

# 5. Próxima Sesión

En la **Sesión 2** trabajaremos con las herramientas que convierten SuperCollider en un generador de material musical:

- **Arrays** — colecciones de notas, ritmos y parámetros
- **Funciones** — código reutilizable y parametrizable
- **Aleatoriedad** — `rrand`, `exprand`, `scramble`
- **Iteración** — `do` y `collect` para recorrer colecciones
- **Ejercicio musical:** construiremos juntos `~makeNotes`, una función que genera acordes en cualquier tonalidad

---

## 📝 Recursos Adicionales

- [Documentación oficial de SuperCollider](https://doc.sccode.org/)
- [Foro de SuperCollider](https://scsynth.org/)
- [Comunidad TOPLAP — Live Coding](https://toplap.org/)
- Cheatsheet de Arrays (en los materiales del curso)

---

**¡Bienvenido/a a SuperCollider!** 🎹

*Módulo 1 · Sesión 1 de 3 — Componer con código*

