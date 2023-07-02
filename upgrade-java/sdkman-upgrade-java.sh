#!/usr/bin/env bash

set -e

SCRIPT_PATH=$(dirname "$0")
JAVA_SYMLINKS_DIR="$HOME"/.java

remove_symlinks() {
  for symlink in "$JAVA_SYMLINKS_DIR"/*; do
    if [ -L "$symlink" ]; then
      rm $symlink
    fi
  done
}

create_symlinks() {
  versions=$(ls "$HOME"/.sdkman/candidates/java/ | grep -v "current")

  for version in $versions
  do
    major_version=$(echo $version | cut -d. -f1 | cut -d- -f1)
    symlink_base_name="java"
    if [[ $version == *"graalce"* ]]; then
      symlink_base_name="graal"
    fi
    ln -sf "$HOME"/.sdkman/candidates/java/"$version" "$JAVA_SYMLINKS_DIR"/"$symlink_base_name""$major_version"
  done
}

display_symlinks() {
  echo -e "\nThe following symlinks exists:"
  for java_symlink in $(find "$JAVA_SYMLINKS_DIR" -type l); do
    echo "$java_symlink -> $(readlink "$java_symlink")"
  done
}

sed -i -e 's/sdkman_auto_answer=false/sdkman_auto_answer=true/g' "$HOME"/.sdkman/etc/config
mkdir -p "$JAVA_SYMLINKS_DIR"

source "$HOME"/.sdkman/bin/sdkman-init.sh
echo "Updating sdkman..."
sdk update
source "$HOME"/.sdkman/bin/sdkman-init.sh

# testing
#installedVersions=$(sdk list java | grep "installed" |  cut -c 62-)
#for version in $installedVersions
#do
#  sdk uninstall java $version
#done

echo -e "\nVerifying default java..."
topVersion=$(sdk list java | grep "tem" | grep "installed" | head -n 1 | cut -c 62-)
if [ -z $topVersion]
then
  topVersion=$(sdk list java | grep "tem" | head -n 1 | cut -c 62-)
  sdk install java $topVersion
fi
sdk default java $topVersion
echo ""

java $SCRIPT_PATH/InstallNewestJavaVersions.java

remove_symlinks
create_symlinks
display_symlinks

"$SCRIPT_PATH"/java-aliases.sh

sdk flush > /dev/null 2>&1

echo -e "\nPlease remember to update IntelliJ java SDKs manually..."

