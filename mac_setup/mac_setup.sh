echo_section() {
  echo "################################################################################"
  echo "################################################################################"
  echo "$1"
  echo "################################################################################"
  echo "################################################################################"
  echo
}

echo_section "[XCODE-TOOLS] Installing..."
if ! xcode-select --install 2>&1 | grep installed; then
  xcode-select --install
fi
echo_section "[XCODE-TOOLS] Installation finished"



# sdkman must be installed first as it alters .zshrc
echo_section "[SDKMAN] Installing..."

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

"$(dirname "$0")"/../sdkman_upgrade_java.sh

echo_section "[SDKMAN] Installation finished"



echo_section "[Oh-My-Zsh] Installing..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
ZSH_PLUGINS_DIR=$ZSH_CUSTOM/plugins
ZSH_THEMES_DIR=$ZSH_CUSTOM/themes

echo_section "[Oh-My-Zsh] Installing custom plugins and themes..."

git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_PLUGINS_DIR"/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGINS_DIR"/zsh-syntax-highlighting
git clone https://github.com/paulirish/git-open.git "$ZSH_PLUGINS_DIR"/git-open

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_THEMES_DIR"/powerlevel10k

cp "$(dirname "$0")"/default_zshrc.sh "$HOME"/.zshrc

echo_section "[Oh-My-Zsh] Installation finished"



echo_section "[brew] Installing..."

if test ! "$(which brew)"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "[brew] Adding taps..."
brew tap homebrew/cask-fonts
brew tap homebrew/cask

echo "[brew] Updating recipes..."
brew update

echo "[brew] Installing command line tools..."
cmd_tools=(
  jq
  autojump
  tree
  bat
  unrar
  watch
  wget
  htop
  mdcat
  httpie
  fzf
  docker
  font-dejavu-sans-mono-nerd-font
)
for cmd_tool in "${cmd_tools[@]}"; do
  echo "[brew-cmd-tools] Installing '$cmd_tool'"
  brew install "$cmd_tool"
done

echo "[brew] Installing desktop applications..."
apps=(
  anki
  fsnotes
  selfcontrol
  vlc
  slack
  microsoft-teams
  send-to-kindle
  sublime-text
  visual-studio-code
  iterm2
  firefox
  karabiner-elements
  postman
  spotify
)
for app in "${apps[@]}"; do
  echo "[brew-apps] Installing '$app'"
  brew install "$app"
done

echo "[brew] Cleaning up..."
brew cleanup

echo_section "[brew] Installation finished"



echo "[FONTS] - Start installing fonts"
"$(dirname "$0")"/fonts.sh
echo "[FONTS] - Completed fonts installation"



# keep in defaults invoke global sudo, remember to run it as the last step
echo "[defaults] - Setting up macOS defaults"
"$(dirname "$0")"/mac_os_defaults.sh
echo "[defaults] - Setting up macOS defaults"



echo_section "Installation completed"