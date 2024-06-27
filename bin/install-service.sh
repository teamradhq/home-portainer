#!/bin/bash

usage() {
  echo -e "Install a systemd service."
  echo
  echo -e  "Usage: $0 <service-name> <owner> <workdir>"
  echo -e "        $0 awesome-things radical /opt/cool"
}

error () {
  echo -e "\e[31mError\e[0m"
  if [ -n "$1" ]; then
    echo -e "$1"
  fi
  usage
  exit 1
}

if [ "$#" -ne 3 ]; then
    error "Script requires three arguments."
fi

SERVICE_NAME=$1
SERVICE="${SERVICE_NAME}.service"
echo "Installing $SERVICE"

WORKDIR=$(realpath "$2")
if [ ! -d "$WORKDIR" ]; then
    error "Directory not found: $WORKDIR"
fi

TEMPLATE_FILE="$WORKDIR/templates/$SERVICE"
TARGET_FILE="/etc/systemd/system/$SERVICE"
if [ ! -f "$TEMPLATE_FILE" ]; then
    error "Template file not found: $TEMPLATE_FILE"
fi

OWNER=$3
if ! id "$OWNER" &>/dev/null; then
    error "User not found: $OWNER"
fi

# Parse template to systemd service target file.
sed -e "s|{{WORKDIR}}|$WORKDIR|g" \
    -e "s|{{OWNER}}|$OWNER|g" \
    "$TEMPLATE_FILE" | sudo tee "$TARGET_FILE" > /dev/null
sudo chmod 644 "$TARGET_FILE"

# Enable and start the service
sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE_NAME"
sudo systemctl reload "$SERVICE_NAME"
sudo systemctl status "$SERVICE"
