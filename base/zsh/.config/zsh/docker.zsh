alias sdocker="sudo systemctl start docker"
alias ssdocker="sudo systemctl stop docker && sudo systemctl stop docker.socket"
alias dockerkill='docker stop $(docker ps -a -q)'
alias dockps="docker ps -a"
alias dps="docker ps"
# Select a docker container to start and attach to
function da() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}
# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}
# Select a docker container to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}

# heh
dockerprune() {
    docker stop $(docker ps -a -q)
    sudo docker system prune -a -f;
    docker rm -vf $(docker ps -aq);
    docker rmi -f $(docker images -aq);
    docker volume prune -f;
}


zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
