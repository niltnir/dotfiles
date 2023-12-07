#!/bin/bash

SHELL_NAME="${1}"

# Set dotfile directory
if [ -d "$HOME/dotfiles" ]; then
  DOTFILES_DIR="$HOME/dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Source the dotfiles (order matters)
for DOTFILE in "$DOTFILES_DIR"/shell/"$SHELL_NAME"/{functions,env,alias,prompt}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
  # echo $? 
done

# Make utilities available
PATH="$DOTFILES_DIR/bin:$PATH"

# Export
export DOTFILES_DIR
export PATH
