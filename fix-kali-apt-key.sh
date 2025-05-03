#!/bin/bash

# fix-kali-apt-key.sh - Script to fix missing Kali Linux apt signing key
# Author: its-ashu-otf
# Updated: 2025-05-03

# Color codes
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
NC="\e[0m"  # No Color

KEY_URL="https://archive.kali.org/archive-keyring.gpg"
KEY_DEST="/usr/share/keyrings/kali-archive-keyring.gpg"
EXPECTED_CHECKSUM="603374c107a90a69d983dbcb4d31e0d6eedfc325"

echo -e "${BLUE}[*] Kali APT Signing Key Fix Script${NC}"
echo -e "${BLUE}[*] A script by @its-ashu-otf${NC}"


# Function to exit on failure
exit_on_error() {
    echo -e "${RED}[!] Error: $1${NC}"
    exit 1
}

# Check for root/sudo privileges
if [[ $EUID -ne 0 ]]; then
    exit_on_error "This script must be run with sudo or as root. Please try again using: sudo ./fix-kali-apt-key.sh"
fi

# Step 1: Download the new keyring
echo -e "${YELLOW}[-] Downloading new keyring...${NC}"
wget -q --show-progress "$KEY_URL" -O "$KEY_DEST" || exit_on_error "Failed to download keyring from $KEY_URL"

# Step 2: Verify checksum
echo -e "${YELLOW}[-] Verifying checksum...${NC}"
ACTUAL_CHECKSUM=$(sha1sum "$KEY_DEST" | awk '{print $1}')
if [ "$ACTUAL_CHECKSUM" != "$EXPECTED_CHECKSUM" ]; then
    exit_on_error "Checksum mismatch! Expected $EXPECTED_CHECKSUM but got $ACTUAL_CHECKSUM"
else
    echo -e "${GREEN}[+] Checksum verified successfully.${NC}"
fi

# Step 3: Show keys for verification
echo -e "${YELLOW}[-] Verifying keys in keyring...${NC}"
gpg --no-default-keyring --keyring "$KEY_DEST" -k | grep -E "pub|uid" || exit_on_error "Failed to list keys in keyring"

# Step 4: Update and test APT
echo -e "${YELLOW}[-] Running apt update...${NC}"
if apt update; then
    echo -e "${GREEN}[+] apt update succeeded! System is now using the new signing key.${NC}"
else
    exit_on_error "apt update still failing. Please check your network or APT sources."
fi

# Done
echo -e "${GREEN}[✔] Kali Linux signing key fix completed successfully.${NC}"
