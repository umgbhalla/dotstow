"
"                                              ██
"                              ██████  ██████ ░░            █████
"        ██████████   ██████  ░██░░░██░██░░░██ ██ ███████  ██░░░██  ██████
"       ░░██░░██░░██ ░░░░░░██ ░██  ░██░██  ░██░██░░██░░░██░██  ░██ ██░░░░
"        ░██ ░██ ░██  ███████ ░██████ ░██████ ░██ ░██  ░██░░██████░░█████
"        ░██ ░██ ░██ ██░░░░██ ░██░░░  ░██░░░  ░██ ░██  ░██ ░░░░░██ ░░░░░██
"        ███ ░██ ░██░░████████░██     ░██     ░██ ███  ░██  █████  ██████
"       ░░░  ░░  ░░  ░░░░░░░░ ░░      ░░      ░░ ░░░   ░░  ░░░░░  ░░░░░░
" 
"
"
"
"
"
" 
" Better nav for omnicomplete
    inoremap <expr> <c-j> ("\<C-n>")
    inoremap <expr> <c-k> ("\<C-p>")

" Use alt + hjkl to resize windows
    nnoremap <M-j>    :resize -2<CR>
    nnoremap <M-k>    :resize +2<CR>
    nnoremap <M-h>    :vertical resize -2<CR>
    nnoremap <M-l>    :vertical resize +2<CR>

" I hate escape more than anything else
    inoremap jk <Esc>
    inoremap kj <Esc>
    inoremap ZZ <Esc>
    inoremap ii <Esc>
    nnoremap OO O<Esc>
    " nnoremap yp <Esc>yyp<esc>
    nnoremap oo o<Esc>
    map <leader>d :bdelete<cr>

" Nert tree toggle
 "   map <C-n> :NERDTreeToggle<CR>

" Easy CAPS
    inoremap <c-u> <ESC>viwUi
    nnoremap <c-u> viwU<Esc>
    inoremap <c-d> <ESC>viwui
    nnoremap <c-d> viwu<Esc>

" TAB in general mode will move to text buffer
    nnoremap <TAB> :bnext<CR>

" SHIFT-TAB will go back
    nnoremap <S-TAB> :bprevious<CR>

" Alternate way to save
    nnoremap <C-s> :w<CR>
" Alternate way to quit
    nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
    "nnoremap <C-c> <Esc>

" <TAB>: completion.
	inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"


" Better tabbing
	vnoremap < <gv
	vnoremap > >gv

" Better window navigation
	nnoremap <C-h> <C-w>h
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-l> <C-w>l

	nnoremap <Leader>o o<Esc>^Da
	nnoremap <Leader>O O<Esc>^Da

	nnoremap <Leader>t <Esc>:FloatermToggle<CR>
	nnoremap <Leader>r <Esc>:RnvimrToggle<CR>
	nnoremap <Leader>h <C-W>s
	nnoremap <Leader>v <C-W>v
	nnoremap <Leader>; <C-W>s<CR>:terminal <CR>i
	" Open terminal
	nnoremap <Leader>' :vsplit term://zsh<CR>
	nnoremap <Leader>; :split term://zsh<CR>

    nnoremap <Leader>p <Esc>:GundoToggle<CR>

	nnoremap <Leader>m <Esc>:GonvimMarkdown <CR>
