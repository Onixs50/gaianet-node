#!/bin/bash
# Define colors
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored messages
print_color() {
    printf "${1}${2}${NC}\n"
}

# Clear the screen
clear
print_color "$YELLOW" "Welcome to GaiaNet Node Installer"
print_color "$YELLOW" "======================================="
echo

# Check and set port
print_color "$YELLOW" "Checking if port 8080 is available..."
if lsof -i :8080 > /dev/null 2>&1; then
    print_color "$RED" "Port 8080 is currently in use. Please choose a different port."
    read -p "Enter a new port: " port
else
    port=8080
fi
print_color "$GREEN" "Using port: $port"
echo

# Download and run the official GaiaNet installation script
print_color "$YELLOW" "Downloading and running the official GaiaNet installation script..."
curl -sSfL 'https://raw.githubusercontent.com/GaiaNet-AI/gaianet-node/main/install.sh' | bash

# Update port in configuration file
config_file="$HOME/gaianet/config.json"
if [ -f "$config_file" ]; then
    print_color "$YELLOW" "Updating port in config file..."
    sed -i "s/\"llamaedge_port\": \"[0-9]*\"/\"llamaedge_port\": \"$port\"/" "$config_file"
    print_color "$GREEN" "Port updated successfully in config file."
else
    print_color "$RED" "Config file not found. Please check your installation."
fi

print_color "$GREEN" "GaiaNet installation process completed."
print_color "$YELLOW" "Please check the output above for any errors or additional instructions."

# Source .bashrc
print_color "$YELLOW" "Updating environment..."
source /root/.bashrc

# Run GaiaNet commands
print_color "$YELLOW" "Initializing GaiaNet..."
gaianet init
sleep 2

print_color "$YELLOW" "Starting GaiaNet..."
gaianet start
sleep 2

print_color "$YELLOW" "GaiaNet Info:"
gaianet info
echo

# Display next steps
echo
print_color "$YELLOW" "╔════════════════════════════════════════════════════════════╗"
print_color "$YELLOW" "║                     Next Steps                            ║"
print_color "$YELLOW" "╠════════════════════════════════════════════════════════════╣"
print_color "$YELLOW" "║ If you need to run these commands again, use:             ║"
print_color "$YELLOW" "║                                                           ║"
print_color "$GREEN"  "║ 1. source /root/.bashrc                                   ║"
print_color "$GREEN"  "║ 2. gaianet init                                           ║"
print_color "$GREEN"  "║ 3. gaianet start                                          ║"
print_color "$GREEN"  "║ 4. gaianet info                                           ║"
print_color "$YELLOW" "║                                                           ║"
print_color "$YELLOW" "║ You can copy and paste each command into your terminal    ║"
print_color "$YELLOW" "║ and press Enter after each one if needed.                 ║"
print_color "$YELLOW" "╚════════════════════════════════════════════════════════════╝"
echo

print_color "$GREEN" "╔════════════════════════════════════╗"
print_color "$GREEN" "║         Edited by Onixia           ║"
print_color "$GREEN" "╚════════════════════════════════════╝"
