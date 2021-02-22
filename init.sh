#!/bin/sh

echo "Install XCode CLI Tool"
#xcode-select --install

TARGET_DIR="$HOME"/test_install/personal/dotfiles
git clone git@github.com:MatCyg/dotfiles.git "$TARGET_DIR"
"$TARGET_DIR"/mac_setup/mac_setup_test.sh


#sh -c "$(curl -fsSL https://raw.githubusercontent.com/MatCyg/dotfiles/master/init.sh)"

