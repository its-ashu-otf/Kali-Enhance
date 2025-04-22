#!/bin/bash

set -e  # Exit on error

# Function to display an error message and exit
die() {
    echo -e "\e[31m❌ Error: $1\e[0m" >&2
    exit 1
}

# Banner
echo -e "\e[34m\e[1m"
cat << "EOF"
    ____  __  __________________ _________    _   __   ____           __        ____         
   / __ \/ / / / ___/_  __/ ___// ____/   |  / | / /  /  _/___  _____/ /_____ _/ / /__  _____
  / /_/ / / / /\__ \ / /  \__ \/ /   / /| | /  |/ /   / // __ \/ ___/ __/ __ `/ / / _ \/ ___/
 / _, _/ /_/ /___/ // /  ___/ / /___/ ___ |/ /|  /  _/ // / / (__  ) /_/ /_/ / / /  __/ /    
/_/ |_|\____//____//_/  /____/\____/_/  |_/_/ |_/  /___/_/ /_/____/\__/\__,_/_/_/\___/_/     

                                 BY @its-ashu-otf
EOF
echo -e "\e[0m"

# Update & install required tools
echo -e "\e[36m📦 Updating system and installing dependencies...\e[0m"
sudo apt update && sudo apt install -y curl unzip wget || die "Failed to install required packages"

# Download URL
RUSTSCAN_ZIP_URL="https://github.com/RustScan/RustScan/releases/latest/download/rustscan.deb.zip"

# Download RustScan
echo -e "\e[33m⬇️  Downloading RustScan from:\n$RUSTSCAN_ZIP_URL\e[0m"
curl -sSLo rustscan.zip "$RUSTSCAN_ZIP_URL" || die "Failed to download RustScan zip"

# Extract .deb from .zip
echo -e "\e[36m📂 Extracting .deb package from zip...\e[0m"
unzip -o rustscan.zip || die "Failed to extract RustScan zip"

# Find the .deb file
RUSTSCAN_DEB=$(ls rustscan_*.deb 2>/dev/null | head -n 1)
[[ -z "$RUSTSCAN_DEB" ]] && die "RustScan .deb file not found after extraction"

# Install RustScan
echo -e "\e[32m⚙️  Installing RustScan...\e[0m"
sudo dpkg -i "$RUSTSCAN_DEB" || die "RustScan installation failed"

# Clean up
echo -e "\e[35m🧹 Cleaning up temporary files...\e[0m"
rm -f rustscan.zip "$RUSTSCAN_DEB" rustscan.tmp* rustscan*.stripped

# Verify installation
echo -e "\e[32m🔍 Verifying RustScan installation...\e[0m"
rustscan --version || die "RustScan installation verification failed"

echo -e "\e[32m🎉 RustScan installation completed successfully!\e[0m"
