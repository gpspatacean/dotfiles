set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'frazrepo/vim-rainbow'
Plugin 'dracula/vim'

let g:rainbow_active = 1
au FileType c,cpp,cc,js,ts call rainbow#load()
call vundle#end()

" theme
"syntax enabled
:set background=light
colorscheme dracula
" Plugin setup
" Map NERDTree Toggle
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

" Generic setup
:set number
:set relativenumber
:set hlsearch
:set incsearch
:set ignorecase
:inoremap jk <esc>

:syntax on
