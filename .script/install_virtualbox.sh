#!/usr/bin/env bash

set -euo pipefail

echo "Installing virtualbox..."
sudo wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo gpg --dearmor -o /usr/share/keyrings/oracle-virtualbox.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/oracle-virtualbox.gpg] http://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
sudo apt update
sudo apt install virtualbox-7.2 build-essential dkms linux-headers-amd64 -y