#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

source "$ROOT_DIR/scripts/utils.sh"

# Family registry: "id|key|label"
FAMILIES=(
  "nord|N|Nord"
  "gruvbox|G|Gruvbox"
  "rose-pine|R|Rose Pine"
  "solarized|S|Solarized"
  "onedark|O|OneDark"
  "kanagawa|K|Kanagawa"
  "tokyonight|T|Tokyo Night"
  "catppuccin|C|Catppuccin"
  "dracula|D|Dracula"
  "bru|B|Bru"
  "jozi-city-nights|J|Jozi City Nights"
)

# Echo variants for a family, one per line: "variant_id:Label"
get_variants() {
  case "$1" in
  nord) echo "default:Default" ;;
  gruvbox) printf '%s\n' "dark:Dark" "light:Light" ;;
  rose-pine) printf '%s\n' "main:Main" "moon:Moon" "dawn:Dawn" ;;
  solarized) printf '%s\n' "dark:Dark" "light:Light" ;;
  onedark) printf '%s\n' "dark:Dark" "darker:Darker" "cool:Cool" "deep:Deep" "warm:Warm" "warmer:Warmer" ;;
  kanagawa) printf '%s\n' "wave:Wave" "dragon:Dragon" "lotus:Lotus" ;;
  tokyonight) printf '%s\n' "moon:Moon" "storm:Storm" "night:Night" ;;
  catppuccin) printf '%s\n' "mocha:Mocha" "macchiato:Macchiato" "frappe:Frappé" "latte:Latte" ;;
  dracula) echo "classic:Classic" ;;
  bru) printf '%s\n' "espresso:Espresso" "latte:Latte" ;;
  jozi-city-nights) printf '%s\n' "nights:Nights" "midnight:Midnight" "morning:Morning" ;;
  esac
}

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

get_current_theme() {
  local t=$(get_tmux_option "@ukiyo-theme" "wave")
  case "$t" in
  wave | dragon | lotus) t="kanagawa/$t" ;;
  esac
  echo "$t"
}

render_top() {
  local current_theme=$(get_current_theme)
  local args=("" "")
  local entry id key label marker prefix
  for entry in "${FAMILIES[@]}"; do
    IFS='|' read -r id key label <<<"$entry"
    prefix="${id}/"
    marker=""
    if [[ "$current_theme" == "${prefix}"* ]]; then
      marker="*"
    fi
    args+=("${label}${marker} >" "$key" "run -b 'UKIYO_MENU_FAMILY=${id} #{@ukiyo-root}/menu_items/colors.sh'")
  done
  args+=("" "<-- Back" "b" "run -b '#{@ukiyo-root}/menu_items/main.sh'" "Close menu" "q" "")
  tmux display-menu -T "#[align=centre fg=green]Themes" -x R -y P "${args[@]}"
}

render_family() {
  local family=$1
  local current_theme=$(get_current_theme)
  local entry id key label title=""
  for entry in "${FAMILIES[@]}"; do
    IFS='|' read -r id key label <<<"$entry"
    if [ "$id" = "$family" ]; then
      title="$label"
      break
    fi
  done
  if [ -z "$title" ]; then
    return 1
  fi

  local args=("" "")
  local i=1 v vid vlabel marked
  while IFS= read -r v; do
    [ -z "$v" ] && continue
    IFS=':' read -r vid vlabel <<<"$v"
    marked=$(mark_if_active "$current_theme" "${family}/${vid}" "$vlabel")
    args+=("$marked" "$i" "run -b '#{@ukiyo-root}/scripts/actions.sh set_state_and_tmux_option theme ${family}/${vid}'")
    i=$((i + 1))
  done < <(get_variants "$family")
  args+=("" "<-- Back" "b" "run -b '#{@ukiyo-root}/menu_items/colors.sh'" "Close menu" "q" "")
  tmux display-menu -T "#[align=centre fg=green]$title" -x R -y P "${args[@]}"
}

if [ -n "$UKIYO_MENU_FAMILY" ]; then
  render_family "$UKIYO_MENU_FAMILY"
  unset UKIYO_MENU_FAMILY
else
  render_top
fi
