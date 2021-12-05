# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

bindkey "^K"      kill-whole-line                      # ctrl-k
bindkey "^D"      delete-char                          # ctrl-d
bindkey "^F"      forward-char                         # ctrl-f
bindkey "^B"      backward-char                        # ctrl-b
bindkey "^[[F"    end-of-line                          # end
bindkey "^[[H"    beginning-of-line                    # home
bindkey "^[[3~"   backward-delete-char                 # delete
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
bindkey "^[." insert-last-word
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# edit command in vim with ^E
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
bindkey -a 'u' undo
bindkey -a '^R' redo
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
bindkey -v
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# esc to change block to line cursor , vim like
zle-keymap-select () {
if [ $KEYMAP = vicmd ]; then
    printf "\033[2 q"
else
    printf "\033[6 q"
fi
}
zle -N zle-keymap-select
zle-line-init () {
zle -K viins
printf "\033[6 q"
}
zle -N zle-line-init

