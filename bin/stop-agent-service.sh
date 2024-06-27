#!/usr/bin/env bash

CWD=$(realpath "$0")
CWD=$(dirname "$CWD")
CWD=$(realpath "$CWD/..")

error () {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
    exit 1
}

cd "$CWD" || error "Directory $CWD does not exist."

/usr/bin/docker compose -f "$CWD/docker-compose-agent.yml" down || error "Failed to stop the registry service."