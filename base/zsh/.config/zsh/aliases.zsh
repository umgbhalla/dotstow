# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
alias -s md="grip -b"
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# navigation
for i in x w q qa wq qw X Q QA WQ QW ZZ quit; eval alias :${i}=\' exit\'
alias ..='z ..' 
alias ...='z ../..'
alias ....='z ../../..'
alias .b='z ~/.scripts/'
alias .s='z ~/.scripts/'
alias .c='z ~/.config'
alias .d='z ~/dotstow'
alias .m='z ~/music'
alias .n='z ~/.config/nvim/'
alias .h='z ~/hub'
alias dc="z "
alias cd='z '
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# mini funcs
alias dicc="cat /usr/share/dict/cracklib-small | fzf-tmux -l 20% --multi --reverse | tr -d '\n' | yank"
alias lol=" figlet -c -f ~/.local/share/fonts/figlet-fonts/3d.flf "
alias logi="sudo systemctl restart logid.service"
alias yp="yank /home/umang/hub/misc-projs/bytelearn/pass"
alias neo='neofetch --backend kitty --source Downloads/figma/Slice\ 1\ \(4\).png'
alias srt='du -sh ./* | sort -h | bat'
alias siz='du -sh '
alias ttystat='echo $(tty) $TERM ${COLUMNS}x$LINES'
alias upwr='upower -i $(upower -e | grep BAT) | grep -E "state|to full|percentage|time to empty"'
alias docker-compose="docker compose"
alias syms='exa --icons --color=always --group-directories-first -a | grep ">"'
alias whatkey="cat > /dev/null"
alias drt='dragon-drop -t -x'
alias drop="dragon-drop -x"
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias teapot="curl https://http.cat/418 -o 418.jpg && kitty +kitten icat 418.jpg"
alias sdev="ssh bl-dev-jump-srv-01.us-central1-c.bytelearn-gcp"
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# apps
alias arch="docker run -w /root -it archlinux sh -uelic '
    pacman -Sy git
    bash ' "
