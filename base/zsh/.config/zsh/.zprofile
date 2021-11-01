# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi


function pth() {
  if [ -d "$1" ] ; then;
    export PATH="$1:$PATH"
  fi
}

#pth /usr/local/go/bin:$GOPATH/bin

### "$$$" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANPAGER="nvim -c 'set ft=man' -"

export GOPATH=$HOME/go
export XAUTHORITY=$HOME/.Xauthority
# export MANPAGER='nvim +Man!'
export BROWSER=firefox
export ZSH=$HOME/.oh-my-zsh
export CM_LAUNCHER=rofi
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk/jre/'
export _JAVA_AWT_WM_NONREPARENTING=1
export ANDROID_SDK_ROOT='/opt/android-sdk'
export CHROME_EXECUTABLE='/usr/bin/google-chrome-stable'
export TESSDATA_PREFIX=/usr/share/tessdata
export BUN_INSTALL=$HOME/.bun

pth $JAVA_HOME/bin
pth $ANDROID_SDK_ROOT/tools/bin/
pth $ANDROID_ROOT/emulator
pth $ANDROID_SDK_ROOT/tools/
pth $HOME/.node_modules/bin
pth $HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
pth $HOME/.cargo/bin
pth $HOME/.local/share/gem/ruby/3.0.0/bin
pth $BUN_INSTALL/bin


# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden '
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

export VISUAL=nvim
export EDITOR="$VISUAL"
