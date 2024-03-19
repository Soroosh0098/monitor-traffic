#!/bin/bash

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

REPO_URL="https://github.com/Soroosh0098/monitor-traffic"

TARGET_DIR="/root/monitor-traffic"

if ! command -v git &>/dev/null; then
    warning "Git is not installed. Attempting to install Git..."
    info "Installing Git..."
    sudo apt update && sudo apt install git -y
    if [ $? -ne 0 ]; then
        error "Failed to install Git. Please install Git manually and try again."
        exit 1
    fi
fi

if [ -d "$TARGET_DIR" ]; then
    warning "The target directory already exists. Continuing without creating the directory again."
else
    info "Cloning repository..."
    git clone "$REPO_URL" "$TARGET_DIR"

    if [ $? -eq 0 ]; then
        success "Repository cloned successfully to $TARGET_DIR"
    else
        error "Failed to clone repository. Please check the repository URL and try again."
        exit 1
    fi

    info "Changing ownership of the target directory..."
    chown -R root:root "$TARGET_DIR"
fi

success "Download and setup completed."

