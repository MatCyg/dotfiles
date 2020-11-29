# Easier navigation: .., ..., ...., ..... and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
alias cd..='cd ..'


export USER_HOME=/Users/$USERNAME
export UH=$USER_HOME
export PROJECTS=$USER_HOME/Projects
export DOWNLOADS=$USER_HOME/Downloads
export DESKTOP=$USER_HOME/Desktop
export TOOLS=$USER_HOME/tools

# Shortcuts
alias dl="cd $DOWNLOADS"
alias dt="cd $DESKTOP"
alias pd="cd $PROJECTS"
alias pde="cd $PROJECTS/eldro"
alias pdf="cd $PROJECTS/finastra"
alias pdp="cd $PROJECTS/personal"
alias ct="cd $TOOLS"
alias g="git"
alias dr="docker"
alias dc="docker-compose"
alias h="history"


alias psg="ps -ef | grep"
alias psgj="psg java"
alias start_simple_server="python -m SimpleHTTPServer 8000"
alias copy_last_command="fc -ln -1 | sed '1s/^[[:space:]]*//' | awk 1 ORS=\"\" | pbcopy"

alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias k9='kill -9'
alias kw='taskkill /pid'
#alias c='clear'
#alias c="echo -ne '\033c'"
alias c="printf '\e]50;ClearScrollback\a'"
alias o='less +F'
alias sl='ls'

extract() { 
    if [ -f $1 ] ; then 
      case $1 in 
        *.tar.bz2)   tar xjf $1     ;; 
        *.tar.gz)    tar xzf $1     ;; 
        *.bz2)       bunzip2 $1     ;; 
        *.rar)       unrar e $1     ;; 
        *.gz)        gunzip $1      ;; 
        *.tar)       tar xf $1      ;; 
        *.tbz2)      tar xjf $1     ;; 
        *.tgz)       tar xzf $1     ;; 
        *.zip)       unzip $1       ;; 
        *.Z)         uncompress $1  ;; 
        *.7z)        7z x $1        ;; 
        *.jar)       unzip $1       ;;
        *)     echo "'$1' cannot be extracted via extract()" ;; 
         esac 
     else 
         echo "'$1' is not a valid file" 
     fi 
}

alias listen="lsof -P -i -n"
alias port='netstat -ap tcp'
refresh () { 
	command=$@;
	if [[ -z "$command" ]]; then
		command=$(history | tail -1 | head -1 | cut -c8-999)
	fi
  echo "Executing command: $command"
  read "response?Are you sure? [y/N]"
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
  then
    while true; do $command; sleep 1; clear; done;
  else
    echo "Exiting."
  fi

}

# shellcheck disable=SC2142
alias cpu_temp='istats cpu | awk '\''{ print $3 }'\'''

alias git_real_diff='$PROJECTS/personal/dotfiles/git_real_diff.sh'
alias git_real_diff_cleanup='$PROJECTS/personal/dotfiles/git_real_diff_cleanup.sh'