#!/usr/bin/env bash

set -e
#st -o pipefail
#set -ux

JAVA_SYMLINKS_DIR="$HOME"/.java

sed -i -e 's/sdkman_auto_answer=false/sdkman_auto_answer=true/g' "$HOME"/.sdkman/etc/config
mkdir -p "$JAVA_SYMLINKS_DIR"

source "$HOME"/.sdkman/bin/sdkman-init.sh
echo "Updating sdkman..."
sdk update
source "$HOME"/.sdkman/bin/sdkman-init.sh

versions_to_delete=$(sdk list java | grep "local only" | cut -c 62-)
java_versions_to_install=$(sdk list java | grep "hs-adpt" | grep -v "sdk install" | grep -v "installed" | cut -c 62-)
graalvm_versions_to_install=$(sdk list java | grep grl | head -2 | grep -v "installed" | cut -c 62-)

echo "##############################"

echo "Java versions to be deleted:"
echo "$versions_to_delete"

echo "##############################"

echo "Java versions to be installed:"
echo "$java_versions_to_install"
echo "$graalvm_versions_to_install"

read -r -p "Do you want to continue? [y/N] " response
case "$response" in
[yY][eE][sS] | [yY])
  #just continue
  ;;
*)
  echo "Java upgrade stopped."
  exit 1
  ;;
esac

delete_for_each() {
  versions=$*;
  for version in $versions
  do
    sdk uninstall java "$version"
  done
}

install_for_each() {
  versions=$*;
  for version in $versions
  do
    install_java_using_sdk "$version"
  done
}

install_java_using_sdk() {
	version=$*;
	echo "Installing java version = $version"
  sdk install java "$version"
	major_version=$(cut -d. -f1 <<< "$version")
	symlink_base_name="java"
	if [[ $version == *"grl"* ]]; then
	  graalvm_version=$(cut -d "r" -f2- <<< "$version")
    symlink_base_name="graalvm-$graalvm_version-"
  fi
  ln -sf "$HOME"/.sdkman/candidates/java/"$version" "$JAVA_SYMLINKS_DIR"/"$symlink_base_name""$major_version"
}

verify_symlinks() {
  bad_symlinks=()
  for symlink in "$JAVA_SYMLINKS_DIR"/*; do
    if [[ ! -e "$symlink" ]]; then
      bad_symlinks+=("$symlink")
    fi
  done

  if [ "${#bad_symlinks[@]}" -ne 0 ]; then
    echo -e "\nFound bad symlinks, please run the following command to remove them:"
  fi
  for bad_symlink in "${bad_symlinks[@]}"; do
    echo "rm $bad_symlink"
  done
}

display_symlinks() {
  echo -e "\nThe following symlinks exists:"
  find "$JAVA_SYMLINKS_DIR" -type l -ls | cut -c 91-
}

delete_for_each "$versions_to_delete"

install_for_each "$graalvm_versions_to_install"
install_for_each "$java_versions_to_install"

verify_symlinks
display_symlinks

sdk flush

echo "Please remember macOS doesn't allow choosing symlink from file picker. Please remember to alter file manually:"
echo "${HOME}/Library/ApplicationSupport/JetBrains/_current_intellij_version/options/jdk.table.xml"
