echo "[brew] Installing..."

if test ! "$(which brew)"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "[brew] Adding taps..."
brew tap homebrew/cask-fonts
brew tap homebrew/cask
brew tap buo/cask-upgrade

echo "[brew] Updating recipes..."
brew update

echo "[brew] Installing command line tools..."
cmd_tools=(
  bash
  bat
  blueutil
  ddcctl
  font-fira-code
  fzf
  git
  goku
  httpie
  jq
  kubernetes-cli
  podman-compose
  tree
  rar
  watch
  wget
)
for cmd_tool in "${cmd_tools[@]}"; do
  echo "[brew-cmd-tools] Installing '$cmd_tool'"
  brew install "$cmd_tool"
done

echo "[brew] Installing desktop applications..."
apps=(
  anki
  drawio
  firefox
  iterm2
  karabiner-elements
  mongodb-compass
  podman-desktop
  postman
  rectangle
  spotify
  sublime-text
  telegram
  visual-studio-code
  vlc
)
for app in "${apps[@]}"; do
  echo "[brew-apps] Installing '$app'"
  brew install --cask "$app"
done

echo "[brew] Cleaning up..."
brew cleanup

echo "[brew] Installation finished"