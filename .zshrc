export ZSH="${HOME}/.oh-my-zsh"

# Too many plugins will slow down shell startup.
plugins=(
  macos
  git
  sdk
  brew
  npm
  node
  mvn
  git-open
  zsh-autosuggestions
  docker
  docker-compose
  extract
  z
)

ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=129'

source $ZSH/oh-my-zsh.sh
source "$DOTFILES"/relay.sh
source "${HOME}/.sdkman/bin/sdkman-init.sh"
