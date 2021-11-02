
# git default branch
gitdefaultbranch(){
  git remote show origin | grep 'HEAD' | cut -d':' -f2 | sed -e 's/^ *//g' -e 's/ *$//g'
}
alias gitdb=gitdefaultbranch
alias gcodb='g checkout $(gitdb)'

# git current branch
gitcurrentbranch() {
  git symbolic-ref --short HEAD | tr -d "\n"
}
alias gcb=gitcurrentbranch

gitpull() {
  git pull --rebase origin $(gcb)
}
alias gpull=gitpull
gpush() {
  git push -u origin $(gcb)
}
alias gpush=gpush
gitcompush() {
  git add -A
  git commit --signoff -m $1
  git push -u origin $2
}
alias gitcompush=gitcompush
alias gcp='gitcompush $1 "$(gcb)"'

git-remote-add-merge() {
  git remote add upstream $1
  git fetch upstream
  git merge upstream/$(gitdb)
}
alias grfa=git-remote-add-merge

git-remote-merge() {
  git fetch upstream
  git merge upstream/$(gitdb)
}
alias grf=git-remote-merge

# ssh-keygen
rsagen() {
  ssh-keygen -t rsa -b 4096 -N $1 -f $HOME/.ssh/$2 -C $USER
}

sshls() {
  rg "Host " $HOME/.ssh/config | awk '{print $2}' | rg -v "\*"
}
alias sshls=sshls
