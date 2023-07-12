#!/usr/bin/env bash

if ! git ls-files >& /dev/null; then
  echo "Not a git repository."
  exit 1
fi

if [[ -n $(git status -s) ]]; then
  echo "There are changes present. Real diff stopped."
  exit 1
fi

passed_branch_name=$1
shouldForce=$2
if [[ -z $passed_branch_name ]]; then
  diff_branch=$(git branch -r --format "%(refname:short)" | fzf)
else
  diff_branch=$passed_branch_name
fi

current_branch="$(git rev-parse --abbrev-ref HEAD)"

if [ "$shouldForce" != "-f" ] && [ "$current_branch" != "master" ] && [ "$current_branch" != "develop" ]; then
  read -r -p "Current branch is '$current_branch'. Are you sure you want to do the diff against that branch? [y/n] " response
  case "$response" in
  [yY][eE][sS] | [yY])
    #just continue
    ;;
  *)
    echo "Real diff stopped."
    exit 1
    ;;
  esac
fi

# check if git merge is needed
commitsBehind=$(git rev-list --left-only --count "$current_branch...$diff_branch")
test "$commitsBehind" = 0
shouldMergeBeforeDiff=$?
if [ "$shouldMergeBeforeDiff" -eq 0 ]; then
  echo "Target branch is up to date with current branch."
  git diff --binary "$current_branch" "$diff_branch" >/tmp/git-real-diff.patch
else
  echo "Target branch is not up to date with current branch. Started automatic merge process."
  git checkout -b git-real-diff-merge-branch "$diff_branch" > /dev/null 2>&1
  git merge --no-commit --no-ff "$current_branch" > /dev/null 2>&1
  areThereConflicts=$?
  git merge --abort
  if [ $areThereConflicts -eq 0 ]; then
    git merge "$current_branch" --no-edit > /dev/null 2>&1
    git checkout "$current_branch" > /dev/null 2>&1
    git diff --binary "$current_branch" git-real-diff-merge-branch >/tmp/git-real-diff.patch
    git branch -D git-real-diff-merge-branch > /dev/null 2>&1
    echo "Automatic merge successful."
  else
    git checkout "$current_branch" > /dev/null 2>&1
    git branch -D git-real-diff-merge-branch > /dev/null 2>&1
    echo "Automatic merge is impossible because of conflicts. Exiting..."
    exit 1
  fi
fi

git apply /tmp/git-real-diff.patch
git add .

echo "Diff executed from branch $diff_branch onto $current_branch."
