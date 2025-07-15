#!/bin/bash
set -e

MAX_RETRIES=30
DELAY=10

check_service() {
    local service=$1
    docker compose ps $service --format json | jq -r '.[0].Health' | grep -q "healthy"
}

echo "Waiting for services to be healthy..."

for i in $(seq 1 $MAX_RETRIES); do
    unhealthy=false
    
    for service in vote worker result redis postgres; do
        if ! check_service $service; then
            echo "Service $service is not healthy yet..."
            unhealthy=true
            break
        fi
    done
    
    if [ "$unhealthy" = false ]; then
        echo "All services are healthy!"
        exit 0
    fi
    
    echo "Attempt $i/$MAX_RETRIES - Waiting ${DELAY}s..."
    sleep $DELAY
done

echo "Services failed to become healthy after $MAX_RETRIES attempts"
docker compose logs
exit 1