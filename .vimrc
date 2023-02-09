set nocompatible
filetype off    " Required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Required
Plugin 'VundleVim/Vundle.vim'

" Required
"Plugin 'gmarik/vundle'   

" solarized theme
Plugin 'altercation/vim-colors-solarized'

" coffeescript
Plugin 'kchmck/vim-coffee-script'

" jade
Plugin 'digitaltoad/vim-pug'

" JSON
Plugin 'elzr/vim-json'

call vundle#end()

" Don't create swap files
set noswapfile

" Some settings to enable the theme:

" Show line numbers
set number 

" Show matching brackets
set showmatch

" Do case insensitive matching
set ignorecase

set ruler
set nowrap

set tabstop=2
set shiftwidth=2
set expandtab

"set completion-ignore-case on
"set show-all-if-abmiguous on
"TAB: menu-complete

" Use syntax highlighting
syntax enable

set background=dark

let g:solarized_termcolors = 256

colorscheme solarized


" Required
filetype plugin indent on 

" Enable copying from vim to the system-clipboard
set clipboard=unnamedplus 
