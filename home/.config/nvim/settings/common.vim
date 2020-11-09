scriptencoding utf-8

""
" @section General

"
" Leader
let g:mapleader = ' '
let g:maplocalleader = ','

" Syntax
syntax enable
filetype plugin indent on

" Undo
silent !mkdir $XDG_DATA_HOME/nvim/backups > /dev/null 2>&1
set undodir=$XDG_DATA_HOME/nvim/backups
set undofile

" Tab Size
set smartindent
set expandtab
set autoindent

"
" List trailing
set listchars=tab:\ \ ,trail:·
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

let g:marvim_store = $XDG_DATA_HOME . '/nvim/macros'
