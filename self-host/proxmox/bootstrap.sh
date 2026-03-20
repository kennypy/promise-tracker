#!/usr/bin/env bash
set -euo pipefail

###############################################################################
# Promise Tracker — Proxmox Bootstrap
#
# Run this on your Proxmox host:
#   curl -fsSL https://raw.githubusercontent.com/kennypy/promise-tracker/main/self-host/proxmox/bootstrap.sh | bash
#
# With options:
#   curl -fsSL https://raw.githubusercontent.com/kennypy/promise-tracker/main/self-host/proxmox/bootstrap.sh | VMID=200 MEMORY=8192 bash
#
###############################################################################

REPO_RAW="https://raw.githubusercontent.com/kennypy/promise-tracker/main"
INSTALL_DIR="/opt/promise-tracker-proxmox"

echo "============================================"
echo "  Promise Tracker — Proxmox Bootstrap"
echo "============================================"
echo ""

# Preflight
if ! command -v qm &>/dev/null; then
  echo "ERROR: 'qm' not found. Run this on your Proxmox host."
  exit 1
fi

# Download scripts
echo "Downloading deployment scripts..."
mkdir -p "$INSTALL_DIR"
curl -fsSL "$REPO_RAW/self-host/proxmox/create-vm.sh" -o "$INSTALL_DIR/create-vm.sh"
curl -fsSL "$REPO_RAW/self-host/proxmox/cloud-init-userdata.yml" -o "$INSTALL_DIR/cloud-init-userdata.yml"
chmod +x "$INSTALL_DIR/create-vm.sh"

echo "Downloaded to $INSTALL_DIR"
echo ""

# Run create-vm.sh, passing through all env vars
cd "$INSTALL_DIR"
exec bash create-vm.sh "$@"
