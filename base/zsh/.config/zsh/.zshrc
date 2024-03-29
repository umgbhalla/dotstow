#
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
  completion.zsh
  opts.zsh
  prompt.zsh
  plugins.zsh
  git.zsh
  aliases.zsh
  funcs.zsh
  colors.zsh
  zoxide.zsh
  keys.zsh
  vpn.zsh
) {
  sie $ZDOTDIR/$file
}
unset file

sie $HOME/.cargo/env

# Performance Warning
END=$(date +%s.%N)
ZSHRC_PERF=$(printf %.2f $(echo "$END - $START" | bc))
if (( $ZSHRC_PERF > 0.14)); then
  echo "\033[0;31mperformance warning!"
  echo ".zshrc startup time" $ZSHRC_PERF "seconds\e[0m"
fi

# yearprog
# upwr
# upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"
# paleofetch
# export PYTHONDONTWRITEBYTECODE=1
# when

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/umang/google-cloud-sdk/path.zsh.inc' ]; then . '/home/umang/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/umang/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/umang/google-cloud-sdk/completion.zsh.inc'; fi
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
