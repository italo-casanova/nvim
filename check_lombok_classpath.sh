#!/usr/bin/env bash

echo "🔍 Buscando proceso JDTLS..."
PID=$(ps -eo pid,comm,args | grep '[j]ava' | grep 'org.eclipse.equinox.launcher' | awk '{print $1}' | head -n1)

if [[ -z "$PID" ]]; then
  echo "❌ No se encontró proceso de JDTLS ejecutándose."
  exit 1
fi

echo "✅ Proceso encontrado (PID: $PID)"
CMDLINE=$(tr '\0' ' ' < /proc/$PID/cmdline)

echo "🔍 Verificando si lombok.jar está en los argumentos..."
if echo "$CMDLINE" | grep -q "javaagent=.*lombok.jar"; then
  echo "✅ Lombok está siendo utilizado como javaagent."
else
  echo "❌ Lombok NO está siendo utilizado como javaagent."
fi

echo ""
echo "📦 Mostrando classpath (CLASSPATH/args):"
echo "--------------------------------------"
if echo "$CMDLINE" | grep -E -- '-cp|-classpath' > /dev/null; then
  echo "$CMDLINE" | grep -oE '(-cp|-classpath) [^ ]+' | cut -d' ' -f2 | tr ':' '\n'
else
  echo "⚠️  No se encontró classpath explícito. Es posible que se esté usando un classloader por defecto."
fi

echo ""
echo "ℹ️  Para ver los jars realmente cargados por el classloader, puedes usar:"
echo "    jcmd $PID VM.classloaders"
echo "    jcmd $PID VM.system_properties | grep -i lombok"
