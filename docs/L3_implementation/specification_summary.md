# Specification Summary

## Zsh

`home/zsh/.zshenv` defines repository paths, XDG locations, unique PATH handling, compilation helpers, and loads `zsh-defer` (`home/zsh/.zshenv:9-114`). `.zshrc` configures history, aliases, prompt loading, deferred core modules, and Node/Python integration (`home/zsh/.zshrc:1-91`).

Core behavior under `home/zsh/zsh.d/core/` includes navigation, Git, Docker, fuzzy finding, AI CLI wrappers, and OS-specific settings. Most modules are deferred (`home/zsh/.zshrc:53-76`). Node activation uses mise (`home/zsh/zsh.d/dev/node.zsh:32-33`).

## Vim And tmux

Vim configures UTF-8, ripgrep, clipboard, indentation, and modular UI files (`home/vim/.vimrc:73-137`). tmux disables automatic renaming, rebuilds bindings, uses `tmux-256color`, refreshes `SESSION_MANAGER` when clients attach, and defines popup sessions (`home/tmux/.tmux.conf:1-160`).

## Workstation Setup

`t480s_apps.sh` installs Ubuntu packages and external tools, including mise with Node 24, keyd, ghq, Claude Code, Codex, Chrome, and yt-dlp (`t480s_apps.sh:9-127`). `t480s.sh` applies GNOME settings and battery thresholds (`t480s.sh:7-47`).

## External Dependencies

Most `bin/` commands are absolute symlinks to the separate `ontheroadjp/shell-tools` checkout. Their implementations and versions are unconfirmed in this repository.
