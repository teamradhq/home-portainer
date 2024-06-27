#!/usr/bin/env bash

CWD=$(realpath "$0")
CWD=$(dirname "$CWD")
CWD=$(realpath "$CWD/..")

"$CWD"/bin/stop-service.sh
"$CWD"/bin/start-service.sh
