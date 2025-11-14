# Ansible + Docker Project

Complete setup for running Ansible locally using Docker containers.

## 📁 Project Structure
```
.
├── Dockerfile              # Container image definition
├── docker-compose.yml      # Multi-container orchestration
├── ansible.cfg            # Ansible configuration
├── playbook.yml           # Main playbook
├── inventory/
│   └── hosts.yml         # Inventory with Docker IPs
├── roles/
│   ├── common/           # Common tasks
│   ├── webserver/        # Nginx setup
│   └── database/         # PostgreSQL setup
├── setup.sh              # Initial setup script
├── run.sh                # Run playbook script
├── cleanup.sh            # Cleanup script
└── test-connection.sh    # Test connectivity

```

## 🚀 Quick Start

### 1. Prerequisites
```bash
# Install Docker and Docker Compose
# Install Ansible
pip install ansible
```

### 2. Setup Project
```bash
# Create directory structure
mkdir -p ansible-docker-project/{inventory,roles/{common,webserver,database}/{tasks,templates,handlers}}
cd ansible-docker-project

# Copy all files from the artifact into their respective locations
```

### 3. Make scripts executable
```bash
chmod +x setup.sh run.sh cleanup.sh test-connection.sh
```

### 4. Start containers and test
```bash
./setup.sh
```

### 5. Run Ansible playbook
```bash
./run.sh
```

### 6. Test the web servers
```bash
curl http://localhost:8081
curl http://localhost:8082
```

Or open in browser:
- http://localhost:8081
- http://localhost:8082

## 🎯 Available Commands

```bash
# Start containers
docker-compose up -d

# Run playbook
ansible-playbook playbook.yml

# Test connectivity
ansible all -m ping

# Run on specific hosts
ansible-playbook playbook.yml --limit webservers

# Check what would change (dry run)
ansible-playbook playbook.yml --check

# Run with verbose output
ansible-playbook playbook.yml -v

# Execute ad-hoc commands
ansible all -a "uptime"
ansible webservers -a "nginx -v"

# Stop containers
docker-compose down

# Full cleanup
./cleanup.sh
```

## 🐛 Troubleshooting

**Containers won't start:**
```bash
docker-compose logs
```

**Can't connect to hosts:**
```bash
# Check if containers are running
docker ps

# Test SSH manually
ssh -p 2221 ansible@localhost  # password: ansible
```

**Ansible connection issues:**
```bash
# Test ping
ansible all -m ping -vvv

# Check from inside container
docker exec -it ansible_web1 bash
```

## 📊 Container Details

| Service | SSH Port | HTTP Port | IP Address   |
|---------|----------|-----------|--------------|
| web1    | 2221     | 8081      | 172.25.0.10  |
| web2    | 2222     | 8082      | 172.25.0.11  |
| db1     | 2223     | 5432      | 172.25.0.20  |

**Credentials:**
- Username: `ansible`
- Password: `ansible`
# sensible
