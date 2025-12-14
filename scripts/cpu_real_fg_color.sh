#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

cpu_low_fg_color="#[fg=green]"
cpu_medium_fg_color="#[fg=yellow]"
cpu_high_fg_color="#[fg=red]"

cpu_low_threshold="30"
cpu_high_threshold="80"

get_fg_color() {
  local cpu_percentage
  cpu_percentage=$("$CURRENT_DIR/cpu_real_percentage.sh" | tr -d '%')

  cpu_low_fg_color=$(get_tmux_option "@cpu_real_low_fg_color" "$cpu_low_fg_color")
  cpu_medium_fg_color=$(get_tmux_option "@cpu_real_medium_fg_color" "$cpu_medium_fg_color")
  cpu_high_fg_color=$(get_tmux_option "@cpu_real_high_fg_color" "$cpu_high_fg_color")
  cpu_low_threshold=$(get_tmux_option "@cpu_real_low_threshold" "$cpu_low_threshold")
  cpu_high_threshold=$(get_tmux_option "@cpu_real_high_threshold" "$cpu_high_threshold")

  if (( $(echo "$cpu_percentage > $cpu_high_threshold" | bc -l) )); then
    echo "$cpu_high_fg_color"
  elif (( $(echo "$cpu_percentage > $cpu_low_threshold" | bc -l) )); then
    echo "$cpu_medium_fg_color"
  else
    echo "$cpu_low_fg_color"
  fi
}

main() {
  get_fg_color
}
main
