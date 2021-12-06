autoload -Uz add-zsh-hook vcs_info # Enable substitution in the prompt.
local mark='*'
setopt prompt_subst # Run vcs_info just before a prompt is displayed (precmd)

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '!'
zstyle ':vcs_info:*' unstagedstr "+"
zstyle ':vcs_info:*' formats ' %s(%F{red}%b%f%c%u)'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git 
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
precmd () {
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    zstyle ':vcs_info:*' formats ' %F{yellow}%b%c%u%F{blue}'
  } else {
    zstyle ':vcs_info:*' formats " %F{yellow}%b%c%u%F{red}$mark%F{blue}"
  }
vcs_info
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
PROMPT="%F{green}%f%F{yellow}%~%f%F{green}%f"$'\n'"%F{white}🦀%f "
# right prompt shows time and branch name
RPROMPT='%F{8}%*%F{blue}${vcs_info_msg_0_}%f'

