# -----------------------------------------------------------------------------
# git-prompt.zsh
# Super fast Git prompt for Zsh (no color)
# -----------------------------------------------------------------------------
#
# Author   : Nuts LLC
# Created  : 2025-11-08
#
# Description:
#   Provides a fast, minimal Git prompt for Zsh. It retrieves the current branch
#   or commit hash and a minimal status indicator with a single call to `git status`.
#   The prompt string is stored in the variable $GIT_PROMPT and can be embedded
#   in PS1. Designed for synchronous updates to ensure accurate branch/state info.
#
# Features:
#   - Only updates when PWD, branch, or working tree/index state changes.
#   - Minimal Git commands to improve startup and prompt speed.
#   - Shows branch names without the refs/heads/ prefix.
#   - Supports optional indicators for:
#       * Unstaged changes (*)
#       * Staged but uncommitted changes (+)
#       * Untracked files (%)
#       * Stashed changes ($)
#       * Upstream divergence (<, >, <>, =)
#   - Handles detached HEAD by showing short SHA instead of branch name.
#
# Variables:
#   GIT_PROMPT               : Stores the final Git prompt string, e.g., (master*+)
#   __GIT_PS1_LAST_PWD       : Caches the last PWD for change detection
#   __GIT_PS1_LAST_HEAD      : Caches the last Git HEAD
#   __GIT_PS1_LAST_STATE     : Caches the last state string (*, +, $, upstream)
#
# Optional Environment Variables:
#   GIT_PS1_SHOWDIRTYSTATE   : true/false to enable * and + indicators (default true)
#   GIT_PS1_SHOWUNTRACKEDFILES : true/false to enable % indicator (default false)
#   GIT_PS1_SHOWSTASHSTATE   : true/false to enable $ indicator (default true)
#   GIT_PS1_SHOWUPSTREAM     : auto/false to enable upstream status (default auto)
#
# Function:
#   __git_ps1_update_fast
#       - Updates $GIT_PROMPT if relevant changes occurred.
#       - Uses a single `git status --porcelain=2 --branch --untracked-files=no`
#         call to retrieve branch name and working tree/index status.
#       - Updates indicators for staged/unstaged changes, stashes, untracked files,
#         and upstream divergence.
#       - Caches previous values to avoid unnecessary prompt updates.
#
# Usage:
#   1) Source this file in your .zshrc:
#        source ~/dotfiles/bin/git-prompt-fast.zsh
#   2) Embed $GIT_PROMPT in your prompt:
#        PS1="[%n@%m %c${GIT_PROMPT}]$ "
#   3) Ensure updates before each prompt:
#        precmd() { __git_ps1_update_fast }
#   4) Optionally hook into chpwd to update prompt when changing directories:
#        autoload -Uz add-zsh-hook
#        add-zsh-hook chpwd __git_ps1_update_fast
#
# Notes:
#   - Designed to be synchronous; async updates possible but may cause brief
#     outdated info display.
#   - Does not apply color codes; keep rendering simple and fast.
#   - For very large repositories, consider async or deferred updates.
#   - Avoids errors in non-Git directories.
#
# Limitations:
#   - Upstream comparison works only if an upstream branch exists.
#   - Untracked file indicator is disabled by default.
#   - No special handling for merge/rebase states.
# -----------------------------------------------------------------------------

# User Preferences
# () is the default value
# GIT_PS1_SHOWDIRTYSTATE=(true)|false       # unstaged (*) and staged but no commit (+)
# GIT_PS1_SHOWUNTRACKEDFILES=true|(false)   # new and untracked file (%)
# GIT_PS1_SHOWSTASHSTATE=(true)|false       # stashed ($)
# GIT_PS1_SHOWUPSTREAM=(auto)|false         # upstream (<, >, <>, =)

GIT_PROMPT=""
__GIT_PS1_LAST_PWD=""
__GIT_PS1_LAST_HEAD=""
__GIT_PS1_LAST_STATE=""

