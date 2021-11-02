
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


function exist_and_not_running() {
    if ! pgrep $1 > /dev/null; then
        if which $1 > /dev/null; then
            $@ &
        fi
    fi
}

function source_if_exist() {
    if [[ -r $1 ]]; then
        source $1
    fi
}


bindkey -v
source_if_exist ~/.config/zsh/.zprofile
autoload -Uz compinit && compinit
autoload -Uz colors && colors

source_if_exist ~/.config/zsh/.zkeys
source_if_exist /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source_if_exist /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source_if_exist /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh
source_if_exist /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# source_if_exist ~/.config/zsh/.zdocker
source_if_exist ~/.config/zsh/.zgit
alias na='nvim ~/.config/zsh/.aliases'
source_if_exist ~/.config/zsh/.aliases
source_if_exist ~/.config/zsh/.zfunc

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups


autoload -Uz add-zsh-hook vcs_info # Enable substitution in the prompt.
setopt prompt_subst # Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '!'
zstyle ':vcs_info:*' unstagedstr "+"
zstyle ':vcs_info:*' formats ' %s(%F{red}%b%f%c%u)' # gitrepo(main)
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'


PS1='%F{green}%f%F{blue}%1~%f%F{green}%f${vcs_info_msg_0_} %F{white} %f ' 


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

upwr
