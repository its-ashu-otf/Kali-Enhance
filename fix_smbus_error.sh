#!/bin/bash

# Script to fix "smbus host not enabled" error in Kali Linux on VMware
# Author: its-ashu-otf
# Created: April 29, 2025

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

echo "[+] Starting SMBus error fix script..."

# Method 1: Blacklist the problematic module
echo "[+] Creating blacklist configuration for i2c_piix4 module..."
if grep -q "blacklist i2c_piix4" /etc/modprobe.d/blacklist.conf 2>/dev/null; then
    echo "[*] Module i2c_piix4 is already blacklisted. Skipping..."
else
    echo "blacklist i2c_piix4" >> /etc/modprobe.d/blacklist.conf
    echo "[+] Added i2c_piix4 to blacklist.conf"
fi

# Method 2: Add kernel parameter to ignore SMBus
echo "[+] Adding kernel parameter to ignore SMBus errors..."
if grep -q "i2c_piix4.ignore_no_smbus=1" /etc/default/grub; then
    echo "[*] Kernel parameter already exists. Skipping..."
else
    # Backup GRUB config
    cp /etc/default/grub /etc/default/grub.bak
    echo "[+] Backed up GRUB configuration to /etc/default/grub.bak"
    
    # Update GRUB config to add the parameter
    sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"/\1 i2c_piix4.ignore_no_smbus=1"/' /etc/default/grub
    echo "[+] Added i2c_piix4.ignore_no_smbus=1 to kernel parameters"
    
    # Update GRUB
    update-grub
    echo "[+] Updated GRUB configuration"
fi

# Update initramfs
echo "[+] Updating initramfs..."
update-initramfs -u
echo "[+] Initramfs updated successfully"

echo "[+] Fix completed successfully!"
echo "[+] Please reboot your system for changes to take effect."
echo "[+] Run: sudo reboot"

exit 0
