# gaianet-node

In this version, you can choose which port you want to start the node with.

## Instructions

Follow these steps to set up and start the Gaianet node:

```bash
# Update your system
sudo apt-get update

# Install screen if it's not already installed
sudo apt-get install screen

# Start a new screen session
screen -S gaianet

# Download the setup script
wget https://github.com/Onixs50/gaianet-node/blob/main/gaianet.sh

# Make the script executable
chmod +x gaianet.sh

# Run the script
./gaianet.sh
```
DONE!