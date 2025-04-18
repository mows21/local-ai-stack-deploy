# Local AI Stack Deployment Script

This repository contains a script to automate the deployment of the Local AI Stack on a Hostinger VPS.

## 🚀 One-Line Deployment

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/mows21/local-ai-stack-deploy/main/hostinger_deploy.sh)"
```

## 🗺️ Services Deployed

| Subdomain | Service | Purpose |
|-----------|---------|---------|
| flowise.mowsdigital.agency | Flowise | Flow-based AI development |
| nn.mowsdigital.agency | n8n | Workflow automation |
| openwebui.mowsdigital.agency | Open Web UI | Web interface |
| superbase.mowsdigital.agency | Supabase | Database and authentication |

## ✅ Pre-deployment Checklist

1. Ensure all subdomains are pointed to your VPS IP (160.238.36.148) in Hostinger DNS panel
2. Have your GitHub account ready (for SSH authentication)
3. Make sure ports 80, 443, 3000, 5432, 8000, and 3001 are available

## 🔒 Security Features

- Uses SSH authentication for GitHub
- Automatic firewall configuration
- Secure environment variable setup

## 🛠️ What the Script Does

1. Installs required dependencies
2. Sets up SSH authentication for GitHub
3. Clones the AI stack repository
4. Configures environment variables
5. Sets up firewall rules
6. Launches the stack with CPU profile

## ⚠️ Troubleshooting

If you encounter any issues:

1. Check your DNS settings
2. Verify GitHub SSH access
3. Ensure all required ports are open
4. Check the logs in the ai-n8n-kit directory