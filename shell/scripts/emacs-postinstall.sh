#!/bin/bash
# Processes to run after use-package has loaded all the extension packages

# Airline-Theme Customization
AIRLINE_THEME_DIR=$(find ~/dotfiles/emacs/elpa/ -maxdepth 1 -name "*airline-theme*" -type d)
ln -s "$HOME"/dotfiles/emacs/postinstall/airline-nil-theme.el  "${AIRLINE_THEME_DIR}"/

# Dashboard Customization
DASHBOARD_DIR=$(find ~/dotfiles/emacs/elpa/ -maxdepth 1 -name "*dashboard*" -type d)
if test -f "${DASHBOARD_DIR}"/banners/1.txt; then 
  rm "${DASHBOARD_DIR}"/banners/1.txt;
fi
if test -f "${DASHBOARD_DIR}"/banners/4.txt; then 
  rm "${DASHBOARD_DIR}"/banners/4.txt;
fi
ln -s "$HOME"/dotfiles/emacs/postinstall/lambdus-logo.txt  "${DASHBOARD_DIR}"/banners/1.txt
ln -s "$HOME"/dotfiles/emacs/postinstall/lisp-logo.txt  "${DASHBOARD_DIR}"/banners/4.txt

