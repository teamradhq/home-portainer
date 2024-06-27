#!/bin/bash

SCRIPT=$(dirname "$(realpath "$0")")
SCRIPT="$SCRIPT/install-service.sh"

if [ ! -f "$SCRIPT" ]; then
  echo "Install script not found: $SCRIPT"
  exit 1
fi

OWNER="$1"
WORKDIR="$2"

if [ -z "$OWNER" ] || [ -z "$WORKDIR" ]; then
  echo "Missing owner or workdir."
  echo "Usage: $0 <owner> <workdir>"
  exit 1
fi

"$SCRIPT" portainer-server "$OWNER" "$WORKDIR"
