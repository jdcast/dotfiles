set nocompatible
filetype off    " Required

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Required
"Bundle 'VundleVim/Vundle.vim'

" Required
Bundle 'gmarik/vundle'   

" solarized theme
Bundle 'altercation/vim-colors-solarized'

" coffeescript
Bundle 'kchmck/vim-coffee-script'

" jade
Bundle 'digitaltoad/vim-jade'

" JSON
Bundle 'elzr/vim-json'

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
