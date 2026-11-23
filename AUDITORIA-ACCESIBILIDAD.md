# Auditoría de UX y accesibilidad (WCAG 2.2, nivel AA)

Sitio: Charla de carreras 2027 (`index.html`, `assets/`).
Fecha: 23 de noviembre de 2026.
Método: revisión del código (HTML, CSS y JS), cálculo de contraste de los tokens de color en tema claro y oscuro, y prueba en navegador a 375 px y en escritorio.

## Resumen

El sitio parte de una base muy buena: HTML semántico, enlace para saltar al contenido, foco visible global, `lang="es-AR"`, íconos marcados como decorativos, textos para lectores de pantalla en el mapa y en el avance, pestañas con teclado, tablas que se apilan en el celular, región `aria-live` y respeto por "reducir movimiento". El texto cumple con el contraste en todos los casos.

Se encontraron 9 problemas. Se corrigieron 8. Queda 1 menor y algunas recomendaciones.

## Problemas corregidos

| # | Criterio WCAG | Nivel | Problema | Corrección |
|---|---|---|---|---|
| 1 | 4.1.2 Nombre, función, valor | A | En pantallas de menos de 480 px el texto "Paradas" del botón de menú se oculta con `display:none` y el botón quedaba **sin nombre accesible**. | `aria-label="Paradas"` en `#menu-btn` (coincide con el texto visible, 2.5.3). |
| 2 | 2.4.3 Orden del foco y 2.4.11 Foco no oculto | A / AA | En el celular el panel de paradas se abre encima del contenido, pero en el DOM está lejos: con Tab el foco seguía por el contenido tapado por el panel. | Al abrir, el foco pasa a la parada actual del panel. Si el foco sale del panel, el panel se cierra. Escape ya devolvía el foco al botón. |
| 3 | 2.2.2 Pausar, detener, ocultar | A | Animaciones decorativas en bucle infinito sin forma de detenerlas: punto "respirando" en las inscripciones abiertas, aro de la parada actual, flecha y brillo de los desplegables. | Ahora se repiten 1 o 2 veces y terminan antes de los 5 s. Con "reducir movimiento" no se ejecutan. |
| 4 | 4.1.3 Mensajes de estado (UX de lector de pantalla) | AA | El resultado de la escala (`aria-live`) se recalculaba **con cada tecla** al escribir el nombre de la carrera, así que el lector anunciaba un mensaje nuevo por letra. | Mientras se escribe solo se guarda. El resultado se actualiza al salir del campo o al elegir un número. |
| 5 | 3.3.2 Etiquetas o instrucciones | A | En la escala hay números que se desactivan solos (no se puede repetir un valor entre carreras) y una forma de deseleccionar (tocar de nuevo o Suprimir) que no se explicaba en ningún lado. | Texto de ayuda visible arriba de la escala, vinculado a cada grupo con `aria-describedby`. |
| 6 | 1.4.11 Contraste de elementos no textuales | AA | El borde del campo "nombre de la carrera" tenía un contraste de 1,37:1 y el borde de los números de la escala, de 2:1. | Bordes recalculados con `color-mix` para superar 3:1 en los dos temas. |
| 7 | 2.4.7 Foco visible | AA | En el campo de la escala, `outline:none` dejaba como foco solo un cambio de color del borde. | Contorno de foco de 3 px con `:focus-visible`, igual que en el resto del sitio. |
| 8 | 1.3.1 Información y relaciones / 4.1.2 | A | `.chain` (Miedos → Excusas → ~~Éxitos~~) tenía `aria-label` en un `div` sin rol, que los lectores ignoran, y el tachado no se transmitía. | `role="img"`, así se lee la frase completa del `aria-label`. |
| 9 | 2.4.6 Encabezados y etiquetas | AA | Los seis botones de animación se llamaban todos "Reproducir", así que en la lista de botones del lector no se podían distinguir. | Se agrega el nombre de la animación con texto oculto: "Reproducir: Los cuatro niveles", etc. |

Extra (buena práctica de ARIA, no es un fallo de WCAG): los paneles de pestañas tienen ahora `tabindex="0"` para llegar al contenido después de elegir una pestaña.

### Ajustes después de la revisión visual

- **Codificación del CSS:** los rótulos "Línea 1" y "Línea 2" del panel se veían como "LÃ­NEA" cuando el servidor no declaraba UTF-8. Se agregó `@charset "UTF-8";` a los dos CSS y la "í" se escribió como escape (`L\00EDnea`).
- **Botones con color según su significado:** Borrar y Borrar mi avance en rojo (`--no`, 5,98:1 en tema claro y 8,2:1 en oscuro), "Copiada" en verde (`--yes`) y "No se pudo copiar" en rojo. El ícono toma el mismo color que el texto.
- **Escala:** la ayuda ocupa todo el ancho de la grilla, y el ícono del botón Borrar dejó de ser amarillo sobre blanco.

