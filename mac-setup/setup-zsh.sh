echo "[zsh] Installing..."

cp "$(dirname "$0")"/default-zshrc.sh "$HOME"/.zshrc

# disable last login message
touch ~/.hushlogin

echo "[zsh] Installation finished"