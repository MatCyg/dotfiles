#!/usr/bin/env bash

if ! git ls-files >& /dev/null; then
  echo "Not a git repository."
  exit 1
fi

current_branch="$(git rev-parse --abbrev-ref HEAD)"

git branch | grep -v develop | grep -v "$current_branch" | xargs git branch -D