# Guía de Neovim y Shortcuts

Este documento explica la notación de teclas y los atajos configurados.

## ⌨️ Notación de Teclas
En el ecosistema de Neovim/Vim, verás estas abreviaturas:
- `<C-x>`: Mantener presionado **Ctrl** y la tecla `x`.
- `<S-x>`: Mantener presionado **Shift** y la tecla `x`.
- `<A-x>` o `<M-x>`: Mantener presionado **Alt** y la tecla `x`.
- `<leader>`: Es una tecla especial para disparar atajos. En tu configuración es la tecla **Espacio**.
- `<CR>`: Tecla **Enter** (Carriage Return).
- `<Esc>`: Tecla **Escape**.

---

## 🚀 Atajos de Teclado (Shortcuts)

### Navegación y Movimiento Básico
| Atajo | Acción |
|-------|--------|
| `h`, `j`, `k`, `l` | Mover cursor: Izquierda, Abajo, Arriba, Derecha. |
| `/texto` | Buscar "texto" en el archivo. Presiona `n` para siguiente, `N` para anterior. |
| `:n` | Saltar a la línea número `n` (ej: `:42`). |
| `gg` | Ir al principio del archivo. |
| `G` | Ir al final del archivo. |
| `]m` | Ir al inicio de la siguiente función/método. |
| `[m` | Ir al inicio de la función/método anterior. |
| `]]` | Ir al inicio de la siguiente clase. |
| `[[` | Ir al inicio de la clase anterior. |
| `<Tab>` | Siguiente buffer (archivo abierto). |
| `<S-Tab>` | Buffer anterior. |

### Diagnósticos (Errores y Advertencias)
| Atajo | Acción | Modo |
|-------|--------|------|
| `<leader>d` | Mostrar detalle del error bajo el cursor (Ventana flotante). | Normal |
| `<leader>rn` | **Smart Rename**: Renombrar variable/función en todo el proyecto (LSP). | Normal |
| `]d` | Saltar al siguiente error/advertencia. | Normal |
| `[d` | Volver al error/advertencia anterior. | Normal |
| `<leader>xx` | **Trouble**: Lista de todos los errores del proyecto. | Normal |
| `<leader>xX` | **Trouble**: Lista de errores solo del archivo actual. | Normal |
| `<leader>q` | Lista completa de errores del archivo (Quickfix). | Normal |

### Gestión de Ventanas (Splits)
| Atajo | Acción |
|-------|--------|
| `<leader>v` | Dividir ventana verticalmente (lado a lado). |
| `<leader>h` | Dividir ventana horizontalmente (arriba y abajo). |
| `<leader>we` | Igualar tamaño de las ventanas abiertas. |
| `<leader>wx` | Cerrar la ventana actual. |
| `<C-h/j/k/l>` | Mover el foco entre ventanas (Ctrl + dirección). |

### Gestión de Pestañas (Tabs)
| Atajo | Acción |
|-------|--------|
| `<leader>to` | Abrir nueva pestaña. |
| `<leader>tx` | Cerrar pestaña actual. |
| `<leader>tn` | Ir a la siguiente pestaña. |
| `<leader>tp` | Ir a la pestaña anterior. |

