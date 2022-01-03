ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=200
HISTFILE="$HOME/.zsh_history"
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

histopts=( 
  BANG_HIST 
  EXTENDED_HISTORY 
  INC_APPEND_HISTORY 
  SHARE_HISTORY 
  HIST_EXPIRE_DUPS_FIRST 
  HIST_IGNORE_DUPS 
  HIST_IGNORE_ALL_DUPS 
  HIST_FIND_NO_DUPS 
  HIST_IGNORE_SPACE 
  HIST_SAVE_NO_DUPS
)
setopt $histopts

miscopts=( 
  auto_cd
  complete_in_word
  complete_aliases
  prompt_subst
  transient_rprompt
  menu_complete
  complete_in_word
  magicequalsubst
  always_to_end auto_pushd
  pushd_ignore_dups
  interactive_comments
  extended_glob
  short_loops
  no_bg_nice
  no_check_jobs
  no_hup
)
setopt $miscopts

unopts=(
  flowcontrol 
  bg_nice 
  nomatch
  prompt_sp
  global_rcs
)
unsetopt $unopts

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
unset zle_bracketed_paste
# autoload -Uz tetriscurses
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
#
