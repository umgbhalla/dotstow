
# 
ghub(){
  cd ~/hub
  git clone $@
}
# 


# 
oxo() {
  if [ -f "$1" ] ; then
    temp="file=@"
  else
    temp="shorten="
  fi

  link=$(curl -F"$temp$1" https://0x0.st 2> /dev/null)
  if [ ! -z "$link" ] ; then
    echo "$link"
    echo "$link" | xclip -selection clipboard
  fi
}

spr (){
  cat "$@" \
    | command curl -fsLF 'sprunge=<-' http://sprunge.us \
    | tr -d "\n" \
    | xclip -in -sel clip && \
    notify-send -t 900 -u low "Sprunge copied to clipboard!"

  }
# 


# 
chmu(){
  tuxi -u $@ | grep http | xcopy 
  notify-send -t 900 -u low "hogya bhai google"
}
# 


# 
ghs(){
  tuxi -u $@ "github repo" | grep http | fzf | xargs -r firefox
}
# 


# 
#hide_on_open
ho() { tdrop -a auto_hide; "$@" && tdrop -a auto_show }
mpq() { setsid mpv --input-ipc-server=/tmp/mpvsocket$(date +%s) -quiet "$1" >/dev/null 2>&1}
# 



# 
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
# 


# 
keyb(){
  setxkbmap -option caps:swapescape && xset r rate 230 30
  notify-send "caps esc swapped and keyrate set to 230::30"
}
# 


# 
up_widget() {
  BUFFER="cd .."
  zle accept-line
}
zle -N up_widget
bindkey "^\\" up_widget
# 


# 
bye() {
  BUFFER="exit"
  zle accept-line
}
zle -N bye
bindkey "^q" bye
# 


# 
musicplayer() {
  BUFFER="mz"
  zle accept-line
}
zle -N musicplayer
bindkey "^o" musicplayer
# 

# # 
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
# # 


# 
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
# 



# 



256color() {
  for code in {0..255};
  do echo -e "\e[38;05;${code}m $code: Test";
  done
}



killall() {
  ps -ef | grep $1 | grep -v grep | awk '{print $2}' | xargs kill -9;
}

# killport() {
#     lsof -i tcp:8080 | grep LISTEN | awk '{print $2}' | xargs kill;
# }

# parentProcess () {
#     ps -p "$1" -o ppid=
# }

# user_commands=(
# list-units is-active status show help list-unit-files
# is-enabled list-jobs show-environment cat)

# sudo_commands=(start stop reload restart try-restart isolate kill
# reset-failed enable disable reenable preset mask unmask
# link load cancel set-environment unset-environment
# edit)

# for c in $user_commands; do alias sc-$c="systemctl $c"; done
# for c in $sudo_commands; do alias sc-$c="sudo systemctl $c"; done


# fancy history search via C-r
function exists { which $1 &> /dev/null; }
if exists percol; then
  function percol_select_history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
    CURSOR=$#BUFFER         # move cursor
    zle -R -c               # refresh
  }
zle -N percol_select_history
bindkey '^R' percol_select_history
fi

function fail {
  echo $1 >&2
  exit 1
}

function retry {
  local n=1
  local max=50
  while true; do
    "$@" && break || {
      if [[ $n -lt $max ]]; then
        ((n++))
        echo "Command failed. Attempt $n/$max:"
        sleep $n;
      else
        fail "The command has failed after $n attempts."
      fi
    }
done
}

# tranlate given string with online leo dictonary
# depends on: lynx, perl

bytesToHumanReadable() {
  numfmt --to=iec-i --suffix=B --padding=7 $1
}

convertsecs() {
  eval "echo $(date -ud "@${1}" +'$((%s/3600/24/356)) years $((%s/3600/24 % 356)) days %H hours %M minutes %S seconds')"
}


calc () {
  echo "$*" | bc -l;
}

randomstring() {
  strings /dev/urandom | grep -o '[[:alnum:]]' | head -n "${1:-30}" | tr -d '\n'; echo
}

