#!/usr/bin/env bash

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$current_dir/utils.sh"

# return current working directory of tmux pane
getPaneDir() {
  nextone="false"
  ret=""
  for i in $(tmux list-panes -F "#{pane_active} #{pane_current_path}"); do
    [ "$i" == "1" ] && nextone="true" && continue
    [ "$i" == "0" ] && nextone="false"
    [ "$nextone" == "true" ] && ret+="$i "
  done
  echo "${ret%?}"
}

main() {
  path="$(getPaneDir)"

  if [[ "$path" == "$HOME" ]]; then
    echo "~"
    return
  fi

  # change '/home/user' to '~'
  cwd="${path/"${HOME}/"/'~/'}"

  # Limit trailing directory components. 0 means unlimited.
  cwd_max_dirs="$(get_tmux_option "@ukiyo-cwd-max-dirs" "0")"
  if [[ "$cwd_max_dirs" -gt 0 ]]; then
    base_to_erase=$cwd
    for ((i = 0; i < cwd_max_dirs; i++)); do
      base_to_erase="${base_to_erase%/*}"
    done
    # Preserve the root / and home ~/ prefixes for unshortened paths.
    if [[ ${#base_to_erase} -gt 1 ]]; then
      cwd="…/${cwd:${#base_to_erase}+1}"
    fi
  fi

  # Match Dracula: the truncation marker is additional to the character limit.
  cwd_max_chars="$(get_tmux_option "@ukiyo-cwd-max-chars" "0")"
  if [[ "$cwd_max_chars" -gt 0 && "${#cwd}" -gt "$cwd_max_chars" ]]; then
    cwd="…/…${cwd:(- cwd_max_chars)}"
  fi

  echo "$cwd"
}

#run main driver program
main
