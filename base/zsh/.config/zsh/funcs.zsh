## Functions
feval(){
echo | fzf -q "$*" --preview-window=up:99% --preview="eval {q}"
}

# Some of this was stolen, amongst others, from https://github.com/SmartFinn/dotfiles.
mk() {
  mkdir -p $@ && cd ${@:$#}
}
#
# Find inside (with previews)
fman() {
  man -k . | fzf -q "$1" --prompt='man> ' --preview-window 'right:60%:wrap' --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Credits: https://github.com/slashbeast/conf-mgmt/blob/master/roles/home_files/files/DOTzshrc
confirm() {
  local answer
  printf "zsh: sure you want to run '${YELLOW}$*${NC}' [yN]? "
  read -q answer
  echo
  if [[ "${answer}" =~ ^[Yy]$ ]]; then
    command "${@}"
  else
    return 1
  fi
}
confirm_wrapper() {
  local prefix=''

  if [ "$1" = '--root' ]; then
    local as_root='true'
    shift
  fi
  if [ "${as_root}" = 'true' ] && [ "${USER}" != 'root' ]; then
    prefix="sudo"
  fi
  confirm ${prefix} "$@"
}

poweroff() { confirm_wrapper --root $0 "$@"; }
reboot() { confirm_wrapper --root $0 "$@"; }
hibernate() { confirm_wrapper --root $0 "$@"; }

get-ip() { 
  local j=$(curl -Ss "https://ifconfig.me")
  echo $j
}
get-ip!() { curl -Ss "https://ipapi.co/$(get-ip)/yaml" }

# proj(){
#  local dir="$PROJECTS"
# if [[ $# == 0 ]]; then
#     cd $dir/$(find $dir -maxdepth 2 -type d  ! -path "*.git*" | sed -E "s#^$dir##"| fzf)
#   else
#     cd $dir/$1;
#   fi
# }
#
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Make a new tmux window and run $@ in it
# nw() {
#   tmux new-window
#   tmux send-keys "$*" C-m
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
packs(){
  pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# viv-git(){
# vivaldi-stable \
#     --no-sandbox \
#     --disable-background-networking \
#     --disable-background-timer-throttling \
#     --disable-backing-store-limit \
#     --disable-breakpad \
#     --app=https://github.com \
#     $@ >/dev/null 2>&1 &
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
globalias() {
  # Get last word to the left of the cursor:
  # (z) splits into words using shell parsing
  # (A) makes it an array even if there's only one element
  local word=${${(Az)LBUFFER}[-1]}
  if [[ $GLOBALIAS_FILTER_VALUES[(Ie)$word] -eq 0 ]]; then
    zle _expand_alias
    zle expand-word
  fi
  zle self-insert
}
zle -N globalias

# space expands all aliases, including global
bindkey -M emacs " " globalias
bindkey -M viins " " globalias

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# wherecat(){
# 	bat $(whereis $1| awk '{print $2}')
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
zathura (){
  /bin/zathura $@ & disown
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
nz() { 
  find ~/.config/zsh/ -maxdepth 1 -type f | fzf | xargs -r nvim 
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

ghub(){
  cd ~/hub
  git clone $@
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

pthf()
{
  echo $PATH | sed 's/:/\n/g' | fzf
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# oxo() {
#   if [ -f "$1" ] ; then
#     temp="file=@"
#   else
#     temp="shorten="
#   fi

#   link=$(curl -F"$temp$1" https://0x0.st 2> /dev/null)
#   if [ ! -z "$link" ] ; then
#     echo "$link"
#     echo "$link" | xclip -selection clipboard
#   fi
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

spr (){
  cat "$@" \
    | command curl -fsLF 'sprunge=<-' http://sprunge.us \
    | tr -d "\n" \
    | xclip -in -sel clip && \
    notify-send -t 900 -u low "Sprunge copied to clipboard!"

  } 

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

#hide_on_open
# ho() { tdrop -a auto_hide; "$@" && tdrop -a auto_show }
# mpq() { setsid mpv --input-ipc-server=/tmp/mpvsocket$(date +%s) -quiet "$1" >/dev/null 2>&1}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# usage: ex <file>

ex() {
  for f in "$@"
  do
    if [ ! -f "$f" ]; then
      printf "extract: '%s' is not a file\n" "$f" >&2
      return 1
    fi

    case "$f" in
      *.tar)	tar -xf "$f"			;;
      *.tar.bz|*.tbz| \
        *.tar.bz2|*.tbz2)
              tar -xjf "$f"					;;
            *.tar.gz|*.tgz)
              tar -xzf "$f"					;;
            *.tar.xz|*.txz)
              tar -xJf "$f"					;;
            *.tar.[zZ]|*.t[zZ])
              tar -xZf "$f"					;;
              *.tar.lz|*.tlz| \
                *.tar.lzma|*.tlzma| \
                *.tar.lzo|*.tzo| \
                *.tar.zst|*.tzst)
                              tar -xaf "$f"					;;
                            *.7z)		7za x -- "$f"			;;
                            *.a|*.ar)
                              ar x -- "$f"					;;
                            *.ace)	unace e -- "$f"		;;
                            *.alz)	unalz -- "$f"			;;
                            *.arc|*.ark|*.ARC|*.ARK)
                              nomarch -- "$f"				;;
                            *.arj|*.ARJ)
                              arj e -r -- "$f"			;;
                            *.bz|*.bz2)
                              bunzip2 -k -- "$f"		;;
                            *.cab|*.CAB|*.exe|*.EXE)
                              cabextract "$f"				;;
                            *.cpio) cpio -id -F "$f"	;;
                            *.deb)	dpkg -x -- "$f" .	;;
                            *.gz)		gunzip -k "$f"		;;
                            *.lha|*.lzh)
                              lha x "$f"						;;
                            *.lrz|*.lrzip|*.rz)
                              lrunzip -- "$f"				;;
                            *.lz)		lzip -d -k -- "$f";;
                            *.lz4)	unlz4 -- "$f"			;;
                            *.lzma) xz -d -k "$f"			;;
                            *.lzo)	lzop -x "$f"			;;
                            *.rar)	unrar x -- "$f"		;;
                            *.src.rpm|*.rpm|*.spm)
                              rpm2cpio "$f" | cpio -dium;;
                            *.xz)		unxz -k -- "$f"		;;
                            *.[zZ]) uncompress -- "$f";;
                            *.zip)	unzip -- "$f"			;;
                            *.zst)	unzstd -- "$f"		;;
                            *.AppImage)
                              ./"$f" --appimage-extract;;
                            *)
                              printf "extract: '%s' - unkwown archive format\n" "$f" >&2
                              return 1
                          esac
                        done
                      }

                    archive() {
                      if [ "$#" -lt 2 ]; then
                        printf "usage: $0 <ARCHIVE> [FILE...]\n" >&2
                        return 1
                      fi

                      local archive="$1"; shift

                      case "$archive" in
                        *.tar.bz|*.tbz| \
                          *.tar.bz2|*.tbz2)
                            tar -cjf "$archive" "$@" ;;
                          *.tar.gz|*.tgz)
                            tar -czf "$archive" "$@" ;;
                          *.tar.xz|*.txz)
                            tar -cJf "$archive" "$@" ;;
                          *.tar.[zZ]|*.t[zZ])
                            tar -cZf "$archive" "$@" ;;
                            *.tar.lzma|*.tlzma| \
                              *.tar.lzo|*.tzo| \
                              *.tar.lz|*.tlz)
                            tar -caf "$archive" "$@" ;;
                          *.tar)
                            tar -cf  "$archive" "$@" ;;
                          *.7z)
                            7za a		 "$archive" "$@" ;;
                          *.zip)
                            zip -r	 "$archive" "$@" ;;
                          *)
                            printf "'%s' is unknown archive format\n" "$archive" >&2
                            return 1
                        esac
                      }

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

