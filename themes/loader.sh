#!/usr/bin/env bash
# Theme loader - loads palette and variant for a given theme

load_theme() {
  local theme_name=$1
  local variant=$2
  local themes_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local theme_dir="${themes_dir}/${theme_name}"

  if [ ! -d "$theme_dir" ]; then
    echo "Theme not found: $theme_name" >&2
    return 1
  fi

  # Source palette (raw color definitions)
  if [ -f "${theme_dir}/palette.sh" ]; then
    source "${theme_dir}/palette.sh"
  fi

  # Source variant (semantic color mapping)
  if [ -f "${theme_dir}/${variant}.sh" ]; then
    source "${theme_dir}/${variant}.sh"
  else
    echo "Variant not found: $variant for theme $theme_name" >&2
    return 1
  fi
}

# Get default variant for a theme
get_default_variant() {
  local theme_name=$1
  case $theme_name in
  kanagawa) echo "wave" ;;
  tokyonight) echo "moon" ;;
  catppuccin) echo "mocha" ;;
  dracula) echo "classic" ;;
  nord) echo "default" ;;
  gruvbox) echo "dark" ;;
  rose-pine) echo "main" ;;
  solarized) echo "dark" ;;
  onedark) echo "dark" ;;
  bru) echo "espresso" ;;
  *) echo "default" ;;
  esac
}
