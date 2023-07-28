echo_section "[Oh-My-Zsh] Installing..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
ZSH_PLUGINS_DIR=$ZSH_CUSTOM/plugins
ZSH_THEMES_DIR=$ZSH_CUSTOM/themes


echo_section "[Oh-My-Zsh] Installing custom plugins and themes..."

git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_PLUGINS_DIR"/zsh-autosuggestions
git clone https://github.com/paulirish/git-open.git "$ZSH_PLUGINS_DIR"/git-open
git clone https://github.com/joshskidmore/zsh-fzf-history-search "$ZSH_PLUGINS_DIR"/zsh-fzf-history-search

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_THEMES_DIR"/powerlevel10k

cp "$(dirname "$0")"/default-zshrc.sh "$HOME"/.zshrc

# disable last login message
touch ~/.hushlogin

echo_section "[Oh-My-Zsh] Installation finished"