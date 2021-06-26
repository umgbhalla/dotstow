
![image](https://user-images.githubusercontent.com/67634565/123525383-d8edfa00-d6ed-11eb-9ce1-70ec431f4150.png)
  
  
You will need `git` and GNU `stow`

<details>
    <summary><b>Installing</b></summary>


Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/umgbhalla/dotstow.git ~
```

Run `stow` to symlink everything or just select what you want

```bash
cd monterey && stow */  -t ~
# Everything (the '/' ignores the README or any file)
# -t ~ implies , target directory is $HOME
```

```bash
stow zsh -t ~
# Just my zsh config
```

</details>

<details>
    <summary><b>Programs</b></summary>

An updated list of all the programs I use can be found in the `programs` directory of any theme


</details>
<details>
  <summary><b><i>Monterey</i></b></summary>
<img src="https://user-images.githubusercontent.com/67634565/123525378-d12e5580-d6ed-11eb-9293-0c9e9cdd2221.png">

</details>
<details>
    <summary><b>Keybinds</b></summary>


  |          Keybind          |         Description         |
  | ------------------------- | --------------------------- |
|super + apostrophe                | # terminal alacritty |
|super + Return                    | # scratchpad without tmux session right |
|super + semicolon                 | # scratchpad without tmux session left |
|super + backslash                 | # tmux scratchpad top |
|super + slash                     | # tmux scratchpad bottom |
|super + shift + Return            | # terminal kitty |
|super + e                         | # Shortcuts |
|super + w                         | # firefox |
|super + n                         | # thunar |
|super + d                         | # dmenu_run |
|super + a                         | # neovide |
|super + b                         | # bpytop |
|super + space                     | # program launcher |
|alt + shift + Return              | # mini youtube |
|alt + Return                      | # mini google |
|alt + e                           | # rofimoji |
|alt + m                           | # man search |
|alt + r                           | # random manpage |
|alt + v                           | # clipmenu |
|alt + h                           | # keybindhelper |
|alt + p                           | # dotfiles rofi menu ; open in nvim |
|super + period                    | # show open window |
|super + shift + d                 | # show ssh sesssions |
|super + p                         | # power-menu  |
|super + shift + r                 | # make sxhkd reload its configuration files: |
|super + {t,shift + t,s}           | # set the window state |
|super + f                         | # toggle the window fullscreen |
|super + alt + {q,r}               | # quit/restart bspwm |
|super + {_,shift + }q             | # close and kill |
|super + m                         | # alternate between the tiled and monocle layout |
|super + y                         | # send the newest marked node to the newest preselected node |
|super + g                         | # swap the current node and the biggest window |
|super + ctrl + {m,x,y,z}          | # set the node flags |
|super + {_,shift + }{h,j,k,l}     | # focus the node in the given direction |
|super + {_,shift + }c             | # focus the next/previous window in the current desktop |
|super + bracket{left,right}       | # focus the next/previous desktop in the current monitor |
|super + {grave,Tab}               | # focus the last node/desktop |
|super + {o,i}                     | # focus the older or newer node in the focus history |
|super + {_,shift + }{1-8,0}       | # focus or send to the given desktop |
|super + ctrl + {h,j,k,l}          | # preselect the direction |
|super + ctrl + {1-9}              | # preselect the ratio |
|super + ctrl + space              | # cancel the preselection for the focused node |
|super + ctrl + shift + space      | # cancel the preselection for the focused desktop |
|super + alt + {h,j,k,l}           | # expand a window by moving one of its side outward |
|super + alt + shift + {h,j,k,l}   | # contract a window by moving one of its side inward |
|super + {Left,Down,Up,Right}      | # move a floating window |
|shift + Print                     | # Screenshot |
|super+Print                       | # Screenshots but better |

</details>


credits and more themes soon 😖
