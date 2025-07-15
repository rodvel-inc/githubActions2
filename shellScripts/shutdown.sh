#!/bin/bash

# shutdown.sh - Detiene y elimina el stack de Voting App
# Autor: Andres Velandia
# Fecha: $(date +%Y-%m-%d)

set -e

echo "🛑 Deteniendo contenedores..."
docker-compose down --remove-orphans

echo "🧼 Limpiando contenedores, volúmenes anónimos y redes huérfanas..."
docker system prune --volumes -f

echo "✅ Stack detenido y entorno limpio."
