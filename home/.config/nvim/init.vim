
call plug#begin('~/.vim/plugged')

" Sensible
Plug 'tpope/vim-sensible'

" Interface
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/deoplete.nvim'
Plug 'gcmt/taboo.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" Tools
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

" Files
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/tabpagebuffer.vim'
Plug 'mhinz/vim-grepper'
Plug 'danro/rename.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'chrisbra/SudoEdit.vim'

" Manipulation
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'godlygeek/tabular'

" Motion
Plug 'terryma/vim-multiple-cursors'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-repeat'

" Tags
Plug 'majutsushi/tagbar'

" Syntax
Plug 'tpope/vim-git'
Plug 'benekastah/neomake'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-ruby/vim-ruby'
Plug 'AndrewRadev/vim-eco'
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'
Plug 'chase/vim-ansible-yaml'
Plug 'janko-m/vim-test'

call plug#end()


"
" Settings

" Leader
let mapleader = ","

" Colors
syntax on
set background=dark
colorscheme hybrid_material
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green

" Undo
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" Tab Size
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" List trailing
set listchars=tab:\ \ ,trail:·
set list

" Cursor
set gcr=a:blinkon500-blinkwait500-blinkoff500
set cursorline

" Search
set smartcase
set ignorecase
set showmatch

" Movement
set nostartofline

" Status Line
set laststatus=2

" Line Numbers
set number

" Session
set sessionoptions+=tabpages,globals
let g:session_autoload = 'no'

let g:session_autosave = 'yes'
let g:session_autosave_periodic = 1
let g:session_autosave_silent = 1

" Python
let g:python_host_prog = '/Users/Jamie/.pyenv/shims/python'
let g:python3_host_prog = '/Users/Jamie/.pyenv/shims/python3'

" Tags
let g:tagbar_type_coffee = { 'ctagstype': 'coffee', 'kinds': [ 'c:classes', 'm:methods', 'f:functions', 'v:variables', 'f:fields', ] }

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = "hybrid"
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '│'

" Ruler
set colorcolumn=120
set nowrap

" CoffeeScript
let g:coffee_lint_options = '-f ~/coffeelint.json'

" Vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$']

" Completion
let g:deoplete#enable_at_startup = 1
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

" CtrlP
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files=0
let g:ctrlp_working_path_mode = 'w'
set wildignore+=*/.git/*,*.scssc,*/tmp/*

" JSX
let g:jsx_ext_required = 0

" Abbreviations
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev t tabe
cnoreabbrev T tabe
cnoreabbrev tc tabc
cnoreabbrev Tc tabc

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

" Multiple Cursors
let g:multi_cursor_exit_from_insert_mode = 0

" Buffers
set hidden

" Neomake
let g:neomake_javascript_enabled_makers = ['eslint', 'coffeelint', 'mri']
autocmd! BufEnter,BufWritePost * Neomake

" test.vim
let test#ruby#rspec#executable = '$(rbenv which zeus) rspec'
let test#strategy = "neovim"


"
" Mappings

" Abbreviations
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Vs vs
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev t tabe
cnoreabbrev T tabe
cnoreabbrev tc tabc
cnoreabbrev Tc tabc

" Source configuration
map <Leader>rr :source ~/.config/nvim/init.vim<CR>

" Indentation
nnoremap <TAB> >>
nnoremap <S-TAB> <<
xnoremap <S-TAB> <gv
xnoremap <TAB> >gv

" Unite
nnoremap <Leader>b :Unite buffer_tab<CR>

" VimFiler
noremap <F3> :VimFilerExplorer -project<CR>
noremap <S-F3> :VimFilerExplorer -file<CR>
noremap <F2> :VimFiler<CR>
noremap <S-F2> :VimFiler -file<CR>

" Buffers
noremap <D-k> :bn<CR>
noremap <D-j> :bp<CR>
nmap <Leader>d :bp<BAR>sp<BAR>bn<BAR>bd<CR> " close buffer
nmap <Leader>D :bufdo bd<CR> " close all buffers
noremap <Leader>eb :%y<CR>:@"<CR> 

" Tabs
noremap <D-}> :tabnext<CR>
noremap <D-{> :tabprevious<CR>

" Taboo
map <Leader>tr :TabooRename 

" Grepper
nnoremap <leader>git :Grepper -tool git -noswitch<cr>
nnoremap <leader>ag  :Grepper -tool ag  -grepprg ag --vimgrep -G '^.+\.txt'<cr>

" Pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" CamelCaseMotion
map <D-C-w> <Plug>CamelCaseMotion_w
map <D-C-b> <Plug>CamelCaseMotion_b
map <D-C-e> <Plug>CamelCaseMotion_e

" Neomake
nmap <Leader><Space>o :lopen<CR>
nmap <Leader><Space>c :lclose<CR>
nmap <Leader><Space>, :ll<CR>
nmap <Leader><Space>n :lnext<CR>
nmap <Leader><Space>p :lprev<CR>

" Tags
map <F8> :TagbarToggle<CR>

" Relative numbers
map <Leader>r :call NumberToggle()<CR>

" test.vim
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>


"
" Functions

" Toggle Relative
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunction
