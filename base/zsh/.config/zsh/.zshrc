
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
# bindkey -v

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups


plugins=(
  fzf
  # docker
  # docker-compose
  # extract 
  # mosh
  # timer
  fzf-tab
  zsh-autosuggestions 
  zsh-syntax-highlighting )

# source git functions and aliases
source ~/.config/zsh/.zgit
# source docker functions and aliases
# source ~/.config/zsh/.zdocker
source ~/.config/zsh/.zprofile
source $ZSH/oh-my-zsh.sh
# source aliases
alias na='nvim ~/.config/zsh/.aliases'
source ~/.config/zsh/.aliases
# source functions
source ~/.config/zsh/.zfunc



autoload -Uz vcs_info # enable vcs_info
precmd () { vcs_info } # always load before displaying the prompt
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '!'
zstyle ':vcs_info:*' unstagedstr "+"
zstyle ':vcs_info:*' formats ' %s(%F{red}%b%f%c%u)' # git(main)
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'


PS1='%F{green}%f%F{blue}%1~%f%F{green}%f$vcs_info_msg_0_ %F{white} %f ' 


# eval "$(starship init zsh)"
# paleofetch
# upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"


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

