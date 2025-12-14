# tmux-cpu-real

# **DISCRAIMER:** made with help of [amp](https://ampcode.com). based on [tmux-plugins/tmux-cpu](https://github.com/tmux-plugins/tmux-cpu)

## [ampcode thread](https://ampcode.com/threads/T-019b1e32-aaf0-7086-bd58-f6ceb8622a8e)

A tmux plugin that shows **real CPU and RAM usage** (CPU excludes I/O wait).

Unlike the standard tmux-cpu plugin which shows `100 - idle` (which includes I/O wait), this plugin shows actual CPU work: `user + nice + system + irq + softirq`.

## Installation

### With TPM (recommended)

Add to your `.tmux.conf`:

```bash
set -g @plugin 'arpangreat/tmux-cpu-real'
```

### Manual

```bash
git clone https://github.com/arpangreat/tmux-cpu-real ~/tmux-cpu-real
```

Add to `.tmux.conf`:

```bash
run-shell ~/tmux-cpu-real/cpu-real.tmux
```

## Usage

Add to your `status-right` or `status-left`:

```bash
set -g status-right "#{cpu_real_fg_color}CPU: #{cpu_real_percentage}|#{ram_real_fg_color}MEM: #{ram_real_percentage}|#[fg=cyan]%A #[fg=orange]%d-%m-%Y"
```

## Variables

| Variable                 | Description                         |
| ------------------------ | ----------------------------------- |
| `#{cpu_real_percentage}` | CPU percentage (excluding I/O wait) |
| `#{cpu_real_fg_color}`   | Foreground color based on CPU usage |
| `#{ram_real_percentage}` | RAM percentage (used / total)       |
| `#{ram_real_fg_color}`   | Foreground color based on RAM usage |

## Options

### CPU Options

```bash
# Percentage format (default: "%3.1f%%")
set -g @cpu_real_percentage_format "%3.1f%%"

# Color thresholds
set -g @cpu_real_medium_threshold "30"
set -g @cpu_real_high_threshold "80"

# Colors
set -g @cpu_real_low_fg_color ""
set -g @cpu_real_medium_fg_color "#[fg=yellow]"
set -g @cpu_real_high_fg_color "#[fg=red]"
```

### RAM Options

```bash
# Percentage format (default: "%3.1f%%")
set -g @ram_real_percentage_format "%3.1f%%"

# Color thresholds
set -g @ram_real_medium_threshold "30"
set -g @ram_real_high_threshold "80"

# Colors
set -g @ram_real_low_fg_color ""
set -g @ram_real_medium_fg_color "#[fg=yellow]"
set -g @ram_real_high_fg_color "#[fg=red]"
```

## Difference from tmux-cpu

| Metric | tmux-cpu                         | tmux-cpu-real                                        |
| ------ | -------------------------------- | ---------------------------------------------------- |
| CPU    | `100 - idle` (includes I/O wait) | `user + nice + system + irq + softirq` (no I/O wait) |
| RAM    | Same                             | Same                                                 |

This makes the CPU reading consistent with tools like `btop` and `htop`.

## License

MIT
