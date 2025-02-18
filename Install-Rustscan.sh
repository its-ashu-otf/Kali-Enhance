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

# Update package lists and install dependencies
echo -e "\e[36m📦 Updating package lists and installing dependencies...\e[0m"
sudo apt update && sudo apt install -y wget curl || die "Failed to install dependencies"

# Fetch the latest RustScan release URL
echo -e "\e[36m🌍 Fetching the latest RustScan release...\e[0m"
RUSTSCAN_URL=$(curl -s https://api.github.com/repos/RustScan/RustScan/releases/latest | jq -r '.assets[] | select(.name | test("linux-amd64.*\\.deb$")) | .browser_download_url')

# Check if URL is valid
if [[ -z "$RUSTSCAN_URL" ]]; then
    die "Failed to fetch a valid RustScan download URL"
fi

# Download the RustScan .deb package
echo -e "\e[33m⬇️  Downloading RustScan...\e[0m"
wget -q --show-progress "$RUSTSCAN_URL" -O rustscan.deb || die "Failed to download RustScan"

# Install RustScan
echo -e "\e[32m⚙️  Installing RustScan...\e[0m"
dpkg -i rustscan.deb || die "Failed to install RustScan"

# Clean up
echo -e "\e[35m🧹 Cleaning up...\e[0m"
rm -f rustscan.deb

# Verify installation
echo -e "\e[32m✅ Verifying installation...\e[0m"
rustscan --version || die "RustScan installation verification failed"

echo -e "\e[32m🎉 RustScan installation completed successfully!\e[0m"
