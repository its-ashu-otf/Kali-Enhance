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
    xfce4-clipman &
fi

# Installing xmlstarlet
sudo apt-get install xmlstarlet -y

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
KEYBOARD_SETTINGS_FILE="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"

# Backup existing keyboard settings
cp "$KEYBOARD_SETTINGS_FILE" "${KEYBOARD_SETTINGS_FILE}.bak"

# Add the Super+V shortcut
if grep -q "<property name=\"&lt;super&gt;v\"" "$KEYBOARD_SETTINGS_FILE"; then
    echo "Shortcut Super+V already exists. Skipping..."
else
    xmlstarlet ed -L \
        -s '/channel/property[@name="commands"]/property[@name="default"]' -t elem -n "property" -v "" \
        -i '/channel/property[@name="commands"]/property[@name="default"]/property[not(@*)]' -t attr -n "name" -v "<Super>v" \
        -i '/channel/property[@name="commands"]/property[@name="default"]/property[@name="<Super>v"]' -t attr -n "type" -v "string" \
        -u '/channel/property[@name="commands"]/property[@name="default"]/property[@name="<Super>v"]' -v "xfce4-clipman-history" \
        "$KEYBOARD_SETTINGS_FILE"

    echo "Shortcut Super+V set for xfce4-clipman-history."
fi

# Reload xfce4-keyboard-settings
xfconf-query -c xfce4-keyboard-shortcuts -r /commands/custom/<Super>v
xfconf-query -c xfce4-keyboard-shortcuts -n -t string -p /commands/custom/<Super>v -s "xfce4-clipman-history"

echo "Clipman setup and configuration completed."
