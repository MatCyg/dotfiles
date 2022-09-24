echo_section() {
  echo "################################################################################"
  echo "################################################################################"
  echo "$1"
  echo "################################################################################"
  echo "################################################################################"
  echo
}

export DOTFILES="${HOME}"/Projects/personal/dotfiles

echo_section "[XCODE-TOOLS] Installing..."
if ! xcode-select --install 2>&1 | grep installed; then
  xcode-select --install
fi
echo_section "[XCODE-TOOLS] Installation finished"



echo_section "[ssh-key] Generation..."

email="matcyg@gmail.com"

echo "[ssh-key] Creating an SSH key for '$email'"
ssh-keygen -t ed25519 -C $email

echo -e "\n[ssh-key] Please add this public key to Github:\n\n"
cat "$HOME"/.ssh/id_ed25519.pub
echo -e "\n\n[ssh-key] https://github.com/account/ssh \n"
read -rp "[ssh-key] Press [Enter] key to continue..."

echo_section "[ssh-key] Generation finished"



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



echo_section "[symlinks] Setting up configuration symlinks..."
ln -s "$DOTFILES"/.gitconfig "$HOME"/.gitconfig
ln -s "$DOTFILES"/Projects/personal/dotfiles/.gitignore_global "$HOME"/.gitignore_global
echo_section "[symlinks] Symlinks set"



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
  bat
  blueutil
  docker
  font-fira-code
  fzf
  goku
  htop
  httpie
  jq
  kubernetes-cli
  tree
  unrar
  watch
  wget
)
for cmd_tool in "${cmd_tools[@]}"; do
  echo "[brew-cmd-tools] Installing '$cmd_tool'"
  brew install "$cmd_tool"
done

echo "[brew] Installing desktop applications..."
apps=(
  alt-tab
  anki
  docker
  drawio
  firefox
  iterm2
  karabiner-elements
  lens
  logitech-options
  microsoft-teams
  postman
  rectangle
  selfcontrol
  slack
  spotify
  sublime-text
  visual-studio-code
  vlc
)
for app in "${apps[@]}"; do
  echo "[brew-apps] Installing '$app'"
  brew install --cask "$app"
done

echo "[brew] Cleaning up..."
brew cleanup

echo_section "[brew] Installation finished"



# keep in defaults invoke global sudo, remember to run it as the last step
echo "[defaults] - Setting up macOS defaults"
"$(dirname "$0")"/defaults.sh
echo "[defaults] - Setting up macOS defaults"



echo_section "Installation completed"
