#!/bin/bash

# Script Title: Wi-Fi Driver Installer for 8821au
# Author: its_ashu_otf
# Description: A Bash script which installs the Wi-Fi driver for 8821au chipset on Kali Linux

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
print_message "Running with sudo privileges."

# Function to check and install dependencies
install_dependencies() {
    local dependencies=("linux-headers-$(uname -r)" "build-essential" "bc" "dkms" "git" "libelf-dev" "rfkill" "iw")
    for package in "${dependencies[@]}"; do
        print_message "Checking for $package..."
        if ! dpkg -l | grep -q "$package"; then
            print_message "Installing $package..."
            sudo apt install -y "$package"
        else
            print_message "$package is already installed."
        fi
    done
    print_message "Installing bc..."
    if ! command -v bc >/dev/null; then
        sudo apt install -y bc
    else
        print_message "bc is already installed."
    fi
}

# Function to check for system package updates
check_for_updates() {
    print_message "Checking for system package updates..."
    sudo apt update
    local updates_available=$(apt list --upgradable 2>/dev/null | grep -c upgradable)
    if [ "$updates_available" -gt 0 ]; then
        print_message "There are $updates_available updates available."
        read -p "Do you want to update the system now? (y/n) [Remember if there is a kernel update, kernel headers will fail to install]: " choice
        case "$choice" in
            y|Y )
                print_message "Updating system packages..."
                sudo apt upgrade -y
                ;;
            * )
                print_message "Skipping system update."
                ;;
        esac
    else
        print_message "No updates available."
    fi
}

# Function to clone the repository and run the install-driver.sh script
install_driver() {
    local repo_url="https://github.com/morrownr/8821au-20210708.git"
    local repo_dir="8821au-20210708"

    if [ -d "$repo_dir" ]; then
        print_message "Repository already cloned."
    else
        print_message "Cloning repository..."
        git clone "$repo_url"
    fi

    cd "$repo_dir" || exit
    print_message "Running install-driver.sh script..."
    if sudo ./install-driver.sh; then
        print_message "Driver installed successfully."
    else
        handle_error $LINENO "Driver installation failed."
    fi
}

# Check for system package updates
check_for_updates
# Ensure all dependencies are installed
install_dependencies
# Install the driver
install_driver

