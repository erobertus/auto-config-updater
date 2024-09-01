#!/bin/bash

SCRIPT_NAME="update_config.sh"
INSTALL_DIR="/usr/local/bin"
SCRIPT_PATH="$INSTALL_DIR/$SCRIPT_NAME"

# Check if the script exists in the current directory
if [ ! -f "$SCRIPT_NAME" ]; then
    echo "Error: $SCRIPT_NAME not found in the current directory."
    exit 1
fi

# Copy the script to the installation directory
echo "Installing $SCRIPT_NAME to $INSTALL_DIR..."
sudo cp "$SCRIPT_NAME" "$INSTALL_DIR"
sudo chmod +x "$SCRIPT_PATH"

# Optional: Set up a sample cron job (commented out by default)
# echo "Setting up a sample cron job to run the script daily at midnight..."
# (sudo crontab -l ; echo "0 0 * * * $SCRIPT_PATH /etc/csf/csf.conf CC_ALLOW_FILTER 'CA,IT' 'CA' '2024-09-18' '2024-10-07' 'csf -ra'") | sudo crontab -

echo "Installation complete. You can now run the script using '$SCRIPT_NAME' from anywhere."
