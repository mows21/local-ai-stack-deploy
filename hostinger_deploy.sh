#!/bin/bash

# Error handling
set -e
trap 'echo "Error on line $LINENO. Exit code: $?"' ERR

# Function to check command success
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed"
        exit 1
    fi
}

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🚀 Starting Local AI Stack Deployment${NC}"

# Update and install dependencies
echo -e "${YELLOW}📦 Installing dependencies...${NC}"
apt update && apt install git python3 nano ufw openssh-client -y
check_command "Package installation"

# Setup SSH key if not exists
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo -e "${YELLOW}🔑 Generating SSH key...${NC}"
    ssh-keygen -t ed25519 -C "dustin@mowsdigital.agency" -N "" -f ~/.ssh/id_ed25519
    echo -e "${GREEN}✅ SSH key generated${NC}"
    echo -e "${YELLOW}⚠️ Add this public key to your GitHub account:${NC}"
    cat ~/.ssh/id_ed25519.pub
    echo -e "${YELLOW}Press Enter once you've added the key to GitHub...${NC}"
    read
fi

# Test GitHub SSH connection
echo -e "${YELLOW}🔒 Testing GitHub SSH connection...${NC}"
ssh -T -o StrictHostKeyChecking=no git@github.com || true

# Clone repository
echo -e "${YELLOW}📥 Cloning repository...${NC}"
git clone git@github.com:mows21/ai-n8n-kit.git
check_command "Repository clone"

# Setup environment
cd ai-n8n-kit
cp .env.example .env

# Configure .env file
echo -e "${YELLOW}⚙️ Configuring .env file...${NC}"
cat > .env << EOL
CADDY_EMAIL=dustin@mowsdigital.agency
CADDY_HOST_nn=nn.mowsdigital.agency
CADDY_HOST_superbase=superbase.mowsdigital.agency
CADDY_HOST_openwebui=openwebui.mowsdigital.agency
CADDY_HOST_flowise=flowise.mowsdigital.agency
EOL

# Configure firewall
echo -e "${YELLOW}🛡️ Configuring firewall...${NC}"
ufw allow 80
ufw allow 443
ufw allow 3000
ufw allow 5432
ufw allow 8000
ufw allow 3001
ufw --force enable
ufw reload
check_command "Firewall configuration"

# Start the stack
echo -e "${YELLOW}🚀 Starting AI Stack...${NC}"
python3 run.py --profile cpu

echo -e "${GREEN}✅ Deployment complete!${NC}"
echo -e "${YELLOW}🌐 Your services should be available at:${NC}"
echo "- Flowise: https://flowise.mowsdigital.agency"
echo "- n8n: https://nn.mowsdigital.agency"
echo "- Open Web UI: https://openwebui.mowsdigital.agency"
echo "- Supabase: https://superbase.mowsdigital.agency"