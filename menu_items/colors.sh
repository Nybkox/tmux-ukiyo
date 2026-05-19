#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

source "$ROOT_DIR/scripts/utils.sh"

mark_if_active() {
  local current=$1
  local check=$2
  local label=$3
  if [ "$current" = "$check" ]; then
    echo "${label}*"
  else
    echo "$label"
  fi
}

render() {
  local current_theme=$(get_tmux_option "@ukiyo-theme" "wave")

  # Normalize legacy values
  case "$current_theme" in
  wave | dragon | lotus)
    current_theme="kanagawa/$current_theme"
    ;;
  esac

  # Nord variants
  local n_default=$(mark_if_active "$current_theme" "nord/default" "Nord")

  # Gruvbox variants
  local g_dark=$(mark_if_active "$current_theme" "gruvbox/dark" "Dark")
  local g_light=$(mark_if_active "$current_theme" "gruvbox/light" "Light")

  # Rose Pine variants
  local rp_main=$(mark_if_active "$current_theme" "rose-pine/main" "Main")
  local rp_moon=$(mark_if_active "$current_theme" "rose-pine/moon" "Moon")
  local rp_dawn=$(mark_if_active "$current_theme" "rose-pine/dawn" "Dawn")

  # Solarized variants
  local s_dark=$(mark_if_active "$current_theme" "solarized/dark" "Dark")
  local s_light=$(mark_if_active "$current_theme" "solarized/light" "Light")

  # OneDark variants
  local od_dark=$(mark_if_active "$current_theme" "onedark/dark" "Dark")
  local od_darker=$(mark_if_active "$current_theme" "onedark/darker" "Darker")
  local od_cool=$(mark_if_active "$current_theme" "onedark/cool" "Cool")
  local od_deep=$(mark_if_active "$current_theme" "onedark/deep" "Deep")
  local od_warm=$(mark_if_active "$current_theme" "onedark/warm" "Warm")
  local od_warmer=$(mark_if_active "$current_theme" "onedark/warmer" "Warmer")

  # Kanagawa variants
  local k_wave=$(mark_if_active "$current_theme" "kanagawa/wave" "Wave")
  local k_dragon=$(mark_if_active "$current_theme" "kanagawa/dragon" "Dragon")
  local k_lotus=$(mark_if_active "$current_theme" "kanagawa/lotus" "Lotus")

  # Tokyo Night variants
  local t_moon=$(mark_if_active "$current_theme" "tokyonight/moon" "Moon")
  local t_storm=$(mark_if_active "$current_theme" "tokyonight/storm" "Storm")
  local t_night=$(mark_if_active "$current_theme" "tokyonight/night" "Night")

  # Catppuccin variants
  local c_mocha=$(mark_if_active "$current_theme" "catppuccin/mocha" "Mocha")
  local c_macchiato=$(mark_if_active "$current_theme" "catppuccin/macchiato" "Macchiato")
  local c_frappe=$(mark_if_active "$current_theme" "catppuccin/frappe" "Frappé")
  local c_latte=$(mark_if_active "$current_theme" "catppuccin/latte" "Latte")

  # Dracula variants
  local d_classic=$(mark_if_active "$current_theme" "dracula/classic" "Classic")

  # Bru variants
  local b_espresso=$(mark_if_active "$current_theme" "bru/espresso" "Espresso")
  local b_latte=$(mark_if_active "$current_theme" "bru/latte" "Latte")

  tmux display-menu -T "#[align=centre fg=green]Themes" -x R -y P \
    "" \
    "" \
    "#[align=centre]─── Nord ───" "" "" \
    "$n_default" N "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme nord/default'" \
    "" \
    "#[align=centre]─── Gruvbox ───" "" "" \
    "$g_dark" O "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme gruvbox/dark'" \
    "$g_light" P "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme gruvbox/light'" \
    "" \
    "#[align=centre]─── Rose Pine ───" "" "" \
    "$rp_main" R "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme rose-pine/main'" \
    "$rp_moon" S "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme rose-pine/moon'" \
    "$rp_dawn" D "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme rose-pine/dawn'" \
    "" \
    "#[align=centre]─── Solarized ───" "" "" \
    "$s_dark" V "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme solarized/dark'" \
    "$s_light" B "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme solarized/light'" \
    "" \
    "#[align=centre]─── OneDark ───" "" "" \
    "$od_dark" D "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme onedark/dark'" \
    "$od_darker" G "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme onedark/darker'" \
    "$od_cool" H "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme onedark/cool'" \
    "$od_deep" J "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme onedark/deep'" \
    "$od_warm" K "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme onedark/warm'" \
    "$od_warmer" L "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme onedark/warmer'" \
    "" \
    "#[align=centre]─── Kanagawa ───" "" "" \
    "$k_wave" 1 "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme kanagawa/wave'" \
    "$k_dragon" 2 "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme kanagawa/dragon'" \
    "$k_lotus" 3 "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme kanagawa/lotus'" \
    "" \
    "#[align=centre]─── Tokyo Night ───" "" "" \
    "$t_moon" 4 "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme tokyonight/moon'" \
    "$t_storm" 5 "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme tokyonight/storm'" \
    "$t_night" 6 "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme tokyonight/night'" \
    "" \
    "#[align=centre]─── Catppuccin ───" "" "" \
    "$c_mocha" 7 "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme catppuccin/mocha'" \
    "$c_macchiato" 8 "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme catppuccin/macchiato'" \
    "$c_frappe" 9 "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme catppuccin/frappe'" \
    "$c_latte" 0 "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme catppuccin/latte'" \
    "" \
    "#[align=centre]─── Dracula ───" "" "" \
    "$d_classic" d "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme dracula/classic'" \
    "" \
    "#[align=centre]─── Bru ───" "" "" \
    "$b_espresso" e "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme bru/espresso'" \
    "$b_latte" l "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme bru/latte'" \
    "" \
    "<-- Back" b "run -b 'source #{@ukiyo-root}/menu_items/main.sh'" \
    "Close menu" q ""
}

render
