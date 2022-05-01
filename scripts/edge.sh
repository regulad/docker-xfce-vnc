#!/bin/bash

curl https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor > microsoft.gpg

install -o root -g root -m 644 \
  microsoft.gpg /etc/apt/trusted.gpg.d/

rm microsoft.gpg

echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" \
  | tee /etc/apt/sources.list.d/microsoft-edge-dev.list

apt update

apt install -y microsoft-edge-dev
