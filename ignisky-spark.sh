#!/usr/bin/env bash
#
# ignisky-spark — La chispa inicial de tu workspace AI 🔥
# Scaffolding inteligente para inicializar workspaces de agentes AI.
# Crea estructura de proyecto, gitignore optimizado para agentes,
# README template y más — en segundos.
#
# Versión:    1.0.0
# Licencia:   MIT
# Autor:      IgnicionDev (yosoyignicion)
# Marca:      ignisky-* por Ignición 🔥
#
# Uso:        ./ignisky-spark.sh [opciones]
#

set -euo pipefail

# ═══════════════════════════════════════════════════════════════
#  CONFIG
# ═══════════════════════════════════════════════════════════════

VERSION="1.0.1"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
SPARK_WORKDIR="${SPARK_WORKDIR:-$(pwd)}"
PROJECT_AUTHOR="${PROJECT_AUTHOR:-$(git config user.name 2>/dev/null || echo 'IgnicionDev')}"
PROJECT_DESC=""

# Tipos de proyecto disponibles (formato: nombre|descripción|icono|extensión)
declare -a PROJECT_TYPES=(
    "bash|Scripts Bash para automatización de agentes|🐚|.sh"
    "python|Python con pip/uv para agentes AI|🐍|.py"
    "ts|TypeScript/Node.js para herramientas MCP|🟦|.ts"
    "cpp|C++ nativo para alto rendimiento|⚡|.cpp"
    "rust|Rust con Cargo para agentes seguros|🦀|.rs"
    "web|Web estática HTML/CSS/JS|🌐|.html"
    "web-app|Web app completa con SDD|📦|.js"
)

get_type_field()  { echo "$1" | cut -d'|' -f"$2"; }
get_type_name()   { get_type_field "$1" 1; }
get_type_desc()   { get_type_field "$1" 2; }
get_type_icon()   { get_type_field "$1" 3; }
get_type_ext()    { get_type_field "$1" 4; }

# ═══════════════════════════════════════════════════════════════
#  PALETA IGNICIÓN
# ═══════════════════════════════════════════════════════════════

ESC=$(printf '\\033')
RED="${ESC}[38;2;237;33;0m"
DARK="${ESC}[38;2;5;5;5m"
LIGHT="${ESC}[38;2;229;229;229m"
GRAY="${ESC}[38;2;100;100;100m"
GREEN="${ESC}[38;2;0;200;100m"
YELLOW="${ESC}[38;2;255;200;0m"
BLUE="${ESC}[38;2;80;160;255m"
BOLD="${ESC}[1m"
NC="${ESC}[0m"
CHECK="${GREEN}✓${NC}"
CROSS="${RED}✗${NC}"

# ═══════════════════════════════════════════════════════════════
#  UTILIDADES
# ═══════════════════════════════════════════════════════════════

log()    { echo -e "  ${GREEN}${BOLD}→${NC} $*"; }
warn()   { echo -e "  ${YELLOW}${BOLD}!${NC} $*"; }
error()  { echo -e "  ${RED}${BOLD}✖${NC} $*" >&2; }
die()    { error "$*"; exit 1; }
header() { echo -e "\n${RED}${BOLD}═══ $* ═══${NC}\n"; }
dim()    { echo -e "${GRAY}$*${NC}"; }
success(){ echo -e "  ${CHECK} ${BOLD}$*${NC}"; }
label()  { echo -e "  ${GRAY}│${NC}  $*"; }

draw_box() {
    local title="$1"
    local width=60
    echo -e "${RED}${BOLD}┌─${title} ${NC}${GRAY}$(printf '─%.0s' $(seq 1 $((width - ${#title} - 4))))${NC}"
}

box_item() { echo -e "  ${GRAY}│${NC}  $*"; }
box_end()  { echo -e "  ${GRAY}└$(printf '─%.0s' $(seq 1 58))${NC}\n"; }

separator() {
    echo -e "  ${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

premium_footer() {
    echo ""
    separator
    echo -e "  ${BOLD}💎 Disponible en el pack premium${NC}"
    echo -e "  ${BOLD}👉 https://ignaciodev.gumroad.com/l/ignisky-spark-premium  ·  Cupón: ${RED}IGNICION25${NC}"
    separator
}

# ═══════════════════════════════════════════════════════════════
#  GENERADOR — .gitignore optimizado para agentes
# ═══════════════════════════════════════════════════════════════

generate_gitignore() {
    local type="$1"

    # Common base gitignore (always printed first)
    echo '# ignisky-spark — .gitignore optimizado para agentes AI
# Generado por ignisky-spark 🔥 (Ignición)
#
# Patrones para workspaces de agentes:
#   - Evita que herramientas externas (npx, uvx) contaminen el repo
#   - Ignora outputs de agentes y logs
#   - Mantiene el workspace limpio para el agente

# ──────────────────────────────────────────
#  General / sistema
# ──────────────────────────────────────────
.DS_Store
Thumbs.db
*.swp
*.swo
*~
._*
*.orig
*.bak

# ──────────────────────────────────────────
#  Entorno y secretos
# ──────────────────────────────────────────
.env
.env.*
!.env.example
*.key
*.pem
*.cert
credentials.json
secrets/
**/secrets.yaml

# ──────────────────────────────────────────
#  Outputs de agente / dependencias externas
# ──────────────────────────────────────────
_output/
_agent/
_work/
hermes-output/
node_modules/
__pycache__/
*.pyc
.venv/
venv/
.python-version
target/
build/
dist/
*.egg-info/
*.so

# ──────────────────────────────────────────
#  Logs y temporales
# ──────────────────────────────────────────
*.log
*.trace
_traces/
_telemetry/
tmp/
temp/
.history/
*.tsbuildinfo

# ──────────────────────────────────────────
#  IDE / editor
# ──────────────────────────────────────────
.vscode/
.idea/
*.sublime-*
*.code-workspace
.cursor/
.aider/
.cline/

# ──────────────────────────────────────────
#  Hermes Agent / MCP
# ──────────────────────────────────────────
.hermes/
mcp-config.yaml
mcp_config.json

# ──────────────────────────────────────────
#  Ignición specific
# ──────────────────────────────────────────
ignition-traces/
kindler-backups/
spark-templates/'

    # Type-specific entries
    case "$type" in
        python)
            cat << 'PYEOF'

# ──────────────────────────────────────────
#  Python
# ──────────────────────────────────────────
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
.venv/
pip-log.txt
pip-delete-this-directory.txt
.pytest_cache/
.coverage
coverage/
htmlcov/
.mypy_cache/
.ruff_cache/
.tox/
*.whl
site-packages/
PYEOF
            ;;
        ts)
            cat << 'TSEOF'

# ──────────────────────────────────────────
#  TypeScript / Node.js
# ──────────────────────────────────────────
node_modules/
dist/
build/
*.tsbuildinfo
.eslintcache
.npm/
.pnpm-store/
yarn-error.log
pnpm-lock.yaml
package-lock.json
TSEOF
            ;;
        cpp)
            cat << 'CPPEOF'

# ──────────────────────────────────────────
#  C / C++
# ──────────────────────────────────────────
build/
cmake-build-*/
CMakeCache.txt
CMakeFiles/
*.o
*.obj
*.a
*.lib
*.so
*.dylib
*.dll
*.exe
*.out
*.app
compile_commands.json
CPPEOF
            ;;
        rust)
            cat << 'RSEOF'

