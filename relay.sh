

script_path=$(dirname "$0")

source "$script_path"/aliases.sh
test -e "$JAVA_ALIASES_PATH" && source "$JAVA_ALIASES_PATH" || true
source "$script_path"/.p10k.zsh
