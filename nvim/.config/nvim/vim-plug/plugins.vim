"                          ██                 ██
"                 ██████  ░██          █████ ░░
"                ░██░░░██ ░██ ██   ██ ██░░░██ ██ ███████   ██████
"                ░██  ░██ ░██░██  ░██░██  ░██░██░░██░░░██ ██░░░░
"                ░██████  ░██░██  ░██░░██████░██ ░██  ░██░░█████
"                ░██░░░   ░██░██  ░██ ░░░░░██░██ ░██  ░██ ░░░░░██
"                ░██      ███░░██████  █████ ░██ ███  ░██ ██████
"                ░░      ░░░  ░░░░░░  ░░░░░  ░░ ░░░   ░░ ░░░░░░
"

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
"
" Better Syntax Support
" Plug 'sheerun/vim-polyglot'
"
" File Explorer
" Plug 'scrooloose/NERDTree'
"
" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'
  
" Theme 
Plug 'arcticicestudio/nord-vim'
" Plug 'gruvbox-community/gruvbox'
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'whatyouhide/vim-gotham'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Stable version of coc
 Plug 'neoclide/coc.nvim',{'branch': 'release'}
" Keeping up to date with master
 Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" DON'T forget to CocInstall from 
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
" also try :CocInstall coc-marketplace then cmnd for list :CocList marketplace
" RANGER
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'
Plug 'f-person/git-blame.nvim'
Plug 'lewis6991/gitsigns.nvim'
" Plug 'zxqfl/tabnine-vim'
Plug 'tpope/vim-repeat'
" Plug 'sjl/gundo.vim'
Plug 'mattn/emmet-vim'
Plug 'romainl/vim-cool'
call plug#end()
