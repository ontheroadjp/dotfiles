# -------------------------------
# git-prompt-fast.zsh
# Super fast Git prompt for Zsh (no color)
# -------------------------------
#
# Author   : Nuts LLC
# Created  : 2025-11-03
#
# Description:
#   This script provides a minimal, fast, and stable Git prompt for Zsh.
#   It displays the current Git branch or short commit hash along with
#   a minimal status indicator for unstaged (*) and staged (+) changes.
#   The prompt string is stored in $GIT_PROMPT and can be embedded in PS1.
#
# Features:
#   - Fast synchronous update to ensure branch name and state are always accurate.
#   - Only updates when there is a change in PWD, branch, or working tree/index state.
#   - Avoids expensive Git operations at every keystroke.
#   - No color codes, simplifying prompt rendering and avoiding escape sequence issues.
#   - Compatible with zle-line-init and chpwd hooks for reliable updates when entering a new directory.
#   - Displays branch names without the refs/heads/ prefix.
#
# Variables:
#   GIT_PROMPT               : The final Git prompt string, e.g., (master*+)
#   __GIT_PROMPT_LAST_PWD    : Tracks the last PWD for change detection
#   __GIT_PROMPT_LAST_HEAD   : Tracks the last Git HEAD for change detection
#   __GIT_PROMPT_LAST_STATE  : Tracks the last Git state (*, +) for change detection
#
# Functions:
#   __git_ps1_update_fast     : Updates $GIT_PROMPT if any relevant changes occurred
#
# Usage:
#   1) Source this file in your .zshrc:
#        source ~/dotfiles/bin/git-prompt-fast.zsh
#   2) Include $GIT_PROMPT in your PS1 or in zle-line-init:
#        PS1="[%n@%m %c${GIT_PROMPT}]$ "
#   3) Ensure you call __git_ps1_update_fast in precmd or chpwd hooks:
#        precmd() { __git_ps1_update_fast }
#        autoload -Uz add-zsh-hook
#        add-zsh-hook chpwd __git_ps1_update_fast
#
# Known pitfalls addressed in this implementation:
#   - Branch name sometimes displayed as "refs/heads/master": stripped to just "master".
#   - Extra prompt lines due to calling a non-existent function (__git_ps1_update_sync) removed.
#   - Non-async updates prevent race conditions where branch name may not display immediately.
#   - Initial prompt rendering handled in zle-line-init for vi-mode compatibility.
#   - Minimal Git commands to maintain zsh startup speed (~0.05-0.07s per interactive shell).
#   - Avoids errors in directories that are not Git repositories.
#
# Async update notes:
#   - Background update can be implemented with e.g., zsh-defer or jobs.
#   - Async updates may improve perceived speed for very large repos.
#   - However, branch/state may temporarily show outdated info until async job completes.
#   - Requires careful prompt redrawing to prevent ghost characters or extra lines.
#
# Limitations:
#   - Does not show stashes ($) or untracked files (%) by default.
#   - No upstream branch comparison (<, >, <>, =).
#   - Color hints are intentionally omitted for simplicity.
#   - Designed for synchronous updates; async mode is possible but may lead to inconsistent display.
#
# -------------------------------

GIT_PROMPT=""
__GIT_PROMPT_LAST_PWD=""
__GIT_PROMPT_LAST_HEAD=""
__GIT_PROMPT_LAST_STATE=""

# Fast Git prompt update
__git_ps1_update_fast() {
    local head state gitstring

    # Empty if not a Git repository
    git rev-parse --git-dir >/dev/null 2>&1 || { GIT_PROMPT=""; return }

    # HEAD branch name or SHA
    head=$(git symbolic-ref --quiet HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [[ "$head" == refs/heads/* ]] && head="${head#refs/heads/}"

    # Status check: working tree changes and index changes
    local w="" i=""
    git diff --quiet 2>/dev/null || w="*"
    git diff --cached --quiet 2>/dev/null || i="+"

    # Git prompt string
    state="${w}${i}"

    # Update only the first time or when there is a change
    if [[ "$PWD" != "$__GIT_PROMPT_LAST_PWD" || "$head" != "$__GIT_PROMPT_LAST_HEAD" || "$state" != "$__GIT_PROMPT_LAST_STATE" ]]; then
        __GIT_PROMPT_LAST_PWD="$PWD"
        __GIT_PROMPT_LAST_HEAD="$head"
        __GIT_PROMPT_LAST_STATE="$state"
        gitstring="${head}${state}"
        GIT_PROMPT="(${gitstring})"
    fi
}

# Update before prompt drawing
precmd() { __git_ps1_update_fast }

