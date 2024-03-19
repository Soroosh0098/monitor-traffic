#!/bin/bash

SERVICE_NAME="monitor-traffic"
SERVICE_DESC="Monitor Traffic Script Made By Soroosh0098"

SCRIPT_PATH="/root/monitor-traffic/nodejs/monitor-traffic.js"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() {
    echo -e "${BLUE}[INFO] $1${NC}"
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

success() {
    echo -e "${GREEN}[SUCCESS] $1${NC}"
}

message() {
    info "For checking service status, use: systemctl status $1"
    info "For stopping the service, use: systemctl stop $1"
    info "For starting the service, use: systemctl start $1"
}

if [[ ! -f "$SCRIPT_PATH" ]]; then
    error "Script file $SCRIPT_PATH does not exist. Please make sure the file exists and is executable."
    exit 1
fi

chmod +x $SCRIPT_PATH

SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

if [[ -f "$SERVICE_FILE" ]]; then
    warning "Service $SERVICE_NAME already exists. Skipping service creation."
    sudo systemctl status "$SERVICE_NAME"
    echo "--------------------------------------------------------------------------------------------"
    message $SERVICE_NAME
    echo "--------------------------------------------------------------------------------------------"
    exit 0
else
    info "Creating service $SERVICE_NAME..."
    cat >"$SERVICE_FILE" <<EOF
[Unit]
Description="${SERVICE_DESC}"

[Service]
ExecStart=/usr/bin/node "${SCRIPT_PATH}"
Restart=always
User=$(whoami)

[Install]
WantedBy=multi-user.target
EOF
fi

sudo systemctl daemon-reload

sudo systemctl start ${SERVICE_NAME}

sudo systemctl enable ${SERVICE_NAME}

success "Systemd service '${SERVICE_NAME}' has been created and started."
echo "--------------------------------------------------------------------------------------------"
message $SERVICE_NAME
echo "--------------------------------------------------------------------------------------------"
