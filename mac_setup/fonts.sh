#!/usr/bin/env bash


MAC_SETUP_DIR="$HOME"/mac_setup
mkdir -p "$MAC_SETUP_DIR"
cd "$MAC_SETUP_DIR" || exit

sans_code_last_release_url=$(curl -s https://api.github.com/repos/SSNikolaevich/DejaVuSansCode/releases/latest | grep browser_download_url | grep lgc-ttf | grep zip | cut -d '"' -f 4)

echo "$sans_code_last_release_url"
curl -LO "$sans_code_last_release_url"

SANS_CODE_DIR=$MAC_SETUP_DIR/sans_code

archive_name=$(basename "$sans_code_last_release_url")
unzip -j "$archive_name" -d "$SANS_CODE_DIR"

cp -v "$SANS_CODE_DIR"/*.ttf ~/Library/Fonts

echo "A directory has been created during setup, please remove the following dir manually:"
echo "$MAC_SETUP_DIR"

