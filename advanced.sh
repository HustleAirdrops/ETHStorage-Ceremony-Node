#!/bin/bash
set -e

SERVICE_NAME="ceremony"
WORKDIR="$HOME/trusted-setup-tmp"

echo "🚀 Ceremony Auto Setup Starting..."
echo "==================================="

# 1️⃣ Update & Install Dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git build-essential

# 2️⃣ Node.js check
if ! command -v node &> /dev/null; then
    echo "📦 Installing Node.js v18..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo bash -
    sudo apt install -y nodejs
    sudo npm install -g npm@9.2
else
    echo "✅ Node.js already installed: $(node -v)"
    echo "✅ npm version: $(npm -v)"
fi

# 3️⃣ Create or switch to working directory
if [ -d "$WORKDIR" ]; then
    echo "📂 Existing working directory found, switching..."
    cd "$WORKDIR"
else
    echo "📂 Creating new working directory..."
    mkdir -p "$WORKDIR"
    cd "$WORKDIR"
fi

# 4️⃣ Install Phase2 CLI if not exists
if ! command -v phase2cli &> /dev/null; then
    echo "📦 Installing Phase2 CLI..."
    sudo npm install -g @p0tion/phase2cli
else
    echo "✅ Phase2 CLI already installed: $(phase2cli --version)"
fi

# 5️⃣ GitHub Authentication
echo "🔐 Checking GitHub authentication..."
set +e
AUTH_OUTPUT=$(phase2cli auth 2>&1)
EXIT_CODE=$?
set -e

if [[ $EXIT_CODE -ne 0 ]]; then
    echo "❌ Auth command failed. Please check."
    exit 1
fi

if echo "$AUTH_OUTPUT" | grep -qi "https://github.com/login/device"; then
    echo "👉 Visit https://github.com/login/device and authorize ethstorage."
    read -p "✅ Have you completed the login and authorization? (yes/no): " CONFIRM
    if [[ "$CONFIRM" != "yes" ]]; then
        echo "❌ Authentication not confirmed. Exiting..."
        exit 1
    fi
else
    echo "✅ Already authenticated with GitHub."
fi

# 6️⃣ Create systemd service
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"
echo "⚙️ Creating systemd service at $SERVICE_FILE"

sudo bash -c "cat > $SERVICE_FILE" <<EOL
[Unit]
Description=EthStorage Ceremony Contributor
After=network.target

[Service]
WorkingDirectory=$WORKDIR
ExecStart=/usr/bin/env bash -c 'phase2cli contribute -c ethstorage-v1-trusted-setup-ceremony'
Restart=always
RestartSec=10
User=$USER

[Install]
WantedBy=multi-user.target
EOL

# 7️⃣ Reload systemd and enable service
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now $SERVICE_NAME

echo ""
echo "🎉 Ceremony service setup complete!"
echo "👉 Check logs:   journalctl -u $SERVICE_NAME -f"
echo "👉 Stop service: sudo systemctl stop $SERVICE_NAME"
echo "👉 Restart svc:  sudo systemctl restart $SERVICE_NAME"
