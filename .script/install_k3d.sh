#!/usr/bin/env bash

set -euo pipefail

curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

sudo chmod 644 /etc/rancher/k3s/k3s.yaml
