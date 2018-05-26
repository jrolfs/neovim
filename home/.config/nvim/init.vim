scriptencoding utf-8

"
" External

runtime scripts/environments.vim
runtime scripts/utilities.vim
runtime scripts/highlights.vim
runtime scripts/autocommands.vim
runtime scripts/autocomplete.vim
runtime scripts/ui.vim
runtime scripts/test.vim


"
" Plugins

call plug#begin('~/.vim/plugged')

" Interface
Plug 'airblade/vim-gitgutter'
Plug 'jrolfs/taboo.vim', { 'branch': 'unicode-tab-numbers' }
Plug 'vim-airline/vim-airline'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'sjl/gundo.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'szw/vim-maximizer'
Plug 'qpkorr/vim-bufkill'
Plug 'wellle/targets.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'romainl/vim-qf'
Plug 'junegunn/fzf', { 'dir': '~/.vim/fzf' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug '~/Development/Sources/seoul256.vim'

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Tools
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs'
Plug 'wokalski/autocomplete-flow'
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'neovim/node-host', { 'do': 'npm install' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

" Tools
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-classpath', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-unimpaired'
Plug 'moll/vim-node'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'janko-m/vim-test'
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
Plug 'hkupty/iron.nvim'
Plug 'kassio/neoterm'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Files
Plug 'Shougo/denite.nvim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/tabpagebuffer.vim'
Plug 'Shougo/vimfiler.vim'
Plug 't9md/vim-choosewin'
Plug 'mhinz/vim-grepper'
Plug 'danro/rename.vim'
Plug 'ryanoasis/vim-devicons'

" Manipulation
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'

" Motion
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'jrolfs/vim-github-hub', { 'branch': 'support-commit' }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'chrisbra/Colorizer'
Plug 'styled-components/vim-styled-components'

call plug#end()


"
" Settings

" Leader
let g:mapleader = ','

" Syntax
set termguicolors
set background=dark

syntax enable
filetype plugin on

colorscheme seoul256

" Interface
set fillchars+=vert: 
set winminwidth=0
set winminheight=0

" Undo
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" Tab Size
set smartindent
set expandtab

" Polyglot
let g:polyglot_disabled = ['javascript', 'jsx', 'html', 'typescript']

" Sleuth
let g:sleuth_automatic = 1

" Taboo
let g:taboo_tab_format = ' %m %I%P  '
let g:taboo_renamed_tab_format = '  %m%I%l  '
let g:taboo_modified_tab_flag = '✎'

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
set number relativenumber

" Buffers
set hidden

" Ruler
set colorcolumn=100
set nowrap

" Omnifunc
inoremap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" Session
set sessionoptions+=tabpages,globals

let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 1
let g:session_autosave_silent = 1

" Denite
call denite#custom#option('_', {
  \ 'prompt': 'λ:',
  \ 'empty': 0,
  \ 'winheight': 16,
  \ 'source_names': 'short',
  \ 'vertical_preview': 1,
  \ 'auto-accel': 1,
  \ 'auto-resume': 1,
  \ })

call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('grep', 'default_opts', [
  \ '--hidden',
  \ '--vimgrep',
  \ '--no-heading',
  \ '-S'
  \ ])

" Grepper
let g:grepper = {
  \   'tools': ['rg', 'ag', 'git'],
  \   'ag': { 'grepprg': '/run/current-system/sw/bin/ag' },
  \   'rg': { 'grepprg': '/run/current-system/sw/bin/rg' }
  \ }

" Python
let g:python_host_prog = '/run/current-system/sw/bin/nvim-python'
let g:python3_host_prog = '/run/current-system/sw/bin/nvim-python3'

let g:JavaComplete_UsePython3 = 1
let g:JavaComplete_BaseDir = '~/.cache'

" Tags
let g:tagbar_autofocus = 1

" Airline
set noshowmode

let g:airline_extensions = ['ale'] + (g:gui_oni ? [] : ['branch'])
let g:airline_powerline_fonts = 1

let airline#extensions#ale#error_symbol = "\uF057 "
let airline#extensions#ale#warning_symbol = "\uF056 "

let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:webdevicons_enable_airline_statusline = 0
let g:airline_section_x = '%{WebDevIconsGetFileTypeSymbol()}% '
let g:airline_section_y = '%{WebDevIconsGetFileFormatSymbol()}% '
let g:airline_section_z = '⇅ %3p%%%  ⇥ %3v'

let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

let g:airline#extensions#default#section_truncate_width = {
  \ 'a': 30,
  \ 'b': 30,
  \ 'x': 45,
  \ 'y': 120,
  \ 'z': 45,
  \ 'warning': 30,
  \ 'error': 30,
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

" Vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$']

" Pandoc
let g:pandoc#modules#disabled = ['chdir', 'folding']

let g:pandoc#syntax#codeblocks#embeds#langs = [
  \   "javascript",
  \   "json=javascript",
  \   "ruby",
  \   "python",
  \   "bash=sh"
  \ ]

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

