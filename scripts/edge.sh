#!/bin/bash

curl https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor > microsoft.gpg

sudo install -o root -g root -m 644 \
  microsoft.gpg /etc/apt/trusted.gpg.d/

sudo rm microsoft.gpg

echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" \
  | sudo tee /etc/apt/sources.list.d/microsoft-edge-dev.list

sudo apt update

sudo apt install -y microsoft-edge-dev
