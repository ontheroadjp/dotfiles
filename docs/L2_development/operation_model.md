# Operation Model

## Installation

There is no repository-wide installer.

1. Clone at `${HOME}/dotfiles` (`home/zsh/.zshenv:9-11`).
2. Link desired startup/config files into the home directory.
3. Review platform-specific files before applying them.
4. For Ubuntu/GNOME T480s, review and run `./t480s_apps.sh`, then `./t480s.sh`.
5. Start a login shell with `zsh -il`.

The exact symlink creation procedure is unconfirmed because no tracked installer implements it.

## Development Commands

```sh
zsh -n home/zsh/.zshenv home/zsh/.zshrc home/zsh/.zprofile
bash -n t480s.sh t480s_apps.sh bin/health-check.sh
git diff --check
```

`.zshenv` establishes shared paths and helpers. `.zshrc` loads prompt-critical files synchronously and schedules most modules through `zsh-defer` (`home/zsh/.zshenv:9-114`, `home/zsh/.zshrc:53-76`).
