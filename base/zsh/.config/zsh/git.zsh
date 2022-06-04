
gcl(){
  git clone $@ && cd $(basename "$1" .git)
}


# git default branch
gitdefaultbranch(){
  git remote show origin | grep 'HEAD' | cut -d':' -f2 | sed -e 's/^ *//g' -e 's/ *$//g'
}
alias gitdb=gitdefaultbranch
alias gcodb='g checkout $(gitdb)'
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# git current branch
gitcurrentbranch() {
  git symbolic-ref --short HEAD | tr -d "\n"
}
alias gcb=gitcurrentbranch
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

gitpull() {
  git pull --rebase origin $(gcb)
}
alias gpull=gitpull
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

gitpush() {
  git push -u origin $(gcb)
}
alias gpush=gitpush
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

gitcmpush() {
  git add -A
  git commit --signoff -m $1
  git push -u origin $2
}
alias gitcompush=gitcmpush
alias gcp='gitcompush $1 "$(gcb)"'
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
git-pull-all-branch(){
git branch -r | grep -v '\->' | decolrtxt |  while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch --all
git pull --all
}

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
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
nuke_history(){
  git tag temp

  git checkout $1
  git checkout --orphan new_root
  git commit -m "chore(nuke): set new root "

  git rebase --onto new_root $1 $(gcb)

  git diff temp   # verification that it worked with no changes
  git tag -d temp
  git branch -D new_root
}

# ssh-keygen
rsagen() {
  ssh-keygen -t rsa -b 4096 -N $1 -f $HOME/.ssh/$2 -C $USER
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


sshls() {
  rg "Host " $HOME/.ssh/config | awk '{print $2}' | rg -v "\*"
}
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# aliases 
alias gad='git add .'
alias gc='google-chrome-stable'
alias gct='git commit -m'
alias gp='git pull'
alias gpuf='git push origin --force'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grm='git rebase master'
alias gs='git status -s'
alias gst='git status'
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gdiff='git diff --name-only --diff-filter=d | xargs bat --diff'

