#!/bin/bash

# Nerd Fonts List
fonts_list=("0xProto" "3270" "AdwaitaMono" "Agave" "AnonymousPro" "Arimo" "AtkinsonHyperlegibleMono" "AurulentSansMono" "BigBlueTerminal" "BitstreamVeraSansMono" "CascadiaCode" "CascadiaMono" "CodeNewRoman" "ComicShannsMono" "CommitMono" "Cousine" "D2Coding" "DaddyTimeMono" "DejaVuSansMono" "DepartureMono" "DroidSansMono" "EnvyCodeR" "FantasqueSansMono" "FiraCode" "FiraMono" "GeistMono" "Go-Mono" "Gohu" "Hack" "Hasklig" "HeavyData" "Hermit" "iA-Writer" "IBMPlexMono" "Inconsolata" "InconsolataGo" "InconsolataLGC" "IntelOneMono" "Iosevka" "IosevkaTerm" "IosevkaTermSlab" "JetBrainsMono" "Lekton" "LiberationMono" "Lilex" "MartianMono" "Meslo" "Monaspace" "Monofur" "Monoid" "Mononoki" "MPlus" "NerdFontsSymbolsOnly" "Noto" "OpenDyslexic" "Overpass" "ProFont" "ProggyClean" "Recursive" "RobotoMono" "ShareTechMono" "SourceCodePro" "SpaceMono" "Terminus" "Tinos" "Ubuntu" "UbuntuMono" "UbuntuSans" "VictorMono" "ZedMono")

# Function to handle the actual download and extraction
install_font() {
    local font=$1
    local zip_file="${font}.zip"
    local download_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${zip_file}"
    local install_dir="$HOME/.local/share/fonts/$font"

    echo "[*] Downloading and installing: $font"
    
    # Create directory
    mkdir -p "$install_dir"

    # Download using curl or wget
    if command -v curl >/dev/null 2>&1; then
        curl -L "$download_url" -o "/tmp/$zip_file"
    elif command -v wget >/dev/null 2>&1; then
        wget -q "$download_url" -O "/tmp/$zip_file"
    else
        echo "[!] Error: Neither curl nor wget found. Please install one."
        exit 1
    fi

    # Unzip and cleanup
    if command -v unzip >/dev/null 2>&1; then
        unzip -oq "/tmp/$zip_file" -d "$install_dir"
        rm "/tmp/$zip_file"
    else
        echo "[!] Error: unzip is not installed."
        exit 1
    fi
}

echo "[-] Download The Nerd Fonts [-]"
echo "###############################"

# Display fonts in columns for better readability
for i in "${!fonts_list[@]}"; do
    printf "%2d) %-25s" "$((i+1))" "${fonts_list[$i]}"
    # New line every 3 items
    if [ $(( (i+1) % 3 )) -eq 0 ]; then echo ""; fi
done

echo -e "\n-------------------------------"
echo "Options:"
echo "  - Enter numbers separated by commas (e.g., 1,12,24)"
echo "  - Enter 'A' for All fonts"
echo "  - Enter 'Q' to Quit"
echo "-------------------------------"

read -p "Selection: " user_input

# Handle Quit
if [[ "$user_input" =~ ^[Qq]$ ]]; then
    echo "Exiting..."
    exit 0
fi

selected_fonts=()

# Handle "All" selection
if [[ "$user_input" =~ ^[Aa]$ ]]; then
    selected_fonts=("${fonts_list[@]}")
else
    # Parse comma-separated numbers
    IFS=',' read -ra ADDR <<< "$user_input"
    for choice in "${ADDR[@]}"; do
        # Strip whitespace
        choice=$(echo "$choice" | tr -d ' ')
        # Check if it's a valid number index
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -le "${#fonts_list[@]}" ] && [ "$choice" -gt 0 ]; then
            selected_fonts+=("${fonts_list[$((choice-1))]}")
        else
            echo "[!] Skipping invalid selection: $choice"
        fi
    done
fi

# Process installations
if [ ${#selected_fonts[@]} -eq 0 ]; then
    echo "[!] No valid fonts selected. Exiting."
    exit 1
fi

for font in "${selected_fonts[@]}"; do
    install_font "$font"
done

# Refresh font cache
echo "[*] Updating font cache..."
fc-cache -fv >/dev/null 2>&1

echo "###############################"
echo "[-] Done! All selected fonts installed."
