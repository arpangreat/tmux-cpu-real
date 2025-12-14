# **DISCLAIMER:** ampcode was used create this plugin. Based on tmux-plugins/tmux-cpu

# tmux-cpu-real

A tmux plugin that shows **real CPU usage** (excluding I/O wait).

Unlike the standard tmux-cpu plugin which shows `100 - idle` (which includes I/O wait), this plugin shows actual CPU work: `user + nice + system + irq + softirq`.

## Installation

### With TPM (recommended)

Add to your `.tmux.conf`:

```bash
set -g @plugin 'arpangreat/tmux-cpu-real'
```

### Manual

```bash
git clone https://github.com/arpangreat/tmux-cpu-real ~/.tmux/plugins/tmux-cpu-real
```

Add to `.tmux.conf`:

```bash
run-shell ~/.tmux/plugins/tmux-cpu-real/cpu-real.tmux
```

## Usage

Add to your `status-right` or `status-left`:

```bash
set -g status-right "#{cpu_real_fg_color}CPU: #{cpu_real_percentage}"
```

## Variables

| Variable                 | Description                         |
| ------------------------ | ----------------------------------- |
| `#{cpu_real_percentage}` | CPU percentage (excluding I/O wait) |
| `#{cpu_real_fg_color}`   | Foreground color based on CPU usage |

## Options

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

## Difference from tmux-cpu

| Tool          | Formula                                | Includes I/O wait |
| ------------- | -------------------------------------- | ----------------- |
| tmux-cpu      | `100 - idle`                           | ✅ Yes            |
| tmux-cpu-real | `user + nice + system + irq + softirq` | ❌ No             |
