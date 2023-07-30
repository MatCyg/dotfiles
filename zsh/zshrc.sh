ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=129'
export LANG="en_US.UTF-8"
setopt SHARE_HISTORY HIST_IGNORE_DUPS

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zsh_plugins_txt="${DOTFILES}/zsh/zsh-plugins.txt"
zsh_plugins_zsh="${HOME}/.zsh-plugins.zsh"
if [[ ! ${zsh_plugins_zsh} -nt ${zsh_plugins_txt} ]]; then
  source /usr/local/opt/antidote/share/antidote/antidote.zsh
  antidote bundle <${zsh_plugins_txt} >${zsh_plugins_zsh}
fi

export SDKMAN_OFFLINE_MODE=true

source ${zsh_plugins_zsh}

unset SDKMAN_OFFLINE_MODE

# Enable the "new" completion system (compsys).
autoload -Uz compinit
compinit
if [[ ! ~/.zcompdump.zwc -nt ~/.zcompdump ]]; then
  zcompile -R -- ~/.zcompdump.zwc ~/.zcompdump
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

autoload -U select-word-style
select-word-style bash