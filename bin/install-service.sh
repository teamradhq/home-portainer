#!/bin/bash

usage() {
  echo -e  "Usage: $0 <service-name> <user> <workdir>"

}

error () {
  echo -e "\e[31mError\e[0m"
  if [ -n "$1" ]; then
    echo -e "$1"
  fi
  usage
  exit 1
}

SERVICE_NAME=$1
SERVICE="${SERVICE_NAME}.service"

echo "Installing $SERVICE"

if [ "$#" -ne 2 ]; then
    error
fi

# Check for working directory
WORKDIR=$(realpath "$2")
if [ ! -d "$WORKDIR" ]; then
    error "Directory not found: $WORKDIR"
fi

# Check for template file
TEMPLATE_FILE="$WORKDIR/templates/$SERVICE"
TARGET_FILE="/etc/systemd/system/$SERVICE"
if [ ! -f "$TEMPLATE_FILE" ]; then
    error "Template file not found: $TEMPLATE_FILE"
fi

# Verify user exists
USER=$3
if ! id "$USER" &>/dev/null; then
    error "User not found: $USER"
fi

# Parse template to systemd service target file.
sed -e "s|{{WORKDIR}}|$WORKDIR|g" \
    -e "s|{{USER}}|$USER|g" \
    "$TEMPLATE_FILE" | sudo tee "$TARGET_FILE" > /dev/null
sudo chmod 644 "$TARGET_FILE"

# Enable and start the service
sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE_NAME"
sudo systemctl start "$SERVICE_NAME"
sudo systemctl status "$SERVICE"
