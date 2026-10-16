# SEPHIA · Página web

Prototipo del frontend de **SEPHIA — Semillero en Producción Hidropónica Inteligente y Automatizada** (Universidad de los Andes).

> Estado: **prototipo de diseño** (HTML de Claude Design). Es la referencia visual y de contenido para implementar el front definitivo; todavía no consume la API real.

## Ver el prototipo

```bash
cd design/landing
python3 -m http.server 8000
# abrir http://localhost:8000/SEPHIA%20Landing.dc.html
```

Las notas `◻` dentro de la página (anotaciones de entrega) describen componentes, props y endpoints. Se ocultan con la prop `showAnnotations=false`.

## Estructura

```
design/landing/
├── SEPHIA Landing.dc.html   # página completa (HTML + lógica de demostración)
├── support.js               # runtime del prototipo (Claude Design)
└── assets/
    ├── sephia-*.svg         # logotipo, isotipo e imagotipo oficiales (currentColor)
    ├── favicon.svg
    └── img/*.webp           # fotos optimizadas (Canva SEPHIA MARKETING 2026-2)
```

## Identidad (manual de marca)

| Token | Valor |
|---|---|
| Verde | `#1D4A22` |
| Beige | `#F2EDE1` |
| Negro | `#221E1F` |
| Salvia | `#BFC6AD` |
| Títulos | Pragmatica Extended Bold (licencia ParaType; fallback: Archivo Expanded) |
| Texto | Montserrat |

Tamaños mínimos del logo: logotipo 151 px · isotipo 76 px · imagotipo 170 px.

## Contrato con el backend

Alineado con [`sephia-doc-db`](https://github.com/Sephia-Uniandes/sephia-doc-db) (`docs/modelo-datos.md`):

| Front | Backend |
|---|---|
| Tarjetas de sensores en vivo | SSE `GET /api/stream` · ids = códigos de variable (`temperatura`, `humedad_relativa`, `ph`) |
| Histórico 1 h · 24 h · 7 d · 30 d + CSV | `GET /api/readings?sensor&range` (InfluxDB) · visible según `sitio.dashboard.historico_publico` / `exportacion_publica` (RF-18) |
| Umbrales y alertas | colecciones `umbrales` / `alertas` |
| Equipo, proyectos, galería | `integrantes`, `proyectos` (`/proyectos/[slug]`), `medios` (`alt` obligatorio) |
| Formulario de contacto | `POST /api/contact` → `mensajes` con `consentimiento {acepto, version}` (Ley 1581) + Turnstile |
| Analítica (RF-27) | Umami, sin cookies |

## Trazabilidad de requerimientos

| Requerimiento | Estado en el prototipo |
|---|---|
| RF-01 Misión, visión, historia | ✅ sección *Nosotros* |
| RF-02 Galería | ✅ |
| RF-03 Redes en header/footer | ✅ footer |
| RF-04 / RNF-06 Responsive, accesibilidad | ✅ verificado en 390 px y 1280 px, `alt` en todas las fotos |
| RF-05 Equipo (foto, nombre, rol, bio) | ✅ falta LinkedIn/correo opcional |
| RF-07 / RF-09 Proyectos y sub-página | ✅ tarjeta destacada + enlace a `/proyectos/[slug]` |
| RF-10 / RF-12 Contacto con validación y anti-spam | ✅ captcha simulado → Turnstile |
| RF-13 Datos en (cuasi) tiempo real | ✅ demo con datos simulados |
| RF-15 Histórico por rango | ✅ 1 h · 24 h · 7 d · 30 d (falta rango personalizado) |
| RF-16 Exportar CSV | ✅ |
| RF-17 Umbrales y alertas visuales | ✅ |
| RF-18 Dashboard público vs autenticado | ⏳ decisión pendiente |
| RF-19 a RF-27 Admin / CMS | ⏳ fuera del alcance de la landing |
| RNF-05 Política de tratamiento de datos | ⏳ falta publicar el documento y enlazarlo |
| RNF-11 SEO | ✅ HTML estático, JSON-LD, Open Graph |

## Pendientes

- `data-website-id` y dominio de Umami (hoy `REEMPLAZAR-WEBSITE-ID`).
- Enlace real a la política de tratamiento de datos (RNF-05).
- Año de fundación e hitos con fecha (Historia).
- Estado y equipo responsable del proyecto de chizas.
- Confirmar que el formulario de inscripción (Microsoft Forms) sigue abierto.
- Licencia web de Pragmatica Extended o mantener el fallback.

## Cómo contribuir

1. Rama desde `main`: `git switch -c feat/descripcion`.
2. Commits convencionales (`feat:`, `fix:`, `docs:`…).
3. `gh pr create` y revisión antes de mezclar.