# ──────────────────────────────────────────
#  Rust
# ──────────────────────────────────────────
target/
Cargo.lock
**/*.rs.bk
rusty-tags/
*.pdb
RSEOF
            ;;

        web)
            # Web estática — sin patrones extra
            ;;

        web-app)
            cat << 'WAEOF'

# ──────────────────────────────────────────
#  Web App (Node.js)
# ──────────────────────────────────────────
node_modules/
dist/
build/
.env
.env.local
WAEOF
            ;;

    esac
}

# ═══════════════════════════════════════════════════════════════
#  GENERADOR — README template

generate_readme() {
    local project_name="$1"
    local project_type="$2"
    local author="$3"
    local desc="$4"
    local type_desc
    type_desc=$(get_type_desc "$(get_type_entry "$project_type")")
    local type_icon
    type_icon=$(get_type_icon "$(get_type_entry "$project_type")")

    cat << READMEEOF
# ${project_name}

<p align="center">
  <img src="https://img.shields.io/badge/ignisky--spark-1.0.0-ED2100?style=flat-square" alt="spark">
  <img src="https://img.shields.io/badge/type-${project_type}-050505?style=flat-square" alt="type">
  <img src="https://img.shields.io/badge/license-MIT-ED2100?style=flat-square" alt="license">
  <img src="https://img.shields.io/badge/AI-Ready-ED2100?style=flat-square" alt="ai-ready">
  <img src="https://img.shields.io/badge/by-${author}-050505?style=flat-square" alt="author">
</p>

<p align="center">
  ${type_icon} <b>${project_name}</b> — ${desc:-$type_desc}
</p>

> Generado con [ignisky-spark](https://github.com/yosoyignicion/ignisky-spark) 🔥 — La chispa inicial de tu workspace AI.

---

## 📁 Estructura

\`\`\`
${project_name}/
├── src/           # Código fuente
├── tests/         # Tests
├── docs/          # Documentación
├── .gitignore     # Optimizado para agentes AI
├── CLAUDE.md      # Contexto para agentes AI
├── AGENTS.md      # Contexto multi-agente
└── README.md      # Este archivo
\`\`\`

## 🚀 Comandos básicos

| Comando | Descripción |
|---------|-------------|
| \`make help\`     | Muestra ayuda disponible |
| \`make build\`    | Compila/construye el proyecto |
| \`make test\`     | Ejecuta los tests |
| \`make clean\`    | Limpia artefactos de build |

## 🧠 Para tu agente AI

Este workspace está optimizado para ser usado por agentes AI (Hermes Agent, Claude Code, etc.):

- \`.gitignore\` evita que herramientas externas contaminen el repo
- Estructura clara \`src/tests/docs\` que los agentes entienden
- Preparado para CI/CD, Docker y plantillas de editor

## 📋 Features

| Feature | Estado |
|---------|--------|
| ✅ Estructura de proyecto | Gratis |
| ✅ .gitignore para agentes | Gratis |
| ✅ README template | Gratis |
| ✅ Inicialización Git | Gratis |
| ⛁ CI/CD (GitHub Actions) | Premium |
| ⛁ Dockerfile + .dockerignore | Premium |
| ⛁ Makefile inteligente | Premium |
| ⛁ Bootstrap de herramientas | Premium |
| ⛁ Editorconfig + Prettier + TSConfig | Premium |

> ⛁ Premium — Disponible con cupón **IGNICION25** en https://ignaciodev.gumroad.com/l/ignisky-spark-premium

## 📦 Requisitos

- Dependencias específicas del tipo \`${project_type}\`

## 🔗 Enlaces

- [ignisky-spark](https://github.com/yosoyignicion/ignisky-spark) — Generador de este workspace
- [ignisky-kindler](https://github.com/yosoyignicion/ignisky-kindler) — Gestor de MCPs para Hermes Agent
- [Ignición 🔥](https://github.com/yosoyignicion) — Ecosistema de herramientas AI

---

<p align="center">
  <b>Ignición 🔥</b> — Herramientas AI para creadores de agentes<br>
  <sub>Hecho con ❤️ por IgnicionDev (yosoyignicion)</sub>
</p>
READMEEOF
}

# ═══════════════════════════════════════════════════════════════
#  GENERADOR — CLAUDE.md (contexto para Claude Code / Hermes Agent)
# ═══════════════════════════════════════════════════════════════

generate_claude_md() {
    local project_name="$1"
    local project_type="$2"
    local author="$3"
    local desc="$4"
    local default_desc="Proyecto ${project_type} generado con ignisky-spark 🔥"
    local safe_desc="${desc:-$default_desc}"

    cat << CLAUDEOF
# ${project_name}

${safe_desc}

## Stack

- **Lenguaje:** ${project_type}
- **Autor:** ${author}
- **Generado por:** [ignisky-spark](https://github.com/yosoyignicion/ignisky-spark)

## Convenciones

- Código en \`src/\`, tests en \`tests/\`, docs en \`docs/\`
- Commits convencionales: \`feat:\`, \`fix:\`, \`chore:\`, \`docs:\`, \`refactor:\`
- No committear .env, secrets/, \*.key — ya en .gitignore

## Para el agente

1. Lee \`README.md\` primero para entender el proyecto
2. Ejecuta \`make test\` antes de cualquier cambio
3. \`.gitignore\` ya filtra artefactos de build, dependencias y secretos
4. No modifiques \`src/main.*\` sin actualizar los tests correspondientes
5. MCP servers en \`.mcp.json\` o \`mcp-config.yaml\` si aplica

## Comandos rápidos

| Comando | Descripción |
|---------|-------------|
| \`make build\` | Compila/construye |
| \`make test\`  | Ejecuta tests |
| \`make clean\` | Limpia artefactos |
| \`make run\`   | Ejecuta el proyecto |
CLAUDEOF
}

# ═══════════════════════════════════════════════════════════════
#  GENERADOR — AGENTS.md (contexto multi-agente / Cursor / Windsurf)
# ═══════════════════════════════════════════════════════════════

generate_agents_md() {
    local project_name="$1"
    local project_type="$2"
    local author="$3"

    # Comandos específicos por tipo
    local build_cmd test_cmd
    case "$project_type" in
        python) build_cmd="pip install -e .";    test_cmd="pytest" ;;
        ts)     build_cmd="npm run build";       test_cmd="npm test" ;;
        web)    build_cmd="echo static";            test_cmd="echo check" ;;
        web-app) build_cmd="npm run build";          test_cmd="npm test" ;;
        rust)   build_cmd="cargo build";         test_cmd="cargo test" ;;
        cpp)    build_cmd="make";                test_cmd="make test" ;;
        bash)   build_cmd="shellcheck src/*.sh"; test_cmd="bash tests/test_*.sh" ;;
    esac

    cat << AGENTSEOF
# ${project_name} — Agent Context

> Generated by ignisky-spark 🔥 · Author: ${author}

## Project

- **Type:** ${project_type}
- **Source:** \`src/\` · **Tests:** \`tests/\` · **Docs:** \`docs/\`

## Agent rules

1. Run \`${test_cmd}\` before every commit
2. One responsibility per file in \`src/\`
3. Update \`docs/\` when changing public APIs
4. Keep existing code style

## Quick commands

| Action | Command |
|--------|---------|
| Build  | \`${build_cmd}\` |
| Test   | \`${test_cmd}\` |
| Clean  | \`make clean\` |

## Related

- [ignisky-spark](https://github.com/yosoyignicion/ignisky-spark)
- [Ignición 🔥](https://github.com/yosoyignicion)
AGENTSEOF
}

# ═══════════════════════════════════════════════════════════════
#  HELPERS
# ═══════════════════════════════════════════════════════════════

get_type_entry() {
    local target="$1"
    for entry in "${PROJECT_TYPES[@]}"; do
        local name
        name=$(get_type_name "$entry")
        [[ "$name" == "$target" ]] && { echo "$entry"; return 0; }
    done
    return 1
}

valid_type() {
    get_type_entry "$1" &>/dev/null
}

create_scaffold() {
    local type="$1"
    local name="$2"
    local author="$3"
    local desc="$4"
    local target_dir="${SPARK_WORKDIR}/${name}"

    header "🔥 Creando ${name} (${type})"
    echo ""

    mkdir -p "${target_dir}"/{src,tests,docs}

    # ── Template inicial según tipo ──
    case "$type" in
        bash)
            cat > "${target_dir}/src/main.sh" <<- 'SHEOF'
				#!/usr/bin/env bash
				#
				# main.sh — Punto de entrada
				#
				set -euo pipefail

				echo "🔥 ${0##*/} funcionando!"
				SHEOF
            chmod +x "${target_dir}/src/main.sh"
            cat > "${target_dir}/tests/test_main.sh" <<- 'TESHEOF'
				#!/usr/bin/env bash
				# Tests básicos
				set -euo pipefail

				echo "✅ Tests ejecutados correctamente"
				TESHEOF
            chmod +x "${target_dir}/tests/test_main.sh"
            cat > "${target_dir}/docs/index.md" <<- 'DOCEOF'
				# Documentación

				Bienvenido al proyecto.
				DOCEOF
            success "src/main.sh creado"
            success "tests/test_main.sh creado"
            ;;

        python)
            cat > "${target_dir}/src/main.py" <<- 'PYEOF'
				#!/usr/bin/env python3
				"""
				main.py — Punto de entrada del proyecto.

				Generado por ignisky-spark 🔥
				"""

				def main() -> None:
				    print("🔥 main.py funcionando!")


				if __name__ == "__main__":
				    main()
				PYEOF
            chmod +x "${target_dir}/src/main.py"
            cat > "${target_dir}/tests/test_main.py" <<- 'PYTEOF'
				"""Tests para main.py"""


				def test_placeholder() -> None:
				    assert True
				PYTEOF
            cat > "${target_dir}/requirements.txt" <<- 'REQEOF'
				# Dependencias del proyecto
				# Añade aquí tus dependencias, ej:
				# requests>=2.31.0
				# pydantic>=2.0.0
				REQEOF
            cat > "${target_dir}/pyproject.toml" <<- 'PYPROJEOF'
				[build-system]
				requires = ["setuptools>=64.0.0", "wheel"]
				build-backend = "setuptools.backends._legacy:_Backend"

				[project]
				name = "__PROJECT_NAME__"
				version = "0.1.0"
				description = "Proyecto generado con ignisky-spark"
				readme = "README.md"
				requires-python = ">=3.10"
				PYPROJEOF
            sed -i "s/__PROJECT_NAME__/$name/g" "${target_dir}/pyproject.toml"
            cat > "${target_dir}/docs/index.md" <<- 'DOCEOF'
				# Documentación del proyecto Python

				Escribe aquí la documentación técnica.
				DOCEOF
            success "src/main.py creado"
            success "tests/test_main.py creado"
            success "requirements.txt + pyproject.toml creados"
            ;;

        ts)
            cat > "${target_dir}/src/main.ts" <<- 'TSEOF'
				/**
				 * main.ts — Punto de entrada del proyecto.
				 *
				 * Generado por ignisky-spark 🔥
				 */

				function main(): void {
				    console.log("🔥 main.ts funcionando!");
				}

				main();
				TSEOF
            cat > "${target_dir}/tests/main.test.ts" <<- 'TSTEOF'
				import { describe, it, expect } from "bun:test";

				describe("main", () => {
				    it("should work", () => {
				        expect(true).toBe(true);
				    });
				});
				TSTEOF
            cat > "${target_dir}/package.json" <<- 'PKGEOF'
				{
				  "name": "__PROJECT_NAME__",
				  "version": "0.1.0",
				  "description": "Proyecto generado con ignisky-spark",
				  "type": "module",
				  "scripts": {
				    "build": "tsc",
				    "test": "bun test",
				    "clean": "rm -rf dist"
				  },
				  "devDependencies": {
				    "typescript": "^5.5.0"
				  }
				}
				PKGEOF
            sed -i "s/__PROJECT_NAME__/$name/g" "${target_dir}/package.json"
            cat > "${target_dir}/tsconfig.json" <<- 'TSCEOF'
				{
				  "compilerOptions": {
				    "target": "ES2022",
				    "module": "ESNext",
				    "moduleResolution": "bundler",
				    "strict": true,
				    "esModuleInterop": true,
				    "outDir": "dist",
				    "rootDir": "src",
				    "declaration": true,
				    "skipLibCheck": true
				  },
				  "include": ["src"],
				  "exclude": ["node_modules", "dist", "tests"]
				}
				TSCEOF
            cat > "${target_dir}/docs/index.md" <<- 'DOCEOF'
				# Documentación del proyecto TypeScript

				Escribe aquí la documentación técnica.
				DOCEOF
            success "src/main.ts creado"
            success "tests/main.test.ts creado"
            success "package.json + tsconfig.json creados"
            ;;

        cpp)
            cat > "${target_dir}/src/main.cpp" <<- 'CPPEOF'
				/**
				 * main.cpp — Punto de entrada del proyecto.
				 *
				 * Generado por ignisky-spark 🔥
				 */
				#include <iostream>

				int main() {
				    std::cout << "🔥 main.cpp funcionando!" << std::endl;
				    return 0;
				}
				CPPEOF
            cat > "${target_dir}/tests/test_main.cpp" <<- 'CPPTEOF'
				/**
				 * test_main.cpp — Tests de unidad
				 */
				#include <cassert>

				int main() {
				    assert(1 + 1 == 2);
				    std::cout << "✅ Tests pasaron" << std::endl;
				    return 0;
				}
				CPPTEOF
            cat > "${target_dir}/Makefile" <<- 'MKEOF'
				CXX := g++
				CXXFLAGS := -std=c++20 -Wall -Wextra -O2
				SRC := src
				BUILD := build
				TARGET := $(BUILD)/main

				all: $(TARGET)

				$(TARGET): $(SRC)/*.cpp
					@mkdir -p $(BUILD)
					$(CXX) $(CXXFLAGS) -o $@ $^

				run: $(TARGET)
					./$(TARGET)

				test:
					$(CXX) $(CXXFLAGS) -o $(BUILD)/test tests/test_main.cpp
					./$(BUILD)/test

				clean:
					rm -rf $(BUILD)

				.PHONY: all run test clean
				MKEOF
            cat > "${target_dir}/docs/index.md" <<- 'DOCEOF'
				# Documentación del proyecto C++

				Escribe aquí la documentación técnica.
				DOCEOF
            success "src/main.cpp creado"
            success "tests/test_main.cpp creado"
            success "Makefile para C++ creado"
            ;;

        rust)
            cat > "${target_dir}/src/main.rs" <<- 'RSEOF'
				/// main.rs — Punto de entrada del proyecto.
				///
				/// Generado por ignisky-spark 🔥
				fn main() {
				    println!("🔥 main.rs funcionando!");
				}
				RSEOF
            cat > "${target_dir}/tests/test_main.rs" <<- 'RSTEOF'
				#[cfg(test)]
				mod tests {
				    #[test]
				    fn test_placeholder() {
				        assert_eq!(2 + 2, 4);
				    }
				}
				RSTEOF
            cat > "${target_dir}/Cargo.toml" <<- 'CARGOEOF'
				[package]
				name = "__PROJECT_NAME__"
				version = "0.1.0"
				edition = "2021"
				description = "Proyecto generado con ignisky-spark"

				[dependencies]
				CARGOEOF
            sed -i "s/__PROJECT_NAME__/$name/g" "${target_dir}/Cargo.toml"
            cat > "${target_dir}/docs/index.md" <<- 'DOCEOF'
				# Documentación del proyecto Rust

				Escribe aquí la documentación técnica.
				DOCEOF
            success "src/main.rs creado"
            success "tests/test_main.rs creado"
            success "Cargo.toml creado"
            ;;

        web)
            mkdir -p "${target_dir}/src/css" "${target_dir}/src/js"
            cat > "${target_dir}/src/index.html" <<- HTEOF
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${name}</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <h1>🔥 ${name}</h1>
  <script src="js/main.js"></script>
</body>
</html>
HTEOF
            cat > "${target_dir}/src/css/style.css" <<- CSSEOF
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: system-ui, sans-serif; color: #111; background: #fafafa; }
CSSEOF
            cat > "${target_dir}/src/js/main.js" <<- JSEOF
console.log("🔥 ${name} funcionando!");
JSEOF
            cat > "${target_dir}/docs/index.md" <<- 'DOCEOF'
# Documentación del proyecto web

Escribe aquí la documentación del sitio.
DOCEOF
            success "src/index.html + CSS + JS creados"
            ;;

        web-app)
            mkdir -p "${target_dir}/src/css" "${target_dir}/src/js/components" "${target_dir}/public"
            cat > "${target_dir}/src/index.html" <<- HTEOF
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${name}</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <div id="app"></div>
  <script type="module" src="js/app.js"></script>
</body>
</html>
HTEOF
            cat > "${target_dir}/src/css/style.css" <<- CSSEOF
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: system-ui, sans-serif; color: #111; background: #fafafa; }
#app { min-height: 100vh; display: flex; flex-direction: column; }
CSSEOF
            cat > "${target_dir}/src/js/app.js" <<- JSEOF
console.log("🔥 ${name} app iniciada");
JSEOF
            mkdir -p "${target_dir}/src/js/components" "${target_dir}/public"
            cat > "${target_dir}/package.json" <<- 'PKGEOF'
{
  "name": "__PROJECT_NAME__",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "npx serve src",
    "build": "echo 'build script pendiente'",
    "test": "echo 'test script pendiente'"
  }
}
PKGEOF
            sed -i "s/__PROJECT_NAME__/$name/g" "${target_dir}/package.json"
            cat > "${target_dir}/.env.example" <<- ENVEOF
# Variables de entorno
# Copia a .env y completa los valores
APP_NAME=${name}
APP_ENV=development
ENVEOF
            cat > "${target_dir}/docs/sdd.md" <<- SDDEOF
# Software Design Document — ${name}

> Generado por ignisky-spark 🔥

## Resumen

Breve descripción del propósito y alcance del proyecto.

## Arquitectura

Descripción de la arquitectura, patrones usados y estructura de directorios.

## Componentes

Lista de componentes principales y sus responsabilidades.

## API / Interfaces

Endpoints, contratos y formatos de datos.

## Decisiones técnicas

ADR - Architecture Decision Records.

---
*SDD generado con [ignisky-spark](https://github.com/yosoyignicion/ignisky-spark)*
SDDEOF
            cat > "${target_dir}/docs/index.md" <<- 'DOCEOF'
# Documentación del proyecto web

- [SDD — Software Design Document](sdd.md)
DOCEOF
            success "src/index.html + CSS + JS + components/ + public/ + SDD creados"
            ;;

        *)
            die "Tipo de proyecto no soportado: $type"
            ;;
    esac

    # ── .gitignore ──
    generate_gitignore "$type" > "${target_dir}/.gitignore"
    success ".gitignore optimizado para agentes AI"

    # ── README ──
    generate_readme "$name" "$type" "$author" "$desc" > "${target_dir}/README.md"
    success "README.md template generado"

    # ── CLAUDE.md (contexto para agentes AI) ──
    generate_claude_md "$name" "$type" "$author" "$desc" > "${target_dir}/CLAUDE.md"
    success "CLAUDE.md generado — contexto para agentes AI"

    # ── AGENTS.md (contexto multi-agente) ──
    generate_agents_md "$name" "$type" "$author" > "${target_dir}/AGENTS.md"
    success "AGENTS.md generado — contexto multi-agente"

    echo ""
    success "📁 ${BOLD}${target_dir}${NC} creado correctamente"
    echo ""
    draw_box "📊 Resumen"
    label "$(get_type_icon "$(get_type_entry "$type")") Tipo: ${BOLD}$type${NC}"
    label "📝 Nombre: ${BOLD}$name${NC}"
    label "👤 Autor: ${BOLD}$author${NC}"
    [[ -n "$desc" ]] && label "📖 Desc: ${BOLD}$desc${NC}"
    label "📂 Ruta: ${GRAY}${target_dir}${NC}"
    label "📦 Carpetas: ${BOLD}src/  tests/  docs/${NC}"
    label "🤖 Contexto: ${BOLD}CLAUDE.md  AGENTS.md${NC}"
    box_end
}

# ═══════════════════════════════════════════════════════════════
#  GIT INIT
# ═══════════════════════════════════════════════════════════════

init_git() {
    local project_dir="$1"
    local name="$2"

    if ! command -v git &>/dev/null; then
        warn "Git no está instalado. Omitiendo --git"
        return 1
    fi

    # Verificar que git tiene config de usuario
    if ! git config user.name &>/dev/null || ! git config user.email &>/dev/null; then
        warn "Git necesita user.name y user.email configurados. Omitiendo --git"
        warn "  Configúralos: git config --global user.name 'Tu Nombre'"
        return 1
    fi

    header "🔧 Inicializando repositorio Git"
    (
        cd "$project_dir" || return 1
        git init -b main &>/dev/null
        git add -A &>/dev/null
        git commit -m "chore: initial scaffold by ignisky-spark 🔥" --allow-empty &>/dev/null
        success "Repositorio Git inicializado en ${GRAY}${project_dir}${NC}"
        success "Commit inicial creado: ${BOLD}chore: initial scaffold by ignisky-spark 🔥${NC}"
    )
}

# ═══════════════════════════════════════════════════════════════
#  INSTALL DEPS — Instala dependencias según tipo
# ═══════════════════════════════════════════════════════════════

install_deps() {
    local project_dir="$1"
    local project_type="$2"

    header "📦 Instalando dependencias"

    cd "$project_dir" || { warn "No se pudo acceder a $project_dir"; return 1; }

    case "$project_type" in
        python)
            if command -v uv &>/dev/null; then
                uv sync --frozen && success "Deps instaladas con uv (locked)" || warn "uv sync falló"
            elif command -v pip &>/dev/null; then
                pip install -e . && success "Deps instaladas con pip" || warn "pip install falló"
            else
                warn "No se encontró pip ni uv"
            fi
            ;;
        ts)
            if command -v bun &>/dev/null; then
                bun install --frozen-lockfile && success "Deps instaladas con bun" || warn "bun install falló"
            elif command -v npm &>/dev/null; then
                npm ci && success "Deps instaladas con npm ci (locked)" || warn "npm ci falló"
            else
                warn "No se encontró bun ni npm"
            fi
            ;;
        web)
            if command -v python3 &>/dev/null; then
                python3 -m http.server --help &>/dev/null && success "Python3 disponible para servidor local" || warn "python3 no disponible"
            else
                warn "python3 no instalado"
            fi
            ;;
        web-app)
            if command -v npm &>/dev/null; then
                npm install && success "Deps instaladas con npm" || warn "npm install falló"
            else
                warn "npm no instalado"
            fi
            ;;
        rust)
            if command -v cargo &>/dev/null; then
                cargo check && success "Deps verificadas con cargo" || warn "cargo check falló"
            else
                warn "Cargo no instalado"
            fi
            ;;
        cpp)
            if command -v g++ &>/dev/null || command -v clang++ &>/dev/null; then
                success "Compilador C++ detectado"
            else
                warn "No se detectó compilador C++ (g++/clang++)"
            fi
            ;;
        bash)
            if command -v shellcheck &>/dev/null; then
                shellcheck src/*.sh && success "ShellCheck OK" || warn "ShellCheck encontró problemas"
            else
                success "Tipo bash — sin dependencias que instalar"
            fi
            ;;
    esac

    cd - &>/dev/null || true
}

# ═══════════════════════════════════════════════════════════════
#  LIST — Tipos disponibles
# ═══════════════════════════════════════════════════════════════

list_types() {
    header "📋 Tipos de proyecto disponibles"
    echo ""
    for entry in "${PROJECT_TYPES[@]}"; do
        local name desc icon
        name=$(get_type_name "$entry")
        desc=$(get_type_desc "$entry")
        icon=$(get_type_icon "$entry")
        echo -e "  ${icon}  ${RED}${BOLD}$name${NC}"
        echo -e "       ${GRAY}${desc}${NC}"
    done
    echo ""
    dim "  Usa:  ./${SCRIPT_NAME} --type <tipo> --name <nombre>"
    dim "  Ej:   ./${SCRIPT_NAME} --type python --name my-agent --git"
    echo ""
}


# ═══════════════════════════════════════════════════════════════
#  DETECT — Auto-detecta tipo de proyecto desde directorio
# ═══════════════════════════════════════════════════════════════

detect_project_type() {
    local dir="$1"
    [[ -f "${dir}/Cargo.toml" ]]        && { echo "rust"; return; }
    [[ -f "${dir}/package.json" ]]      && { echo "ts"; return; }
    [[ -f "${dir}/pyproject.toml" ]]    && { echo "python"; return; }
    [[ -f "${dir}/setup.py" ]]          && { echo "python"; return; }
    [[ -f "${dir}/Makefile" ]]          && { echo "cpp"; return; }
    [[ -f "${dir}/CMakeLists.txt" ]]    && { echo "cpp"; return; }
    # Buscar archivos .sh en src/ o raíz
    local sh_count
    sh_count=$(find "$dir" -maxdepth 2 -name '*.sh' 2>/dev/null | wc -l)
    [[ "$sh_count" -gt 0 ]]             && { echo "bash"; return; }
    [[ -f "${dir}/package.json" ]]       && { echo "web-app"; return; }
    ls "${dir}/src/index.html" &>/dev/null 2>&1 && { echo "web"; return; }
    echo "unknown"
}

# ═══════════════════════════════════════════════════════════════
#  PREMIUM STUB — Muestra mensaje de cupón cuando no está desbloqueado
# ═══════════════════════════════════════════════════════════════

premium_stub() {
    local name="${1:-feature}"
    header "🔥 ignisky-spark:${name}"
    echo -e "  ${YELLOW}⛁${NC} ${BOLD}Premium feature${NC}"
    dim "  Disponible en el pack premium con cupón ${RED}IGNICION25${NC}"
    premium_footer
}

# ═══════════════════════════════════════════════════════════════
#  spark:blast → --ci: CI/CD (.github/workflows) + Dockerfile
# ═══════════════════════════════════════════════════════════════

premium_ci() {
    [[ "${SPARK_PREMIUM:-}" != "true" ]] && { premium_stub "blast"; return; }
    local target_dir="$1"
    local project_type="$2"

    header "🔥 ignisky-spark:blast — CI/CD + Docker"

    mkdir -p "${target_dir}/.github/workflows"

    # ── CI workflow ──
    case "$project_type" in
        python)
            cat > "${target_dir}/.github/workflows/ci.yml" <<- CIEOF
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.12'
      - run: pip install -e .
      - run: pip install pytest ruff
      - run: ruff check src/
      - run: pytest
CIEOF
            ;;
        ts)
            cat > "${target_dir}/.github/workflows/ci.yml" <<- CIEOF
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: npm
      - run: npm ci
      - run: npm test
CIEOF
            ;;
        web)
            cat > "${target_dir}/.github/workflows/ci.yml" <<- CIEOF
name: CI

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: sudo apt-get update && sudo apt-get install -y htmlhint || true
      - run: echo "✅ Web estático — sin build necesario"
CIEOF
            ;;
        web-app)
            cat > "${target_dir}/.github/workflows/ci.yml" <<- CIEOF
name: CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: npm
      - run: npm ci
      - run: npm test
      - run: npm run build
CIEOF
            ;;
        rust)
            cat > "${target_dir}/.github/workflows/ci.yml" <<- CIEOF
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions-rust-lang/setup-rust-toolchain@v1
      - run: cargo check
      - run: cargo test
      - run: cargo clippy -- -D warnings
CIEOF
            ;;
        cpp)
            cat > "${target_dir}/.github/workflows/ci.yml" <<- CIEOF
name: CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: sudo apt-get update && sudo apt-get install -y build-essential cmake
      - run: make test
CIEOF
            ;;
        bash)
            cat > "${target_dir}/.github/workflows/ci.yml" <<- CIEOF
name: CI

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: sudo apt-get update && sudo apt-get install -y shellcheck
      - run: shellcheck src/*.sh
CIEOF
            ;;
    esac
    success ".github/workflows/ci.yml generado"

    # ── Dockerfile ──
    case "$project_type" in
        python)
            cat > "${target_dir}/Dockerfile" <<- DOCKEOF
FROM python:3.12-slim AS builder
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir .

FROM python:3.12-slim
WORKDIR /app
COPY --from=builder /usr/local/lib/python3.12 /usr/local/lib/python3.12
COPY --from=builder /usr/local/bin /usr/local/bin
COPY src/ ./src/
CMD ["python", "src/main.py"]
DOCKEOF
            ;;
        ts)
            cat > "${target_dir}/Dockerfile" <<- DOCKEOF
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:22-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./
CMD ["node", "dist/main.js"]
DOCKEOF
            ;;
        web)
            cat > "${target_dir}/Dockerfile" <<- DOCKEOF
FROM nginx:alpine
COPY src/ /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
DOCKEOF
            ;;
        web-app)
            cat > "${target_dir}/Dockerfile" <<- DOCKEOF
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY src/ ./src/
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
DOCKEOF
            ;;
        rust)
            cat > "${target_dir}/Dockerfile" <<- DOCKEOF
FROM rust:slim AS builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /app/target/release/* /usr/local/bin/
CMD ["/usr/local/bin/app"]
DOCKEOF
            ;;
        cpp)
            cat > "${target_dir}/Dockerfile" <<- DOCKEOF
FROM gcc:latest AS builder
WORKDIR /app
COPY . .
RUN make

FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /app/build ./build
CMD ["./build/main"]
DOCKEOF
            ;;
        bash)
            cat > "${target_dir}/Dockerfile" <<- DOCKEOF
FROM alpine:latest
RUN apk add --no-cache bash
WORKDIR /app
COPY src/ ./src/
CMD ["bash", "src/main.sh"]
DOCKEOF
            ;;
    esac
    success "Dockerfile generado"

    # ── .dockerignore ──
    cat > "${target_dir}/.dockerignore" <<- DIEOF
.git/
.gitignore
*.md
tests/
docs/
__pycache__/
*.pyc
node_modules/
target/
build/
.env
DIEOF
    success ".dockerignore generado"
}

# ═══════════════════════════════════════════════════════════════
#  spark:forge → --make: Makefile completo
# ═══════════════════════════════════════════════════════════════

premium_make() {
    [[ "${SPARK_PREMIUM:-}" != "true" ]] && { premium_stub "forge"; return; }
    local target_dir="$1"
    local project_type="$2"

    header "🔥 ignisky-spark:forge — Makefile Inteligente"

    case "$project_type" in
        python)
            cat > "${target_dir}/Makefile" <<- MKEOF
.PHONY: help build test clean lint run install docker-build docker-run

help:           ## Muestra esta ayuda
	@grep -E '^[a-zA-Z_-]+:.*##' Makefile | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

build:          ## Compila/empaqueta el proyecto
	pip install -e .

test:           ## Ejecuta tests
	pytest -v

lint:           ## Linting con ruff
	ruff check src/

clean:          ## Limpia artefactos
	rm -rf *.egg-info/ __pycache__/ .pytest_cache/ build/ dist/

run:            ## Ejecuta el proyecto
	python src/main.py

install:        ## Instala dependencias
	pip install -e .
	pip install pytest ruff

docker-build:   ## Construye imagen Docker
	docker build -t ${NAME:-app} .

docker-run:     ## Ejecuta contenedor Docker
	docker run --rm ${NAME:-app}
MKEOF
            ;;
        ts)
            cat > "${target_dir}/Makefile" <<- MKEOF
.PHONY: help build test clean lint run install docker-build docker-run

NAME ?= app

help:           ## Muestra esta ayuda
	@grep -E '^[a-zA-Z_-]+:.*##' Makefile | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

build:          ## Compila TypeScript
	npm run build

test:           ## Ejecuta tests
	npm test

lint:           ## Linting con eslint
	npx eslint src/

clean:          ## Limpia artefactos
	rm -rf dist/ node_modules/

run:            ## Ejecuta el proyecto
	node dist/main.js

install:        ## Instala dependencias
	npm ci

docker-build:   ## Construye imagen Docker
	docker build -t \$(NAME) .

docker-run:     ## Ejecuta contenedor Docker
	docker run --rm \$(NAME)
MKEOF
            ;;
        web)
            cat > "${target_dir}/Makefile" <<- MKEOF
.PHONY: help test clean run

help:           ## Muestra esta ayuda
	@grep -E '^[a-zA-Z_-]+:.*##' Makefile | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-16s\033[0m %s\n", \$$1, \$$2}'

test:           ## No hay tests en web estática
	@echo "✅ Web estática — sin tests automatizados"

clean:          ## Limpia temporales
	rm -rf tmp/

run:            ## Sirve localmente con python3
	@echo "  → Abre http://localhost:8000"
	python3 -m http.server 8000 -d src
MKEOF
            ;;
        web-app)
            cat > "${target_dir}/Makefile" <<- MKEOF
.PHONY: help build test clean lint run install docker-build docker-run

NAME ?= app

help:           ## Muestra esta ayuda
	@grep -E '^[a-zA-Z_-]+:.*##' Makefile | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-16s\033[0m %s\n", \$$1, \$$2}'

build:          ## Build de la web app
	npm run build

test:           ## Ejecuta tests
	npm test

lint:           ## Linting
	npx eslint src/

clean:          ## Limpia artefactos
	rm -rf dist/ node_modules/

run:            ## Dev server
	npm run dev

install:        ## Instala dependencias
	npm ci

docker-build:   ## Construye imagen Docker
	docker build -t \\$(NAME) .

docker-run:     ## Ejecuta contenedor Docker
	docker run --rm -p 80:80 \\$(NAME)
MKEOF
            ;;
        rust)
            cat > "${target_dir}/Makefile" <<- MKEOF
.PHONY: help build test clean lint run install docker-build docker-run

NAME ?= app

help:           ## Muestra esta ayuda
	@grep -E '^[a-zA-Z_-]+:.*##' Makefile | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

build:          ## Compila el proyecto
	cargo build --release

test:           ## Ejecuta tests
	cargo test

lint:           ## Linting con clippy
	cargo clippy -- -D warnings

clean:          ## Limpia artefactos
	cargo clean

run:            ## Ejecuta el proyecto
	cargo run --release

install:        ## Instala dependencias
	cargo fetch

docker-build:   ## Construye imagen Docker
	docker build -t \$(NAME) .

docker-run:     ## Ejecuta contenedor Docker
	docker run --rm \$(NAME)
MKEOF
            ;;
        cpp)
            cat > "${target_dir}/Makefile" <<- MKEOF
.PHONY: help build test clean lint run docker-build docker-run

CXX ?= g++
CXXFLAGS ?= -std=c++20 -Wall -Wextra -O2
SRC := src
BUILD := build

help:           ## Muestra esta ayuda
	@grep -E '^[a-zA-Z_-]+:.*##' Makefile | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

build: \$(BUILD)/main  ## Compila el proyecto

\$(BUILD)/main: \$(SRC)/*.cpp
	@mkdir -p \$(BUILD)
	$(CXX) $(CXXFLAGS) -o $@ $^

test: \$(BUILD)/test  ## Ejecuta tests
	./\$(BUILD)/test

\$(BUILD)/test: tests/*.cpp
	@mkdir -p \$(BUILD)
	$(CXX) $(CXXFLAGS) -o $@ $^

lint:           ## Linting con cppcheck
	cppcheck --enable=all --suppress=missingIncludeSystem \$(SRC)/

clean:          ## Limpia artefactos
	rm -rf \$(BUILD)

run: build      ## Ejecuta el proyecto
	./\$(BUILD)/main

docker-build:   ## Construye imagen Docker
	docker build -t \$(NAME:-app) .

docker-run:     ## Ejecuta contenedor Docker
	docker run --rm \$(NAME:-app)
MKEOF
            ;;
        bash)
            cat > "${target_dir}/Makefile" <<- MKEOF
.PHONY: help test lint clean run

help:           ## Muestra esta ayuda
	@grep -E '^[a-zA-Z_-]+:.*##' Makefile | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

test:           ## Ejecuta tests
	for f in tests/test_*.sh; do bash "$$f"; done

lint:           ## Linting con shellcheck
	shellcheck src/*.sh

clean:          ## Limpia artefactos
	rm -rf tmp/ _output/

run:            ## Ejecuta el proyecto
	bash src/main.sh
MKEOF
            ;;
    esac
    success "Makefile generado con $(grep -c '##' "${target_dir}/Makefile") targets"
}

# ═══════════════════════════════════════════════════════════════
#  spark:env → --bootstrap: Detecta herramientas y sugiere instalación
# ═══════════════════════════════════════════════════════════════

premium_bootstrap() {
    [[ "${SPARK_PREMIUM:-}" != "true" ]] && { premium_stub "env"; return; }
    local project_type="$1"

    header "🔥 ignisky-spark:env — Bootstrap de Herramientas"

    local -a missing=()
    local -a found=()

    case "$project_type" in
        python)
            for tool in python3 pip uv pytest ruff; do
                command -v "$tool" &>/dev/null && found+=("$tool") || missing+=("$tool")
            done
            local install_cmd="pip install uv pytest ruff"
            ;;
        ts)
            for tool in node npm bun; do
                command -v "$tool" &>/dev/null && found+=("$tool") || missing+=("$tool")
            done
            local install_cmd="npm install -g bun typescript tsx"
            ;;
        web)
            for tool in python3; do
                command -v "$tool" &>/dev/null && found+=("$tool") || missing+=("$tool")
            done
            local install_cmd="python3 ya incluido — instala un editor de texto"
            ;;
        web-app)
            for tool in node npm; do
                command -v "$tool" &>/dev/null && found+=("$tool") || missing+=("$tool")
            done
            local install_cmd="nvm install --lts  # o desde https://nodejs.org"
            ;;
        rust)
            for tool in rustup cargo clippy rustfmt; do
                command -v "$tool" &>/dev/null && found+=("$tool") || missing+=("$tool")
            done
            local install_cmd="rustup update && rustup component add clippy rustfmt"
            ;;
        cpp)
            for tool in g++ gcc make cmake cppcheck; do
                command -v "$tool" &>/dev/null && found+=("$tool") || missing+=("$tool")
            done
            local install_cmd="sudo apt install build-essential cmake cppcheck  # Debian/Ubuntu"
            ;;
        bash)
            for tool in shellcheck bash; do
                command -v "$tool" &>/dev/null && found+=("$tool") || missing+=("$tool")
            done
            local install_cmd="sudo apt install shellcheck  # o: brew install shellcheck"
            ;;
    esac

    echo -e "  ${GREEN}✅ Encontradas:${NC} ${found[*]:-ninguna}"
    echo -e "  ${YELLOW}❌ Faltantes:${NC}  ${missing[*]:-ninguna}"
    echo ""
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo -e "  ${BOLD}Para instalar lo que falta:${NC}"
        echo -e "    ${GRAY}${install_cmd}${NC}"
        echo ""
        # Intentar instalación si el usuario quiere
        echo -e "  ${YELLOW}¿Intentar instalación automática?${NC}"
        read -r -p "  ${RED}›${NC} ¿Instalar? (s/N): " confirm
        if [[ "$confirm" =~ ^[sS] ]]; then
            eval "$install_cmd" 2>&1 || warn "Alguna instalación falló — instala manualmente"
        fi
    else
        success "¡Todo instalado! ✅"
    fi
}

# ═══════════════════════════════════════════════════════════════
#  spark:kit → --templates: Editorconfig + linters por tipo
# ═══════════════════════════════════════════════════════════════

premium_templates() {
    [[ "${SPARK_PREMIUM:-}" != "true" ]] && { premium_stub "kit"; return; }
    local target_dir="$1"
    local project_type="$2"

    header "🔥 ignisky-spark:kit — Templates de Editor"

    # ── .editorconfig (universal) ──
    cat > "${target_dir}/.editorconfig" <<- ECOF
root = true

[*]
indent_style = space
indent_size = 4
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.{yml,yaml,json,md}]
indent_size = 2

[Makefile]
indent_style = tab
ECOF
    success ".editorconfig generado"

    # ── Linter/formatter por tipo ──
    case "$project_type" in
        python)
            cat > "${target_dir}/ruff.toml" <<- RUFFEOF
target-version = "py310"
line-length = 100

[lint]
select = ["E", "F", "I", "N", "W", "UP"]
ignore = ["E501"]

[format]
quote-style = "double"
RUFFEOF
            success "ruff.toml generado"
            ;;
        ts)
            cat > "${target_dir}/.prettierrc" <<- PTEOF
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "all",
  "printWidth": 100,
  "tabWidth": 2
}
PTEOF
            cat > "${target_dir}/.eslintrc.json" <<- ESLINTEOF
{
  "env": { "browser": true, "es2022": true, "node": true },
  "extends": ["eslint:recommended"],
  "parserOptions": { "ecmaVersion": "latest", "sourceType": "module" },
  "rules": {
    "no-unused-vars": "warn",
    "no-console": "off"
  }
}
ESLINTEOF
            success ".prettierrc + .eslintrc.json generados"
            ;;
        cpp)
            cat > "${target_dir}/.clang-format" <<- CFEOF
BasedOnStyle: Google
IndentWidth: 4
ColumnLimit: 100
AllowShortFunctionsOnASingleLine: None
CFEOF
            success ".clang-format generado"
            ;;
        web)
            success "Web usa .editorconfig + .prettierrc (incluido en general)"
            ;;
        web-app)
            cat > "${target_dir}/.prettierrc" <<- PTEOF
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "all",
  "printWidth": 100,
  "tabWidth": 2
}
PTEOF
            success ".prettierrc generado"
            ;;
        rust)
            cat > "${target_dir}/rustfmt.toml" <<- RFEOF
max_width = 100
tab_spaces = 4
edition = "2021"
RFEOF
            success "rustfmt.toml generado"
            ;;
        bash)
            # Para bash usamos .editorconfig + sugerencia de shellcheck
            success "Bash usa .editorconfig + shellcheck (ya incluido en CI)"
            ;;
    esac
}

# ═══════════════════════════════════════════════════════════════
#  spark:all — Muestra resumen del pack premium
# ═══════════════════════════════════════════════════════════════

premium_all() {
    header "💎 ignisky-spark — Pack Premium"
    echo -e "  ${BOLD}Funciones exclusivas del pack premium:${NC}"
    echo ""
    echo -e "  ${GRAY}│${NC}  🔥  ${BOLD}spark:blast${NC}    ${GRAY}· CI/CD (GitHub Actions) + Dockerfile + .dockerignore${NC}"
    echo -e "  ${GRAY}│${NC}  🔧  ${BOLD}spark:forge${NC}    ${GRAY}· Makefile completo (build/test/clean/lint/deploy)${NC}"
    echo -e "  ${GRAY}│${NC}  🌍  ${BOLD}spark:env${NC}      ${GRAY}· Bootstrap: detecta e instala herramientas${NC}"
    echo -e "  ${GRAY}│${NC}  🧰  ${BOLD}spark:kit${NC}      ${GRAY}· Editorconfig + Prettier + Linters por tipo${NC}"
    echo ""
    separator
    echo -e "  ${BOLD}👉 https://ignaciodev.gumroad.com/l/ignisky-spark-premium${NC}"
    echo -e "  ${BOLD}🏷️  Cupón: ${RED}IGNICION25${NC} ${GRAY}(25% OFF → 11.25€)${NC}"
    separator
}

# ═══════════════════════════════════════════════════════════════
#  MODO INTERACTIVO
# ═══════════════════════════════════════════════════════════════

show_banner() {
    echo ""
    echo -e "  ${RED}${BOLD}╔══════════════════════════════════════════╗${NC}"
    echo -e "  ${RED}${BOLD}║   🔥 ignisky-spark v${VERSION}               ${NC}"
    echo -e "  ${RED}${BOLD}║   La chispa inicial de tu workspace AI   ║${NC}"
    echo -e "  ${RED}${BOLD}╚══════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${GRAY}by IgnicionDev · Parte de ignisky-* 🔥${NC}"
    echo ""
}

interactive_menu() {
    while true; do
        echo -e "\n${RED}${BOLD}┌─ ¿Qué quieres hacer? ───────────────────────────────────┐${NC}"
        echo -e "  ${GRAY}│${NC}  ${BOLD}1${NC}  🔥  Crear nuevo workspace (scaffold completo)"
        echo -e "  ${GRAY}│${NC}  ${BOLD}2${NC}  📋  Ver tipos de proyecto disponibles"
        echo -e "  ${GRAY}│${NC}  ${BOLD}3${NC}  💎  Ver funciones premium"
        echo -e "  ${GRAY}│${NC}  ${BOLD}0${NC}  🚪  Salir"
        echo -e "${RED}${BOLD}└────────────────────────────────────────────────────────┘${NC}"
        echo ""
        read -r -p "  ${RED}›${NC} ${BOLD}Opción${NC} [0-3]: " opt
        echo ""

        case "$opt" in
            1) interactive_create ;;
            2) list_types ;;
            3) premium_all ;;
            0) echo -e "  ${GREEN}¡Hasta luego! 🔥${NC}\n"; exit 0 ;;
            *) warn "Opción inválida" ;;
        esac
    done
}

interactive_create() {
    header "🔥 Crear nuevo workspace"

    # ── Elegir tipo ──
    echo -e "  ${BOLD}Selecciona el tipo de proyecto:${NC}"
    echo ""
    local i=1
    declare -a names
    for entry in "${PROJECT_TYPES[@]}"; do
        local name desc icon
        name=$(get_type_name "$entry")
        desc=$(get_type_desc "$entry")
        icon=$(get_type_icon "$entry")
        names[$i]="$name"
        echo -e "  ${GRAY}│${NC}  ${BOLD}$i${NC}  ${icon}  ${RED}${BOLD}$name${NC} ${GRAY}· ${desc}${NC}"
        ((i++))
    done
    echo ""
    read -r -p "  ${RED}›${NC} Número del tipo [1-$((i-1))]: " sel
    local project_type="${names[$sel]:-}"
    if [[ -z "$project_type" ]]; then
        warn "Selección inválida"
        return
    fi
    echo ""

    # ── Nombre del proyecto ──
    read -r -p "  ${RED}›${NC} ${BOLD}Nombre del proyecto${NC}: " project_name
    if [[ -z "$project_name" ]]; then
        warn "El nombre no puede estar vacío"
        return
    fi
    # Sanitizar nombre
    project_name=$(echo "$project_name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]//g')
    echo ""

    # ── Autor (opcional) ──
    local default_author="$PROJECT_AUTHOR"
    read -r -p "  ${RED}›${NC} ${BOLD}Autor${NC} [${default_author}]: " project_author
    project_author="${project_author:-$default_author}"
    echo ""

    # ── Descripción (opcional) ──
    read -r -p "  ${RED}›${NC} ${BOLD}Descripción${NC} (opcional): " project_desc
    echo ""

    # ── Extras ──
    echo -e "  ${BOLD}Extras (separados por espacio):${NC}"
    echo ""
    echo -e "  ${GRAY}│${NC}  ${BOLD}1${NC}  🔧  Inicializar Git (${GREEN}--git${NC})"
    echo -e "  ${GRAY}│${NC}  ${BOLD}2${NC}  🔥  CI/CD + Docker (${YELLOW}⛁${NC} Premium)"
    echo -e "  ${GRAY}│${NC}  ${BOLD}3${NC}  🔧  Makefile (${YELLOW}⛁${NC} Premium)"
    echo -e "  ${GRAY}│${NC}  ${BOLD}4${NC}  🌍  Bootstrap tools (${YELLOW}⛁${NC} Premium)"
    echo -e "  ${GRAY}│${NC}  ${BOLD}5${NC}  🧰  Templates editor (${YELLOW}⛁${NC} Premium)"
    echo -e "  ${GRAY}│${NC}  ${BOLD}6${NC}  📦  Instalar dependencias (${GREEN}--install${NC})"
    echo -e "  ${GRAY}│${NC}  ${BOLD}0${NC}  🚫  Ninguno extra"
    echo ""
    read -r -p "  ${RED}›${NC} Números (ej: 1 2 3): " -a extras

    # ── Ejecutar ──
    create_scaffold "$project_type" "$project_name" "$project_author" "$project_desc"

    local target_dir="${SPARK_WORKDIR}/${project_name}"
    local has_git=false

    for extra in "${extras[@]}"; do
        case "$extra" in
            1)
                init_git "$target_dir" "$project_name"
                has_git=true
                ;;
            2)
                premium_ci "$target_dir" "$project_type"
                ;;
            3)
                premium_make "$target_dir" "$project_type"
                ;;
            4)
                premium_bootstrap "$project_type"
                ;;
            5)
                premium_templates "$target_dir" "$project_type"
                ;;
            6)
                install_deps "$target_dir" "$project_type"
                ;;
            *) ;;
        esac
    done

    echo ""
    success "🚀 Workspace listo: ${BOLD}${target_dir}${NC}"
    echo ""
    echo -e "  ${GRAY}  cd ${target_dir}${NC}"
    echo -e "  ${GRAY}  tree -L 2  (si tienes tree instalado)${NC}"
    echo ""
    if [[ "$has_git" == false ]]; then
        echo -e "  ${YELLOW}💡${NC} Usa ${BOLD}--git${NC} para inicializar el repo automáticamente."
    fi
    echo -e "  ${YELLOW}💡${NC} Descubre las funciones premium con ${BOLD}--premium${NC} o cupón ${RED}IGNICION25${NC}"
    echo ""
    read -r -p "  ${RED}›${NC} Presiona Enter para volver al menú..." _
}

# ═══════════════════════════════════════════════════════════════
#  PARSER DE ARGUMENTOS
# ═══════════════════════════════════════════════════════════════

usage() {
    echo -e "${RED}${BOLD}ignisky-spark v${VERSION}${NC} ${GRAY}— La chispa inicial de tu workspace AI 🔥${NC}"
    echo ""
    echo -e "${BOLD}Uso:${NC} ${SCRIPT_NAME} [opciones]"
    echo ""
    echo -e "${BOLD}Opciones gratuitas:${NC}"
    echo -e "  ${GREEN}--help${NC}, ${GREEN}-h${NC}            Muestra esta ayuda"
    echo -e "  ${GREEN}--version${NC}                Muestra la versión"
    echo -e "  ${GREEN}--type${NC} <lenguaje>         Inicializa workspace (bash|python|ts|cpp|rust|web|web-app)"
    echo -e "  ${GREEN}--name${NC} <nombre>           Nombre del proyecto"
    echo -e "  ${GREEN}--author${NC} <autor>          Autor del proyecto (default: git user.name)"
    echo -e "  ${GREEN}--desc${NC} <descripción>      Descripción breve del proyecto"
    echo -e "  ${GREEN}--dir${NC} <directorio>        Directorio destino (para --ci/--make/--templates)"
    echo -e "  ${GREEN}--list${NC}"
    echo -e "  ${GREEN}--git${NC}                     Inicializa repo Git automáticamente"
    echo -e "  ${GREEN}--install${NC}                 Instala dependencias (pip/npm/cargo)"
    echo ""
    echo -e "${BOLD}Premium (⛁  requiere pack con cupón ${RED}IGNICION25${NC}${BOLD}):${NC}"
    echo -e "  ${YELLOW}⛁${NC} ${GREEN}--ci${NC}           CI/CD (.github/workflows) + Dockerfile + .dockerignore"
    echo -e "  ${YELLOW}⛁${NC} ${GREEN}--make${NC}         Genera Makefile (build/test/clean/deploy)"
    echo -e "  ${YELLOW}⛁${NC} ${GREEN}--bootstrap${NC}    Detecta e instala herramientas necesarias"
    echo -e "  ${YELLOW}⛁${NC} ${GREEN}--templates${NC}    Añade .editorconfig, .prettierrc, tsconfig según tipo"
    echo -e "  ${YELLOW}⛁${NC} ${GREEN}--premium${NC}      Muestra todas las funciones premium disponibles"
    echo ""
    echo -e "${BOLD}Ejemplos:${NC}"
    echo -e "  ${GRAY}# Modo interactivo (por defecto)${NC}"
    echo -e "  ${SCRIPT_NAME}"
    echo ""
    echo -e "  ${GRAY}# Workspace Python con Git${NC}"
    echo -e "  ${SCRIPT_NAME} --type python --name my-agent --git"
    echo ""
    echo -e "  ${GRAY}# Workspace TypeScript completo con dependencias${NC}"
    echo -e "  ${SCRIPT_NAME} --type ts --name mcp-server --git --install"
    echo ""
    echo -e "  ${GRAY}# Workspace Rust con autor personalizado${NC}"
    echo -e "  ${SCRIPT_NAME} --type rust --name my-tool --author Nacho --desc 'CLI tool rápida'"
    echo ""
    echo -e "  ${GRAY}# Ver tipos disponibles${NC}"
    echo -e "  ${SCRIPT_NAME} --list"
    echo ""
    echo -e "  ${GRAY}# Ver funciones premium${NC}"
    echo -e "  ${SCRIPT_NAME} --premium"
    echo ""
    separator
    echo -e "${BOLD}💎 https://ignaciodev.gumroad.com/l/ignisky-spark-premium  ·  Cupón: ${RED}IGNICION25${NC}"
    separator
    exit 0
}

# Flags por defecto
PROJECT_TYPE=""
PROJECT_NAME=""
DO_GIT=false
DO_INSTALL=false
PREMIUM_DIR=""
INTERACTIVE=true

parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)       usage ;;
            --version)       echo "ignisky-spark v${VERSION}"; exit 0 ;;
            --type)          PROJECT_TYPE="$2"; shift ;;
            --name)          PROJECT_NAME="$2"; shift ;;
            --author)        PROJECT_AUTHOR="$2"; shift ;;
            --desc)          PROJECT_DESC="$2"; shift ;;
            --dir)           PREMIUM_DIR="$2"; shift ;;
            --list)          list_types; exit 0 ;;
            --git)           DO_GIT=true ;;
            --install)       DO_INSTALL=true ;;
            --ci)            MODE="premium-ci" ;;
            --make)          MODE="premium-make" ;;
            --bootstrap)     MODE="premium-bootstrap" ;;
            --templates)     MODE="premium-templates" ;;
            --premium)       MODE="premium-all" ;;
            *)               die "Opción desconocida: $1. Usa --help para ayuda." ;;
        esac
        shift
    done

    # Si hay modo premium, ejecutar y salir
    if [[ -n "${MODE:-}" ]]; then
        local pdir="${PREMIUM_DIR:-$(pwd)}"
        local ptype="${PROJECT_TYPE:-$(detect_project_type "$pdir")}"
        case "$MODE" in
            premium-ci)
                premium_ci "$pdir" "$ptype"
                ;;
            premium-make)
                premium_make "$pdir" "$ptype"
                ;;
            premium-bootstrap)
                premium_bootstrap "$ptype"
                ;;
            premium-templates)
                premium_templates "$pdir" "$ptype"
                ;;
            premium-all)
                premium_all
                ;;
        esac
        exit 0
    fi

    # Si hay --type, modo no interactivo
    if [[ -n "$PROJECT_TYPE" ]]; then
        INTERACTIVE=false
        if [[ -z "$PROJECT_NAME" ]]; then
            die "Se requiere --name <nombre> cuando se usa --type"
        fi
        if ! valid_type "$PROJECT_TYPE"; then
            die "Tipo no soportado: $PROJECT_TYPE. Usa --list para ver los disponibles."
        fi
    fi
}

# ═══════════════════════════════════════════════════════════════
#  MAIN
# ═══════════════════════════════════════════════════════════════

main() {
    parse_args "$@"

    if [[ "$INTERACTIVE" == false ]]; then
        # Modo directo (flags)
        create_scaffold "$PROJECT_TYPE" "$PROJECT_NAME" "$PROJECT_AUTHOR" "$PROJECT_DESC"
        local target_dir="${SPARK_WORKDIR}/${PROJECT_NAME}"

        if [[ "$DO_GIT" == true ]]; then
            init_git "$target_dir" "$PROJECT_NAME"
        fi

        if [[ "$DO_INSTALL" == true ]]; then
            install_deps "$target_dir" "$PROJECT_TYPE"
        fi

        echo ""
        success "🚀 Workspace listo: ${BOLD}${target_dir}${NC}"
        echo ""
        echo -e "  ${GRAY}  cd ${target_dir}${NC}"
        exit 0
    fi

    # Modo interactivo (por defecto)
    show_banner
    interactive_menu
}

main "$@"
