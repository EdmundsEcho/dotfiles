#!/usr/bin/env zsh

# change-zsh-theme.sh new_theme
#---------------------------------------------------------------
# TODO: verify that the new theme exists
#       use autoload -U add-zsh-hook to force cursor update
#
# Note: If a theme is replaced with one that does not exist
#       oh-my-xsh defaults to `robbyrussell`.  The requested
#       theme must already have an entry in the config
#       file.  This script only toggles commenting in/out
#       to activate a theme entry. Finally, the zshrc file
#       is copied to a backup before changes are maded file
#       if required (e.g., zshrc_bk).
#
#---------------------------------------------------------------
ZSHRC=$HOME/dotfiles/zshrc
#---------------------------------------------------------------

PROGNAME=${0##*/}
ARGS=1

main () {
  validate_input $#
  swap_themes $@
  echo "Updated zshr. Source the file to see changes."
  exit 0
}

swap_themes () {

  NEW_THEME=$1
  TEMP_FILE=/tmp/swap_themes.$$.$RANDOM

  # backup .zshrc
  cp $ZSHRC ${ZSHRC}_bk

  # Comment out the line with an active theme
  sed -E "s/^(ZSH_THEME=.+\")/# \1/" $ZSHRC > $TEMP_FILE

  # Activate the chosen theme
  sed -E "s/^# +(ZSH_THEME=\"$NEW_THEME\".*)/\1/" $TEMP_FILE > $ZSHRC

  rm -f $TEMP_FILE
}

err () {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

validate_input () {
  if [[ $1 -lt $ARGS ]]; then
    err "Usage: $PROGNAME new-theme-name"
    exit 128
  fi
}

main "$@"
exit 0
