#!/usr/bin/env bash
# ================================================================
# GitHub Issue Management Launcher (Vim + fzf + YAML Support)
# ------------------------------------------------
# Description:
#   This script provides a lightweight GitHub issue management
#   interface integrated with Vim templates and optional fzf menus.
#   It allows the user to:
#     1. Create new issues via predefined Vim templates (.todo, .bug, etc.)
#     2. Edit existing issues, including:
#        - Title
#        - Labels
#        - Assignee
#        - Milestone
#        - Body
#     3. Close issues interactively.
#
#   Key Features:
#     - YAML front matter support: each issue file contains metadata
#       (title, label, assignee, milestone) at the top.
#     - Body extraction:
#         * All lines after the second '---' (YAML end) are considered
#           the issue body.
#         * Leading empty lines in the body are automatically removed.
#     - Fuzzy selection menus (using fzf) for improved user experience.
#       Falls back to simple numbered select menus if fzf is unavailable.
#     - Fully compatible with GitHub CLI v2 commands:
#         * gh issue list
#         * gh issue view
#         * gh issue edit
#         * gh issue close
#
# Requirements:
#   - GitHub CLI (gh) installed and authenticated
#   - Vim configured to handle issue templates (.todo, .bug, etc.)
#   - Optional: fzf for interactive fuzzy menus
#
# Usage:
#   chmod +x github_issue.sh
#   ./github_issue.sh
#
# Processing Flow:
#   1. Main menu is displayed (via fzf if available):
#        - Create new Issue (opens Vim template)
#        - Edit Issue (select an existing issue and edit in Vim)
#        - Complete Issue (close an existing issue)
#        - Exit
#
#   2. Create new Issue:
#        a. User selects issue type (Todo, Bug, Enhancement, etc.)
#        b. Corresponding Vim template file is opened for editing
#        c. User can edit both YAML front matter and body
#
#   3. Edit Issue:
#        a. Fetch a list of issues from GitHub (title, number, state)
#        b. User selects issue (via fzf or manual input)
#        c. Current issue data is saved into a temporary Markdown file:
#           - YAML front matter: title, label, assignee, milestone
#           - Body: all lines below second '---'
#        d. User edits the temporary file in Vim
#        e. After saving and exiting Vim:
#           - Confirm whether to update the issue
#           - Parse YAML metadata
#           - Extract body, removing leading empty lines
#           - Update issue via gh CLI:
#               * Replace existing labels and assignees completely
#               * Update title, body, and milestone
#           - Delete temporary file
#
#   4. Complete Issue:
#        a. List open issues
#        b. User selects issue to close
#        c. Close the issue using gh CLI
#
# Notes:
#   - Temporary files are created with mktemp to avoid conflicts
#   - YAML parsing is done with awk for simplicity
#   - Body extraction is robust against arbitrary empty lines in YAML
#   - Supports up to 50 issues in selection lists (configurable in gh issue list)
# ================================================================

set -e

# -------------------------------
# Helper: safe selection (fzf or fallback)
# -------------------------------
select_with_fzf() {
  local prompt="$1"
  shift
  local options=("$@")

  if command -v fzf &>/dev/null; then
    printf "%s\n" "${options[@]}" | fzf --prompt="${prompt} > " --height=10 --border --reverse
  else
    echo "${prompt}"
    select opt in "${options[@]}"; do
      [[ -n "$opt" ]] && echo "$opt" && break
    done
  fi
}

# -------------------------------
# Check GitHub authentication
# -------------------------------
if ! gh auth status &>/dev/null; then
  echo "Error: GitHub CLI is not authenticated."
  echo "Run: gh auth login"
  exit 1
fi

# -------------------------------
# Check repository context
# -------------------------------
if ! gh repo view &>/dev/null; then
  echo "Error: This directory is not a GitHub repository."
  exit 1
fi

# -------------------------------
# Create new issue via Vim template
# -------------------------------
launch_vim_issue() {
  issue_types=("Todo" "Bug Fix" "Enhancement" "Consideration" "Documentation" "Test" "Cancel")

  selected=$(select_with_fzf "Select issue type" "${issue_types[@]}")
  [[ "$selected" == "Cancel" || -z "$selected" ]] && echo "Canceled." && return

  case "$selected" in
    "Todo") file="issue.todo" ;;
    "Bug Fix") file="issue.bug" ;;
    "Enhancement") file="issue.enhance" ;;
    "Consideration") file="issue.consideration" ;;
    "Documentation") file="issue.docs" ;;
    "Test") file="issue.test" ;;
    *) echo "Unknown type."; return ;;
  esac

  echo "Opening Vim with template: $file"
  vim "$file"
}

