# Kali-Enhance ⚙️🛠️

Kali-Enhance is a collection of scripts & add-ons designed to improve the functionality and usability of a Kali Linux system. These scripts automate the installation and configuration of essential tools and services, making your Kali Linux experience more efficient and user-friendly.

## Prerequisites

- Kali Linux
- sudo privileges
  
## Getting Started ⚡

To get started with Kali-Enhance, follow these instructions:

1. Clone the repository:
  ```bash
  git clone https://github.com/yourusername/Kali-Enhance.git
  cd Kali-Enhance
  ```

2. Run the scripts as needed:
  ```bash
  bash <script_name>.sh
  ```

## Scripts Overview 🧷

### clipboard-manager.sh 📋

This script installs and configures a clipboard manager (Clipman) on Xfce. It aims to provide a clipboard manager similar to Windows. It performs the following tasks:

- Checks if Clipman is installed and installs it if necessary.
- Ensures Clipman is running.
- Configures Clipman to start on login.
- Sets up a keyboard shortcut (Super + V) for accessing Clipman history.

### additional-package-managers.sh ➕

This script installs additional package managers (Flatpak and Snap) on Kali Linux. It performs the following tasks:

- Updates system repositories.
- Installs Flatpak and adds the Flathub repository.
- Installs Snapd and ensures its services are enabled and started.
- Adds Snapd and Flatpak directories to the system-wide environment variables.

### Install-Rustscan.sh

This script install rustscan automatically and does everything that is neccesary. It performs the following tasks:

- Uses wget to download rustscan latest release
- Then uses apt to install the file

### Fix stuttering audio in VM for Kali Linux.sh

This script fixes stuttering audio in Kali Linux running on VMware 

- Makes neccassary configuration files to fix the issue and restart the services

### Wi-Fi Driver Installer for 8821au 🛜

This script installs the Wi-Fi driver for the 8821au chipset on Kali Linux. It automates the process of checking for system updates, installing necessary dependencies, and cloning and running the driver installation script from a GitHub repository.

#### Features

- Checks for system package updates and prompts the user to update if available.
- Installs necessary dependencies for building and installing the driver.
- Clones the driver repository from GitHub.
- Runs the driver installation script with sudo privileges.

The Scripts are designed to enhance the functionality and usability of a Kali Linux system.
