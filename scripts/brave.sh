#!/bin/bash

curl https://brave-browser-apt-release.s3.brave.com/brave-core.asc \
  | gpg --dearmor > brave-browser-release.gpg

install -o root -g root -m 644 \
  brave-browser-release.gpg /etc/apt/trusted.gpg.d/

rm brave-browser-release.gpg

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
  | tee /etc/apt/sources.list.d/brave-browser-release.list

apt update

apt install -y brave-browser

mkdir -p ~/.config/BraveSoftware/Brave-Browser/Default
cp -i ~/.config/BravePreferences.json ~/.config/BraveSoftware/Brave-Browser/Default/Preferences
