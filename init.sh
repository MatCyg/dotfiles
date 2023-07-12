#!/bin/sh

echo "Install XCode CLI Tool"
if ! xcode-select --install 2>&1 | grep installed; then
  xcode-select --install
fi

TARGET_DIR="$HOME"/Projects/personal/dotfiles
git clone https://github.com/MatCyg/dotfiles.git "$TARGET_DIR"
"$TARGET_DIR"/mac-setup/mac-setup.sh