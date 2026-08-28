#!/usr/bin/env bash

CURRENT_FILE="${BASH_SOURCE[0]}"
CURRENT_DIR="$(dirname -- "$(readlink -f -- "$0")")"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

source "$ROOT_DIR/scripts/utils.sh"
source "$ROOT_DIR/scripts/state.sh"

options=("show-powerline" "show-fahrenheit" "military-time" "show-flags")
titles=("Powerline" "Fahrenheit" "Military Time" "Flags")

get_option_title() {
  local option=$1
  local name=""
  for i in "${!options[@]}"; do
    if [[ "${options[$i]}" == "$option" ]]; then
      name="${titles[$i]}"
      break
    fi
  done

  if [[ $(read_option_from_state "$option") == true ]]; then
    echo "Hide $name"
  else
    echo "Show $name"
  fi
}

render() {
  tmux display-menu -T "#[align=centre fg=green]Options" -x R -y P \
    "$(get_option_title show-powerline)" A "run -b '$ROOT_DIR/scripts/actions.sh toggle_option show-powerline; $CURRENT_FILE'" \
    "$(get_option_title show-fahrenheit)" B "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_option show-fahrenheit; tmux display-message \"Weather will be updated after next fetch.\"; $CURRENT_FILE'" \
    "$(get_option_title military-time)" C "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_option military-time; $CURRENT_FILE'" \
    "$(get_option_title show-flags)" D "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_option show-flags; $CURRENT_FILE'" \
    "" \
    "<-- Back" b "run -b '#{@ukiyo-root}/menu_items/main.sh'" \
    "Close menu" q ""
}

render
