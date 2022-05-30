#lib/shared/services                                      ██
#                                     ░██
#                       ██████  ██████░██      ██████  █████
#                      ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#                         ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#                    ██  ██    ░░░░░██░██  ░██ ░██   ░██   ██
#                   ░██ ██████ ██████ ░██  ░██░███   ░░█████
#                   ░░ ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░

START=$(date +%s.%N)
# If not running interactively, don't do anything

source $ZDOTDIR/profile.zsh

[[ $- != *i* ]] && return



# [ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ] &&  startx 

# source if exist
sie() {
  if [[ -r $1 ]]; then
    source $1
  fi
}

alias na='nvim ~/.config/zsh/aliases.zsh'

foreach file (
  prompt.zsh
  plugins.zsh
  keys.zsh
  completion.zsh
  git.zsh
  aliases.zsh
  funcs.zsh
  colors.zsh
  zoxide.zsh
  aws.zsh
  opts.zsh
  # android.zsh
  # tmux.zsh
  # conda.zsh
  kubctl.zsh
  # terraform.zsh
  # fly.zsh
  docker.zsh
) {
  sie $ZDOTDIR/$file
}
unset file

sie $HOME/.cargo/env

# Performance Warning
END=$(date +%s.%N)
ZSHRC_PERF=$(printf %.2f $(echo "$END - $START" | bc))
# if (( $ZSHRC_PERF > 0.09)); then
#   echo "\033[0;31mperformance warning!"
#   echo ".zshrc startup time" $ZSHRC_PERF "seconds\e[0m"
# fi

# yearprog
# upwr
# upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"
# paleofetch
# export PYTHONDONTWRITEBYTECODE=1
# when
