
 <img align="right" src="https://user-images.githubusercontent.com/67634565/123535664-dcf83700-d742-11eb-84ee-e0663dd167b5.png" width="320px"  >
<p align="left"><img src="https://visitor-badge.glitch.me/badge?page_id=umgbhalla/dotstow.visitor-badge" >    <img  alt="" src="https://img.shields.io/github/repo-size/umgbhalla/dotstow?style=flat&label=repo-size&color=fb9199&labelColor=1d212a"/>    <img  alt="" src="https://img.shields.io/github/last-commit/umgbhalla/dotstow?color=fbdf90&label=updated&style=flat&labelColor=1d212a"/>
</p>

#

You will need `git` , GNU [`stow`](https://www.youtube.com/watch?v=tkUllCAGs3c) and [`wmutils opt`](https://github.com/wmutils/opt) (for double border)
<details>
    <summary><b>Installing</b></summary>
Clone into your <code>$HOME</code> directory  
  <br>

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
 base git(main)$  pwd
 /
└ home
  └ umang
    └ dotstow
      └ base
 
stow zsh -t ~
# Just my zsh config
```
</details>
<!-- Icon Theme | [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) -->
<!-- Gtk-theme | [Nordic-Gtk](https://www.gnome-look.org/p/1267246/) -->
<!-- Music Player | [Audacious-qt](https://audacious-media-player.org) -->

<details>
    <summary><b>Programs</b></summary>
  <br>

Program | Name
:---:|:---:
Window Manger | [bspwm](https://github.com/baskerville/bspwm)
Bar | [polybar](https://github.com/polybar/polybar)
Compositor | [picom-jonaburg](https://github.com/jonaburg/picom)
Launcher | [rofi](https://github.com/davatorium/rofi)
Wallpaper Setter | [feh](https://feh.finalrewind.org/)
Web Browser | [firefox](https://www.mozilla.org/en-US/firefox/new/)
Music Visualizer | [xava](https://github.com/nikp123/xava)
Lockscreen | [i3lock-color](https://github.com/Raymo111/i3lock-color)
Terminal Emulator | [Alacritty](https://github.com/alacritty/alacritty)
Shell | [zsh](https://www.zsh.org)
Prompt | `grep PS1 ~/.config/zsh/.zshrc`
Code Editor | [neovim](https://neovim.io), [vsocde](https://github.com/microsoft/vscode)
Notification daemon | [dunst](https://dunst-project.org/)
Scratch pad | [tdrop](https://github.com/noctuid/tdrop)
Fetch | [paleofetch](https://github.com/umgbhalla/paleofetch)
Login manager | [lightdm](https://github.com/canonical/lightdm)
music | [mpvc](https://github.com/lwilletts/mpvc/)
misc | [hideIt.sh](http://giithub.com/tadly/hideIt.sh)
 
 
An updated list of all the programs I have installed, can be found <code><a href="https://github.com/umgbhalla/dotstow/blob/main/base/programs/program-list">here</a></code>
<br>
</details>  
<details>
    <summary><b>Themes</b></summary>  

| Monterey   | [Glass-green](https://user-images.githubusercontent.com/67634565/126061920-2d44885f-2943-452c-86a6-3178d1e58599.png)   | Gruv-dark |
|---|---| ---|
| <p align="center"><img src="https://user-images.githubusercontent.com/67634565/123525378-d12e5580-d6ed-11eb-9293-0c9e9cdd2221.png" width="920px"  ></p>  |  <p align="center"><img src="https://user-images.githubusercontent.com/67634565/124610237-f4939600-de8d-11eb-8469-1863f953359d.png" width="920px"></p> | <p align="center"><img src="https://user-images.githubusercontent.com/67634565/130346655-1e8b8957-54de-4e16-99b4-0495c5d7389e.png" width="920px"></p> |
  


 
  </details>
<details>
    <summary><b>Zsh plugins / manager </b></summary>
<code><a href="https://github.com/ohmyzsh/ohmyzsh">ohmyzsh</a></code>  
</br> 
<code><a href="https://github.com/Aloxaf/fzf-tab">Fzf-tab</a></code>  
</details>
<details>
    <summary><b>Keybinds</b></summary>


|          Keybind          |         Description         |
| ------------------------- | --------------------------- |
|super + apostrophe                  |   # terminal alacritty |
|super + Return                      |   # scratchpad without tmux session right |
|super + semicolon                   |   # scratchpad without tmux session left |
|super + backslash                   |   # tmux scratchpad top |
|super + slash                       |   # tmux scratchpad bottom |
|super + shift + Return              |   # terminal kitty |
|super + e                           |   # Shortcuts |
|super + w                           |   # firefox |
|super + n                           |   # thunar |
|super + d                           |   # dmenu_run |
|super + a                           |   # neovide |
|super + b                           |   # bpytop |
|super + space                       |   # program launcher |
|alt + shift + Return                |   # mini youtube |
|alt + Return                        |   # mini google |
|alt + e                             |   # rofimoji |
|alt + m                             |   # man search |
|alt + r                             |   # random manpage |
|alt + v                             |   # clipmenu |
|alt + shift + h                     |   # keybindhelper |
|alt + p                             |   # dotfiles rofi menu ; open in nvim |
|alt + o                             |   # toggle polybar over ipc |
|super + period                      |   # show open window |
|super + shift + d                   |   # show ssh sesssions |
|super + p                           |   # power-menu  |
|super + shift + r                   |   # make sxhkd reload its configuration files: |
|super + {t,shift + t,s}             |   # set the window state |
|super + f                           |   # toggle the window fullscreen |
|super + alt + {q,r}                 |   # quit/restart bspwm |
|super + {_,shift + }q               |   # close and kill |
|super + m                           |   # alternate between the tiled and monocle layout |
|super + y                           |   # send the newest marked node to the newest preselected node |
|super + g                           |   # swap the current node and the biggest window |
|super + ctrl + {m,x,y,z}            |   # set the node flags |
|super + {_,shift + }{h,j,k,l}       |   # focus the node in the given direction |
|super + comma                       |   # focus the node for the given path jump |
|super + {_,shift + }c               |   # focus the next/previous window in the current desktop |
|super + bracket{left,right}         |   # focus the next/previous desktop in the current monitor |
|super + shift + bracket{left,right} |   # focus to next ore previous node  |
|alt + {Tab, shift + Tab}            |   # focus the last node/desktop |
|super + {grave,Tab}                 |   # focus the last node/desktop |
|super + {o,i}                       |   # focus the older or newer node in the focus history |
|super + {_,shift + }{1-8,0}         |   # focus or send to the given desktop |
|super + ctrl + {h,j,k,l}            |   # preselect the direction |
|super + ctrl + {1-9}                |   # preselect the ratio |
|super + ctrl + space                |   # cancel the preselection for the focused node |
|super + ctrl + shift + space        |   # cancel the preselection for the focused desktop |
|super + alt + {h,j,k,l}             |   # expand a window by moving one of its side outward |
|super + alt + shift + {h,j,k,l}     |   # contract a window by moving one of its side inward |
|super + {Left,Down,Up,Right}        |   # move a floating window |
|shift + Print                       |   # Screenshot |
|super+Print                         |   # Screenshots but better |

to generate this use , and tthen in vim visual mode add | [pipe symbol] yourself   
```bash
awk '/^[a-z]/ && last {print "|" $0,"\t",last,"|"} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc |    column -t -s $'\t' | xclip -in -sel clip
```

</details>

