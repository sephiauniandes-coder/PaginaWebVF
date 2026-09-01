# Requerimientos — Plataforma Web de la Iniciativa (SEPHIA)
---

## 1. Alcance general

El sistema tiene tres audiencias distintas:
1. **Público general**: visita el sitio, conoce la iniciativa, ve el dashboard de datos, escribe por el formulario de contacto. No requiere cuenta.
2. **Administrador(es)**: estudiantes del equipo con correo institucional `@uniandes.edu.co`, que editan contenido y gestionan el sitio.
3. **Sensores del invernadero**: dispositivos IoT que envían datos de forma autónoma y continua al sistema.

---
## 2. Requerimientos funcionales (RF)

### 2.1 Módulo institucional (público)
- **RF-01**: El sitio debe mostrar misión, visión e historia de la iniciativa en una sección accesible desde el menú principal.
- **RF-02**: El sitio debe incluir una galería de imágenes (invernadero, equipo, eventos).
- **RF-03**: El sitio debe mostrar enlaces a las redes sociales de la iniciativa, visibles en todas las páginas (header o footer).
- **RF-04**: El sitio debe ser responsive (móvil, tablet, escritorio).

### 2.2 Módulo de equipo
- **RF-05**: El sitio debe presentar a los integrantes del equipo (foto, nombre, rol, bio breve, enlace opcional a LinkedIn/correo).
- **RF-06**: La información del equipo debe gestionarse como contenido editable por el admin, no como código fijo — esto importa porque el equipo estudiantil rota cada semestre/año.

### 2.3 Módulo de proyectos
- **RF-07**: Cada proyecto debe presentarse con nombre, descripción, imágenes/multimedia, estado (activo/finalizado) y equipo responsable.
- **RF-08**: El admin debe poder crear, editar y archivar proyectos.
- **RF-09** *(sugerido)*: Cada proyecto podría tener su propia sub-página con cronograma o resultados, útil para mostrar avances a evaluadores o posibles aliados.

### 2.4 Módulo de contacto
- **RF-10**: Formulario de "Contáctanos" con al menos nombre, correo y mensaje.
- **RF-11**: El sistema debe notificar por correo al equipo cuando llegue un nuevo mensaje.
- **RF-12**: El formulario debe validar campos y tener protección anti-spam (captcha o similar).

### 2.5 Zona de datos / Dashboard del invernadero
- **RF-13**: Mostrar en (cuasi) tiempo real las lecturas de temperatura, humedad y pH, dejando el modelo de datos abierto para variables futuras (luminosidad, CO2, humedad del suelo, etc.).
- **RF-14**: Recibir y almacenar de forma continua los datos enviados por el hardware existente, vía una API de ingesta autenticada por dispositivo (cada sensor/nodo con su propia credencial, no una clave compartida).
- **RF-15**: Permitir ver series históricas por variable y rango de tiempo (última hora, día, semana, mes, rango personalizado).
- **RF-16**: Permitir exportar datos históricos (CSV/Excel) para uso en investigación o reportes.
- **RF-17**: Permitir definir umbrales (mín/máx) por variable y generar alertas visuales — y opcionalmente notificaciones por correo — cuando se excedan.
- **RF-18**: Definir si el dashboard completo (incluido histórico y exportación) es público, o si el detalle fino se reserva a usuarios autenticados y el público solo ve el estado actual. *(pendiente de decisión — ver sección 6)*.

### 2.6 Autenticación y administración
- **RF-19**: El admin debe iniciar sesión únicamente con su correo institucional `@uniandes.edu.co`.
- **RF-20**: El resto del sitio (contenido institucional y dashboard) debe ser accesible sin autenticación.
- **RF-21**: El sistema debe validar el dominio del correo de forma confiable en el proceso de autenticación (no basta con validar el formato del texto; idealmente se verifica vía OAuth/SSO con el proveedor de identidad real de la universidad).
- **RF-22**: El sistema debe soportar múltiples administradores, con capacidad de autorizar o revocar accesos sin tocar código.
- **RF-23** *(sugerido)*: Registro de auditoría (quién cambió qué y cuándo) — valioso dado el recambio anual típico de un equipo estudiantil.

