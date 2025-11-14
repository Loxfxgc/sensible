#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Running Ansible Playbook${NC}"
echo ""

# Check if containers are running
if ! docker ps | grep -q ansible_web1; then
    echo "⚠️  Containers not running. Starting them first..."
    ./setup.sh
    echo ""
fi

# Run the playbook
echo -e "${GREEN}Running playbook...${NC}"
ansible-playbook playbook.yml

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Playbook execution completed successfully!${NC}"
    echo ""
    echo "🌐 Test your web servers:"
    echo "  curl http://localhost:8081"
    echo "  curl http://localhost:8082"
    echo ""
    echo "Or open in browser:"
    echo "  http://localhost:8081"
    echo "  http://localhost:8082"
else
    echo ""
    echo "❌ Playbook execution failed. Check the output above."
fi