### Edición y Utilidades
| Atajo | Acción | Modo |
|-------|--------|------|
| `<leader>s` | Buscar y reemplazar palabra bajo el cursor en todo el archivo. | Normal |
| `<leader><Space>` | Formatear el código (LSP). | Normal |
| `gcc` | Comentar/Descomentar línea. | Normal |
| `J` / `K` | Mover bloque de código seleccionado hacia arriba/abajo. | Visual |
| `Alt + j/k` | Mover línea o selección hacia abajo/arriba (como VS Code). | Normal/Visual/Insert |
| `Alt + Shift + j/k` | Duplicar línea o selección hacia abajo/arriba (como VS Code). | Normal/Visual/Insert |
| `Alt + Flechas` | También funciona para mover y duplicar líneas. | Normal/Visual |
| `Enter` | Agregar línea vacía abajo (sin mover el cursor). | Normal |
| `Shift + Enter` | Agregar línea vacía arriba (sin mover el cursor). | Normal |
| `<leader>mp` | Abrir/Cerrar previsualización de Markdown en el navegador. | Normal |
| `gf` | Seguir link de Obsidian `[[nota]]` (Go Follow). | Normal |
| `<leader>bb` | Volver atrás (al buffer o posición anterior). | Normal |
| `<leader>bf` | Ir hacia adelante en el historial de saltos. | Normal |
| `<leader>ch` | Alternar checkbox de una tarea en Markdown. | Normal |
| `<leader>st` | Abrir terminal en la parte inferior. | Normal |
| `<Esc><Esc>` | Salir del modo terminal (volver a modo normal). | Terminal |
| `<Esc>` | Limpiar el resaltado de búsqueda. | Normal |

### Telescope (Buscador Difuso)
| Atajo | Acción |
|-------|--------|
| `<leader>ff` | Buscar archivos por nombre. |
| `<leader>fs` | Buscar texto dentro de todos los archivos (Grep). |
| `<leader>fb` | Listar y buscar en buffers abiertos. |
| `<leader>fr` | Archivos abiertos recientemente. |
| `<leader>/` | Búsqueda difusa dentro del archivo actual. |

### Oil.nvim (Explorador de Archivos)
*Te permite editar tu sistema de archivos como si fuera un buffer de texto.*
| Atajo | Acción |
|-------|--------|
| `-` o `<leader>e` | Abrir el explorador de archivos. |
| `<CR>` | Abrir el archivo o directorio bajo el cursor. |
| `-` | (Dentro de Oil) Ir al directorio padre. |
| `<C-p>` | Abrir previsualización en una ventana flotante. |
| `<C-c>` | Cerrar el explorador. |
| `g.` | Mostrar/Ocultar archivos ocultos. |

**Cómo crear/renombrar/borrar:**
1.  Abre Oil con `-` o `<leader>e`.
2.  **Crear:** Escribe el nombre de un archivo nuevo en una línea vacía.
3.  **Renombrar:** Cambia el nombre de cualquier archivo existente (ej: `cw`).
4.  **Borrar:** Borra la línea completa del archivo (ej: `dd`).
5.  **Confirmar:** Ejecuta `:w` (guardar) y confirma los cambios.

---

## 🔌 Plugins Instalados

| Plugin | Descripción |
|--------|-------------|
| **nvim-treesitter** | Resaltado de sintaxis inteligente. |
| **render-markdown.nvim** | Renderiza el Markdown directamente en Neovim (iconos, encabezados, LaTeX). |
| **markdown-preview.nvim** | Previsualización en tiempo real en el navegador (usa `<leader>mp`). Soporta LaTeX y diagramas. |
| **obsidian.nvim** | Soporte para bóvedas de Obsidian, links `[[ ]]` y gestión de notas. |
| **telescope.nvim** | Buscador difuso ultra-rápido. |
| **oil.nvim** | Explorador de archivos que se edita como texto. |
| **blink.cmp** | Autocompletado (como IntelliSense). |
| **conform.nvim** | Formateador de código automático (Prettier, Stylua, clang-format, google-java-format). |
| **mason.nvim** | Gestor de servidores LSP y herramientas. |
| **lualine.nvim** | Barra de estado inferior (tema Catppuccin). |
| **catppuccin** | Tema visual moderno y suave (variante Mocha). |
| **trouble.nvim** | Panel elegante para navegar por todos los errores y símbolos del proyecto. |
| **Comment.nvim** | Comentarios fáciles con `gcc`. |
| **nvim-surround** | Manipula paréntesis/comillas (`ys`, `ds`, `cs`). |
| **vim-fugitive** | Comandos de Git integrados. |
| **twilight.nvim** | Modo enfoque (atenúa código circundante). |
-fugitive** | Comandos de Git integrados. |
| **twilight.nvim** | Modo enfoque (atenúa código circundante). |
