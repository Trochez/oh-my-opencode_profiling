#!/bin/bash
set -e

MODO=$1
PATH_CONFIG="./.opencode"

# Archivos activos posibles
DESTINO_OPENAGENT_DOT="$PATH_CONFIG/oh-my-openagent.json"
DESTINO_OPENCODE_DOT="$PATH_CONFIG/oh-my-opencode.json"
DESTINO_ROOT="./oh-my-opencode.json"

# Perfil fuente por defecto
DEFAULT_ORIGEN="$PATH_CONFIG/oh-my-opencode-nogpt.json"

# 1. Mapear argumentos
case "$MODO" in
  "nogpt")
    ORIGEN="$PATH_CONFIG/oh-my-opencode-nogpt.json"
    ;;
  "gpt")
    ORIGEN="$PATH_CONFIG/oh-my-opencode-gpt.json"
    ;;
  "nv")
    ORIGEN="$PATH_CONFIG/oh-my-opencode-nvoa.json"
    MODO="nv"
    ;;
  "lw")
    ORIGEN="$PATH_CONFIG/oh-my-opencode-lowcost.json"
    MODO="lw"
    ;;
  *)
    ORIGEN="$DEFAULT_ORIGEN"
    MODO="nogpt"
    ;;
esac

# 2. Validar existencia
if [ ! -f "$ORIGEN" ]; then
  echo "❌ Error: No existe $ORIGEN"
  exit 1
fi

# 3. Copiar a todos los destinos posibles
cp "$ORIGEN" "$DESTINO_OPENAGENT_DOT"
cp "$ORIGEN" "$DESTINO_OPENCODE_DOT"
cp "$ORIGEN" "$DESTINO_ROOT"

# --- BLOQUE DE VERIFICACIÓN ---
echo "------------------------------------------------"
echo "🔍 VERIFICACIÓN DE SESIÓN:"
echo "🧩 Modo solicitado: $MODO"
echo "📂 Archivo fuente: $ORIGEN"
echo "🎯 Archivos activos:"
echo "   - $DESTINO_OPENAGENT_DOT"
echo "   - $DESTINO_OPENCODE_DOT"
echo "   - $DESTINO_ROOT"

MODELO_OPENAGENT=$(grep -oP '"model":\s*"\K[^"]+' "$DESTINO_OPENAGENT_DOT" | head -n 1 || true)
MODELO_OPENCODE=$(grep -oP '"model":\s*"\K[^"]+' "$DESTINO_OPENCODE_DOT" | head -n 1 || true)
MODELO_ROOT=$(grep -oP '"model":\s*"\K[^"]+' "$DESTINO_ROOT" | head -n 1 || true)

echo "🤖 Modelo en oh-my-openagent.json: $MODELO_OPENAGENT"
echo "🤖 Modelo en .opencode/oh-my-opencode.json: $MODELO_OPENCODE"
echo "🤖 Modelo en ./oh-my-opencode.json: $MODELO_ROOT"
echo "------------------------------------------------"

# 4. Trap para limpieza
cleanup() {
  if [ -f "$DEFAULT_ORIGEN" ]; then
    cp "$DEFAULT_ORIGEN" "$DESTINO_OPENAGENT_DOT"
    cp "$DEFAULT_ORIGEN" "$DESTINO_OPENCODE_DOT"
    cp "$DEFAULT_ORIGEN" "$DESTINO_ROOT"
    echo -e "\n✅ Sesión cerrada. Perfil original restaurado."
  fi
}

trap cleanup EXIT INT TERM

# 5. Lanzar
echo "🚀 Iniciando OpenCode..."
opencode
