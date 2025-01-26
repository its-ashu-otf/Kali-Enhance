#!/bin/bash

# Script Title: Additional Package Managers
# Author: its_ashu_otf
# Description: A Bash script which installs additional package managers for Kali-Linux

# Function to print messages
print_message() {
    echo " "
    printf "\e[32m%s\e[0m\n" "$1"
    echo " "
}

# Function to handle errors
handle_error() {
    printf "\e[31mError on line %d: %s\e[0m\n" "$1" "$2"
    exit 1
}

# Trap errors
trap 'handle_error $LINENO "$BASH_COMMAND"' ERR

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    printf "\e[31mThis script must be run with sudo.\e[0m\n"
    exit 1
fi 

# Check if running on Kali Linux
if ! grep -q "Kali" /etc/os-release; then
    printf "\e[31mThis script is intended to run on Kali Linux.\e[0m\n"
    exit 1
fi

print_message "Running with sudo privileges."

print_message "Updating system repositories and packages..."
sudo apt update

# Install Flatpak
print_message "Installing Flatpak..."
if ! command -v flatpak >/dev/null; then
    sudo apt install -y flatpak
else
    print_message "Flatpak is already installed."
fi

# Add Flathub repository
print_message "Adding Flathub repository to Flatpak..."
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install Snapd
print_message "Installing Snapd..."
if ! command -v snap >/dev/null; then
    sudo apt install -y snapd
else
    print_message "Snapd is already installed."
fi

# Enable and start Snapd services
print_message "Ensuring Snapd services are enabled and started..."
sudo systemctl enable --now snapd
sudo systemctl enable --now snapd.apparmor

# Add Snapd binaries to PATH
print_message "Adding Snapd binaries to system-wide environment variables..."
if ! echo "$PATH" | grep -q '/snap/bin'; then
    if ! grep -q '/snap/bin' /etc/environment; then
        sudo sed -i '/^PATH=/ s|$|:/snap/bin|' /etc/environment
        print_message "Snapd binaries added to PATH."
    else
        print_message "Snapd binaries already in PATH."
    fi
fi

# Add Flatpak directories to PATH
print_message "Adding Flatpak directories to environment variables..."
if ! echo "$PATH" | grep -q '/var/lib/flatpak/exports/share'; then
    if ! grep -q '/var/lib/flatpak/exports/share' /etc/environment; then
        sudo sed -i '/^PATH=/ s|$|:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share|' /etc/environment
        print_message "Flatpak directories added to PATH."
    else
        print_message "Flatpak directories already in PATH."
    fi
fi

print_message "Done! Please consider restarting your system for the changes to take effect globally."
