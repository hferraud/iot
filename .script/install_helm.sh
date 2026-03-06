#!/bin/bash

curl -L https://get.helm.sh/helm-v4.1.1-linux-amd64.tar.gz | tar -xz
sudo install -o root -g root -m 0755 linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64
