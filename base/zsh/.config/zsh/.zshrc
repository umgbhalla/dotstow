#                                      ██
#                                     ░██
#                       ██████  ██████░██      ██████  █████
#                      ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#                         ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#                    ██  ██    ░░░░░██░██  ░██ ░██   ░██   ██
#                   ░██ ██████ ██████ ░██  ░██░███   ░░█████
#                   ░░ ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
[ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ] && ( fixpulse &disown ; startx )

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
START=$(date +%s.%N)

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# source if exist
sie() {
  if [[ -r $1 ]]; then
    source $1
  fi
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
alias na='nvim ~/.config/zsh/aliases.zsh'

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
sie ~/.config/zsh/.zprofile
sie ~/.config/zsh/prompt.zsh
sie ~/.config/zsh/keys.zsh
sie ~/.config/zsh/git.zsh
sie ~/.config/zsh/aliases.zsh
sie ~/.config/zsh/funcs.zsh
sie ~/.config/zsh/colors.zsh
sie ~/.config/zsh/completion.zsh
sie ~/.config/zsh/opts.zsh
# sie ~/.config/zsh/tmux.zsh
# sie ~/.config/zsh/conda.zsh
# sie ~/.config/zsh/kubctl.zsh
# sie ~/.config/zsh/docker.zsh
sie $HOME/.cargo/env

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# External plugins
sie /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
sie /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
sie /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
sie /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh
if [[ -r /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"
# upwr
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Performance Warning
END=$(date +%s.%N)
ZSHRC_PERF=$(printf %.2f $(echo "$END - $START" | bc))
if (( $ZSHRC_PERF > 0.08)); then
  echo "\033[0;31mperformance warning!"
  echo ".zshrc startup time" $ZSHRC_PERF "seconds\e[0m"
fi
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