keyb(){
setxkbmap -option caps:swapescape && xset r rate 230 30
notify-send "caps esc swapped and keyrate set to 230::30"
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

up_widget() {
BUFFER="cd .."
zle accept-line
}
zle -N up_widget
bindkey "^\\" up_widget
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

bye() {
BUFFER="exit"
zle accept-line
}
zle -N bye
bindkey "^q" bye
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# fzf-z-search() {
#   local res=$(history -n 1 | fzf)
#   if [ -n "$res" ]; then
#     BUFFER+="$res"
#     zle accept-line
#   else
#     return 0
#   fi
# }
# zle -N fzf-z-search
# bindkey '^s' fzf-z-search
                                                                                        # >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# 256color() {
#   for code in {0..255};
#   do echo -e "\e[38;05;${code}m $code: Test";
#   done
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# killall() {
#   ps -ef | grep $1 | grep -v grep | awk '{print $2}' | xargs kill -9;
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

killport() {
  lsof -i tcp:8080 | grep LISTEN | awk '{print $2}' | xargs kill;
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# parentProcess () {
#     ps -p "$1" -o ppid=
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# user_commands=(
# list-units is-active status show help list-unit-files
# is-enabled list-jobs show-environment cat)

# sudo_commands=(start stop reload restart try-restart isolate kill
# reset-failed enable disable reenable preset mask unmask
# link load cancel set-environment unset-environment
# edit)

# for c in $user_commands; do alias sc-$c="systemctl $c"; done
# for c in $sudo_commands; do alias sc-$c="sudo systemctl $c"; done
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# fancy history search via C-r
# function exists { which $1 &> /dev/null; }
# if exists percol; then
#   function percol_select_history() {
#     local tac
#     exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
#     BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
#     CURSOR=$#BUFFER         # move cursor
#     zle -R -c               # refresh
#   }
# zle -N percol_select_history
# bindkey '^R' percol_select_history
# fi
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# bytesToHumanReadable() {
#   numfmt --to=iec-i --suffix=B --padding=7 $1
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# convertsecs() {
#   eval "echo $(date -ud "@${1}" +'$((%s/3600/24/356)) years $((%s/3600/24 % 356)) days %H hours %M minutes %S seconds')"
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

calc () {
  echo "$*" | bc -l;
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# randomstring() {
#   strings /dev/urandom | grep -o '[[:alnum:]]' | head -n "${1:-30}" | tr -d '\n'; echo
# }
# alias randstr=randomstring
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

manpdf() {
  command man -t "$1" | ps2pdf - /tmp/"$1".pdf && zathura /tmp/"$1".pdf
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



# lastdir() {
#     last_dir="$(\ls -Frt | grep '/$' | tail -n1)"
#     if [ -d "$last_dir" ]; then
#         cd "$last_dir"
#     fi
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# cycle() {
#     last_dir="$(\ls -Frt | grep '/$' | tail -n1)"
#     if [ -d "$last_dir" ]; then
#         cd "$last_dir"
#     fi
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


orphans() {
  if [[ ! -n $(pacman -Qdt) ]]; then
    echo "No orphans to remove."
  else
    sudo pacman -Rns $(pacman -Qdtq)
  fi
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function repeat() {
  local i max
  max=$1; shift;
  for ((i=1; i <= max ; i++)); do  # --> C-like syntax
    eval "$@";
  done
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


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
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# function texnonstop() {
#     latexmk -pvc -pdf --latex=lualatex -interaction=nonstopmode $1
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# printcolors() {
#   x=`tput op` y=`printf %$((${COLUMNS}-6))s`;
#   for i in {0..7};
#   do
#     o=00$i;
#     echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;
#   done
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


function countdown() {
  date1=$((`date +%s` + $1));
  while [ "$date1" -ge `date +%s` ]; do
    echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
    sleep 0.1
  done
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


function timer() {
  date1=`date +%s`;
  while true; do
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
  done
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# function cd() {
#   new_directory="$*";
#   if [ $# -eq 0 ]; then
#     new_directory=${HOME};
#   fi;
#   builtin cd "${new_directory}" && exa
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# gdb_get_backtrace() {
#   local exe=$1
#   local core=$2

#   gdb ${exe} \
#     --core ${core} \
#     --batch \
#     --quiet \
#     -ex "thread apply all bt full" \
#     -ex "quit"
#   }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Get a 42 chars password: generate-password 42
# generate-password() {
#   if [[ 18 -lt $1 ]] then
#     strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n'; echo;
#   else
#     echo "password to short unsecure"
#   fi
# }
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function monitor() {
  watch -n1 -t "lsof -i -n|awk '{print \$1, \$2, \$9}'|column -t";
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
########################
# fzf enhanced functions
########################
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# find-in-file - usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi
  rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Search and install packages with yay and fzf
yi() {
  SELECTED_PKGS="$(yay -Slq | fzf --header='Install packages' -m --height 100% --preview 'yay -Si {1}')"
  if [ -n "$SELECTED_PKGS" ]; then
    yay -S $(echo $SELECTED_PKGS)
  fi
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Search and remove packages with yay and fzf
yr() {
  SELECTED_PKGS="$(yay -Qsq | fzf --header='Remove packages' -m --height 100% --preview 'yay -Si {1}')"
  if [ -n "$SELECTED_PKGS" ]; then
    yay -Rns $(echo $SELECTED_PKGS)
  fi
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --preview 'bat --color=always --style=header,grid --line-range :300  {} '))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# cd into the directory of the selected file
# fzd() {
#   local file
#   local dir
#   cd $HOME && file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
# }
# zle -N fzd{,}
# bindkey '^F' fzd
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# gl - git commit browser
gl() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
    --bind "ctrl-m:execute:
      (grep -o '[a-f0-9]\{7\}' | head -1 |
        xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
              {}
              FZF-EOF"
            } # >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# flog - checkout git commit
flog() {
  local commits commit
  commits=$(git log --color=never --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
  }
# source /usr/share/fzf/key-bindings.zsh


# Key bindings
# ------------
# if [[ $- == *i* ]]; then

# # CTRL-T - Paste the selected file path(s) into the command line
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
# fi
#
#
#
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Imagemagick
## Resize images
75%() { mogrify -resize '75%X75%' "$@" ; }
50%() { mogrify -resize '50%X50%' "$@" ; }
25%() { mogrify -resize '25%X25%' "$@" ; }
## Scan folder for images of a certain ratio
#fzfimg() {
#images="$(\ls | \grep -i "\.\(png\|jpg\|jpeg\|gifv\|gif\|webp\|tif\|tiff\|ico\)\(_large\)*$")"
#if [ -z "$1" ]; then
#  echo $images |	fzf --preview 'geometry=$(identify -format '%wx%h' {}); ratio="$(printf %.3f "$((10**3 *${geometry%%x*}/${geometry##*x}))e-3")"; if [ $ratio = "1.777" ]; then printf "%s\n%s\n\033[1;34m█\n" "$geometry" "$ratio"; else printf "%s\n%s\n\033[1;31m█\n" "$geometry" "$ratio"; fi	' --multi --height=80%
#else
#  echo $images |	fzf --preview 'geometry=$(identify -format '%wx%h' {}); ratio="$(printf %.3f "$((10**3 *${geometry%%x*}/${geometry##*x}))e-3")"; if [ $ratio = "1.777" ]; then printf "%s\n%s\n\033[1;34m█\n" "$geometry" "$ratio"; else printf "%s\n%s\n\033[1;31m█\n" "$geometry" "$ratio"; fi;  chafa --symbols=block -c 240 {}' --multi --height=80%
#fi
#}


## pdf utils
#img2pdf() {
#  while read file; do
#    filebase=$(basename $file | cut -d'.' -f1)
#    convert -density 300 -quality 100 $file $filebase.pdf
#  done <<< $(ls)
#}
#compresspdf() {
#  gs			\
#    -sDEVICE=pdfwrite		\
#    -dCompatibilityLevel=1.4\
#    -dPDFSETTINGS=/screen	\
#    -dNOPAUS		\
#    -dBATCH			\
#    -dQUIET			\
#    -sOutputFile=$2.pdf	\
#    "$1"
#      ## PDFSETTINGS:		screen << ebook << prepress
#      #
#      ## If available, also try
#      #	 ps2pdf LARGE.pdf SMALL.pdf
#    }

## Web Stuff
### URL Shortener	| Usage : short <url>
#short() {
#  curl -F"shorten=$*" https://0x0.st
#}
### Upload-file | Usage : share /path/to/file.foo (256 Mib limit)
#share() {
#  if [[ $# == 0 ]]; then
#    printf "Usage: share FILE(s)\n"
#    return 1
#  fi
#  for f in "$@"; do
#    curl -sF"file=@${f}" https://0x0.st
#  done
#}
#cheat() {
#  curl -m 7 "https://cheat.sh/${1}"
#}
### Readable
#readw3m() {
#  readable -q $@ |
#    w3mwrap -T text/html
#  }
#readlynx() {
#  readable -q $@ |
#    lynx -editor=nvim -stdin -force_html
#  }
### A wget wrapper
#wgetext() {
#  if [ "$#" -lt 2 ]; then
#    cat <<- EOF
#    Download all files with specific extension on a webpage
#    Usage: $0 extension[,extension...] URL(s)
#    Example:
#    $0 mp4 http://example.com/files/
#    $0 mp3,ogg,wma http://samples.com/files/
#    Google: http://lmgtfy.com/?q=intitle%3Aindex.of+mp3+-html+-htm+-php+-asp+-txt+-pls+madonna
#    based on http://stackoverflow.com/a/18709707
#    EOF

#    return 1
#  fi

#  extensions="$1";
#  outputdir_name="$(awk -F/ '{print $(NF-1);}' <<< "$extensions")"; shift
#  mkdir -pv "$outputdir_name"
#  cd "$outputdir_name"

#  for f in $@; do
#    wget -c -r -l1 -H -t1 -nd -N -np -A "$extensions" -erobots=off "$f"
#  done
#}

## Games
#gog() {
#  local sel=$(fd -t f start.sh ~/slsk/games/GOG | cut -d/ -f7 | ccze -A | head -n -1| fzf --ansi	| head --bytes -2)
#  [ -n "$sel" ] && ~/slsk/games/GOG/"$sel"/start.sh
#}

## Locate wrappers
#llocate() {
#  local -a dbs=( -d /var/lib/mlocate/mlocate.db )

#  # don't throw errors when file globs don't match anything
#  setopt NULL_GLOB

#  for db in "$HOME/.cache/updatedb"/*.db; do
#    [ -f "$db" ] || break
#    dbs+=( -d "$db" )
#  done

# # unsetopt NULL_GLOB

# locate "${dbs[@]}" "$@"
#}
#updatedbmnt() {
#  # usage: updatedbmnt <mountpoint>
#  # http://askubuntu.com/questions/460535/how-do-i-tell-locate-to-keep-the-index-of-an-external-hdd
#  local db_file="${XDG_CACHE_HOME:=$HOME/.cache}/updatedb/$1:t.db"

#  [ -n "$1" ] || return 1

#  mkdir -p "$db_file:A:h"
#  updatedb -l 0 -o "$db_file" -U "$1"
#}
## vim: ft=zsh
