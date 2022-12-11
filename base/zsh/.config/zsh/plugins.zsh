
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# External plugins
sie /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
sie /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
sie /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
sie /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh
if [[ -r /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

