scriptencoding utf-8

"
" External

runtime scripts/utilities.vim
runtime scripts/highlights.vim
runtime scripts/autocommands.vim
runtime scripts/relative-numbers.vim
runtime scripts/lightline.vim
runtime scripts/test.vim


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
Plug 'sjl/vitality.vim'

" Tools
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript' }
Plug 'wokalski/autocomplete-flow', { 'for': 'javascript' }
Plug 'mhartington/nvim-typescript', { 'for': 'typescript' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'neovim/node-host', { 'do': 'npm install' }
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rails'
Plug 'moll/vim-node'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'janko-m/vim-test'
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
Plug 'hkupty/iron.nvim'
Plug 'kassio/neoterm'

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
Plug 'tpope/vim-sleuth'
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'clojure-vim/nvim-parinfer.js'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'
Plug 'sbdchd/neoformat'

" Motion
Plug 'terryma/vim-multiple-cursors'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-repeat'

" Tags
Plug 'majutsushi/tagbar'

" Syntax
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'sheerun/vim-polyglot'
Plug 'othree/yajs.vim'

call plug#end()


"
" Settings

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
set expandtab

" Sleuth
let g:sleuth_automatic = 0

" Taboo
let g:taboo_tab_format = ' [%P]%m '

" GitGutter
set signcolumn=yes
let g:gitgutter_max_signs = 2000

" List trailing
set listchars=tab:\ \ ,trail:·
set list

" Cursor
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
let g:python_host_prog = '/run/current-system/sw/bin/nvim-python'
let g:python3_host_prog = '/run/current-system/sw/bin/nvim-python3'

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
let s:node_bin =  NodenvGetGlobalExecutable('node')
let s:tern_bin = NodenvGetGlobalExecutable('tern')
let s:tern_command = [s:node_bin, s:tern_bin]

let g:tern_request_timeout = 2
let g:tern#command = s:tern_command
let g:tern#arguments = ['--persistent']
let g:deoplete#sources#ternjs#tern_bin = join(s:tern_command, ' ')

" JSDoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1

" ALE
let g:ale_sign_error = "\uF057"
let g:ale_sign_warning = "\uF056"

" vim-test
let g:test#ruby#rspec#executable = '$(rbenv which zeus) rspec'
let g:test#strategy = 'neovim'

" Parinfer
let g:parinfer_preview_cursor_scope = 1

" Neoformat
let s:prettier_eslint_bin = NodenvGetGlobalExecutable('prettier-eslint')
let s:prettier_bin = NodenvGetGlobalExecutable('prettier')

let g:neoformat_enabled_javascript = ['prettiereslint']
let g:neoformat_javascript_prettiereslint = {
  \ 'exe': s:prettier_eslint_bin,
  \ 'args': ['--stdin', '--bracket-spacing true'],
  \ 'stdin': 1
  \ }

let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_typescript_prettier = {
  \ 'exe': s:prettier_bin,
  \ 'args': [
  \   '--stdin',
  \   '--parser typescript',
  \   '--print-width 100',
  \   '--tab-width 4',
  \   '--no-bracket-spacing'
  \ ],
  \ 'stdin': 1
  \ }

" Flow
let g:flow#autoclose = 1
let g:flow#timeout = 5
let g:flow#enable = 0

" Neosnippet
let g:neosnippet#enable_completed_snippet = 1


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
cnoreabbrev tc tabc
cnoreabbrev Tc tabc
cnoreabbrev oS OpenSession
cnoreabbrev sS SaveSession
cnoreabbrev cS CloseSession

" Source configuration
noremap <Leader>c :source ~/.config/nvim/init.vim<CR>

" Buffer path
noremap <Leader>p :let @+ = expand("%")<CR>
noremap <Leader>h :tcd %:p:h<CR>

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
noremap <Leader>. :tabnext<CR>
noremap <Leader>m :tabprevious<CR>

" Taboo
noremap <Leader>tr :TabooRename

" Grepper
nnoremap <Leader>git :Grepper -tool git -noswitch<CR>
nnoremap <Leader>ag  :Grepper -tool ag  -grepprg ag --vimgrep<CR>

nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)

" Pane navigation
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>

" Terminal
tnoremap <Leader><ESC> <C-\><C-n>
tnoremap <D-l> clear<CR>

tmap <C-h> <Leader><ESC><C-h>
tmap <C-j> <Leader><ESC><C-j>
tmap <C-k> <Leader><ESC><C-k>
tmap <C-l> <Leader><ESC><C-l>

" CamelCaseMotion
noremap <D-C-w> <Plug>CamelCaseMotion_w
noremap <D-C-b> <Plug>CamelCaseMotion_b
noremap <D-C-e> <Plug>CamelCaseMotion_e

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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
nnoremap <silent> <Leader>t :TestNearest<CR>
nnoremap <silent> <Leader>T :TestFile<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>g :TestVisit<CR>

" Neoformat
noremap <Leader>n :Neoformat<CR>
