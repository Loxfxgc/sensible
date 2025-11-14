#!/bin/bash

echo "🐳 Starting Docker containers..."
docker-compose down 2>/dev/null
docker-compose up -d --build

echo "⏳ Waiting for containers to start..."
sleep 5

echo "🔧 Starting SSH services in containers..."
docker exec ansible_web1 service ssh start 2>/dev/null || docker exec ansible_web1 /usr/sbin/sshd
docker exec ansible_web2 service ssh start 2>/dev/null || docker exec ansible_web2 /usr/sbin/sshd
docker exec ansible_db1 service ssh start 2>/dev/null || docker exec ansible_db1 /usr/sbin/sshd

echo "⏳ Waiting for SSH to be ready..."
sleep 10

echo "🔍 Testing connectivity..."
ansible all -m ping

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ All hosts are reachable!"
    echo ""
    echo "📋 Available commands:"
    echo "  ./run.sh                              # Run the playbook"
    echo "  ansible-playbook playbook.yml          # Run manually"
    echo "  ansible all -m ping                    # Test connectivity"
    echo "  ansible all -a 'uptime'                # Run command on all hosts"
    echo ""
    echo "🌐 Access web servers:"
    echo "  http://localhost:8081 (web1)"
    echo "  http://localhost:8082 (web2)"
else
    echo ""
    echo "❌ Connection failed. Running diagnostics..."
    echo ""
    docker-compose ps
    echo ""
    echo "Run './debug.sh' for detailed troubleshooting"
fi
