#!/bin/bash

set -e

echo "🧪 Iniciando pruebas de integración..."

# 1. Nginx -> Vote
echo "🔁 Verificando conexión de NGINX -> VOTE (http://localhost)..."
curl -s -f http://localhost | grep -i "voting" && echo "✅ NGINX puede acceder a VOTE" || (echo "❌ Falla NGINX -> VOTE" && exit 1)

# 2. Vote -> Redis
echo "📨 Enviando voto de prueba a VOTE (http://localhost/vote)..."
curl -s -X POST -d "vote=a" http://localhost/  || (echo "❌ Falla al votar desde VOTE" && exit 1)

echo "⏳ Esperando procesamiento por parte de WORKER..."
sleep 5  # Esperar a que el worker consuma de Redis y escriba en Postgres

# 4. Verificar que el voto fue registrado en la base de datos a través de /stats
echo "📊 Verificando votos a través de /stats..."

stats_response=$(curl -s -f http://localhost/stats) || (echo "❌ Error accediendo a /stats" && exit 1)

total_votes=$(echo "$stats_response" | jq '.total_votes')
cats_votes=$(echo "$stats_response" | jq '.cats_votes')
dogs_votes=$(echo "$stats_response" | jq '.dogs_votes')

echo "📈 Votos actuales: total=$total_votes, cats=$cats_votes, dogs=$dogs_votes"

if [ "$total_votes" -ge 1 ] && [ "$cats_votes" -ge 1 ]; then
  echo "✅ Voto registrado exitosamente en la base de datos"
else
  echo "❌ El voto no fue registrado correctamente"
  exit 1
fi

echo "🎉 Todas las pruebas de integración pasaron exitosamente."
