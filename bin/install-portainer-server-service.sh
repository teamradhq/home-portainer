#!/bin/bash

error () {
  echo -e "\e[31mError\e[0m"
  if [ -n "$1" ]; then
    echo -e "$1"
  fi
  echo -e  "Usage: $0 WORKDIR USER"
  exit 1
}

SERVICE="portainer-server.service"

echo "Installing $SERVICE"

if [ "$#" -ne 2 ]; then
    error
fi

# Check for working directory
WORKDIR=$(realpath "$1")
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
USER=$2
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
sudo systemctl enable "$(basename $SERVICE .service)"
sudo systemctl start "$(basename $SERVICE .service)"
sudo systemctl status $SERVICE
