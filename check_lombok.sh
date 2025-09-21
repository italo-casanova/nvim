#!/usr/bin/env bash

echo "🔍 Buscando proceso JDTLS..."
PID=$(ps -ef | grep -i 'org.eclipse.equinox.launcher' | grep -v grep | awk '{print $2}')

if [[ -z "$PID" ]]; then
  echo "❌ No se encontró proceso de JDTLS ejecutándose."
  exit 1
fi

echo "✅ Proceso encontrado (PID: $PID)"
echo "🔍 Verificando si lombok.jar está siendo usado..."

CMDLINE=$(tr '\0' ' ' < /proc/$PID/cmdline)

if echo "$CMDLINE" | grep -q "javaagent=.*lombok.jar"; then
  echo "✅ Lombok está siendo utilizado como javaagent."
else
  echo "❌ Lombok NO está siendo utilizado. Revisa tu configuración de -javaagent."
  echo "⚠️  Línea de comando:"
  echo "$CMDLINE"
fi
