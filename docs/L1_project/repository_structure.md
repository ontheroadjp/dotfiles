# Repository Structure

| Path | Responsibility | Evidence |
| --- | --- | --- |
| `.config/` | XDG application settings. | `.config/alacritty/alacritty.toml`, `.config/ripgrep/.ripgreprc` |
| `home/zsh/` | Zsh startup, modules, plugins, and runtime integration. | `home/zsh/.zshenv:9-117`, `home/zsh/.zshrc:50-91` |
| `home/vim/` | Vim entrypoint, fragments, colors, templates, and references. | `home/vim/.vimrc:45-150` |
| `home/tmux/` | tmux configuration and bindings. | `home/tmux/.tmux.conf:1-160` |
| `home/bash/` | Bash startup configuration. | `home/bash/.bashrc`, `home/bash/.bash_profile` |
| `home/hammerspoon/` | macOS Hammerspoon automation. | `home/hammerspoon/.hammerspoon/init.lua` |
| `bin/` | PATH commands; most are absolute symlinks to `shell-tools`. | `home/zsh/.zshrc:19-22`, `bin/bench_zsh` |
| `linux/` | Linux/CentOS setup assets. | `linux/setup_scripts_for_centos7/` |
| `macosx/` | macOS application and Homebrew configuration. | `macosx/homebrew/`, `macosx/karabiner_elements/` |
| `t480s*.sh` | Ubuntu/GNOME package and workstation setup. | `t480s_apps.sh:9-127`, `t480s.sh:7-47` |

No package-manager workspace or monorepo manifest exists.