alias b='bat'
alias ani="ani-cli"
alias batr="bat README.md"
alias c='clear && reload'
alias calc="kalker"
alias calcc="insect"
alias chx="chmod +x"
alias cloc="tokei"
alias ct='cht.sh' #curl cht.sh/:learn
alias dh='dirs -v'
alias dk='docker'
alias dv='devour'
alias f='tuxi '
alias fastwget='aria2c -x 16'
alias ff='tuxi -u'
alias fire='firefox'
alias kubuntu="kubectl run temp-shell --rm -i --tty --image ubuntu -- bash"
alias icat='kitty +kitten icat'
alias j='just'
alias jctl='journalctl -p3 --pager-end'
alias jctll='journalctl -f -n 100'
alias kb="kubectl"
alias lswifi="nmcli conn show"
alias wifils="nmcli conn show"
alias libre="libreoffice"
alias mp.="mpv ."
alias n='neovide --maximized '
alias nn='nvim'
alias op='xdg-open'
alias tf="terraform"
# alias vpn="$HOME/.scripts/ovpn3"
# alias vpn="printf "%s\n%s\n" "umang.bhalla" "4a=Fyb" | openvpn3 session-start --config $HOME/downloads/client.ovpn "
# alias vppause="openvpn3 session-manage --pause -o  `openvpn3 sessions-list | head -n 2 | tail -n 1 | cut -d ':' -f2 | tr -d '\n'` "
# alias vpresume="openvpn3 session-manage --resume -o  `openvpn3 sessions-list | head -n 2 | tail -n 1 | cut -d ':' -f2 | tr -d '\n'` "
alias pacman='sudo pacman'
alias ping='prettyping'
alias podcast='castero'
alias pp='python'
alias qr='curl -F-=\<- qrenco.de'
# alias r='ranger .'
alias rec='asciinema rec'
alias reload='source ~/.config/zsh/.zshrc'
alias s='startx'
alias sva="source venv/bin/activate"
alias sc='tty-clock -SscC0'
alias sf='surf '
alias dsql="docker run --env="MYSQL_ROOT_PASSWORD=root_password" -p 3306:3306 -d mysql:latest"
alias sqlroot="mycli mariadb://root@localhost:3306 -p root_password"
alias sys='systemctl'
alias sysu='systemctl --user'
alias tree='tree -aC -I .git --dirsfirst'
alias tty-clock="tty-clock -C6 -c -t"
alias v='vim'
alias viv='vivaldi-stable'
alias ww="when"
alias wgetr='wget -r --no-parent'
alias zathura='zathura --fork'
alias zshbench='repeat 10 time zsh -i -c exit'
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# confirm before removing something
alias rm='rm -iv'
alias rmf="rm -f"
alias rmrf="rm -rf"
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# pkg managers
alias aura='sudo aura'
alias fyay='sudo pacman --overwrite "*" -Syu'
alias yay='paru'
alias yayr='paru -Rcns'
alias yup='paru -Qq > ~/program-list'
alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)
alias updt='sudo pacman -Sy && sudo powerpill -Su && paru -Su'
alias unlock='sudo rm /var/lib/pacman/db.lck'  
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# configs
alias nb='nvim ~/.config/bspwm/bspwmrc'
alias np='nvim ~/.config/picom.conf'
alias ns='nvim ~/.config/sxhkd/sxhkdrc'
# alias nz='nvim ~/.config/zsh/.zshrc'
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# get fast mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrorr="sudo reflector --latest 50  --sort rate --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --verbose --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --verbose --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --verbose --sort age --save /etc/pacman.d/mirrorlist"
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Colorize grep output (good for log files)
alias egrep='egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias fgrep='fgrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Changing "ls" to "exa"
alias la='(exa --git -ahl --color=always --group-directories-first --sort date) | bat ' # my preferred listing
alias lr='(exa -R --color=always --group-directories-first) |bat '  # all files and dirs
alias ll='(exa -al --color=always --group-directories-first --sort name) '  # all files and dirs
alias ld='(exa --git -l --color=always --group-directories-first --sort date) | bat'  # long format
alias lt='(exa -aT --color=always --group-directories-first)| bat' # tree listing
alias l='exa -a --color=always --group-directories-first --sort date'
alias l.='exa -a | egrep "^\." | bat'
alias g="grep"
alias ls='exa --icons --color=always --group-directories-first'
alias lcr='exa -lhFT --color=always --icons --sort=size --group-directories-first'
# alias ls='exa --color=always --group-directories-first'
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
alias cpv="cp -v"
alias cpvr="cp -vr"
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# youtube-dl
alias ytf=' ytfzf -t '
alias ytp='yt-dlp --extract-audio --audio-format opus --cookies $HOME/cookies.txt https://music.youtube.com/playlist\?list\=LM'
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# doom rarely used
alias emacs="emacsclient -c -a 'emacs'"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# crpt
alias md5='md5sum'
alias s128='sha128sum'
alias s256='sha256sum'
alias s512='sha512sum'
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ports
alias ports='sudo lsof -Pni'
alias conn='netstat -Wat | grep ESTABLISHED'
alias bands='sudo bandwhich'
alias covid='curl https://corona-stats.online\?minimal\=true | bat'
alias sprng="curl -fsLF 'sprunge=<-' http://sprunge.us "
alias ixi="curl -F 'f:1=<-' ix.io"
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# depreiciated
# open_with_fzf() {
#     fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
# }
# cd_with_fzf() {
#     \cd $HOME && \cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
# }
# alias cz='cd_with_fzf'
# alias oz='open_with_fzf'
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
map() {
  default=$1
  shift
  for i in $@
  do
    alias -s $i=$default
  done
}

map $BROWSER htm html de org net com at cx nl se dk dk php

map $EDITOR cpp cxx cc c hh h inl asc txt TXT tex

map $XIVIEWER jpg jpeg png gif mng tiff tif xpm

map $PLAYER ape avi flv mkv mov mp3 mpeg mpg ogg ogm rm wav webm opus
alias -s pdf=zathura
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
