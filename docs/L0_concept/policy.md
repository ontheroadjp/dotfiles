# Policy

## Performance

Keep prompt-critical Zsh work synchronous and defer nonessential modules. Measure startup changes because the loader separates synchronous and deferred files (`home/zsh/.zshrc:53-76`).

## Portability And Safety

- Keep OS-specific behavior isolated (`home/zsh/zsh.d/core/zsh.zsh:23-36`).
- Review setup scripts before execution: they use `sudo`, modify services, and download remote installers (`t480s_apps.sh:9-127`).
- Do not commit credentials or machine-generated account state without explicit review.
- Preserve unrelated changes in a dirty worktree.

## Verification

No CI or test suite is tracked. Validate shell files with `zsh -n` or `bash -n`, validate configuration with the owning application when available, and run `git diff --check`.
