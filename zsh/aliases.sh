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
export JAVA_ALIASES_PATH=$JAVA_SYMLINKS_DIR/java-aliases.sh

# Shortcuts
alias dl='cd $DOWNLOADS'
alias dt='cd $DESKTOP'
alias pd='cd $PROJECTS'
alias pdf='cd $PROJECTS/finastra'
alias pdp='cd $PROJECTS/personal'
# shellcheck disable=SC2139
# cd to dotfiles project
alias pdd="cd $(dirname "$0")"
alias pdm="cd $(dirname "$0")/../monorepo"
alias tl='cd $TOOLS'
alias g="git"
alias dr="docker"
alias s="subl"
alias dc="docker-compose"
alias h="history"
alias mk="minikube"
alias kc="kubectl"

alias start-simple-server="python -m SimpleHTTPServer 8000"
alias clc="fc -ln -1 | sed '1s/^[[:space:]]*//' | awk 1 ORS=\"\" | pbcopy"

alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias k9='kill -9'
alias c="printf '\e]50;ClearScrollback\a'"
alias le='less +F'
alias sl='ls'

alias listen="lsof -P -i -n"
alias port='netstat -ap tcp'

alias utctime='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias upgrade-brew-packages='brew update && brew upgrade; brew upgrade --casks --greedy; brew cleanup; brew cleanup --prune=all; brew doctor'
alias upgrade-java='$DOTFILES/upgrade-java/sdkman-upgrade-java.sh && exec $SHELL'

#alias goku='/usr/local/bin/goku -c $DOTFILES/config/karabiner/karabiner.edn'
alias goku='~/goku -c $DOTFILES/config/karabiner/karabiner.edn; karabinerAddHoldDownMilliseconds ~/.config/karabiner/karabiner.json'

alias start-mongo='rm -rf ~/data;mkdir -p ~/data/db;mongod --fork --syslog --dbpath ~/data/db'
alias stop-mongo='killall mongod'

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\"" 
  alias catt="bat --theme \"Visual Studio Dark+\"" 
fi

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'



karabinerAddHoldDownMilliseconds() {
  temp_file=$(mktemp)
  jq '
    def addHoldDownMilliseconds:
      if type == "object" then
        if .key_code == "vk_none" then . + {"hold_down_milliseconds": 200}
        else with_entries(.value |= addHoldDownMilliseconds) end
      elif type == "array" then map(addHoldDownMilliseconds)
      else . end;

    .profiles |= map(if .name == "Default" then
      .complex_modifications.rules |= map(if .description == "auto shift" then
        .manipulators |= map(addHoldDownMilliseconds)
      else . end)
    else . end)
  ' $1 > $temp_file && mv $temp_file $1
}

refresh () {
	command=$*;
	if [[ -z "$command" ]]; then
		command=$(history | tail -1 | head -1 | cut -c8-999)
	fi
  echo "Executing command: $command"
#  read -r -p "Do you want to continue? [y/n] " response # bash version
  read "response?Are you sure? [y/n]" # zsh version
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
  then
    clear;
    while true; do eval "$command"; sleep 1; clear; done;
  else
    echo "Exiting."
  fi
}

t() {
  passed_dir=$1
  if [[ -z $passed_dir ]]; then
    passed_dir=$(z | awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' | fzf | awk '{print $2}')
  fi
  z "$passed_dir"
}

i() {
  passed_dir=$1
  if [[ -z $passed_dir ]]; then
    passed_dir="."
  fi
  idea "$passed_dir"
}

git-open-url() {
  remoteUrl=$(git ls-remote --get-url origin)
  if [[ "$remoteUrl" == *"ssh.dev.azure.com"* || "$remoteUrl" == *"ssh.visualstudio.com"* ]]; then
    url=$(echo $remoteUrl | awk '{split($0,a,"/"); print "https://dev.azure.com/"a[2]"/"a[3]"/_git/"a[4]"/pullrequests?_a=mine"}')
    open $url
  else
    git open
  fi
  }

git-open-pipelines() {
  remoteUrl=$(git ls-remote --get-url origin)
  if [[ "$remoteUrl" == *"ssh.dev.azure.com"* || "$remoteUrl" == *"ssh.visualstudio.com"* ]]; then
    url=$(echo $remoteUrl | awk '{split($0,a,"/"); print "https://dev.azure.com/"a[2]"/"a[3]"/_build?pipelineNameFilter="a[4]}')
    open $url
  else
    echo "Not in Azure DevOps repository"
    exit 1
  fi
}

command_not_found_handler() {
  fullCommand=$@

  fixed=false
  if [[ "$0" == *"g"* ]]; then
    git_commands=("gconfig ghelp ginit gclone gadd gstatus gdiff gcommit grestore greset grm gmv gbranch gcheckout gswitch gmerge gmergetool glog gstash gtag gworktree gfetch gpull gpush gremote gsubmodule gshow glog gdiff gdifftool grange-diff gshortlog gdescribe gapply gcherry-pick gdiff grebase grevert gbisect gblame ggrep gapply greflog gcat-file gcheck-ignore gcheckout-index gcommit-tree gcount-objects gdiff-index gfor-each-ref ghash-object gls-files gls-tree gmerge-base gread-tree grev-list grev-parse gshow-ref gsymbolic-ref gupdate-index gupdate-ref gverify-pack gwrite-tree")
    git_aliases=$(git la | awk -F= '{print "g"$1}')
    all+=( ${git_commands[@]} "${git_aliases[@]}" )
    contains=$(echo "$all" | grep -w -q $0)
    if [ "$?" -eq 0 ]; then
      fixed=true
      git "${fullCommand:1}"
    fi
  fi
  if [ "$fixed" = false ] ; then
    echo "zsh: command not found: $fullCommand"
    return 127
  fi
}

cfp() {
  file=$1
  if [[ -z $file ]]; then
      file="."
  fi
  filePath=$(readlink -f $file)
  echo -n "$filePath" | pbcopy
}

o() {
  file=$1
  if [[ -z $file ]]; then
      file="."
  fi
  open "$file"
}