#!/bin/bash

echo "🔧 Fixing SSH connectivity issues..."
echo ""

echo "1. Restarting containers..."
docker-compose restart

echo "2. Waiting for containers to start..."
sleep 5

echo "3. Starting SSH services..."
for container in ansible_web1 ansible_web2 ansible_db1; do
    echo "   Starting SSH in $container..."
    docker exec $container service ssh start 2>/dev/null || \
    docker exec $container /usr/sbin/sshd
done

echo "4. Waiting for SSH to initialize..."
sleep 10

echo "5. Testing SSH manually from host..."
for port in 2221 2222 2223; do
    echo -n "   Testing localhost:$port - "
    sshpass -p ansible ssh -p $port -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=5 ansible@localhost "echo OK" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "✅"
    else
        echo "❌ Failed"
    fi
done

echo ""
echo "6. Testing Ansible connectivity..."
ansible all -m ping -o

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ SSH fixed! All hosts are now reachable."
else
    echo ""
    echo "⚠️  Still having issues."
    echo ""
    echo "Installing sshpass if needed..."
    if ! command -v sshpass &> /dev/null; then
        echo "Please install sshpass:"
        echo "  macOS: brew install hudochenkov/sshpass/sshpass"
        echo "  Linux: sudo apt-get install sshpass"
    fi
    echo ""
    echo "Or install paramiko for Python:"
    echo "  pip install paramiko"
fi
