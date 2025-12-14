#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cpu_real_percentage="#($CURRENT_DIR/scripts/cpu_real_percentage.sh)"
cpu_real_fg_color="#($CURRENT_DIR/scripts/cpu_real_fg_color.sh)"

cpu_real_percentage_interpolation="\#{cpu_real_percentage}"
cpu_real_fg_color_interpolation="\#{cpu_real_fg_color}"

do_interpolation() {
  local string="$1"
  string="${string/$cpu_real_percentage_interpolation/$cpu_real_percentage}"
  string="${string/$cpu_real_fg_color_interpolation/$cpu_real_fg_color}"
  echo "$string"
}

update_tmux_option() {
  local option="$1"
  local option_value
  option_value=$(tmux show-option -gqv "$option")
  local new_option_value
  new_option_value=$(do_interpolation "$option_value")
  tmux set-option -gq "$option" "$new_option_value"
}

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}
main
