# Define colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored messages
print_color() {
    printf "${1}${2}${NC}\n"
}

# Clear the screen
clear

print_color "$BLUE" "Welcome to GaiaNet Node Installer"
print_color "$BLUE" "======================================="
echo

# Check and set port
print_color "$BLUE" "Checking if port 8080 is available..."
if lsof -i :8080 > /dev/null 2>&1; then
    print_color "$RED" "Port 8080 is currently in use. Please choose a different port."
    read -p "Enter a new port: " port
else
    port=8080
fi
print_color "$GREEN" "Using port: $port"
echo

# Download and run the official GaiaNet installation script
print_color "$BLUE" "Downloading and running the official GaiaNet installation script..."
curl -sSfL 'https://raw.githubusercontent.com/GaiaNet-AI/gaianet-node/main/install.sh' | bash

# Update port in configuration file
config_file="$HOME/gaianet/config.json"
if [ -f "$config_file" ]; then
    print_color "$BLUE" "Updating port in config file..."
    sed -i "s/\"llamaedge_port\": \"[0-9]*\"/\"llamaedge_port\": \"$port\"/" "$config_file"
    print_color "$GREEN" "Port updated successfully in config file."
else
    print_color "$RED" "Config file not found. Please check your installation."
fi

print_color "$GREEN" "GaiaNet installation process completed."
print_color "$BLUE" "Please check the output above for any errors or additional instructions."

# Additional commands with appropriate spacing
if [ -f /root/.bashrc ]; then
    print_color "$BLUE" "Sourcing /root/.bashrc and running GaiaNet commands..."
    sudo bash -c 'source /root/.bashrc && gaianet init && gaianet start && gaianet info'
else
    print_color "$RED" "/root/.bashrc not found. Please check your installation."
fi

echo
print_color "$GREEN" "╔════════════════════════════════════╗"
print_color "$GREEN" "║         Edited by Onixia           ║"
print_color "$GREEN" "╚════════════════════════════════════╝"
