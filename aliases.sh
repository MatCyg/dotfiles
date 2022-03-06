# Easier navigation: .., ..., ...., ..... and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
alias cd..='cd ..'


export PROJECTS=$HOME/Projects
export DOWNLOADS=$HOME/Downloads
export DESKTOP=$HOME/Desktop
export TOOLS=$HOME/Tools
export JAVA_SYMLINKS_DIR=$HOME/.java

# Shortcuts
alias dl='cd $DOWNLOADS'
alias dt='cd $DESKTOP'
alias pd='cd $PROJECTS'
alias pdf='cd $PROJECTS/finastra'
alias pdp='cd $PROJECTS/personal'
# shellcheck disable=SC2139
# cd to dotfiles project
alias pdd="cd $(dirname "$0")"
alias tl='cd $TOOLS'
alias g="git"
alias dr="docker"
alias dc="docker-compose"
alias h="history"

alias start_simple_server="python -m SimpleHTTPServer 8000"
alias copy_last_command="fc -ln -1 | sed '1s/^[[:space:]]*//' | awk 1 ORS=\"\" | pbcopy"

alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias k9='kill -9'
alias c="printf '\e]50;ClearScrollback\a'"
alias o='less +F'
alias sl='ls'

alias listen="lsof -P -i -n"
alias port='netstat -ap tcp'

alias current_datetime='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias brew_update_all='brew update && brew upgrade && brew upgrade --casks && brew cleanup --prune=all && brew cleanup; brew doctor'

refresh () {
	command=$*;
	if [[ -z "$command" ]]; then
		command=$(history | tail -1 | head -1 | cut -c8-999)
	fi
  echo "Executing command: $command"
  read -r "response?Are you sure? [y/N]" response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
  then
    while true; do eval "$command"; sleep 1; clear; done;
  else
    echo "Exiting."
  fi
}

alias goku='cd $DOTFILES/config/keyboard/; ./build.sh; cd -'
alias gokus='/usr/local/bin/goku -c $DOTFILES/config/karabiner/karabiner.edn'


