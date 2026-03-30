#!/usr/bin/env bash

set -euo pipefail

sudo apt install curl
curl -1sLf 'https://dl.cloudsmith.io/public/task/task/setup.deb.sh' | sudo -E bash
sudo apt install task