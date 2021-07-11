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

export MANPAGER='nvim +Man!'
export BROWSER=firefox
export ZSH=$HOME/.oh-my-zsh
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk/jre/'
export PATH=$JAVA_HOME/bin:$PATH 
export ANDROID_SDK_ROOT='/opt/android-sdk'
export CHROME_EXECUTABLE='/usr/bin/google-chrome-stable'
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
export PATH=$PATH:'/home/umang/.node_modules/bin'
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=$PATH:/home/umang/.cargo/bin
export CM_LAUNCHER=rofi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPS="--extended"

export PATH='/home/umang/.scripts/':$PATH 
export VISUAL=nvim
export EDITOR="$VISUAL"


# ZSH_THEME="af-magic"
ZSH_THEME="awesomepanda"
# ZSH_THEME="wedisagree"
# ZSH_THEME="theunraveler"
# ZSH_THEME="dstufft"
# ZSH_THEME="refined"
# ZSH_THEME="mh"
# ZSH_THEME="muse"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# ZSH_THEME="powerlevel10k/powerlevel10k" 
# ZSH_THEME="random"
# ZSH_THEME="avit"
# ZSH_THEME="intheloop"
# ZSH_THEME="fox"
# ZSH_THEME="agnoster"
# ZSH_THEME="robbyrussell"

plugins=(fzf zsh-autosuggestions zsh-syntax-highlighting web-search )

### "bat" as manpager
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANPAGER="nvim -c 'set ft=man' -"


open_with_fzf() {
    fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
}
cd_with_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}
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

#hide_on_open
ho() { tdrop -a auto_hide; "$@" && tdrop -a auto_show }


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





alias cz='cd_with_fzf'
alias oz='open_with_fzf'
keyb(){
setxkbmap -option caps:swapescape && xset r rate 230 30
notify-send "caps esc swapped and keyrate set to 230::30"
}
# only for git
#zstyle ':completion:*:*:git:*' fzf-search-display true
# or for everything
zstyle ':completion:*' fzf-search-display true




# Path to your oh-my-zsh installation.
source $ZSH/oh-my-zsh.sh
alias na='nvim ~/.config/zsh/.aliases'
source ~/.config/zsh/.aliases
source ~/.profile
# eval "$(starship init zsh)"
alias ide="tmux  split-window -v -p 30 ;	tmux  split-window -h -p 50  "

export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#eval $(thefuck --alias)
#autoload -Uz compinit
#bat ~/.todo
# colorscript -e 32


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
#
#
# fet.sh
source /home/umang/.config/broot/launcher/bash/br
paleofetch
