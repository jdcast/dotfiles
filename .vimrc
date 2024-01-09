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

" YCM
Plugin 'ycm-core/YouCompleteMe'

call vundle#end()

" enable mouse
set mouse=a

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

" toggle for when pasting with no indent desired e.g. from clipboard
" https://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim
set pastetoggle=<F4>

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
syntax on

" Enable copying from vim to the system-clipboard
" Needs clipboard for vim. Install with 'sudo apt install vim-gtk3'
set clipboard=unnamedplus 

" Set the filetype based on the file's extension, but only if
" " 'filetype' has not already been set
" Allows these file types to have proper syntax highlighting
au BufRead,BufNewFile *.urdf.xacro setfiletype xml
au BufRead,BufNewFile *.xacro setfiletype xml
au BufRead,BufNewFile *.sdf setfiletype xml
au BufRead,BufNewFile *.ops setfiletype sh
au BufRead,BufNewFile *.launch setfiletype xml
au BufRead,BufNewFile *.service* setfiletype systemd 

" YCM settings
let g:ycm_max_num_candidates = 5
let g:ycm_warning_symbol = '>'
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_max_diagnostics_to_display = 0  " Reference: https://github.com/ycm-core/YouCompleteMe/issues/2392

" YCM Error & Warning Color Scheme
" https://jonasjacek.github.io/colors/
hi YcmErrorSection ctermbg=0 cterm=underline
hi YcmWarningSection ctermbg=0 cterm=underline

" YCM Shortcut
map gt :YcmCompleter GoTo<CR>  " Go to definition
