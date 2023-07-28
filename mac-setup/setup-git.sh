export DOTFILES="${HOME}"/Projects/personal/dotfiles

echo "[ssh-key] Generation..."

email="matcyg@gmail.com"

echo "[ssh-key] Creating an SSH key for '$email'"
ssh-keygen -t ed25519 -C $email

echo -e "\n[ssh-key] Please add this public key to Github:\n\n"
cat "$HOME"/.ssh/id_ed25519.pub
echo -e "\n\n[ssh-key] https://github.com/account/ssh \n"
read -rp "[ssh-key] Press [Enter] key to continue..."

echo "[ssh-key] Generation finished"

echo "[symlinks] Setting up configuration symlinks..."
ln -s "$DOTFILES"/.gitconfig "$HOME"/.gitconfig
ln -s "$DOTFILES"/Projects/personal/dotfiles/.gitignore_global "$HOME"/.gitignore_global
echo "[symlinks] Symlinks set"