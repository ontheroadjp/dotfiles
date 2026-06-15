# Consistency Checks

1. Run syntax checks for every changed Zsh or Bash file.
2. Run `git diff --check`.
3. Confirm every sourced path or symlink exists, or document it as external.
4. For startup changes, measure `zsh -i -c exit` repeatedly and verify deferred functions.
5. Parse Vim, tmux, and terminal configuration with the owning application when available.

## Risks

- `bin/` contains absolute symlinks into `/home/diego/repo/github.com/ontheroadjp/shell-tools`.
- Deferred Zsh output can be hidden by `zsh-defer`.
- Workstation scripts download software and modify system state.

No CI workflow exists, so these checks are not automatically enforced.
