

function set_default_java_and_run_command() {
  java_version_to_set=$1
  # shellcheck disable=SC2124
  remaining_args="${@:2}"

  current_sdkman_java_path=$(readlink "$HOME"/.sdkman/candidates/java/current)
  currently_set_java_version=$(basename $current_sdkman_java_path)

  if [ "$currently_set_java_version" = "$java_version_to_set" ]; then
    echo "Default java version already set to $java_version_to_set."

  else
    echo "Setting up default java version to $java_version_to_set..."
    sdk default java "$java_version_to_set"
  fi

#  java -version

  if [ -n "$remaining_args" ];then
    # shellcheck disable=SC2068
    # pass remaining args
    java ${@:2}
  fi
}

# shellcheck disable=SC2044
rm -f "$JAVA_ALIASES_PATH"
type set_default_java_and_run_command | sed 1d >> "$JAVA_ALIASES_PATH"
for java_symlink in $(find "$JAVA_SYMLINKS_DIR" -type l); do
    alias_name=$(basename "$java_symlink")
    sdkman_java_version=$(basename "$(readlink "$java_symlink")")

#    echo "$alias_name -> $sdkman_java_version"

    # shellcheck disable=SC2139
    # shellcheck disable=SC2140
    echo "alias $alias_name='set_default_java_and_run_command $sdkman_java_version'" >> "$JAVA_ALIASES_PATH"
done

echo -e "\nCreated the following aliases:"
grep alias "$JAVA_ALIASES_PATH"