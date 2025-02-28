scriptencoding utf-8

""
" @section General

" Leader
let g:mapleader = ' '
let g:maplocalleader = ','

" Syntax
syntax enable
filetype plugin indent on

"
" Undo

" Define lua_home with ability to override
let g:lua_home = get(g:, 'lua_home', '~/.config/nvim/lua')
let &runtimepath .= ', ' . g:lua_home

" Define backup directory name with ability to override
let g:backup_directory = get(g:, 'backup_directory', 'backups')

" Determine the base XDG data directory
let s:xdg_data_home = empty($XDG_DATA_HOME) ? $HOME . '/.local/share' : $XDG_DATA_HOME
let s:nvim_data_dir = s:xdg_data_home . '/nvim'

" Construct the full backup path
let s:backup_full_path = s:nvim_data_dir . '/' . g:backup_directory

" Create backup directory if it doesn't exist
silent execute '!mkdir -p ' . s:backup_full_path . ' > /dev/null 2>&1'

" Set undodir to the backup directory
let &undodir = s:backup_full_path

set undofile

" Tab Size
set smartindent
set expandtab
set autoindent

"
" Hidden characters
set listchars=tab:->,trail:·
set list

" Search
set smartcase
set showmatch

" Movement
set nostartofline

" Buffers
set hidden
set autoread

set nowrap
set textwidth=80

" Session
set sessionoptions+=tabpages,globals

set completeopt-=preview
set wildmode=list:full
set wildmenu

set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

""
" @section Plugins

let g:marvim_store = g:xdg_data_home . '/nvim/macros'
