
## Installing

You will need `git` and GNU `stow`

Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/umgbhalla/dotstow.git ~
```

Run `stow` to symlink everything or just select what you want

```bash
stow */ # Everything (the '/' ignores the README)
```

```bash
stow zsh # Just my zsh config
```

## Programs

An updated list of all the programs I use can be found in the `programs` directory


## Keybinds

|super + apostrophe               |  # terminal alacritty |
|super + Return                   |  # scratchpad without tmux session right |
|super + semicolon                |  # scratchpad without tmux session left |
|super + backslash                |  # tmux scratchpad top |
|super + slash                    |  # tmux scratchpad bottom |
|super + shift + Return           |  # terminal kitty |
|super + e                        |  # Shortcuts |
|super + w                        |  # firefox |
|super + n                        |  # thunar |
|super + d                        |  # dmenu_run |
|super + a                        |  # neovide |
|super + b                        |  # bpytop |
|super + space                    |  # program launcher |
|alt + shift + Return             |  # mini youtube |
|alt + Return                     |  # mini google |
|alt + e                          |  # rofimoji |
|alt + m                          |  # man search |
|alt + r                          |  # random manpage |
|alt + v                          |  # clipmenu |
|alt + h                          |  # keybindhelper |
|alt + o                          |  # scripts rofi menu ; open in nvim |
|alt + p                          |  # config rofi menu ; open in nvim |
|super + period                   |  # show open window |
|super + shift + d                |  # show ssh sesssions |
|super + p                        |  # power-menu  |
|super + shift + r                |  # make sxhkd reload its configuration files: |
|super + {t,shift + t,s}          |  # set the window state |
|super + f                        |  # toggle the window fullscreen |
|super + alt + {q,r}              |  # quit/restart bspwm |
|super + {_,shift + }q            |  # close and kill |
|super + m                        |  # alternate between the tiled and monocle layout |
|super + y                        |  # send the newest marked node to the newest preselected node |
|super + g                        |  # swap the current node and the biggest window |
|super + ctrl + {m,x,y,z}         |  # set the node flags |
|super + {_,shift + }{h,j,k,l}    |  # focus the node in the given direction |
|super + {_,shift + }c            |  # focus the next/previous window in the current desktop |
|super + bracket{left,right}      |  # focus the next/previous desktop in the current monitor |
|super + {grave,Tab}              |  # focus the last node/desktop |
|super + {o,i}                    |  # focus the older or newer node in the focus history |
|super + {_,shift + }{1-8,0}      |  # focus or send to the given desktop |
|super + ctrl + {h,j,k,l}         |  # preselect the direction |
|super + ctrl + {1-9}             |  # preselect the ratio |
|super + ctrl + space             |  # cancel the preselection for the focused node |
|super + ctrl + shift + space     |  # cancel the preselection for the focused desktop |
|super + alt + {h,j,k,l}          |  # expand a window by moving one of its side outward |
|super + alt + shift + {h,j,k,l}  |  # contract a window by moving one of its side inward |
|super + {Left,Down,Up,Right}     |  # move a floating window |
|shift + Print                    |  # Screenshot |
|super+Print                      |  # Screenshots but better |

