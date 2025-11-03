gemini() {
  # Get current branch name
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  # If not under git control, continue as is
  if [ $? -ne 0 ]; then
    echo "⚠️  Start the Gemini CLI, not the Git repository.
"
    command gemini "$@"
    return
  fi

  # Check working tree status
  local git_status
  git_status=$(git status --porcelain)

  # Check Conditions
  local clean=true
  local on_dev=true

  if [ "$branch" != "dev" ]; then
    echo "⚠️  Current branch is '$branch' (not dev)
"
    on_dev=false
  fi

  if [ -n "$git_status" ]; then
    echo "⚠️  There are uncommitted changes to the king tree"
    clean=false
  fi

  # Issue confirmation if either is unsuitable
  if [ "$on_dev" = false ] || [ "$clean" = false ]; then
    echo
    echo "Choose one of the following:"
    echo " [c] continue to launch gemini"
    echo " [a] Suspend"
    echo -n "> "
    read -r ans
    case "$ans" in
      c|C)
        echo "👉 Start Gemini CLI..."
        ;;
      *)
        echo "⛔ Interrupted..."
        return 1
        ;;
    esac
  fi

  # Normal gemini CLI execution
  command gemini "$@"
}
