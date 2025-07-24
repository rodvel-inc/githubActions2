#!/bin/bash
set -e

MAX_RETRIES=30
DELAY=10

check_service() {
    local service=$1
    status=$(docker inspect --format='{{.State.Health.Status}}' "$(docker compose ps -q $service)")
    if [ "$status" = "healthy" ]; then
        return 0
    else
        echo "Current status of $service: $status"
        return 1
    fi
}

echo "Waiting for services to be healthy..."

for i in $(seq 1 $MAX_RETRIES); do
    unhealthy=false
    
    for service in vote worker result redis postgres nginx; do
        echo "Checking $service..."
        if ! check_service $service; then
            unhealthy=true
            break
        fi
    done
    
    if [ "$unhealthy" = false ]; then
        echo "✅ All services are healthy!"
        exit 0
    fi
    
    echo "Attempt $i/$MAX_RETRIES - Waiting ${DELAY}s..."
    sleep $DELAY
done

echo "❌ Services failed to become healthy after $MAX_RETRIES attempts"
docker compose ps
docker compose logs
exit 1