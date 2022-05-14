if (( $+commands[terraform] )); then
  export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
  mkdir -p "$TF_PLUGIN_CACHE_DIR"

  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C terraform terraform

  alias t="terraform"
fi
