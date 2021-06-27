"                             ██         ██ ██
"                            ░░         ░██░░
"                    ██████   ██ ██████ ░██ ██ ███████   █████
"                   ░░░░░░██ ░██░░██░░█ ░██░██░░██░░░██ ██░░░██
"                    ███████ ░██ ░██ ░  ░██░██ ░██  ░██░███████
"                   ██░░░░██ ░██ ░██    ░██░██ ░██  ░██░██░░░░
"                  ░░████████░██░███    ███░██ ███  ░██░░██████
"                   ░░░░░░░░ ░░ ░░░    ░░░ ░░ ░░░   ░░  ░░░░░░

" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''



" Switch to your current theme
"let g:airline_theme = 'deus'

" Always show tabs
set showtabline=2

" We don't need to see things like -- INSERT -- anymore
set noshowmode
"=========================================================================
"
""Status-line
"    set statusline=
"    set statusline+=%#IncSearch#
"    set statusline+=\ %y
"    set statusline+=\ %r
"    set statusline+=%#CursorLineNr#
"    set statusline+=\ %F
"    set statusline+=%= "Right side settings
"    set statusline+=%#Search#
"    set statusline+=\ %l/%L
"    set statusline+=\ [%c]

" air-line
    let g:airline_powerline_fonts = 1

    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif



" airline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = 'B'
    let g:airline_symbols.readonly = 'R'
    let g:airline_symbols.linenr = '^'
    let g:airline_symbols.maxlinenr = 'L '

