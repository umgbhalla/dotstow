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



function pthn() {
    export PATH="$1:$PATH"
}

#pth /usr/local/go/bin:$GOPATH/bin


########################
# ENVIORNMENT variables
########################
export ARCHFLAGS="-arch x86_64"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LLC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/tmp/$USER-data/"

export GOPATH=$HOME/go
export XAUTHORITY=$HOME/.Xauthority
### "$$$" as manpager
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANPAGER="nvim -c 'set ft=man' -"
export MANPAGER='nvim +Man!'
export BROWSER=firefox
# export ZSH=$HOME/.oh-my-zsh
export CM_LAUNCHER=rofi
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk/jre/'
export _JAVA_AWT_WM_NONREPARENTING=1
export ANDROID_SDK_ROOT='/opt/android-sdk'
export CHROME_EXECUTABLE='/usr/bin/google-chrome-stable'
export TESSDATA_PREFIX=/usr/share/tessdata
export BUN_INSTALL=$HOME/.bun

pthn $JAVA_HOME/bin
pthn $ANDROID_SDK_ROOT/tools/bin/
pthn $ANDROID_ROOT/emulator
pthn $ANDROID_SDK_ROOT/tools/
pthn $HOME/.node_modules/bin
pthn $HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
pthn $HOME/.cargo/bin
pthn $HOME/.local/share/gem/ruby/3.0.0/bin
pthn $BUN_INSTALL/bin


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


# 10ms for key sequences
KEYTIMEOUT=1

export VISUAL=nvim
export EDITOR="$VISUAL"
