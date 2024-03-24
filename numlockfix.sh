#!/bin/bash
# Script Title: Numlock Fix for Kali-Linux
# Author: its_ashu_otf
# Description: This scripts enables the numlock automatically on start.

cat << "EOF"


EOF

echo " "
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo."
    exit 1
fi

echo "Running with sudo privileges."
echo " "
echo "Installing numlockx, if already installed it will be skipped..."
sudo apt-get install numlockx
echo " "
echo "Adding numlockx to your light-dm config... "
sudo sed -i '/^\[Seat:\*\]/a greeter-setup-script=/usr/bin/numlockx on' /etc/lightdm/lightdm.conf
echo " "
echo "Done ! "
echo ""
echo "Now! when you reboot your system numlock will be enabled automatically :)"