### 2.7 Panel de administración (CMS)
- **RF-24**: Edición de contenido institucional, equipo y proyectos desde una interfaz visual, sin tocar código.
- **RF-25**: Subida y eliminación de imágenes desde el panel.
- **RF-26**: Gestión de los mensajes de contacto recibidos (ver, marcar, archivar).
- **RF-27**: Panel unificado con métricas de uso del sitio y estado del invernadero (últimas lecturas, sensores caídos o sin reportar).

---

## 3. Requerimientos no funcionales (RNF)

| # | Requerimiento | Detalle |
|---|---|---|
| RNF-01 | Rendimiento | Carga inicial < 3s en conexión promedio; actualización del dashboard con baja latencia (ideal: near real-time vía WebSockets/SSE; aceptable: polling cada 15-30s). |
| RNF-02 | Escalabilidad | La arquitectura debe soportar crecimiento en tráfico y en número de sensores/invernaderos sin rediseño mayor. |
| RNF-03 | Disponibilidad | Uptime objetivo razonable para un servicio institucional (p. ej. 99%), con monitoreo activo. |
| RNF-04 | Seguridad | HTTPS obligatorio, credenciales por dispositivo IoT, protección contra XSS/CSRF/inyección, gestión segura de secretos, rate limiting en la API de ingesta. |
| RNF-05 | Privacidad y cumplimiento | Tratamiento de datos personales del formulario de contacto conforme a la Ley 1581 de 2012 (habeas data, Colombia): aviso de privacidad y política de tratamiento de datos publicados. |
| RNF-06 | Usabilidad y accesibilidad | Diseño responsive, navegación clara, cumplimiento razonable de WCAG AA. |
| RNF-07 | Mantenibilidad | Código documentado y arquitectura modular — prioridad alta dado el recambio de estudiantes; preferir simplicidad sobre sofisticación innecesaria. |
| RNF-08 | Observabilidad | Logging centralizado, métricas de aplicación (requests, errores, latencia), alertas si un sensor deja de reportar o el sistema falla. |
| RNF-09 | Continuidad | Backups automáticos de la base de datos (contenido + histórico de sensores) y plan simple de recuperación ante fallos. |
| RNF-10 | Costos/portabilidad | Preferir servicios con tier gratuito o económico para un proyecto estudiantil, con camino claro para escalar sin depender de un solo proveedor. |
| RNF-11 | SEO | El contenido institucional público debe ser indexable por buscadores (renderizado en servidor o estático). |

---

## 4. Arquitectura propuesta (por definir)

**Frontend**: 

**Backend**: 

**Ingesta de datos IoT**: 

**Base de datos**: PostgreSQL

**Autenticación restringida a `@uniandes.edu.co`**:

**Hosting**: 

**Métricas**: Google Analytics o Plausible para tráfico del sitio

**CI/CD**: GitHub Actions

---

## 5. Ideas adicionales (no pedidas explícitamente, pero valen la pena)

- Formulario de "Únete al equipo" / voluntariado, para captar nuevos integrantes.
- Sección de aliados, patrocinadores o reconocimientos.
- Blog o bitácora de actualizaciones del invernadero (buena forma de mostrar progreso sin depender solo del dashboard).
- Notificaciones automáticas (correo o WhatsApp) cuando una variable del invernadero salga de rango — más allá de la alerta visual del dashboard.
- Roles diferenciados de administrador (p. ej. super-admin vs. editor de contenido) si el equipo crece.
- Manual de traspaso técnico para nuevas generaciones de estudiantes — crítico en una iniciativa con recambio anual, para no perder conocimiento cada vez que se gradúa alguien.
- Modo oscuro y, si buscan visibilidad internacional, soporte multilenguaje (ES/EN).

