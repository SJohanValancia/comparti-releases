#!/bin/bash
set -e

DMG_URL="https://github.com/SJohanValancia/comparti-releases/releases/download/v1.0.0/comparti.1.0.0.dmg"
TMP_DIR=$(mktemp -d)
DMG_PATH="$TMP_DIR/comparti.dmg"

echo "Comparti - Instalador automatico"
echo "================================"

echo ""
echo "Descargando Comparti..."
curl -L -# -o "$DMG_PATH" "$DMG_URL"

echo ""
echo "Montando DMG..."
hdiutil attach "$DMG_PATH" -nobrowse -quiet -mountpoint "$TMP_DIR/mount"

echo "Instalando..."
cp -R "$TMP_DIR/mount/comparti.app" /Applications/

echo "Desmontando..."
hdiutil detach "$TMP_DIR/mount" -quiet -force 2>/dev/null || true

rm -rf "$TMP_DIR"

echo ""
echo "Comparti instalado exitosamente en /Applications/"
echo "Abrelo desde Launchpad o Terminal: open /Applications/comparti.app"
