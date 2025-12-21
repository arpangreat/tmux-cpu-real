# AGENTS.md

## Project Overview
Tmux plugin that displays real CPU and RAM usage (CPU excludes I/O wait). Written in Bash.

## Commands
- **Lint**: `shellcheck scripts/*.sh cpu-real.tmux`
- **Test**: Source in tmux: `tmux source ~/.tmux.conf` then check status bar
- **Manual test**: `./scripts/cpu_real_percentage.sh` or `./scripts/ram_real_percentage.sh`

## Architecture
- `cpu-real.tmux` - Main plugin entry point, handles tmux interpolation
- `scripts/helpers.sh` - Shared utilities (`get_tmux_option`, `set_tmux_option`)
- `scripts/cpu_real_percentage.sh` - CPU usage calculation from /proc/stat
- `scripts/ram_real_percentage.sh` - RAM usage calculation
- `scripts/*_fg_color.sh` - Color output based on usage thresholds

## Code Style
- Use `#!/usr/bin/env bash` shebang
- Source helpers.sh via `CURRENT_DIR` pattern for relative paths
- Use `get_tmux_option` for reading tmux options with defaults
- Format: `local` for local variables, quote variables in comparisons
- Naming: snake_case for variables and functions
- All scripts must be executable (`chmod +x`)
