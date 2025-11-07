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

# User Preferences
# GIT_PS1_SHOWDIRTYSTATE=true         # unstaged (*) and staged but no commit (+)
# GIT_PS1_SHOWUNTRACKEDFILES=false    # new and untracked file (%)
# GIT_PS1_SHOWSTASHSTATE=true         # stashed ($)
# GIT_PS1_SHOWUPSTREAM=auto           # upstream (<, >, <>, =)

GIT_PROMPT=""
__GIT_PS1_LAST_PWD=""
__GIT_PS1_LAST_HEAD=""
__GIT_PS1_LAST_STATE=""

__git_ps1_update_fast() {
    local head \
        state \
        gitstring \
        line \
        staged_found=0 \
        work_found=0 \
        stash_found=0 \
        upstream_mark=""

    git rev-parse --git-dir >/dev/null 2>&1 || {
        GIT_PROMPT="";
        return
    }

    # Retrieved in git command 1 time
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
    if [[ "${PWD}" != "${__GIT_PS1_LAST_PWD}" \
            || "${head}" != "${__GIT_PS1_LAST_HEAD}" \
            || "${state}" != "${__GIT_PS1_LAST_STATE}" ]]; then
        __GIT_PS1_LAST_PWD="${PWD}"
        __GIT_PS1_LAST_HEAD="${head}"
        __GIT_PS1_LAST_STATE="${state}"
        gitstring="${head}${state}"
        GIT_PROMPT="(${gitstring})"
    fi
}

precmd() { __git_ps1_update_fast }

