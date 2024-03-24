#!/bin/bash
# Script Title: Thorium Installer for Linux
# Author: its_ashu_otf
# Description: This scripts installs Thorium and also adds it to your default repository.

cat << "EOF"

 _____ _   _ ___________ _____ _   ____  ___  _____ _   _  _____ _____ ___   _      _      ___________ 
|_   _| | | |  _  | ___ \_   _| | | |  \/  | |_   _| \ | |/  ___|_   _/ _ \ | |    | |    |  ___| ___ \
  | | | |_| | | | | |_/ / | | | | | | .  . |   | | |  \| |\ `--.  | |/ /_\ \| |    | |    | |__ | |_/ /
  | | |  _  | | | |    /  | | | | | | |\/| |   | | | . ` | `--. \ | ||  _  || |    | |    |  __||    / 
  | | | | | \ \_/ / |\ \ _| |_| |_| | |  | |  _| |_| |\  |/\__/ / | || | | || |____| |____| |___| |\ \ 
  \_/ \_| |_/\___/\_| \_|\___/ \___/\_|  |_/  \___/\_| \_/\____/  \_/\_| |_/\_____/\_____/\____/\_| \_|
                                                                                                       
                                                                                                       
EOF

echo " "
echo "Fetching Thorium and adding it to your repository lists....."
sudo rm -fv /etc/apt/sources.list.d/thorium.list && \
sudo wget --no-hsts -P /etc/apt/sources.list.d/ \
http://dl.thorium.rocks/debian/dists/stable/thorium.list && \
echo "Updating Repositories..."
sudo apt update
echo " "
echo "Installing Thorium-Browser now....."
sudo apt install thorium-browser
echo "Done ! a reboot may be required to launch thorium :)" 
