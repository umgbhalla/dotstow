# Make special variables duplicate-free.
typeset -gU path fpath cdpath

# Define functions to load them on execution.
foreach function (
  compinit
  promptinit
  surround
) {
  autoload -Uz $function
}

# Define module to load them on execution.
foreach module (
  complete
  complist
  datetime
  parameter
  regex
  zle
  zleparameter
  zpty
  zutil
) {
  zmodload zsh/$module
}

# Initialize the completion system with a cache time of 24 hours.
typeset -g zcompdump="$HOME/.local/share/zsh/zcompdump"
typeset -g comp_files=($zcompdump(Nm-24))

if (( $#comp_files )) {
  compinit -i -C -d $zcompdump
} else {
  compinit -i -d $zcompdump
}


# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST
zstyle ':completion:*:git-checkout:*' sort false # disable sort when completing `git checkout`
zstyle ':completion:*:descriptions' format '[%d]' # set descriptions format to enable group support
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # set list-colors to enable filename colorizing
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # case insensitive tab complete
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # preview directory's content with exa when completing cd
zstyle ':fzf-tab:*' switch-group ',' '.' # switch group using `,` and `.`

compdef -d mpv
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}


unset zcompdump
unset comp_files
