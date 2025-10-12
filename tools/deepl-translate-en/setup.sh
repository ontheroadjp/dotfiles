#!/bin/bash

# This script creates a symbolic link to the deepl-translate-en.py script
# in the user's bin directory, so it can be run from anywhere.

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# The target script
TARGET_SCRIPT="$SCRIPT_DIR/deepl-translate-en.py"

# The link name in the bin directory
# Assuming the bin directory is at ~/dotfiles/bin
BIN_DIR="$HOME/dotfiles/bin"
LINK_NAME="$BIN_DIR/deepl-translate-en"

# Create bin directory if it doesn't exist
mkdir -p "$BIN_DIR"

# Create the symbolic link
if [ -L "$LINK_NAME" ]; then
    echo "Symbolic link already exists at $LINK_NAME"
elif [ -e "$LINK_NAME" ]; then
    echo "Error: A file or directory already exists at $LINK_NAME"
    exit 1
else
    ln -s "$TARGET_SCRIPT" "$LINK_NAME"
    echo "Symbolic link created at $LINK_NAME"
fi
