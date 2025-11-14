#!/bin/bash

echo "🔍 Ansible Docker Debug Tool"
echo "================================"
echo ""

# Check if Docker is running
echo "1️⃣  Checking Docker status..."
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi
echo "✅ Docker is running"
echo ""

# Check container status
echo "2️⃣  Checking container status..."
docker-compose ps
echo ""

# Check if containers are running
RUNNING=$(docker ps --filter "name=ansible_" --format "{{.Names}}" | wc -l)
if [ "$RUNNING" -lt 3 ]; then
    echo "⚠️  Only $RUNNING/3 containers running. Restarting..."
    docker-compose down
    docker-compose up -d
    echo "⏳ Waiting 15 seconds for containers to fully start..."
    sleep 15
else
    echo "✅ All 3 containers are running"
fi
echo ""

# Check SSH service in containers
echo "3️⃣  Checking SSH service in containers..."
for container in ansible_web1 ansible_web2 ansible_db1; do
    echo -n "   $container: "
    if docker exec $container pgrep sshd > /dev/null 2>&1; then
        echo "✅ SSH running"
    else
        echo "❌ SSH not running - Starting SSH..."
        docker exec $container service ssh start 2>/dev/null || \
        docker exec $container /usr/sbin/sshd 2>/dev/null
    fi
done
echo ""

# Test Ansible connectivity
echo "4️⃣  Testing Ansible connectivity..."
ansible all -m ping -o

echo ""
echo "================================"
echo "📋 Quick fixes:"
echo "  ./fix-ssh.sh                    # Fix SSH issues"
echo "  docker-compose restart          # Restart all containers"
echo "  docker-compose down && docker-compose up -d  # Full restart"
