#!/bin/bash

# Color definitions
bold_green='\033[1;32m'
bold_cyan='\033[1;36m'
bold_yellow='\033[1;33m'
bold_purple='\033[1;35m'
bold_blue='\033[1;34m'
bold_red='\033[1;31m'
reset='\033[0m'

# Function to print colored messages
echo_color() {
    echo -e "${1}${2}${reset}"
}

# Clear screen
clear

echo_color $bold_blue "Welcome to GaiaNet Node Installer"
echo_color $bold_blue "======================================="
echo

if [ -d "$HOME/gaianet" ]; then
    echo_color $bold_red "Removing old GaiaNet installation..."
    rm -rf $HOME/gaianet
    echo_color $bold_green "Old installation removed successfully."
fi

echo_color $bold_purple "Enter the port you want to use (default is 8080):"
read -p "Port: " port
port=${port:-8080}
echo_color $bold_cyan "Using port: $port"
echo

echo_color $bold_yellow "Downloading and installing GaiaNet node..."
curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash > /dev/null 2>&1
echo_color $bold_green "GaiaNet node downloaded and installed successfully."
echo

export PATH=$PATH:$HOME/gaianet/bin

echo_color $bold_blue "Updating shell configuration..."
if [ -n "$BASH_VERSION" ]; then
    source ~/.bashrc > /dev/null 2>&1
elif [ -n "$ZSH_VERSION" ]; then
    source ~/.zshrc > /dev/null 2>&1
elif [ -n "$FISH_VERSION" ]; then
    source ~/.config/fish/config.fish > /dev/null 2>&1
fi
echo_color $bold_green "Shell configuration updated successfully."
echo

echo_color $bold_purple "Downloading and modifying configuration file..."
CONFIG_URL="https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen-1.5-0.5b-chat/config.json"
CONFIG_FILE="$HOME/gaianet/config.json"
curl -o $CONFIG_FILE $CONFIG_URL > /dev/null 2>&1
sed -i "s/\"llamaedge_port\": \"[0-9]*\"/\"llamaedge_port\": \"$port\"/" $CONFIG_FILE
echo_color $bold_green "Configuration file downloaded and modified successfully."
echo

if lsof -i :$port > /dev/null 2>&1; then
    echo_color $bold_red "Port $port is in use. Please choose a different port."
    exit 1
fi

echo_color $bold_cyan "Initializing GaiaNet node..."
gaianet init --config $CONFIG_FILE > /dev/null 2>&1
echo_color $bold_green "GaiaNet node initialized successfully."
echo

echo_color $bold_yellow "Starting GaiaNet node..."
gaianet start > /dev/null 2>&1
echo_color $bold_green "GaiaNet node started successfully."
echo

echo_color $bold_blue "GaiaNet Node Information:"
echo_color $bold_blue "======================================="
node_info=$(gaianet info)
node_id=$(echo "$node_info" | grep "Node ID" | awk '{print $3}')
device_id=$(echo "$node_info" | grep "Device ID" | awk '{print $3}')
node_url="https://${node_id}.us.gaianet.network/"

echo_color $bold_purple "Node ID:    $node_id"
echo_color $bold_cyan "Device ID:  $device_id"
echo_color $bold_green "Node URL:   $node_url"
echo

echo_color $bold_yellow "╔════════════════════════════════════╗"
echo_color $bold_yellow "║         Edited by Onixia           ║"
echo_color $bold_yellow "╚════════════════════════════════════╝"
