#!/usr/bin/env bash

if ! git ls-files >& /dev/null; then
  echo "Not a git repository."
  exit 1
fi

if [[ -n $(git status -s) ]]; then
  if test -f "git_real_diff_marker.txt"; then
    echo "diff file exists."
    git fresh > /dev/null 2>&1
  else
    echo "There are changes present. Real diff stopped."
    exit 1
  fi
fi

passed_target_branch_name=$1
if [[ -z $passed_target_branch_name ]]; then
  target_branch="develop"
else
  target_branch=$passed_target_branch_name
fi


echo "target_branch="$target_branch""

git pull
exists=$(git show-ref refs/heads/"$target_branch")
if [ -n "$exists" ]; then
    git checkout "$target_branch"
else
    git checkout -t origin/"$target_branch"
fi
