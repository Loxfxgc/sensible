#!/bin/bash

echo "🧹 Stopping and removing containers..."
docker-compose down

echo "🗑️  Removing Docker images..."
docker-compose down --rmi local

echo "✅ Cleanup complete!"
