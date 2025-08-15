#!/bin/bash
set -e

echo "🚀 Starting Ceremony Setup..."
echo "======================================"

# 1️⃣ Update & Install Dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git build-essential screen

# 2️⃣ Install Node.js v18 & npm v9.2
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo bash -
sudo apt install -y nodejs
sudo npm install -g npm@9.2

# 3️⃣ Check Versions
echo "📦 Installed versions:"
node -v
npm -v

# 4️⃣ Create Temporary Directory
mkdir -p ~/trusted-setup-tmp && cd ~/trusted-setup-tmp

# 5️⃣ Install Phase2 CLI
sudo npm install -g @p0tion/phase2cli

# 6️⃣ Verify CLI Installation
echo "🔍 Verifying CLI..."
phase2cli --version

# Ceremony Info
echo ""
echo "📅 Ceremony: Aug 13 – 22, 2025"
echo ""

# 7️⃣ Authenticate with GitHub
echo "🔐 Starting GitHub authentication..."
phase2cli auth
echo "👉 Visit https://github.com/login/device, enter the code, and authorize ethstorage."
echo ""
read -p "✅ Have you completed the login and authorization? (yes/no): " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
    echo "❌ Authentication not confirmed. Exiting..."
    exit 1
fi

# 8️⃣ Contribute to the Ceremony
echo "🎉 Authentication successful! Starting contribution..."
screen -S ceremony bash -c "phase2cli contribute -c ethstorage-v1-trusted-setup-ceremony; exec bash"
