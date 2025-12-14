#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# CPU variables
cpu_real_percentage="#($CURRENT_DIR/scripts/cpu_real_percentage.sh)"
cpu_real_fg_color="#($CURRENT_DIR/scripts/cpu_real_fg_color.sh)"

# RAM variables
ram_real_percentage="#($CURRENT_DIR/scripts/ram_real_percentage.sh)"
ram_real_fg_color="#($CURRENT_DIR/scripts/ram_real_fg_color.sh)"

# Interpolation patterns
cpu_real_percentage_interpolation="\#{cpu_real_percentage}"
cpu_real_fg_color_interpolation="\#{cpu_real_fg_color}"
ram_real_percentage_interpolation="\#{ram_real_percentage}"
ram_real_fg_color_interpolation="\#{ram_real_fg_color}"

do_interpolation() {
  local string="$1"
  # CPU interpolations
  string="${string/$cpu_real_percentage_interpolation/$cpu_real_percentage}"
  string="${string/$cpu_real_fg_color_interpolation/$cpu_real_fg_color}"
  # RAM interpolations
  string="${string/$ram_real_percentage_interpolation/$ram_real_percentage}"
  string="${string/$ram_real_fg_color_interpolation/$ram_real_fg_color}"
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
