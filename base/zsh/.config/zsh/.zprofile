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
#export GOPATH=$HOME/go
#export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

### "bat" as manpager
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# export MANPAGER="nvim -c 'set ft=man' -"
export XAUTHORITY=/home/umang/.Xauthority
export MANPAGER='nvim +Man!'
export BROWSER=firefox
export ZSH=$HOME/.oh-my-zsh
export CM_LAUNCHER=rofi
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk/jre/'
export _JAVA_AWT_WM_NONREPARENTING=1
export PATH=$JAVA_HOME/bin:$PATH 
export ANDROID_SDK_ROOT='/opt/android-sdk'
export CHROME_EXECUTABLE='/usr/bin/google-chrome-stable'
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
export PATH=$PATH:'/home/umang/.node_modules/bin'
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=$PATH:/home/umang/.cargo/bin
export PATH=$PATH:/home/umang/.local/share/gem/ruby/3.0.0/bin

export TESSDATA_PREFIX=/usr/share/tessdata

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

export VISUAL=nvim
export EDITOR="$VISUAL"



