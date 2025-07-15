#!/bin/bash
set -e

docker compose -f docker-compose.test.yml up -d redis postgres
sleep 5

docker compose -f docker-compose.test.yml up -d vote result
sleep 10

echo "🔍 Checking vote service..."
curl -f http://localhost:5000/health

echo "🔍 Checking result service..."
curl -f http://localhost:5001/health

docker compose -f docker-compose.test.yml down
