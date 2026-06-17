# ignisky-spark 🔥 — La chispa inicial de tu workspace AI

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0.1-ED2100?style=flat-square" alt="version">
  <img src="https://img.shields.io/badge/license-MIT-050505?style=flat-square" alt="license">
  <img src="https://img.shields.io/badge/AI-Ready-ED2100?style=flat-square" alt="ai-ready">
  <img src="https://img.shields.io/badge/ShellCheck-Passing-ED2100?style=flat-square" alt="shellcheck">
  <img src="https://img.shields.io/badge/by-IgnicionDev-050505?style=flat-square" alt="author">
</p>

**ignisky-spark** es un scaffold inteligente para inicializar workspaces de agentes AI. Crea al instante la estructura de proyecto perfecta para que tu agente (Hermes Agent, Claude Code, Codex CLI...) empiece a trabajar sin fricción.

> ⚡ Parte del ecosistema **ignisky-*** por **Ignición 🔥**

---

## 🚀 Uso rápido

```bash
# Modo interactivo
./ignisky-spark.sh

# Workspace Python con Git
./ignisky-spark.sh --type python --name my-agent --git

# Workspace TypeScript
./ignisky-spark.sh --type ts --name mcp-server --git

# Ver tipos disponibles
./ignisky-spark.sh --list
```

---

## 📋 Tipos de proyecto

| Tipo | Lenguaje | Icono | Extensión |
|------|----------|-------|-----------|
| `bash` | Scripts Bash para automatización de agentes | 🐚 | `.sh` |
| `python` | Python con pip/uv para agentes AI | 🐍 | `.py` |
| `ts` | TypeScript/Node.js para herramientas MCP | 🟦 | `.ts` |
| `cpp` | C++ nativo para alto rendimiento | ⚡ | `.cpp` |
| `rust` | Rust con Cargo para agentes seguros | 🦀 | `.rs` |
| `web` | Web estática HTML/CSS/JS | 🌐 | `.html` |
| `web-app` | Web app completa con SDD | 📦 | `.js` |

Cada tipo crea automáticamente:

- `src/` — Código fuente con archivo de entrada (`main.sh`/`main.py`/`main.ts`/`main.cpp`/`main.rs`)
- `tests/` — Tests adaptados al lenguaje
- `docs/` — Documentación
- `.gitignore` optimizado para agentes AI
- `README.md` con badges Ignición 🔥
- **`CLAUDE.md`** — Contexto para Claude Code / Hermes Agent
- **`AGENTS.md`** — Contexto multi-agente (Cursor, Windsurf, Copilot)
- Ficheros específicos por tipo (`package.json`, `Cargo.toml`, `pyproject.toml`, `Makefile`, etc.)

---

## ✨ Características

| Característica | Descripción |
|----------------|-------------|
| ✅ **5 tipos de proyecto** | bash, python, ts, cpp, rust |
| ✅ **CLAUDE.md + AGENTS.md** | Contexto AI para tu agente |
| ✅ **--author / --desc** | Personaliza el proyecto |
| ✅ **--git** | Git init + commit inicial |
| ✅ **--install** | Auto-instala dependencias |
| ✅ **--interactivo** | Menú guiado paso a paso |
| ⛁ **--ci** | CI/CD + Docker (Premium) |
| ⛁ **--make** | Makefile completo (Premium) |
| ⛁ **--bootstrap** | Bootstrap de tools (Premium) |
| ⛁ **--templates** | Editorconfig + linters (Premium) |

---

## 📦 Estructura generada

```
mi-proyecto/
├── src/           # Código fuente
├── tests/         # Tests
├── docs/          # Documentación
├── .gitignore     # Optimizado para agentes AI
├── CLAUDE.md      # Contexto para agentes Claude/Hermes
├── AGENTS.md      # Contexto multi-agente
└── README.md      # README template con badges 🔥
```

---

## 🆓 vs ⛁ — Gratis vs Premium

| Feature | Flag | Gratis | Premium ⛁ |
|---------|------|:------:|:----------:|
| Scaffold completo (`src/`, `tests/`, `docs/`) | `--type <lang>` | ✅ | — |
| `.gitignore` optimizado para agentes AI | automático | ✅ | — |
| `README.md` template con badges | automático | ✅ | — |
| Archivo de entrada según tipo | automático | ✅ | — |
| Archivo de test inicial | automático | ✅ | — |
| Inicializar repo Git | `--git` | ✅ | — |
| **CI/CD + Docker** (`.github/workflows/`, `Dockerfile`, `.dockerignore`) | `--ci` | — | ⛁ |
| **Makefile inteligente** (build/test/clean/deploy/help) | `--make` | — | ⛁ |
| **Bootstrap de herramientas** (instala dependencias automáticamente) | `--bootstrap` | — | ⛁ |
| **Templates de editor** (`.editorconfig`, `.prettierrc`, linters) | `--templates` | — | ⛁ |

> ⛁ **Premium** — Canjea tu cupón **`IGNICION25`** (25% OFF → **11.25€**) en [gumroad.com/l/...](https://gumroad.com/l/...)

---

## 🔥 Premium features detalladas

### spark:blast — `--ci`
Añade a tu proyecto:
- `.github/workflows/ci.yml` — Pipeline de CI con lint + test + build
- `.github/workflows/deploy.yml` — Pipeline de deploy
- `Dockerfile` — Multi-stage optimizado para el tipo de proyecto
- `.dockerignore` — Excluye lo innecesario del contexto Docker

### spark:forge — `--make`
Genera un Makefile con todos los targets que necesitas:
`build`, `test`, `clean`, `deploy`, `lint`, `docs`, `install`, `run`, `docker-build`, `docker-run`, `help`

Se adapta automáticamente al tipo de proyecto.

### spark:env — `--bootstrap`
Detecta e instala las herramientas necesarias para tu proyecto:
- **bash**: shellcheck, bash-completion
- **python**: python3, pip, uv, pytest, ruff
- **ts**: node, bun, typescript, tsx
- **cpp**: g++, cmake, make, clang-format
- **rust**: rustup, cargo, clippy, rustfmt

### spark:kit — `--templates`
Añade configuraciones de editor profesionales adaptadas al tipo de proyecto:
- `.editorconfig` — Estilo consistente en cualquier editor
- `.prettierrc` — Formateo automático (TS/JS/Python)
- Configuración específica de linter según tipo

---

## 🔗 Enlaces del ecosistema

| Herramienta | Descripción |
|-------------|-------------|
| [ignisky-spark](https://github.com/yosoyignicion/ignisky-spark) | 🏠 **Este script** — Scaffolding de workspaces AI |
| [ignisky-kindler](https://github.com/yosoyignicion/ignisky-kindler) | 🔥 Gestor de servidores MCP para Hermes Agent |
| [Ignición 🔥](https://github.com/yosoyignicion) | 🧠 Ecosistema de herramientas AI para creadores |

---

## 📖 Licencia

MIT — Hecho con ❤️ por **IgnicionDev (yosoyignicion)**

---

<p align="center">
  <b>Ignición 🔥</b> — Herramientas AI para creadores de agentes<br>
  <sub>Discord: <a href="https://discord.gg/">ignicion-community</a> · Web: próximamente</sub>
</p>