" Deoplete
let g:deoplete#enable_at_startup = 1

" Neosnippet
let g:neosnippet#enable_completed_snippet = 1

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

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

" FZF
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'hl':      ['fg', 'Todo'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'Normal', 'Normal'],
  \ 'hl+':     ['fg', 'Special'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Include'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }

" ALE
let g:ale_sign_error = "\uF057"
let g:ale_sign_warning = "\uF056"
let g:ale_completion_enabled = 1

let g:ale_linters = {
  \   'javascript': [ 'eslint', 'flow'],
  \   'typescript': ['tslint', 'tsserver']
  \ }

let g:ale_fixers = {
  \   'javascript': ['prettier_eslint'],
  \   'typescript': ['prettier'],
  \   'json': ['prettier'],
  \   'scss': ['prettier'],
  \   'xhtml': ['html-tidy'],
  \   'html': ['html-tidy']
  \ }

" vim-test
let g:test#ruby#rspec#executable = '$(rbenv which zeus) rspec'
let g:test#strategy = 'neoterm'


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
noremap <silent> <Leader>c :source $XDG_CONFIG_HOME/nvim/init.vim<CR>

" Navigation
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz

nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

noremap <Leader>. :tabnext<CR>
noremap <Leader>m :tabprevious<CR>

" Buffer path
noremap <Leader>p :let @+ = expand("%")<CR>
noremap <Leader>h :tcd %:p:h<CR>

" Tern
nnoremap <D-]> :TernDef<CR>

" Denite
nnoremap <Leader>dp :<C-u>Denite file_rec<CR>
nnoremap <Leader>df :<C-u>Denite grep:. -mode=normal<CR>
nnoremap <Leader>ds :<C-u>DeniteCursorWord grep:. -mode=normal<CR>
nnoremap <Leader>dr :<C-u>Denite -resume<CR>

" Unite
nnoremap <Leader>b :Unite buffer_tab<CR>
nnoremap <Leader>B :Unite buffer<CR>

" FZF
noremap <C-p> :Files<CR>

" ALE
nmap <Leader>al <Plug>(ale_lint)
nmap <Leader>af <Plug>(ale_fix)
nmap <Leader>ap <Plug>(ale_previous)
nmap <Leader>an <Plug>(ale_next)
nmap <Leader>ag :ALEGoToDefinition<CR>
nmap <Leader>aG :ALEGoToDefinitionInTab<CR>
nmap <Leader>ad :ALEDetail<CR>

" VimFiler
noremap <F1> :VimFilerExplorer -project -winwidth=50<CR>
noremap <D-F1> :VimFilerExplorer -find -winwidth=50<CR>
noremap <F2> :VimFilerBuffer<CR>
noremap <D-F2> :VimFiler<CR>

" Gundo
nnoremap <F5> :GundoToggle<CR>

" GitGutter
nnoremap <Leader>gg :GitGutter<CR>

" Choosewin
map - <Plug>(choosewin)

" Search
noremap <silent> <Leader>/ :noh<CR>

" Taboo
noremap <Leader>tr :TabooRename

" Maximixer
nnoremap <F6> :MaximizerToggle<CR>

" Find/Replace
nnoremap <Leader>rp :%s/"//g<Left><Left>

" Grepper
noremap <Leader>fg :Grepper -tool git -noswitch<CR>
nnoremap <Leader>fa :Grepper -tool ag -grepprg ag --vimgrep<CR>
nnoremap <Leader>fr :Grepper -tool rg -grepprg rg<CR>

nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)

" Pane navigation
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>

" Quickfix

nnoremap <Leader>qq :ccl<CR>

" Terminal
tnoremap <Leader><ESC> <C-\><C-n>
tnoremap <D-l> clear<CR>

tmap <C-h> <Leader><ESC><C-h>
tmap <C-j> <Leader><ESC><C-j>
tmap <C-k> <Leader><ESC><C-k>
tmap <C-l> <Leader><ESC><C-l>

" Neoterm
nnoremap <silent> <Leader>z :call neoterm#toggle()<CR><ESC>
nnoremap <silent> <Leader>sx :call neoterm#close()<CR>
nnoremap <silent> <Leader>ss :call neoterm#open()<CR><ESC>
nnoremap <silent> <Leader>sc :call neoterm#clear()<CR>
nnoremap <silent> <Leader>sk :call neoterm#kill()<CR>

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

" vim-test
nnoremap <silent> <Leader>tt :TestNearest<CR> :call neoterm#open()<CR><ESC>
nnoremap <silent> <Leader>tT :TestFile<CR> :call neoterm#open()<CR><ESC>
nnoremap <silent> <Leader>ta :TestSuite<CR> :call neoterm#open()<CR><ESC>
nnoremap <silent> <Leader>tl :TestLast<CR> :call neoterm#open()<CR><ESC>
nnoremap <silent> <Leader>tg :TestVisit<CR> :call neoterm#open()<CR><ESC>
