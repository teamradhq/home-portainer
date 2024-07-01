#!/bin/bash

usage() {
  echo -e "Uninstall a systemd service."
  echo
  echo -e  "Usage: $0 <service-name>"
  echo -e "        $0 awesome-things"
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
echo "Uninstalling $SERVICE"

TARGET_FILE="/etc/systemd/system/$SERVICE"
if [ ! -f "$TARGET_FILE" ]; then
    error "Service file not found: $TARGET_FILE"
fi

sudo systemctl stop "$SERVICE_NAME"
sudo systemctl disable "$SERVICE_NAME"
sudo rm "$TARGET_FILE"
sudo systemctl daemon-reload

echo "$SERVICE uninstalled successfully."
