# Concept

## Purpose

This repository centralizes personal shell, editor, terminal, and workstation configuration for reproducible Linux and macOS environments. Its documented core scope is Bash/Zsh, tmux, Vim, Git, and Docker configuration (`README.md:1-5`).

## Users And Constraints

The confirmed user is the repository owner. Paths assume `~/dotfiles`, `~/WORKSPACE`, and externally cloned repositories (`home/zsh/.zshenv:9-11`, `home/zsh/.zshrc:19-22`).

- Interactive shell latency is a first-class concern: prompt-critical files load synchronously and most modules use `zsh-defer` (`home/zsh/.zshrc:53-76`).
- Configuration is split by tool and OS rather than packaged as one application (`home/`, `.config/`, `linux/`, `macosx/`).
- `bin/` intentionally exposes commands from external repositories through symlinks.

## Unconfirmed

- Licensing terms: no tracked license file exists.
- Supported OS versions: Ubuntu-style and macOS configuration exist, but no version matrix is defined.
