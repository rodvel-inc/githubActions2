#!/bin/bash
set -e

MAX_RETRIES=30
DELAY=10

check_service() {
    local service=$1
    # Fix: Parse the health status correctly from docker compose ps
    health_status=$(docker compose ps $service --format '{{.Health}}')
    if [ "$health_status" = "healthy" ]; then
        return 0
    else
        return 1
    fi
}

echo "Waiting for services to be healthy..."

for i in $(seq 1 $MAX_RETRIES); do
    unhealthy=false
    
    for service in vote worker result redis postgres; do
        echo "Checking $service..."
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
echo "Container logs:"
docker compose logs
exit 1