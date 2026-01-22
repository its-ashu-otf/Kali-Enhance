#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Script Name : install-docker-kali-recommended.sh
# Description : Kali Linux Docker installer (docker.io + rootless Docker)
# Author      : its-ashu-otf
# Version     : 1.0
# -----------------------------------------------------------------------------

set -Eeuo pipefail

# ---------------------------- Configuration ----------------------------------
LOG_FILE="/var/log/docker-install.log"
TARGET_USER="${SUDO_USER:-$USER}"
# -----------------------------------------------------------------------------

# ---------------------------- Logging -----------------------------------------
log()   { echo "[+] $1" | tee -a "$LOG_FILE"; }
warn()  { echo "[!] $1" | tee -a "$LOG_FILE" >&2; }
error() { echo "[✘] $1" | tee -a "$LOG_FILE" >&2; exit 1; }
# -----------------------------------------------------------------------------

trap 'error "Unexpected failure. Check ${LOG_FILE}"' ERR

# ---------------------------- Pre-flight Checks -------------------------------
[[ $EUID -eq 0 ]] || error "Run as root (use sudo)"
grep -qi kali /etc/os-release || error "This script supports Kali Linux only"

log "Updating package lists..."
apt update -y >>"$LOG_FILE" 2>&1

log "Installing required dependencies..."
apt install -y docker.io uidmap dbus-user-session >>"$LOG_FILE" 2>&1
# -----------------------------------------------------------------------------

# ---------------------------- Docker Service ----------------------------------
log "Enabling and starting Docker daemon..."
systemctl enable docker --now >>"$LOG_FILE" 2>&1
systemctl is-active --quiet docker || error "Docker daemon failed to start"
# -----------------------------------------------------------------------------

# ---------------------------- Docker Group ------------------------------------
log "Configuring docker group for non-root usage..."
groupadd -f docker

if id -nG "$TARGET_USER" | grep -qw docker; then
    log "User '$TARGET_USER' already in docker group."
else
    usermod -aG docker "$TARGET_USER"
    warn "User '$TARGET_USER' added to docker group (logout/login required)."
fi
# -----------------------------------------------------------------------------

# ---------------------------- Rootless Docker ---------------------------------
log "Setting up rootless Docker for user '$TARGET_USER'..."

sudo -u "$TARGET_USER" env -i \
    HOME="/home/$TARGET_USER" \
    USER="$TARGET_USER" \
    PATH="/usr/bin:/bin" \
    bash <<'EOF'
set -e

if ! command -v dockerd-rootless-setuptool.sh >/dev/null; then
    echo "[!] Rootless Docker tools not available"
    exit 0
fi

if [[ ! -f ~/.config/systemd/user/docker.service ]]; then
    dockerd-rootless-setuptool.sh install
    systemctl --user enable docker
    systemctl --user start docker
fi
EOF
# -----------------------------------------------------------------------------

# ---------------------------- Verification ------------------------------------
log "Verifying Docker (rootful)..."
docker --version >>"$LOG_FILE" 2>&1 || \
    warn "Rootful Docker requires re-login for non-root access"

log "Verifying Docker (rootless)..."
sudo -u "$TARGET_USER" docker info >/dev/null 2>&1 || \
    warn "Rootless Docker available after user login"
# -----------------------------------------------------------------------------

log "Docker installation completed successfully."
warn "Log out and log back in to finalize permissions."
warn "Log file saved at: $LOG_FILE"
