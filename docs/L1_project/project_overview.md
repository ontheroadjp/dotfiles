# Project Overview

## Scope

- Zsh startup, aliases, deferred modules, completion, and runtime integration (`home/zsh/.zshenv`, `home/zsh/.zshrc`, `home/zsh/zsh.d/`).
- Vim configuration, mappings, UI fragments, templates, and bundled references (`home/vim/.vimrc:45-150`).
- tmux bindings, terminal capabilities, popups, and sessions (`home/tmux/.tmux.conf:1-160`).
- CLI application configuration under `.config/`.
- Linux/macOS workstation configuration (`t480s.sh`, `t480s_apps.sh`, `linux/`, `macosx/`).
- Commands in `bin/`, mostly symlinked to the separate `shell-tools` repository.

## Technology And Entry Points

Primary languages are Zsh, Bash, Vimscript, Lua, and application-specific formats. No root package manifest or lock file exists.

- Zsh: `home/zsh/.zshenv`, `home/zsh/.zshrc`, `home/zsh/.zprofile`
- Vim: `home/vim/.vimrc`
- tmux: `home/tmux/.tmux.conf`
- Workstation setup: `t480s_apps.sh`, `t480s.sh`
- Network utility: `bin/health-check.sh`

No `.github/workflows` definitions or automated tests were detected.
