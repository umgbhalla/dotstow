"                              ██     ██   ██
"                             ░██    ░██  ░░            █████
"             ██████  █████  ██████ ██████ ██ ███████  ██░░░██  ██████
"            ██░░░░  ██░░░██░░░██░ ░░░██░ ░██░░██░░░██░██  ░██ ██░░░░
"           ░░█████ ░███████  ░██    ░██  ░██ ░██  ░██░░██████░░█████
"            ░░░░░██░██░░░░   ░██    ░██  ░██ ░██  ░██ ░░░░░██ ░░░░░██
"            ██████ ░░██████  ░░██   ░░██ ░██ ███  ░██  █████  ██████
"           ░░░░░░   ░░░░░░    ░░     ░░  ░░ ░░░   ░░  ░░░░░  ░░░░░░
"
"
"
"
"
"

" set leader key
let g:mapleader = "\<Space>"
let maplocalleader = "\\"
" syntax enable                           " Enables syntax highlighing
set backspace=indent,eol,start
set shortmess+=I
set hidden                              " Required to keep multiple buffers open multiple buffers
set hlsearch
set incsearch
set ignorecase
set smartcase
set scrolloff=999
" set sidescrolloff=999
" set nowrap                              " Display long lines as just one line
nmap Q <Nop>                            " Q in normal mode enters Ex mode. You almost never want this.
set noerrorbells visualbell t_vb=       " audio bell disbled
set colorcolumn=81
set encoding=UTF-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=UTF-8                  " The encoding written to file
set ruler                               " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                        " treat dash separated words as a word text object"
set mouse+=a                            " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=2
set tabstop=2                           " Insert 2 spaces for a tab
set softtabstop=2
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set showtabline=2                       " Always show tabs
set fileformat=unix
set smartindent                         " Makes indenting smart
set fdm=indent
set foldlevelstart=99
set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set cursorcolumn
set cursorline                          " Enable highlighting of the current line
" set number
set relativenumber
set background=dark                     " tell vim what the background color looks like
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc       
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set undofile                            " keep undo histroy of all files
set clipboard+=unnamedplus              " Copy paste between vim and everything else
"set autochdir                           " Your working directory will always be the same as your working directory
set list listchars=nbsp:¬,tab:>~,trail:.,extends:¤
au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

augroup exe_code
	autocmd!

	autocmd FileType python nnoremap <buffer> <localleader>r
				\ :sp<CR> :term python3 %<CR> :startinsert<CR>

	
	autocmd FileType javascript nnoremap <buffer> <localleader>r
				\ :sp<CR> :term nodejs %<CR> :startinsert<CR>

	autocmd FileType bash,sh nnoremap <buffer> <localleader>\
				\ :sp<CR> :term bash %<CR> :startinsert<CR>
augroup END

let g:user_emmet_mode='a' 
let g:user_emmet_leader_key=','
" You can't stop me
cmap w!! w !sudo tee %