# Set default values if not already set
: ${GIT_PS1_SHOWDIRTYSTATE:=true}      # unstaged (*) and staged (+)
: ${GIT_PS1_SHOWUNTRACKEDFILES:=false} # untracked files (%)
: ${GIT_PS1_SHOWSTASHSTATE:=true}      # stashed ($)
: ${GIT_PS1_SHOWUPSTREAM:=auto}        # upstream (<, >, <>, =)

__git_ps1_update_fast() {
    local head \
        state \
        gitstring \
        line \
        staged_found=0 \
        work_found=0 \
        stash_found=0 \
        upstream_mark=""

    # Determine if git is managed or not
    git rev-parse --git-dir >/dev/null 2>&1 || {
        GIT_PROMPT="";
        return
    }

    # Retrieved in git command only one time
    local lines
    lines=("${(@f)$(\
        git status --porcelain=2 \
                --branch \
                --untracked-files=no \
                2>/dev/null\
            )}"
        )

    for line in "${lines[@]}"; do
        case "${line}" in
            "# branch.head "*)

                # Get only immediately after branch.head
                head="${line#\# branch.head }"

                # Remove trailing whitespace and line breaks
                head="${head%%$'\n'}"
                head="${head%%$'\r'}"

                # detached HEAD or replace with SHA if empty
                if [[ -z "${head}" || "${head}" == "(detached)" ]]; then
                    head=$(git rev-parse --short HEAD 2>/dev/null)
                fi
                ;;

            "1 "*)
                local index=${line:2:1}
                local worktree=${line:3:1}
                [[ "${GIT_PS1_SHOWDIRTYSTATE}" == true \
                    && "${index}" != "." ]] \
                    && staged_found=1
                [[ "${GIT_PS1_SHOWDIRTYSTATE}" == true \
                    && "${worktree}" != "." ]] \
                    && work_found=1
                ;;

            "?"*)
                [[ "${GIT_PS1_SHOWUNTRACKEDFILES}" == true ]] \
                    && work_found=1
                ;;
        esac
    done

    # stash
    if [[ "${GIT_PS1_SHOWSTASHSTATE}" == true ]]; then
        git rev-parse --verify refs/stash >/dev/null 2>&1 && stash_found=1
    fi

    # upstream
    if [[ "${GIT_PS1_SHOWUPSTREAM}" != "false" ]]; then
        if git rev-parse \
            --abbrev-ref \
            --symbolic-full-name \
            @{upstream} \
            >/dev/null 2>&1; then

            local ahead behind
            read ahead behind < <(\
                git rev-list \
                    --left-right \
                    --count \
                    @{upstream}...HEAD \
                    2>/dev/null\
                )
            if [[ ${ahead} -gt 0 && ${behind} -gt 0 ]]; then
                upstream_mark="<>"
            elif [[ ${ahead} -gt 0 ]]; then
                upstream_mark=">"
            elif [[ ${behind} -gt 0 ]]; then
                upstream_mark="<"
            else
                upstream_mark="="
            fi
        fi
    fi

    # state made
    state=""
    [[ ${staged_found} -eq 1 ]] && state+="+"
    [[ ${work_found} -eq 1 ]] && state+="*"
    [[ ${stash_found} -eq 1 ]] && state+="$"
    [[ -n ${upstream_mark} ]] && state+="${upstream_mark}"

    # Cache
    local cached_pwd="${PWD%%/}"
    local cached_head="${head%%[[:space:]]}"
    local cached_state="${state%%[[:space:]]}"

    if [[ "${cached_pwd}" != "${__GIT_PS1_LAST_PWD}" || \
                "${cached_head}" != "${__GIT_PS1_LAST_HEAD}" || \
                "${cached_state}" != "${__GIT_PS1_LAST_STATE}" ]]; then
        __GIT_PS1_LAST_PWD="${cached_pwd}"
        __GIT_PS1_LAST_HEAD="${cached_head}"
        __GIT_PS1_LAST_STATE="${cached_state}"
        GIT_PROMPT="(${cached_head}${cached_state})"
    fi
}

