#!/bin/bash

#Script Title: SnapD Fix
#Author: its_ashu_otf
#Description: A Bash script which Fixes Snap for Kali-Linux

cat << "EOF"

 _____  _   _   ___  ______ ______    ______  _____ __   __   ______ __   __   _  _                             _                            _     __ 
/  ___|| \ | | / _ \ | ___ \|  _  \   |  ___||_   _|\ \ / /   | ___ \\ \ / /  (_)| |                           | |                          | |   / _|
\ `--. |  \| |/ /_\ \| |_/ /| | | |   | |_     | |   \ V /    | |_/ / \ V /    _ | |_  ___           __ _  ___ | |__   _   _           ___  | |_ | |_ 
 `--. \| . ` ||  _  ||  __/ | | | |   |  _|    | |   /   \    | ___ \  \ /    | || __|/ __|         / _` |/ __|| '_ \ | | | |         / _ \ | __||  _|
/\__/ /| |\  || | | || |    | |/ /    | |     _| |_ / /^\ \   | |_/ /  | |    | || |_ \__ \        | (_| |\__ \| | | || |_| |        | (_) || |_ | |  
\____/ \_| \_/\_| |_/\_|    |___/     \_|     \___/ \/   \/   \____/   \_/    |_| \__||___/         \__,_||___/|_| |_| \__,_|         \___/  \__||_|  
                                                                                            ______                            ______                  
                                                                                           |______|                          |______|                 
EOF

echo " "

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo."
    exit 1
fi 

echo "Running with sudo privileges."
echo " "
echo "Updating system repositories and packages..."
sudo apt update && sudo apt upgrade -y
echo " "

echo "Ensuring Snap is installed..."
sudo apt install -y snapd
echo " "

echo "Do you want to enable Snapd services to start automatically on boot? (yes/no)"
read -r enable_snapd

case $enable_snapd in
    [Yy][Ee][Ss])
        echo "Enabling Snapd services..."
        sudo systemctl enable snapd
        sudo systemctl start snapd
        sudo systemctl enable snapd.apparmor
        sudo systemctl start snapd.apparmor
        ;;
    [Nn][Oo])
        echo "Snapd services will not be enabled on boot."
        ;;
    *)
        echo "Invalid input. Please enter 'yes' or 'no'."
        ;;
esac

echo " "
echo "Linking Snapd to local application path..."
ln -s /var/lib/snapd/desktop/applications ~/.local/share/applications/snap
echo " "

echo "Adding Snapd binaries to system-wide environment variables..."
sudo sed -i '/^PATH=/ s|$|:/snap/bin|' /etc/environment
echo " "

echo "Please consider restarting your system for the changes to take effect globally."

