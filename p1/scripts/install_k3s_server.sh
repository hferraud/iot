#!/usr/bin/env bash
set -e

# Install k3s server
curl -sfL https://get.k3s.io | \
INSTALL_K3S_EXEC="--node-ip=192.168.56.110" \
sh -

# Copy the token for the agent to access it
cat /var/lib/rancher/k3s/server/node-token > /vagrant/node-token