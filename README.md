# Kali-Enhance

Kali-Enhance is a collection of scripts & add-ons designed to improve the functionality and usability of a Kali Linux system. These scripts automate the installation and configuration of essential tools and services, making your Kali Linux experience more efficient and user-friendly.

## Getting Started

To get started with Kali-Enhance, follow these instructions:

1. Clone the repository:
  ```bash
  git clone https://github.com/yourusername/Kali-Enhance.git
  cd Kali-Enhance
  ```

2. Run the scripts as needed:
  ```bash
  bash clipboard-manager.sh
  bash additional-package-managers.sh
  ```

## Scripts Overview

### clipboard-manager.sh

This script installs and configures a clipboard manager (Clipman) on Xfce. It aims to provide a clipboard manager similar to Windows. It performs the following tasks:

- Checks if Clipman is installed and installs it if necessary.
- Ensures Clipman is running.
- Configures Clipman to start on login.
- Sets up a keyboard shortcut (Super + V) for accessing Clipman history.

### additional-package-managers.sh

This script installs additional package managers (Flatpak and Snap) on Kali Linux. It performs the following tasks:

- Updates system repositories.
- Installs Flatpak and adds the Flathub repository.
- Installs Snapd and ensures its services are enabled and started.
- Adds Snapd and Flatpak directories to the system-wide environment variables.

Both scripts are designed to enhance the functionality and usability of a Kali Linux system.
## Scripts Overview

### clipboard-manager.sh

This script installs and configures a clipboard manager (Clipman) on Xfce.
It aims to provide a clipboard manager just like Windows.
It performs the following tasks:

- Checks if Clipman is installed and installs it if necessary.
- Ensures Clipman is running.
- Configures Clipman to start on login.
- Sets up a keyboard shortcut (Super + V) for accessing Clipman history.

### additional-package-managers.sh

This script installs additional package managers (Flatpak and Snap) on Kali Linux. It performs the following tasks:

- Updates system repositories.
- Installs Flatpak and adds the Flathub repository.
- Installs Snapd and ensures its services are enabled and started.
- Adds Snapd and Flatpak directories to the system-wide environment variables.

Both scripts are designed to enhance the functionality and usability of a Kali Linux system.
