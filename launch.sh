#!/bin/bash

# launch.sh - Lanza el stack docker-compose después de validar puertos
# Autor: Andres Velandia
# Fecha: $(date +%Y-%m-%d)

set -e

# Lista de puertos que deben estar libres
PORTS=(80 8080 3000 3010 5432)

# Contenedores para los cuales queremos recolectar logs
SERVICES=(vote worker result nginx)

# Carpeta de logs
LOG_DIR="logs"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/stack_$TIMESTAMP.log"

mkdir -p "$LOG_DIR"

echo "🔎 Verificando disponibilidad de puertos..."
for PORT in "${PORTS[@]}"; do
    if lsof -iTCP -sTCP:LISTEN -nP | grep ":$PORT" > /dev/null; then
        echo "❌ Puerto $PORT está en uso. Aborta el lanzamiento."
        echo "   Para ver el proceso: sudo lsof -i :$PORT"
        exit 1
    else
        echo "✅ Puerto $PORT está libre"
    fi
done

echo -e "\n🚀 Todos los puertos están disponibles. Iniciando stack en modo detached..."
docker-compose up --build --remove-orphans --force-recreate -d

echo -e "\n📡 Recolectando logs de servicios críticos..."
echo "Timestamp: $TIMESTAMP" > "$LOG_FILE"
for SERVICE in "${SERVICES[@]}"; do
    echo -e "\n==================== [LOG: $SERVICE] ====================" >> "$LOG_FILE"
    docker-compose logs --no-color "$SERVICE" >> "$LOG_FILE" 2>&1
done

echo -e "\n✅ Stack lanzado correctamente."
echo "📁 Logs guardados en: $LOG_FILE"
