#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

ram_low_fg_color=""
ram_medium_fg_color="#[fg=yellow]"
ram_high_fg_color="#[fg=red]"

ram_medium_threshold="30"
ram_high_threshold="80"

get_fg_color() {
  local ram_percentage
  ram_percentage=$("$CURRENT_DIR/ram_real_percentage.sh" | tr -d '%')

  ram_low_fg_color=$(get_tmux_option "@ram_real_low_fg_color" "$ram_low_fg_color")
  ram_medium_fg_color=$(get_tmux_option "@ram_real_medium_fg_color" "$ram_medium_fg_color")
  ram_high_fg_color=$(get_tmux_option "@ram_real_high_fg_color" "$ram_high_fg_color")
  ram_medium_threshold=$(get_tmux_option "@ram_real_medium_threshold" "$ram_medium_threshold")
  ram_high_threshold=$(get_tmux_option "@ram_real_high_threshold" "$ram_high_threshold")

  if (( $(echo "$ram_percentage >= $ram_high_threshold" | bc -l) )); then
    echo "$ram_high_fg_color"
  elif (( $(echo "$ram_percentage >= $ram_medium_threshold" | bc -l) )); then
    echo "$ram_medium_fg_color"
  else
    echo "$ram_low_fg_color"
  fi
}

main() {
  get_fg_color
}
main
