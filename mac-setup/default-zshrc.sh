export DOTFILES="${HOME}"/Projects/personal/dotfiles
if [ -r "$DOTFILES"/zsh/zshrc.sh ]; then
  source "$DOTFILES"/zsh/zshrc.sh
else
  echo "Failed to find .zshrc at path: $DOTFILES"
fi