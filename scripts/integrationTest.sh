#!/bin/bash

set -e

echo "🧪 Iniciando pruebas de integración..."

# 1. Nginx -> Vote
echo "🔁 Verificando conexión de NGINX -> VOTE (http://localhost)..."
curl -s -f http://localhost | grep -i "voting" && echo "✅ NGINX puede acceder a VOTE" || (echo "❌ Falla NGINX -> VOTE" && exit 1)

# 2. Vote -> Redis
echo "📨 Enviando voto de prueba a VOTE (http://localhost/vote)..."
curl -s -X POST -d "vote=a" http://localhost/vote || (echo "❌ Falla al votar desde VOTE" && exit 1)

echo "⏳ Esperando procesamiento por parte de WORKER..."
sleep 5  # Esperar a que el worker consuma de Redis y escriba en Postgres

# 3. Result -> Postgres
echo "📊 Verificando si RESULT puede leer los votos desde POSTGRES..."
curl -s -f http://localhost:3010 | grep -i "results" && echo "✅ RESULT muestra resultados" || (echo "❌ Falla RESULT -> POSTGRES" && exit 1)

echo "🎉 Todas las pruebas de integración pasaron exitosamente."
