scriptencoding utf-8

"
" Functions

runtime functions/syntax.vim
runtime functions/utilities.vim
runtime functions/relative-numbers.vim
runtime functions/lightline.vim
runtime functions/test.vim


"
" Plugins

call plug#begin('~/.vim/plugged')

" Interface
Plug 'jlesquembre/base16-neovim'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/deoplete.nvim'
Plug 'gcmt/taboo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --key-bindings --completion' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'jrolfs/vim-base16-lightline'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'sjl/gundo.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'szw/vim-maximizer'

" Tools
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript' }
Plug 'neovim/node-host', { 'do': 'npm install' }
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'janko-m/vim-test'
Plug 'jrolfs/ale', { 'branch': 'enhanced-sign-highlighting' }
Plug 'editorconfig/editorconfig-vim'
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
Plug 'hkupty/iron.nvim'

" Files
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 't9md/vim-choosewin'
Plug 'Shougo/tabpagebuffer.vim'
Plug 'mhinz/vim-grepper'
Plug 'danro/rename.vim'
Plug 'ryanoasis/vim-devicons'

" Manipulation
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'clojure-vim/nvim-parinfer.js'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'godlygeek/tabular'

" Motion
Plug 'terryma/vim-multiple-cursors'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-repeat'

" Tags
Plug 'majutsushi/tagbar'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'othree/yajs.vim'

call plug#end()


"
" Settings

" Redraw
augroup lazyredraw
  autocmd! CursorMoved,CursorMovedI,InsertEnter *.rb,*.jade set lazyredraw
  autocmd! FocusLost * set nolazyredraw
augroup END

" Leader
let g:mapleader = ','

" Colors
let g:base16colorspace = 256
syntax on
set background=dark
colorscheme base16-oceanicnext

" Undo
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" Tab Size
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Taboo
let g:taboo_tab_format = ' [%P]%m '

" GitGutter
let g:gitgutter_max_signs = 2000
let g:gitgutter_sign_column_always = 1

" List trailing
set listchars=tab:\ \ ,trail:·
set list

" Cursor
set guicursor=a:blinkon500-blinkwait500-blinkoff500
set cursorline

" Search
set smartcase
set showmatch

" Movement
set nostartofline

" Status Line
set laststatus=2

" Line Numbers
set number

" Buffers
set hidden
"
" Ruler
set colorcolumn=120
set nowrap

" Session
set sessionoptions+=tabpages,globals

let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 1
let g:session_autosave_silent = 1

" Python
let g:python_host_prog = $HOME .'/.pyenv/shims/python'
let g:python3_host_prog = $HOME . '/.pyenv/shims/python3'

let g:JavaComplete_UsePython3 = 1
let g:JavaComplete_BaseDir = '~/.cache'

" Tags
let g:tagbar_autofocus = 1

" Lightline
let g:tagbar_status_func = 'TagbarStatusFunc'
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
let g:lightline = {
  \   'colorscheme': 'base16',
  \   'active': {
  \     'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
  \     'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \   },
  \   'component_function': {
  \     'fugitive': 'LightLineFugitive',
  \     'filename': 'LightLineFilename',
  \     'fileformat': 'LightLineFileformat',
  \     'filetype': 'LightLineFiletype',
  \     'fileencoding': 'LightLineFileencoding',
  \     'mode': 'LightLineMode',
  \   },
  \   'subseparator': { 'left': '|', 'right': '|' }
  \ }

" Tmuxline
let g:tmuxline_preset = {
  \   'a'    : '#S',
  \   'c'    : ['#(whoami)', '#(uptime | cud -d " " -f 1,2,3)'],
  \   'win'  : ['#I', '#W'],
  \   'cwin' : ['#I', '#W', '#F'],
  \   'x'    : '#(date)',
  \   'y'    : ['%R', '%a', '%Y'],
  \   'z'    : '#H'
  \ }

" CoffeeScript
let g:coffee_lint_options = '-f ~/coffeelint.json'

" Vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$']

" Completion
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

let g:deoplete#enable_at_startup = 1

" JSX
let g:jsx_ext_required = 0

" Multiple Cursors
let g:multi_cursor_exit_from_insert_mode = 0

" Tern
let g:tern_request_timeout = 2

" JSDoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1

" ALE
let g:ale_sign_error = "\uF057"
let g:ale_sign_warning = "\uF056"

" vim-test
let g:test#ruby#rspec#executable = '$(rbenv which zeus) rspec'
let g:test#strategy = 'neovim'


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
cnoreabbrev oS OpenSession
cnoreabbrev sS SaveSession
cnoreabbrev cS CloseSession

" Source configuration
noremap <Leader>c :source ~/.config/nvim/init.vim<CR>

" Buffer path
noremap <Leader>p :let @+ = expand("%")<CR>

" Tern
nnoremap <D-]> :TernDef<CR>

" Unite
nnoremap <Leader>b :Unite buffer_tab<CR>
nnoremap <Leader>B :Unite buffer<CR>

" FZF
noremap <C-p> :Files<CR>

" VimFiler
noremap <F1> :VimFilerExplorer -project -winwidth=50<CR>
noremap <D-F1> :VimFilerExplorer -find -winwidth=50<CR>
noremap <F2> :VimFilerBuffer<CR>
noremap <D-F2> :VimFiler<CR>
noremap <Leader>f :VimFiler<CR>

" Gundo
nnoremap <F5> :GundoToggle<CR>

" GitGutter
nnoremap <Leader>gg :GitGutter<CR>

" Choosewin
map - <Plug>(choosewin)

" Search
noremap <Leader>/ :noh<CR>

" Tabs
noremap <D-k> :tabnext<CR>
noremap <D-j> :tabprevious<CR>

" Taboo
noremap <Leader>tr :TabooRename

" Grepper
nnoremap <leader>git :Grepper -tool git -noswitch<CR>
nnoremap <leader>ag  :Grepper -tool ag  -grepprg ag --vimgrep<CR>

nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)

" Pane navigation
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" CamelCaseMotion
noremap <D-C-w> <Plug>CamelCaseMotion_w
noremap <D-C-b> <Plug>CamelCaseMotion_b
noremap <D-C-e> <Plug>CamelCaseMotion_e

" Location list
nnoremap <Leader><Space>o :lopen<CR>
nnoremap <Leader><Space>c :lclose<CR>
nnoremap <Leader><Space>, :ll<CR>
nnoremap <Leader><Space>n :lnext<CR>
nnoremap <Leader><Space>p :lprev<CR>

" JSDoc
nmap <Leader>js <Plug>(jsdoc)

" Tags
noremap <F8> :TagbarToggle<CR>

" Relative numbers
noremap <Leader>r :call NumberToggle()<CR>

" vim-test
nnoremap <silent> <leader>t :TestNearest<CR>
nnoremap <silent> <leader>T :TestFile<CR>
nnoremap <silent> <leader>a :TestSuite<CR>
nnoremap <silent> <leader>l :TestLast<CR>
nnoremap <silent> <leader>g :TestVisit<CR>
