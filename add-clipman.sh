#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to ensure Clipman is installed
install_clipman() {
    if command_exists xfce4-clipman; then
        echo "Clipman is already installed."
    else
        echo "Clipman is not installed. Installing..."
        sudo apt update && sudo apt install xfce4-clipman -y
    fi
}

# Function to ensure Clipman is running
start_clipman() {
    if pgrep -x "xfce4-clipman" >/dev/null; then
        echo "Clipman is already running."
    else
        echo "Starting Clipman..."
        nohup xfce4-clipman &>/dev/null &
    fi
}

# Function to ensure Clipman starts on login
configure_autostart() {
    AUTOSTART_DIR="$HOME/.config/autostart"
    CLIPMAN_AUTOSTART_FILE="$AUTOSTART_DIR/xfce4-clipman-plugin-autostart.desktop"

    mkdir -p "$AUTOSTART_DIR"

    if [ ! -f "$CLIPMAN_AUTOSTART_FILE" ]; then
        cat <<EOL > "$CLIPMAN_AUTOSTART_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=Clipman
Comment=Clipboard Manager
Exec=xfce4-clipman
StartupNotify=false
Terminal=false
Hidden=false
X-GNOME-Autostart-enabled=true
EOL
        echo "Clipman is configured to start on login."
    else
        echo "Clipman autostart already configured."
    fi
}

# Function to configure the keyboard shortcut for Super + V
configure_shortcut() {
    # The keybinding path for Super+V
    SUPER_V_PATH="/xfce4-keyboard-shortcuts/custom/Super+V"

    # Remove existing shortcut if any
    xfconf-query -c xfce4-keyboard-shortcuts -r "$SUPER_V_PATH" 2>/dev/null

    # Add new shortcut for Clipman history
    xfconf-query -c xfce4-keyboard-shortcuts -n -t string -p "$SUPER_V_PATH" -s "xfce4-clipman-history"

    echo "Shortcut Super+V set for xfce4-clipman-history."
}

# Main function to orchestrate the setup
main() {
    echo "Starting Clipman setup..."

    # Step 1: Install Clipman if necessary
    install_clipman

    # Step 2: Ensure Clipman is running
    start_clipman

    # Step 3: Configure Clipman to start on login
    configure_autostart

    # Step 4: Set up the Super+V keyboard shortcut for Clipman history
    configure_shortcut

    echo "Clipman setup and configuration completed."
}

# Run the main function
main
