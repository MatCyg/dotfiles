#!/bin/sh

echo "Install XCode CLI Tool"
#xcode-select --install

git clone git@github.com:MatCyg/dotfiles.git "$HOME"/test_install/personal/dotfiles && cd "$_" && ./mac_setup/mac_setup.sh


#sh -c "$(curl -fsSL https://raw.githubusercontent.com/MatCyg/dotfiles/master/init.sh)"

