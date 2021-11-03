

alias -s md="grip -b"

# navigation
alias ZZ='exit'
alias :q='exit'
alias ..='\cd ..' 
alias ...='\cd ../..'
alias .f='\cd /mnt/F'
alias .b='\cd ~/.local/bin'
alias .c='\cd ~/.config'
alias .d='\cd ~/dotstow'
alias .m='\cd ~/Music'
alias .h='\cd ~/hub'

alias chx="chmod +x"

alias aura='sudo aura'
alias b='bat'
alias batr="bat README.md"
alias c='clear && reload'
alias ct='cht.sh' #curl cht.sh/:learn
alias d='devour'
alias dh='dirs -v'
alias dic="cat /usr/share/dict/cracklib-small | fzf-tmux -l 20% --multi --reverse | tr -d '\n' | xcopy"
alias f='tuxi '
alias fastwget='aria2c -x 16'
alias ff='tuxi -u'
alias fire='firefox'
alias gad='git add .'
alias gc='google-chrome-stable'
alias gcl='git clone'
alias gct='git commit -m'
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gp='git pull'
alias gpuf='git push origin --force'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grm='git rebase master'
alias gs='git status -s'
alias gst='git status'
alias icat='kitty +kitten icat'
alias lol=" figlet -c -f ~/.local/share/fonts/figlet-fonts/3d.flf "
alias lswifi="nmcli conn show"
alias n='nvim'
alias neo='neofetch --backend kitty --source Downloads/Slice\ 1\ \(4\).png'
alias op='xdg-open'
alias pacman='sudo pacman'
alias podcast='castero'
alias pp='python'
alias qr='curl -F-=\<- qrenco.de'
alias r='ranger .'
alias rec='asciinema rec'
alias reload='source ~/.config/zsh/.zshrc'
alias rmd='devour goneovim README.md'
alias s='startx'
# alias s='sudo systemctl start lightdm.service'
alias sc='tty-clock -SscC0'
alias sf='surf '
alias srt=' du -sh ./* | sort -h | bat'
alias tty-clock="tty-clock -C6 -c -t"
alias ttystat='echo $(tty) $TERM ${COLUMNS}x$LINES'
alias updt='sudo pacman -Sy && sudo powerpill -Su && paru -Su'
alias upwr='upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage" '
alias v='vim'
alias wgetr='wget -r --no-parent'
alias zshbench='repeat 10 time zsh -i -c exit'

# confirm before removing something
alias rm='rm -iv'
alias rmf="rm -f"
alias rmrf="rm -rf"
#
# pkg managers
alias yay='paru'
alias yayr='paru -Rcns'
alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)
alias unlock='sudo rm /var/lib/pacman/db.lck'  

# configs
alias nb='nvim ~/.config/bspwm/bspwmrc'
alias nn='nvim ~/.config/nvim/init.vim'
alias np='nvim ~/.config/picom.conf'
alias ns='nvim ~/.config/sxhkd/sxhkdrc'
alias nz='nvim ~/.config/zsh/.zshrc'


# get fast mirrors

alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrorr="sudo reflector --latest 50  --sort rate --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --verbose --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --verbose --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --verbose --sort age --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
# alias grep='grep --color=auto'
# alias egrep='egrep --color=auto'
# alias fgrep='fgrep --color=auto'

# Changing "ls" to "exa"
alias la='(exa -ahl --color=always --group-directories-first) | bat ' # my preferred listing
alias lr='(exa -R --color=always --group-directories-first) |bat '  # all files and dirs
alias ll='(exa -a --color=always --group-directories-first) |bat '  # all files and dirs
alias ld='(exa -l --color=always --group-directories-first) | bat'  # long format
alias lt='(exa -aT --color=always --group-directories-first)| bat' # tree listing
alias l.='exa -a | egrep "^\." | bat'
alias g="grep"
alias ls='exa --icons --color=always --group-directories-first'
alias lcr='exa -lhFT --color=always --icons --sort=size --group-directories-first'
# alias ls='exa --color=always --group-directories-first'

# alias ls="ptls "
alias pd="ptpwd"
alias mkdir="ptmkdir"
alias touch="pttouch"
alias cp="ptcp"
alias cpv="ptcp -v"
alias cpvr="ptcp -vr"
# youtube-dl
alias ytf=' ytfzf -t '
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

# doom 
alias emacs="emacsclient -c -a 'emacs'"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"

# kubectl
alias k='kubectl'
alias kgn='kubectl get nodes -o wide'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployment'
alias kge='kubectl get events'
alias kgpvc='kubectl get pvc'

# crpt
alias md5='md5sum'
alias s128='sha128sum'
alias s256='sha256sum'
alias s512='sha512sum'

# ports
alias ports='sudo lsof -Pni'
alias conn='netstat -Wat | grep ESTABLISHED'
alias covid='curl https://corona-stats.online\?minimal\=true | bat'
alias sprng="curl -fsLF 'sprunge=<-' http://sprunge.us "
alias ixi="curl -F 'f:1=<-' ix.io"

# open_with_fzf() {
#     fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
# }
# cd_with_fzf() {
#     cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
# }
# alias cz='cd_with_fzf'
# alias oz='open_with_fzf'
