#!/usr/bin/env bash

echo_section() {
  local line="################################################################################"
  echo -e "${line}\n${line}\n$1\n${line}\n${line}\n"
}

echo_section "[xcode-tools] Installing..."
if ! xcode-select --install 2>&1 | grep installed; then
  xcode-select --install
fi
echo_section "[xcode-tools] Installation finished"

# sdkman must be installed first as it alters .zshrc
echo_section "[sdkman] Installing..."
"$(dirname "$0")"/setup-sdkman.sh
echo_section "[sdkman] Installation finished"

echo_section "[zsh] Installing..."
"$(dirname "$0")"/setup-zsh.sh
echo_section "[zsh] Installation finished"

echo_section "[brew] Installing..."
"$(dirname "$0")"/setup-brew.sh
echo_section "[brew] Installation finished"

# remember to run this as the last step
echo_section "[defaults] - Setting up macOS defaults"
"$(dirname "$0")"/setup-defaults.sh
echo_section "[defaults] - finished"

echo_section "Installation completed"
