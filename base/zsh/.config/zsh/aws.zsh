if (( $+commands[aws_completer] )); then
  autoload bashcompinit && bashcompinit
  complete -C "$(which aws_completer)" aws
fi
