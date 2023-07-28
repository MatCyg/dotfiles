#!/usr/bin/env bash

echo_section() {
  local line="################################################################################"
  echo -e "${line}\n${line}\n$1\n${line}\n${line}\n"
}

echo_section "[XCODE-TOOLS] Installing..."
if ! xcode-select --install 2>&1 | grep installed; then
  xcode-select --install
fi
echo_section "[XCODE-TOOLS] Installation finished"

# sdkman must be installed first as it alters .zshrc
echo_section "[SDKMAN]SDKMAN Installing..."
"$(dirname "$0")"/setup-sdkman.sh
echo_section "[SDKMAN] Installation finished"

echo_section "[zsh] Installing..."
"$(dirname "$0")"/setup-zsh.sh
echo_section "[zsh] Installation finished"

echo_section "[brew] Installing..."
"$(dirname "$0")"/setup-brew.sh
echo_section "[brew] Installation finished"

# remember to run this as the last step
echo "[defaults] - Setting up macOS defaults"
"$(dirname "$0")"/setup-defaults.sh
echo "[defaults] - Setting up macOS defaults"

echo_section "Installation completed"
