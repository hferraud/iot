#!/usr/bin/env bash

set -euo pipefail

VERSION="2.4.9"
URL="https://releases.hashicorp.com/vagrant/${VERSION}/vagrant_${VERSION}_linux_amd64.zip"
VAGRANT_TMP=/tmp/vagrant_${VERSION}.zip
VAGRANT_PATH=/opt/vagrant/${VERSION}
BIN_PATH=/usr/local/bin/vagrant

echo "Downloading vagrant..."
wget -q ${URL} -O ${VAGRANT_TMP}

rm -rf ${VAGRANT_PATH}

echo "Installing vagrant..."
sudo mkdir -p ${VAGRANT_PATH}
sudo unzip -o -q ${VAGRANT_TMP} -d ${VAGRANT_PATH}

rm -rf ${VAGRANT_TMP}

sudo ln -sf "${VAGRANT_PATH}/vagrant" "${BIN_PATH}"

echo "Done"
vagrant --version
