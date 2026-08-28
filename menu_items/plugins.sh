#!/usr/bin/env bash

CURRENT_FILE="${BASH_SOURCE[0]}"
CURRENT_DIR="$(dirname -- "$(readlink -f -- "$0")")"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

source "$ROOT_DIR/scripts/utils.sh"

available_plugins="battery cpu-usage git gpu-usage ram-usage tmux-ram-usage network network-bandwidth network-ping ssh-session attached-clients network-vpn openconnect weather time mpc spotify-tui playerctl kubernetes-context synchronize-panes"

get_plugin_title() {
  local plugin=$1
  local active_plugins=$(get_tmux_option "@ukiyo-plugins" "")
  if [[ $active_plugins == *"$plugin"* ]]; then
    echo "Hide $plugin"
  else
    echo "Show $plugin"
  fi
}

render() {
  tmux display-menu -T "#[align=centre fg=green]Plugins" -x R -y P \
    "" \
    "" \
    "$(get_plugin_title "battery")" A "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin battery; $CURRENT_FILE" \
    "$(get_plugin_title "cpu-usage")" B "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin cpu-usage; $CURRENT_FILE" \
    "$(get_plugin_title "git")" C "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin git; $CURRENT_FILE" \
    "$(get_plugin_title "gpu-usage")" D "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin gpu-usage; $CURRENT_FILE" \
    "$(get_plugin_title "ram-usage")" E "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin ram-usage; $CURRENT_FILE" \
    "$(get_plugin_title "tmux-ram-usage")" F "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin tmux-ram-usage; $CURRENT_FILE" \
    "$(get_plugin_title "network")" G "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin network; $CURRENT_FILE" \
    "$(get_plugin_title "network-bandwidth")" H "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin network-bandwidth; $CURRENT_FILE" \
    "$(get_plugin_title "network-ping")" I "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin network-ping; $CURRENT_FILE" \
    "$(get_plugin_title "ssh-session")" J "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin ssh-session; $CURRENT_FILE" \
    "$(get_plugin_title "attached-clients")" K "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin attached-clients; $CURRENT_FILE" \
    "$(get_plugin_title "network-vpn")" L "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin network-vpn; $CURRENT_FILE" \
    "$(get_plugin_title "weather")" M "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin weather; $CURRENT_FILE" \
    "$(get_plugin_title "time")" N "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin time; $CURRENT_FILE" \
    "$(get_plugin_title "mpc")" O "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin mpc; $CURRENT_FILE" \
    "$(get_plugin_title "spotify-tui")" P "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin spotify-tui; $CURRENT_FILE" \
    "$(get_plugin_title "playerctl")" Q "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin playerctl; $CURRENT_FILE" \
    "$(get_plugin_title "kubernetes-context")" R "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin kubernetes-context; $CURRENT_FILE" \
    "$(get_plugin_title "synchronize-panes")" S "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin synchronize-panes; $CURRENT_FILE" \
    "$(get_plugin_title "openconnect")" T "run -b '#{@ukiyo-root}/scripts/actions.sh toggle_plugin openconnect; $CURRENT_FILE" \
    "" \
    "<-- Back" b "run -b '#{@ukiyo-root}/menu_items/main.sh" \
    "Close menu" q ""
}

render