alias randstr=randomstring

# man() {
#     command man -t "$1" | ps2pdf - /tmp/"$1".pdf && zathura /tmp/"$1".pdf
# }


# lastdir() {
#     last_dir="$(\ls -Frt | grep '/$' | tail -n1)"
#     if [ -d "$last_dir" ]; then
#         cd "$last_dir"
#     fi
# }

# cycle() {
#     last_dir="$(\ls -Frt | grep '/$' | tail -n1)"
#     if [ -d "$last_dir" ]; then
#         cd "$last_dir"
#     fi
# }




orphans() {
  if [[ ! -n $(pacman -Qdt) ]]; then
    echo "No orphans to remove."
  else
    sudo pacman -Rns $(pacman -Qdtq)
  fi
}


function repeat() {
  local i max
  max=$1; shift;
  for ((i=1; i <= max ; i++)); do  # --> C-like syntax
    eval "$@";
  done
}

# # tex compile and clean up command
# function cleantex() {
#     pdf=$(echo $1 | sed 's/tex/pdf/g')
#     log=$(echo $1 | sed 's/tex/log/g')
#     out=$(echo $1 | sed 's/tex/out/g')
#     aux=$(echo $1 | sed 's/tex/aux/g')
#     toc=$(echo $1 | sed 's/tex/toc/g')
#     lof=$(echo $1 | sed 's/tex/lof/g')
#     lot=$(echo $1 | sed 's/tex/lot/g')
#     bbl=$(echo $1 | sed 's/tex/bbl/g')
#     blg=$(echo $1 | sed 's/tex/blg/g')
#     dvi=$(echo $1 | sed 's/tex/dvi/g')
#     fbd=$(echo $1 | sed 's/tex/fdb\_latexmk/g')
#     fls=$(echo $1 | sed 's/tex/fls/g')
#     ps=$(echo $1 | sed 's/tex/ps/g')
#     tdo=$(echo $1 | sed 's/tex/tdo/g')
#     rm $log; rm $out; rm $aux; rm $toc; rm $lof; rm $lot;
#     rm $bbl; rm $blg; rm $dvi; rm $fdb; rm $fls; rm $ps; rm $tdo;
# }

# function texnonstop() {
#     latexmk -pvc -pdf --latex=lualatex -interaction=nonstopmode $1
# }


printcolors() {
  x=`tput op` y=`printf %$((${COLUMNS}-6))s`;
  for i in {0..7};
  do
    o=00$i;
    echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;
  done
}

function countdown() {
  date1=$((`date +%s` + $1));
  while [ "$date1" -ge `date +%s` ]; do
    echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
    sleep 0.1
  done
}

function timer() {
  date1=`date +%s`;
  while true; do
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
  done
}

function cd() {
  new_directory="$*";
  if [ $# -eq 0 ]; then
    new_directory=${HOME};
  fi;
  builtin cd "${new_directory}" && exa
}


gdb_get_backtrace() {
  local exe=$1
  local core=$2

  gdb ${exe} \
    --core ${core} \
    --batch \
    --quiet \
    -ex "thread apply all bt full" \
    -ex "quit"
  }

# screen recoding to webm best uploaded at http://webmshare.com/ (gyfact cuts at 15 sec)
record () {
  # $1 resolution $2 offset x $3 offset y $4 output example:
  # ffmpeg -f x11grab -s 1024x768 -i :0.0+10,100 -c:v libvpx -crf 12 -b:v 500K ouput.webm
  ffmpeg -f x11grab -s $1 -i :0.0+$2,$3 -c:v libvpx -crf 12 -b:v 500K $4
  # open with firefox output.webm
}

# Get a 42 chars password: generate-password 42
generate-password() {
  if [[ 18 -lt $1 ]] then
    strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n'; echo;
  else
    echo "password to short unsecure"
  fi
}

function monitor() {
  watch -n1 -t "lsof -i -n|awk '{print \$1, \$2, \$9}'|column -t";
}

########################
# fzf enhanced functions
########################


# 
# find-in-file - usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi
  rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}
