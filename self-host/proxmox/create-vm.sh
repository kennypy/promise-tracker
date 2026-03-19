#!/usr/bin/env bash
set -euo pipefail

###############################################################################
# Promise Tracker — Create Proxmox VM
#
# Run this on your Proxmox host. It downloads a Debian 12 cloud image,
# creates a VM, attaches cloud-init, and starts it.
#
# Usage:
#   ./create-vm.sh                          # defaults (DHCP, VMID 900)
#   VMID=200 MEMORY=8192 ./create-vm.sh    # custom
#   IP_CONFIG="ip=192.168.1.50/24,gw=192.168.1.1" ./create-vm.sh  # static IP
#
###############################################################################

# ── Configuration (override with environment variables) ─
VMID="${VMID:-900}"
VM_NAME="${VM_NAME:-promise-tracker}"
CORES="${CORES:-2}"
MEMORY="${MEMORY:-4096}"
DISK_SIZE="${DISK_SIZE:-32G}"
BRIDGE="${BRIDGE:-vmbr0}"
STORAGE="${STORAGE:-local-lvm}"
SNIPPET_STORAGE="${SNIPPET_STORAGE:-local}"
IP_CONFIG="${IP_CONFIG:-dhcp}"
SSH_KEY_FILE="${SSH_KEY_FILE:-$HOME/.ssh/id_rsa.pub}"
CI_USER="${CI_USER:-deploy}"

CLOUD_IMAGE_URL="https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
CACHE_DIR="/var/lib/vz/template/qcow2"
IMAGE_FILE="debian-12-genericcloud-amd64.qcow2"
SNIPPET_DIR="/var/lib/vz/snippets"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "============================================"
echo "  Promise Tracker — Proxmox VM Setup"
echo "============================================"
echo ""
echo "  VMID:       $VMID"
echo "  Name:       $VM_NAME"
echo "  Cores:      $CORES"
echo "  Memory:     ${MEMORY}MB"
echo "  Disk:       $DISK_SIZE"
echo "  Bridge:     $BRIDGE"
echo "  Storage:    $STORAGE"
echo "  IP:         $IP_CONFIG"
echo "  SSH key:    $SSH_KEY_FILE"
echo "  User:       $CI_USER"
echo ""

# ── Preflight checks ──────────────────────────────────
if ! command -v qm &>/dev/null; then
  echo "ERROR: 'qm' not found. Run this script on your Proxmox host."
  exit 1
fi

if [ ! -f "$SSH_KEY_FILE" ]; then
  echo "ERROR: SSH public key not found at $SSH_KEY_FILE"
  echo "  Generate one:  ssh-keygen -t ed25519"
  echo "  Or set:        SSH_KEY_FILE=/path/to/key.pub ./create-vm.sh"
  exit 1
fi

if qm status "$VMID" &>/dev/null; then
  echo "ERROR: VM $VMID already exists. Choose a different VMID or remove it first."
  exit 1
fi

# ── Step 1: Ensure snippets storage is enabled ─────────
echo "[1/6] Checking snippet storage..."
CURRENT_CONTENT=$(pvesm status --storage "$SNIPPET_STORAGE" -enabled 2>/dev/null | tail -1 | awk '{print $2}' || true)
if [ ! -d "$SNIPPET_DIR" ]; then
  mkdir -p "$SNIPPET_DIR"
fi

# Enable snippets content type if not already enabled
if ! pvesm get "$SNIPPET_STORAGE" 2>/dev/null | grep -q "snippets"; then
  echo "  Enabling snippets on '$SNIPPET_STORAGE' storage..."
  EXISTING_CONTENT=$(pvesm get "$SNIPPET_STORAGE" 2>/dev/null | grep "^content" | awk '{print $2}' || echo "images")
  pvesm set "$SNIPPET_STORAGE" --content "${EXISTING_CONTENT},snippets" 2>/dev/null || true
  echo "  Done."
fi

# ── Step 2: Download cloud image ──────────────────────
echo "[2/6] Preparing Debian 12 cloud image..."
mkdir -p "$CACHE_DIR"

