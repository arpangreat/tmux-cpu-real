#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

ram_percentage_format="%3.1f%%"

print_ram_percentage() {
  ram_percentage_format=$(get_tmux_option "@ram_real_percentage_format" "$ram_percentage_format")

  # Read memory info from /proc/meminfo
  local mem_total mem_available mem_used percentage

  mem_total=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
  mem_available=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)

  # Calculate used memory (total - available)
  mem_used=$((mem_total - mem_available))

  # Calculate percentage
  if [ "$mem_total" -gt 0 ]; then
    percentage=$(echo "scale=1; $mem_used * 100 / $mem_total" | bc)
    # shellcheck disable=SC2059
    printf "$ram_percentage_format" "$percentage"
  else
    printf "$ram_percentage_format" "0.0"
  fi
}

main() {
  print_ram_percentage
}
main
