export DOTFILES="${HOME}"/Projects/personal/dotfiles
if [ -r "$DOTFILES"/.zshrc ]; then
  source "$DOTFILES"/.zshrc
else
  echo "Failed to find .zshrc at path: $DOTFILES"
fi