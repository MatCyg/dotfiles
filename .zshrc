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
  zsh-fzf-history-search
  docker
  docker-compose
  extract
  z
)

ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=129'

source $ZSH/oh-my-zsh.sh
source "$DOTFILES"/relay.sh

export SDKMAN_OFFLINE_MODE=true
source "${HOME}/.sdkman/bin/sdkman-init.sh"
unset SDKMAN_OFFLINE_MODE

setopt SHARE_HISTORY HIST_IGNORE_DUPS