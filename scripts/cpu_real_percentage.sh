#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

cpu_percentage_format="%3.1f%%"

print_cpu_percentage() {
  cpu_percentage_format=$(get_tmux_option "@cpu_real_percentage_format" "$cpu_percentage_format")

  # Read /proc/stat twice with a 1 second interval to get accurate usage
  read_cpu_stats() {
    awk '/^cpu / {print $2, $3, $4, $5, $6, $7, $8}' /proc/stat
  }

  # First reading
  read -r user1 nice1 system1 idle1 iowait1 irq1 softirq1 <<< "$(read_cpu_stats)"

  sleep 1

  # Second reading
  read -r user2 nice2 system2 idle2 iowait2 irq2 softirq2 <<< "$(read_cpu_stats)"

  # Calculate deltas
  user_delta=$((user2 - user1))
  nice_delta=$((nice2 - nice1))
  system_delta=$((system2 - system1))
  idle_delta=$((idle2 - idle1))
  iowait_delta=$((iowait2 - iowait1))
  irq_delta=$((irq2 - irq1))
  softirq_delta=$((softirq2 - softirq1))

  # Total CPU time (excluding iowait from "busy" calculation)
  total=$((user_delta + nice_delta + system_delta + idle_delta + iowait_delta + irq_delta + softirq_delta))
  
  # Active CPU time (user + nice + system + irq + softirq) - excludes idle AND iowait
  active=$((user_delta + nice_delta + system_delta + irq_delta + softirq_delta))

  # Calculate percentage
  if [ "$total" -gt 0 ]; then
    # shellcheck disable=SC2059
    printf "$cpu_percentage_format" "$(echo "scale=1; $active * 100 / $total" | bc)"
  else
    printf "$cpu_percentage_format" "0.0"
  fi
}

main() {
  print_cpu_percentage
}
main
