#!/bin/sh

echo "Install XCode CLI Tool"
xcode-select --install

TARGET_DIR="$HOME"/Projects/personal/dotfiles
git clone https://github.com/MatCyg/dotfiles.git "$TARGET_DIR"
"$TARGET_DIR"/mac_setup/mac_setup.sh