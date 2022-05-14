if (( $+commands[kubectl] )); then
  eval "$(flyctl completion zsh)"
  compdef _flyctl fly
fi