# 

# Search and install packages with yay and fzf
yi() {
  SELECTED_PKGS="$(yay -Slq | fzf --header='Install packages' -m --height 100% --preview 'yay -Si {1}')"
  if [ -n "$SELECTED_PKGS" ]; then
    yay -S $(echo $SELECTED_PKGS)
  fi
}
# 

# 
# Search and remove packages with yay and fzf
yr() {
  SELECTED_PKGS="$(yay -Qsq | fzf --header='Remove packages' -m --height 100% --preview 'yay -Si {1}')"
  if [ -n "$SELECTED_PKGS" ]; then
    yay -Rns $(echo $SELECTED_PKGS)
  fi
}
# 



fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}


# 
# process search and kill
psk() { ps -afx|  fzf |  xargs -0 -I {} echo {} | awk '{ printf $1 }' | xargs -0 -I {}  kill -9  {}; }
# psk() {
#   local pid
#   pid=$(ps ax | sed 1d | fzf -m | awk '{print $1}')
#   if [ "x$pid" != "x" ]
#   then
#     echo $pid | xargs kill -${1:-9}
#   fi
# }
# 

# cd into the directory of the selected file
fzd() {
  local file
  local dir
  cd $HOME && file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
zle -N fzd{,}
bindkey '^F' fzd


# fshow - git commit browser
gl() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
    --bind "ctrl-m:execute:
      (grep -o '[a-f0-9]\{7\}' | head -1 |
        xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
              {}
              FZF-EOF"
            }

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --color=never --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
  }
# source /usr/share/fzf/key-bindings.zsh


# Key bindings
# ------------
if [[ $- == *i* ]]; then

# CTRL-T - Paste the selected file path(s) into the command line
# __fsel() {
#   local cmd="${FZF_ALT_C_COMMAND:-"cd $HOME && rg --files --hidden -g ''"}"
#   setopt localoptions pipefail 2> /dev/null
#   eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
#     echo -n "${(q)item} "
#   done
#   local ret=$?
#   echo
#   return $ret
# }

# __fzf_use_tmux__() {
#   [ -n "$TMUX_PANE" ] && [ "${FZF_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ]
# }

# __fzfcmd() {
#   __fzf_use_tmux__ &&
#     echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
# }

# fzf-file-widget() {
#   LBUFFER="${LBUFFER}$(__fsel)"
#   local ret=$?
#   zle redisplay
#   typeset -f zle-line-init >/dev/null && zle zle-line-init
#   return $ret
# }
# zle     -N   fzf-file-widget
# bindkey '^T' fzf-file-widget


# fzf-cd-widget() {
#   # cd $HOME
#   local cmd="${FZF_ALT_C_COMMAND:-"rg --files --hidden -g ''"}"
#   setopt localoptions pipefail 2> /dev/null
#   local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
#   if [[ -z "$dir" ]]; then
#     zle redisplay
#     return 0
#   fi
#   cd $(dirname "$dir")
#   local ret=$?
#   zle reset-prompt
#   typeset -f zle-line-init >/dev/null && zle zle-line-init
#   return $ret
# }

# zle     -N    fzf-cd-widget
# bindkey '^F' fzf-cd-widget

# # CTRL-R - Paste the selected command from history into the command line
# fzf-history-widget() {
#   local selected num
#   setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
#   selected=( $(fc -l 1 |
#     FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(q)LBUFFER} +m" $(__fzfcmd)) )
#   local ret=$?
#   if [ -n "$selected" ]; then
#     num=$selected[1]
#     if [ -n "$num" ]; then
#       zle vi-fetch-history -n $num
#     fi
#   fi
#   zle redisplay
#   typeset -f zle-line-init >/dev/null && zle zle-line-init
#   return $ret
# }
# zle     -N   fzf-history-widget
# bindkey '^R' fzf-history-widget

fi
