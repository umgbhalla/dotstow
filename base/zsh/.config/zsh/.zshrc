
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

source ~/.config/zsh/.zgit
# source ~/.config/zsh/.zdocker
source ~/.config/zsh/.zprofile
source $ZSH/oh-my-zsh.sh

# source aliases
alias na='nvim ~/.config/zsh/.aliases'
source ~/.config/zsh/.aliases


# >>>>>>>>>>>>>
ghub(){
  cd ~/hub
  git clone $@
}
# <<<<<<<<<<<<<


# >>>>>>>>>>>>>
x0 (){
  cat "$@" \
    | command curl -fsLF "file=@-" "https://0x0.st" \
    | tr -d "\n" \
    | xclip -in -sel clip && \
    notify-send -t 900 -u low "File link copied to clipboard!"
  }

spr (){
  cat "$@" \
    | command curl -fsLF 'sprunge=<-' http://sprunge.us \
    | tr -d "\n" \
    | xclip -in -sel clip && \
    notify-send -t 900 -u low "Sprunge copied to clipboard!"

  }
# <<<<<<<<<<<<<


# >>>>>>>>>>>>>
chmu(){
  tuxi -u $@ | grep http | xcopy 
  notify-send -t 900 -u low "hogya bhai google"
}
# <<<<<<<<<<<<<


# >>>>>>>>>>>>>
ghs(){
  tuxi -u $@ "github repo" | grep http | fzf | xargs -r firefox
}
# <<<<<<<<<<<<<


# >>>>>>>>>>>>>
#hide_on_open
ho() { tdrop -a auto_hide; "$@" && tdrop -a auto_show }
mpq() { setsid mpv --input-ipc-server=/tmp/mpvsocket$(date +%s) -quiet "$1" >/dev/null 2>&1}
# <<<<<<<<<<<<<



# >>>>>>>>>>>>>
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
# <<<<<<<<<<<<<


# >>>>>>>>>>>>>
keyb(){
  setxkbmap -option caps:swapescape && xset r rate 230 30
  notify-send "caps esc swapped and keyrate set to 230::30"
}
# <<<<<<<<<<<<<


# >>>>>>>>>>>>>
up_widget() {
  BUFFER="cd .."
  zle accept-line
}
zle -N up_widget
bindkey "^\\" up_widget
# <<<<<<<<<<<<<


# >>>>>>>>>>>>>
bye() {
  BUFFER="exit"
  zle accept-line
}
zle -N bye
bindkey "^q" bye
# <<<<<<<<<<<<<

# >>>>>>>>>>>>>
fzf-z-search() {
        local res=$(history -n 1 | fzf)
        if [ -n "$res" ]; then
            BUFFER+="$res"
            zle accept-line
        else
            return 0
        fi
    }
zle -N fzf-z-search
bindkey '^s' fzf-z-search
# <<<<<<<<<<<<<


# >>>>>>>>>>>>>
# select-history() {
#         BUFFER=$(history -n -r 1 \
#             | awk 'length($0) > 2' \
#             | rg -v "^...$" \
#             | rg -v "^....$" \
#             | rg -v "^.....$" \
#             | rg -v "^......$" \
#             | rg -v "^exit$" \
#             | uniq -u \
#             | fzf-tmux --no-sort +m --query "$LBUFFER" --prompt="History > ")
#         CURSOR=$#BUFFER
#     }
# zle -N select-history
# bindkey '^r' select-history
# <<<<<<<<<<<<<


# >>>>>>>>>>>>>
# process search and kill
psk() { ps -afx|  fzf |  xargs -0 -I {} echo {} | awk '{ printf $1 }' | xargs -0 -I {}  kill -9  {}; }
# <<<<<<<<<<<<<

# >>>>>>>>>>>>>
# find-in-file - usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi
  rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}
# <<<<<<<<<<<<<

autoload -Uz vcs_info # enable vcs_info
precmd () { vcs_info } # always load before displaying the prompt
zstyle ':vcs_info:*' formats ' %s(%F{red}%b%f)' # git(main)
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
# welc
# upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"
# echo ""


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

