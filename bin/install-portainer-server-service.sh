#!/bin/bash

SCRIPT=$(dirname "$(realpath "$0")")
SCRIPT="$SCRIPT/install-service.sh"

if [ ! -f "$SCRIPT" ]; then
  error "Script not found: $SCRIPT"
fi

"$SCRIPT" portainer-server "$1" "$2"
