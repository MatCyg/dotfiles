#!/usr/bin/env bash

SUBLIME_SETTINGS_PATH=~/Library/Application\ Support/Sublime\ Text/Packages/User

for file in "$(dirname "$0")"/*; do
  if [ -f "$file" ] && [ "${file##*.}" != "sh" ]; then
    basename=$(basename "$file")
    ln -sF "$file" "$SUBLIME_SETTINGS_PATH/$basename"
  fi
done