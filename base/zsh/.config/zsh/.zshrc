
#                                      ██
#                                     ░██
#                       ██████  ██████░██      ██████  █████
#                      ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#                         ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#                    ██  ██    ░░░░░██░██  ░██ ░██   ░██   ██
#                   ░██ ██████ ██████ ░██  ░██░███   ░░█████
#                   ░░ ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░
#
#
#
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
[ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ] && ( fixpulse &disown ; startx )


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
START=$(date +%s.%N)

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
exist_and_not_running() {
  if ! pgrep $1 > /dev/null; then
    if which $1 > /dev/null; then
      $@ &
    fi
  fi
}
# source if exist
sie() {
  if [[ -r $1 ]]; then
    source $1
  fi
}


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# autoload -uz compinit && compinit -u
setopt autocd
sie ~/.config/zsh/.zprofile
sie ~/.config/zsh/prompt.zsh
sie ~/.config/zsh/keys.zsh
sie ~/.config/zsh/git.zsh
sie ~/.config/zsh/aliases.zsh
sie ~/.config/zsh/funcs.zsh
sie $HOME/.cargo/env
# sie ~/.config/zsh/enhancd.zsh
# sie ~/.config/zsh/kubctl.zsh
# sie ~/.config/zsh/docker.zsh
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
alias na='nvim ~/.config/zsh/aliases.zsh'
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
sie /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
sie /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
sie /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups
# gitrepo(main)
zstyle ':completion:*:git-checkout:*' sort false 
# disable sort when completing `git checkout`
zstyle ':completion:*:descriptions' format '[%d]' 
# set descriptions format to enable group support
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 
# set list-colors to enable filename colorizing
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' 
# case insensitive tab complete
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' 
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:*' switch-group ',' '.' 
# switch group using `,` and `.`
#
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# bindkey "^Xa" _expand_alias
# zstyle ':completion:*' completer _expand_alias _complete _ignored
# zstyle ':completion:*' regular true
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# paleofetch
# upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/umang/.miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/umang/.miniconda/etc/profile.d/conda.sh" ]; then
#         . "/home/umang/.miniconda/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/umang/.miniconda/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# zstyle ':completion:*' completer _complete _ignored
# zstyle :compinstall filename '/home/umang/.config/zsh//.zshrc'
autoload -Uz compinit
compinit
# Performance Warning
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
END=$(date +%s.%N)
ZSHRC_PERF=$(printf %.2f $(echo "$END - $START" | bc))
if (( $ZSHRC_PERF > 0.08)); then
  echo "\033[0;31mperformance warning!"
  echo ".zshrc startup time" $ZSHRC_PERF "seconds\e[0m"
fi
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# upwr
