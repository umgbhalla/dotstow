let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]
    
let g:startify_bookmarks = [
            \ { 'c': '~/.config/alacritty/alacritty.yml' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' },
            \ { 'd': '~/Downloads' },
            \ '~/dotfiles-1',
            \ '~/dotfiles_meow',
            \ ]

let g:startify_change_to_vcs_root = 1
let g:startify_session_delete_buffers = 1
let g:startify_enable_special = 0

let g:startify_custom_header = [
        \ '                            ████                                  ', 
        \ '                           █░░░█                                  ',
        \ '           █████   ██████ ░█  █░█  ███████   ██   ██   ██████     ',    
        \ '          ██░░░██ ░░██░░█ ░█ █ ░█ ░░██░░░██ ░██  ░██  ██░░░░      ',
        \ '         ░██  ░░   ░██ ░  ░██  ░█  ░██  ░██ ░██  ░██ ░░█████      ',
        \ '         ░██   ██  ░██    ░█   ░█  ░██  ░██ ░██  ░██  ░░░░░██     ',
        \ '         ░░█████  ░███    ░ ████   ███  ░██ ░░██████  ██████      ',
        \ '          ░░░░░   ░░░      ░░░░   ░░░   ░░   ░░░░░░  ░░░░░░       ',
        \]