if [ ! -f "$CACHE_DIR/$IMAGE_FILE" ]; then
  echo "  Downloading from cloud.debian.org (~350MB)..."
  wget -q --show-progress -O "$CACHE_DIR/$IMAGE_FILE" "$CLOUD_IMAGE_URL"
else
  echo "  Using cached image at $CACHE_DIR/$IMAGE_FILE"
fi

# ── Step 3: Copy cloud-init user-data ─────────────────
echo "[3/6] Installing cloud-init config..."
cp "$SCRIPT_DIR/cloud-init-userdata.yml" "$SNIPPET_DIR/promise-tracker-ci.yml"

# ── Step 4: Create the VM ─────────────────────────────
echo "[4/6] Creating VM $VMID..."

qm create "$VMID" \
  --name "$VM_NAME" \
  --cores "$CORES" \
  --memory "$MEMORY" \
  --net0 "virtio,bridge=$BRIDGE" \
  --ostype l26 \
  --agent enabled=1 \
  --onboot 1

# ── Step 5: Import disk and configure ─────────────────
echo "[5/6] Importing disk and configuring..."

# Import the cloud image as a disk
qm importdisk "$VMID" "$CACHE_DIR/$IMAGE_FILE" "$STORAGE" --format qcow2 2>/dev/null || \
  qm importdisk "$VMID" "$CACHE_DIR/$IMAGE_FILE" "$STORAGE"

# Attach the imported disk
qm set "$VMID" --scsihw virtio-scsi-pci --scsi0 "$STORAGE:vm-${VMID}-disk-0"

# Set boot order
qm set "$VMID" --boot order=scsi0

# Resize disk
qm resize "$VMID" scsi0 "$DISK_SIZE"

# Add cloud-init drive
qm set "$VMID" --ide2 "$STORAGE:cloudinit"

# Configure cloud-init
qm set "$VMID" --ciuser "$CI_USER"
qm set "$VMID" --sshkeys "$SSH_KEY_FILE"
qm set "$VMID" --cicustom "user=${SNIPPET_STORAGE}:snippets/promise-tracker-ci.yml"

# Set IP configuration
if [ "$IP_CONFIG" = "dhcp" ]; then
  qm set "$VMID" --ipconfig0 ip=dhcp
else
  qm set "$VMID" --ipconfig0 "$IP_CONFIG"
fi

# Serial console (needed for cloud-init output)
qm set "$VMID" --serial0 socket --vga serial0

# ── Step 6: Start the VM ──────────────────────────────
echo "[6/6] Starting VM..."
qm start "$VMID"

echo ""
echo "============================================"
echo "  VM $VMID is booting!"
echo "============================================"
echo ""
echo "  Cloud-init will automatically:"
echo "    1. Install Docker"
echo "    2. Clone the Promise Tracker repo"
echo "    3. Run setup and start all containers"
echo "    (~3-5 minutes for first boot)"
echo ""
echo "  Monitor progress:"
echo "    qm guest exec $VMID -- cat /var/log/cloud-init-output.log"
echo "    qm guest exec $VMID -- cloud-init status"
echo ""
if [ "$IP_CONFIG" = "dhcp" ]; then
  echo "  Find the VM's IP:"
  echo "    qm guest cmd $VMID network-get-interfaces"
  echo ""
  echo "  Once cloud-init completes, access:"
  echo "    Frontend:  http://<VM_IP>:8080"
  echo "    API:       http://<VM_IP>:8000"
  echo "    Studio:    http://<VM_IP>:3000"
else
  VM_IP=$(echo "$IP_CONFIG" | sed 's/ip=\([^/]*\).*/\1/')
  echo "  Once cloud-init completes, access:"
  echo "    Frontend:  http://${VM_IP}:8080"
  echo "    API:       http://${VM_IP}:8000"
  echo "    Studio:    http://${VM_IP}:3000"
fi
echo ""
echo "  SSH into the VM:"
echo "    ssh ${CI_USER}@<VM_IP>"
echo ""
