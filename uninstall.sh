#!/bin/bash

SCRIPT_NAME="update_config.sh"
INSTALL_DIR="/usr/local/bin"
SCRIPT_PATH="$INSTALL_DIR/$SCRIPT_NAME"

# Check if the script is installed
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Error: $SCRIPT_NAME not found in $INSTALL_DIR."
    exit 1
fi

# Remove the script from the installation directory
echo "Uninstalling $SCRIPT_NAME from $INSTALL_DIR..."
sudo rm "$SCRIPT_PATH"

# Optional: Remove the sample cron job (commented out by default)
# echo "Removing sample cron job..."
# sudo crontab -l | grep -v "$SCRIPT_PATH" | sudo crontab -

echo "Uninstallation complete."
