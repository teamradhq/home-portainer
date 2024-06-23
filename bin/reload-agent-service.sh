#!/usr/bin/env bash

CWD=$(realpath "$0")
CWD=$(dirname "$CWD")
CWD=$(realpath "$CWD/..")

"$CWD"/bin/stop-agent-service.sh
"$CWD"/bin/start-agent-service.sh
