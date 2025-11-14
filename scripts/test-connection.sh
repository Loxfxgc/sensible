#!/bin/bash

echo "Testing connection to all hosts..."
echo ""

ansible all -m ping -o

echo ""
echo "Getting system information..."
ansible all -m setup -a "filter=ansible_distribution*" -o
