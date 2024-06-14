#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Ensure Clipman is installed
if command_exists xfce4-clipman; then
    echo "Clipman is already installed."
else
    echo "Clipman is not installed. Installing..."
    sudo apt update && sudo apt install xfce4-clipman -y
fi

# Ensure Clipman is running
if pgrep -x "xfce4-clipman" >/dev/null; then
    echo "Clipman is already running."
else
    echo "Starting Clipman..."
    nohup xfce4-clipman &>/dev/null &
fi

# Ensure Clipman starts on login
AUTOSTART_DIR="$HOME/.config/autostart"
CLIPMAN_AUTOSTART_FILE="$AUTOSTART_DIR/xfce4-clipman-plugin-autostart.desktop"

mkdir -p "$AUTOSTART_DIR"

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

# Set keyboard shortcut for Clipman history
SUPER_V_PATH="/commands/custom/<Super>v"

# Remove existing shortcut if any
xfconf-query -c xfce4-keyboard-shortcuts -r "$SUPER_V_PATH" 2>/dev/null

# Add new shortcut
xfconf-query -c xfce4-keyboard-shortcuts -n -t string -p "$SUPER_V_PATH" -s "xfce4-clipman-history"

echo "Shortcut Super+V set for xfce4-clipman-history."

echo "Clipman setup and configuration completed."
