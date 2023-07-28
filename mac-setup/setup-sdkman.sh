# sdkman must be installed first as it alters .zshrc
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

"$(dirname "$0")"/../upgrade-java/sdkman-upgrade-java.sh
