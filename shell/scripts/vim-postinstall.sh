#!/bin/bash
# Processes to run after PlugInstall has loaded all the extension packages

VIM_AIRLINE_THEMES_DIR="$HOME/.vim/plugged/vim-airline-themes/autoload/airline/themes/"
echo "Adding niltnir airline theme to vim-airline-theme directory."
cp "$HOME"/dotfiles/vim/niltnir_airline_theme.vim "${VIM_AIRLINE_THEMES_DIR}"/base16_snazzy.vim
echo "done"