# -------------------------------
# Edit existing issue
# -------------------------------
edit_issue() {
  echo "Fetching issues..."
  issues=$(gh issue list --state all --limit 50 --json number,title,state | \
    jq -r '.[] | "#\(.number) | \(.title | gsub("\n"; " ")) | \(.state)"')

  [[ -z "$issues" ]] && echo "No issues found." && return

  if command -v fzf &>/dev/null; then
    selected=$(echo "$issues" | fzf --prompt="Select issue to edit > " --height=15 --border)
    issue_number=$(echo "$selected" | grep -oE '#[0-9]+' | tr -d '#')
  else
    echo "$issues"
    read -rp "Enter issue number (without #) to edit: " issue_number
  fi

  [[ -z "$issue_number" ]] && echo "Canceled." && return

  tmpfile=$(mktemp -t issue_edit_XXXXXX).md

  # 既存 Issue 情報を取得
  issue_json=$(gh issue view "$issue_number" --json title,body,labels,assignees,milestone)

  # YAML front matter 作成
  title_yaml=$(echo "$issue_json" | jq -r '.title')
  label_yaml=$(echo "$issue_json" | jq -r '.labels[].name' | paste -sd "," -)
  assignee_yaml=$(echo "$issue_json" | jq -r '.assignees[].login' | paste -sd "," -)
  milestone_yaml=$(echo "$issue_json" | jq -r '.milestone.title // ""')
  body_content=$(echo "$issue_json" | jq -r '.body')

  cat > "$tmpfile" <<EOF
---
title: "$title_yaml"
label: $label_yaml
assignee: $assignee_yaml
milestone: $milestone_yaml
---

$body_content
EOF

  vim "$tmpfile"

  # 確認
  read -rp "この内容で Issue を更新しますか？ [y/N]: " confirm
  [[ "$confirm" != "y" && "$confirm" != "Y" ]] && echo "Canceled." && rm -f "$tmpfile" && return

  # YAML の値を抽出
  title=$(awk '/^title:/ {sub(/^title: */,""); gsub(/^"|"$/,""); print}' "$tmpfile")
  label=$(awk '/^label:/ {sub(/^label: */,""); print}' "$tmpfile")
  assignee=$(awk '/^assignee:/ {sub(/^assignee: */,""); print}' "$tmpfile")
  milestone=$(awk '/^milestone:/ {sub(/^milestone: */,""); print}' "$tmpfile")

  # 本文抽出: 2回目の --- 以降を全て本文とする
  raw_body=$(awk '
    BEGIN {yaml_done=0}
    /^---$/ {
      if (yaml_done==0) { yaml_done=1 } else { yaml_done=2; next }
      next
    }
    yaml_done==2 { print }
  ' "$tmpfile")

  # 本文先頭の空行は削除
  body=$(echo "$raw_body" | sed '/./,$!d')

  # -------------------------------
  # ラベルとアサインの完全置換
  # -------------------------------
  # ラベル削除（既存をまとめて）
  existing_labels=$(echo "$issue_json" | jq -r '.labels[].name')
  if [ -n "$existing_labels" ]; then
    args=()
    for lbl in $existing_labels; do
      args+=(--remove-label "$lbl")
    done
    gh issue edit "$issue_number" "${args[@]}"
  fi

  # アサイン削除（既存をまとめて）
  existing_assignees=$(echo "$issue_json" | jq -r '.assignees[].login')
  if [ -n "$existing_assignees" ]; then
    args=()
    for a in $existing_assignees; do
      args+=(--remove-assignee "$a")
    done
    gh issue edit "$issue_number" "${args[@]}"
  fi

  # まとめて更新: タイトル・本文・マイルストーン・新しいラベル・アサイン
  args=()
  args+=(--title "$title")
  args+=(--body "$body")
  args+=(-m "$milestone")
  IFS=',' read -ra new_labels <<< "$label"
  for l in "${new_labels[@]}"; do
    [ -n "$l" ] && args+=(--add-label "$l")
  done
  IFS=',' read -ra new_assignees <<< "$assignee"
  for a in "${new_assignees[@]}"; do
    [ -n "$a" ] && args+=(--add-assignee "$a")
  done

  gh issue edit "$issue_number" "${args[@]}"

  echo "✅ Issue #$issue_number updated successfully."
  rm -f "$tmpfile"
}


# -------------------------------
# Complete (Close) issue
# -------------------------------
complete_issue() {
  issues=$(gh issue list --state open --limit 50 --json number,title --template '{{range .}}{{.number}}\t{{.title}}\n{{end}}')

  [[ -z "$issues" ]] && echo "No open issues." && return

  if command -v fzf &>/dev/null; then
    selected=$(echo "$issues" | fzf --prompt="Select issue to close > " --with-nth=2 --height=15 --border)
    issue_number=$(echo "$selected" | awk '{print $1}')
  else
    echo "Open Issues:"
    echo "$issues"
    read -rp "Enter issue number to close: " issue_number
  fi

  if [ -n "$issue_number" ]; then
    gh issue close "$issue_number"
    echo "✅ Issue #$issue_number closed."
  fi
}

# -------------------------------
# Create Branch from Issue
# -------------------------------
create_branch_from_issue() {
  echo "Fetching open issues..."
  issues=$(gh issue list --state open --limit 50 --json number,title,labels | \
    jq -r '.[] | "#\(.number) | \(.title) | [\(.labels[].name)]"'
  )

  [[ -z "$issues" ]] && echo "No open issues found." && return

  if command -v fzf &>/dev/null; then
    selected_issue=$(echo "$issues" | fzf --prompt="Select issue to create a branch from > " --height=15 --border)
  else
    echo "Open Issues:"
    echo "$issues"
    read -rp "Enter issue number to create a branch from: " issue_number_input
    selected_issue=$(echo "$issues" | grep "^#$issue_number_input ")
  fi

  [[ -z "$selected_issue" ]] && echo "Canceled." && return

  issue_number=$(echo "$selected_issue" | awk -F ' | ' '{print $1}' | tr -d '#')

  # Issue詳細を再取得して正確な情報を得る
  issue_json=$(gh issue view "$issue_number" --json title,labels)
  issue_title=$(echo "$issue_json" | jq -r '.title')
  labels=$(echo "$issue_json" | jq -r '.labels[].name')

  # 'consideration' ラベルのチェック
  if echo "$labels" | grep -q "consideration"; then
    echo "This issue is still under consideration and cannot be implemented yet."
    echo "Please change the label to 'todo' or 'enhancement' after the review is complete."
    return
  fi

  # ラベルに基づいてブランチのprefixを決定
  prefix="feat" # デフォルト
  if echo "$labels" | grep -q "bug"; then
    prefix="fix"
  elif echo "$labels" | grep -q "enhancement"; then
    prefix="feat"
  elif echo "$labels" | grep -q "todo"; then
    prefix="todo"
  elif echo "$labels" | grep -q "docs"; then
    prefix="docs"
  elif echo "$labels" | grep -q "test"; then
    prefix="test"
  fi

  # ブランチ名を作成
  sanitized_title=$(echo "$issue_title" | tr ' ' '_' | tr -d '[:punct:]')
  branch_name="${prefix}/#${issue_number}_${sanitized_title}"

  # ブランチ作成
  if git checkout -b "$branch_name"; then
    echo "✅ Branch '$branch_name' created and switched to successfully."
  else
    echo "❌ Failed to create branch '$branch_name'. It may already exist."
  fi
}

# -------------------------------
# Main menu
# -------------------------------
main_menu() {
  while true; do
    options=("Create new Issue (open Vim)" "Edit Issue" "Create Branch from Issue" "Complete Issue" "Exit")
    selected=$(select_with_fzf "Select operation" "${options[@]}")

    case "$selected" in
      "Create new Issue (open Vim)") launch_vim_issue ;;
      "Edit Issue") edit_issue ;;
      "Create Branch from Issue") create_branch_from_issue ;;
      "Complete Issue") complete_issue ;;
      "Exit"|"") echo "Goodbye." && exit 0 ;;
      *) echo "Invalid selection." ;;
    esac
    echo
  done
}

main_menu