### Segunda revisión: contraste de cada texto en pantalla y calendario en el celular

Primero se midió el contraste de los colores de diseño (tokens). En esta segunda revisión se midió cada texto visible contra su fondo real, sumando la opacidad y los fondos semitransparentes, en los dos temas. Aparecieron casos que la medición de los tokens no mostraba:

| Elemento | Antes | Corrección |
|---|---|---|
| Crédito del pie ("Webmaster y diseño…") | 4,38:1 en tema claro y 4,15:1 en oscuro | Color de texto al 72 % en lugar del 48 % |
| Fuentes de los datos (`.fact-src`), en tema oscuro | 4,15:1 a 4,40:1 | Opacidad de 0,86 en lugar de 0,72 |
| Subtítulos de universidades (`.split-sub`), en tema oscuro | 4,10:1 | Color de texto al 78 % en lugar de `--muted` |
| Cita del post-it ("Adaptado de Kassem"), en tema oscuro | 4,44:1 | Opacidad de 0,88 en lugar de 0,75 |

Después de los cambios, ningún texto queda por debajo de 4,5:1 en ninguno de los dos temas.

**Calendario en el celular (2.1.1 Teclado, nivel A):** a 375 px el calendario mide unos 640 px y se desliza hacia los costados, pero el contenedor no recibía foco, así que con el teclado no se podía desplazar. Ahora tiene `tabindex="0"` y se mueve con las flechas. También se agregó una indicación visible en pantallas chicas: "Deslizá el calendario hacia los costados para ver todos los meses".

## Contraste medido

Todos los pares de texto superan 4,5:1. Algunos ejemplos en tema claro: `--muted` sobre el fondo, 5,56; `--l1` sobre el fondo, 4,86; `--l2` sobre blanco, 5,02; etiquetas amarillas sobre carbón, 11,5. En tema oscuro, todos superan 6:1.

Hay dos pares por debajo de 4,5:1 que hoy **no** se usan para texto chico:

- `--l2` (#b4530f) sobre `--l2-soft`: 4,32:1.
- `--l2` sobre `--bg`: 4,14:1.

Hoy solo aparecen en íconos y en números grandes, así que cumplen. Si en el futuro se usan para texto de tamaño normal, conviene oscurecer `--l2` a algo como `#a34a0c`.

## Pendiente (menor)

- **Escala, campo "nombre de la carrera":** la etiqueta es solo para lectores de pantalla y lo visible es el placeholder ("Ej.: Ingeniería en Sistemas"), que desaparece al escribir. La leyenda "Carrera A" da contexto, así que cumple, pero una etiqueta visible ("Nombre de la carrera") sería más clara para estudiantes. Es un cambio de diseño, por eso no lo apliqué.

## Recomendaciones de UX y tecnología educativa

- **Animaciones (iframes):** la descripción de cada animación (`.mg-cap`) existe solo para lectores de pantalla. Mostrarla como epígrafe visible, o en un "Ver descripción", ayuda a quien no llega a seguir el movimiento y sirve como resumen en el aula.
- **Calendario:** el detalle de cada barra está en `title` (solo con el mouse). La tabla con las fechas cubre la información, pero está dentro de un desplegable cerrado. Podría quedar abierta por defecto o mencionarse justo debajo del gráfico.
- **Jerarquía:** los apartados especiales (h3) quedan bajo el h2 "Elegir tu camino" aunque están fuera del recorrido. Un h2 propio ("Apartados especiales") ordenaría el esquema para lectores de pantalla.
- **Confirmación de borrado:** `confirm()` funciona y es accesible, pero un diálogo propio permitiría explicar qué se borra con el mismo tono del sitio.
- **Hero (`.hero-copy::after`):** la animación `drift` de 16 s pasó a ejecutarse una sola vez. Esa clase no se usa en esta página (viene del CSS compartido con el taller de primer empleo); conviene aplicar ahí el mismo cambio.

## Archivos modificados

- `index.html`: nombre del botón de menú, ayuda de la escala, `aria-describedby`, rol de `.chain`, `tabindex` de los paneles.
- `assets/app.js`: foco del menú en el celular, anuncios de la escala, nombre de los botones de animación.
- `assets/styles.css`: animaciones con fin.
- `assets/carreras.css`: bordes con contraste 3:1, foco del campo y estilo del texto de ayuda.

## Cómo verlo en local

```
python -m http.server 4173
```

Después abrí http://localhost:4173.
