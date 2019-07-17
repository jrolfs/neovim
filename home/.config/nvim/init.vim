scriptencoding utf-8

""
" @section External, external

runtime scripts/utilities.vim
runtime scripts/highlights.vim
runtime scripts/autocommands.vim
runtime scripts/autocomplete.vim
runtime scripts/test.vim
runtime scripts/ui.vim

let s:xdg_data = $XDG_DATA_HOME
let s:data = s:xdg_data . '/nvim/'


""
" @section Plugins, plugins

call plug#begin('$XDG_DATA_HOME/nvim/plugged')

""
" @section Plugins, interface
Plug '$SOURCES/junegunn/seoul256.vim'
Plug '$SOURCES/mhartington/oceanic-next'
Plug '$SOURCES/vim-airline/vim-airline-themes'
Plug 'arzg/seoul8'
Plug 'chrisbra/Recover.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jrolfs/taboo.vim', { 'branch': 'unicode-tab-numbers' }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'lotabout/skim', { 'dir': '$XDG_DATA_HOME/nvim/skim' }
Plug 'lotabout/skim.vim'
Plug 'mhinz/vim-signify'
Plug 'qpkorr/vim-bufkill'
Plug 'romainl/vim-qf'
Plug 'sjl/gundo.vim'
Plug 'szw/vim-maximizer'
Plug 'vim-airline/vim-airline'
Plug 'wellle/targets.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'metakirby5/codi.vim'

""
" @section Plugins, completion
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }

""
" @section Plugins, tools
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
Plug 'heavenshell/vim-jsdoc'
Plug 'kassio/neoterm'

""
" @section Plugins, files
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'
Plug 'Shougo/tabpagebuffer.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'danro/rename.vim'
Plug 'mhinz/vim-grepper'
Plug 't9md/vim-choosewin'

""
" @section Plugins, Manipulation
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'

""
" @section Plugins, motion
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'

""
" @section Plugins, syntax
Plug 'sheerun/vim-polyglot'
Plug 'othree/yajs.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mxw/vim-jsx'
Plug 'jrolfs/vim-github-hub', { 'branch': 'support-commit' }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'chrisbra/Colorizer'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

""
" @section Plugins, icons
Plug 'ryanoasis/vim-devicons'

call plug#end()


""
" @section Settings, settings

" Leader
let g:mapleader = ' '

" Syntax
set termguicolors
set background=dark

syntax enable
filetype plugin on

let g:seoul256_background = 238
let g:seoul256_srgb = 0

colorscheme seoul256
let g:seoul256_srgb = 1

" Interface
set noshowmode
set fillchars+=vert:⎸
set winminwidth=0
set winminheight=0
set updatetime=100

" Undo
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" Tab Size
set smartindent
set expandtab
"
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
set colorcolumn=0
set nowrap

" Session
set sessionoptions+=tabpages,globals

" Polyglot
let g:polyglot_disabled = ['javascript', 'jsx', 'typescript']

" Sleuth
let g:sleuth_automatic = 1

" Taboo
let g:taboo_tab_format = ' %m %I%P  '
let g:taboo_renamed_tab_format = '  %m%I%l  '
let g:taboo_modified_tab_flag = '✎'

" Signify
let g:signify_sign_show_text = 1

" Colorizer
let g:colorizer_auto_map = 1
let g:colorizer_disable_bufleave = 1

let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 1
let g:session_autosave_silent = 1
let g:session_command_aliases = 1
let g:session_directory = s:data . 'sessions'

" Denite
call denite#custom#option('_', {
  \   'prompt': 'λ:',
  \   'empty': 0,
  \   'winheight': 16,
  \   'source_names': 'short',
  \   'vertical_preview': 1,
  \   'auto-accel': 1,
  \   'auto-resume': 1,
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
call denite#custom#source(
  \ 'buffer',
  \ 'matchers', [
  \   'matcher/fuzzy',
  \   'matcher/project_files'
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
let g:airline_theme = 'seoul256'

let g:airline_extensions = ['ale', 'branch']
let g:airline_powerline_fonts = 1

let airline#extensions#ale#error_symbol = "\ubb"
let airline#extensions#ale#warning_symbol = "\u2248"

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:webdevicons_enable_airline_statusline = 0
let g:airline_section_x = '%{WebDevIconsGetFileTypeSymbol()}%  '
let g:airline_section_y = '%{WebDevIconsGetFileFormatSymbol()}% '
let g:airline_section_z = '%3p％%3v⮐ '

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

" Vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$']

" Pandoc
let g:pandoc#modules#disabled = ['chdir', 'folding']

let g:pandoc#syntax#codeblocks#embeds#langs = [
  \   'javascript',
  \   'js=javascript',
  \   'json=javascript',
  \   'ruby',
  \   'python',
  \   'bash=sh'
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

" Neosnippet
let g:neosnippet#enable_completed_snippet = 1

" JSX
let g:jsx_ext_required = 0

" Multiple Cursors
let g:multi_cursor_exit_from_insert_mode = 0

" JSDoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1

" skim
let $SKIM_DEFAULT_COMMAND = 'fd --ignore-case --hidden --type f --exclude "\.git"'
let s:ripgrep_find_command = 'rg
  \ --column
  \ --line-number
  \ --no-heading
  \ --fixed-strings
  \ --ignore-case
  \ --no-ignore
  \ --hidden
  \ --follow
  \ --glob "!.git/*"
  \ --color "always"'

command! -bang -nargs=* Find call fzf#vim#grep(s:ripgrep_find_command.shellescape(<q-args>), 1, <bang>0)

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Todo'],
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
let g:ale_sign_error = "\uf057"
let g:ale_sign_warning = "\uf071"
let g:ale_completion_enabled = 1

" COC
let g:coc_status_error_sign = "\uf057"
let g:coc_status_warning_sign = "\uf071"

let g:ale_linters = {
  \   'javascript': ['eslint', 'flow'],
  \   'typescript': ['tslint', 'tsserver']
  \ }

let g:ale_fixers = {
  \   'javascript': ['prettier'],
  \   'typescript': ['prettier'],
  \   'json': ['prettier'],
  \   'css': ['prettier'],
  \   'scss': ['prettier'],
  \   'html': ['html-tidy']
  \ }

" vim-test
let g:test#ruby#rspec#executable = '$(rbenv which zeus) rspec'
let g:test#strategy = 'neoterm'


"
" @section Mappings, mappings

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

" Omnifunc
inoremap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" Source configuration
noremap <silent> <Leader>C :source $XDG_CONFIG_HOME/nvim/init.vim<CR>

" Navigation
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz

nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

noremap ]w :tabnext<CR>
noremap [w :tabprevious<CR>

" Airline
nnoremap <silent> <Leader>uh :call AirlineToggleShowHighlight()

" Denite
nnoremap <Leader>dp :<C-u>Denite file_rec<CR>
nnoremap <Leader>df :<C-u>Denite grep:. -mode=normal<CR>
nnoremap <Leader>ds :<C-u>DeniteCursorWord grep:. -mode=normal<CR>
nnoremap <Leader>dr :<C-u>Denite -resume<CR>

" Unite
nnoremap <Leader>b :Unite buffer<CR>
nnoremap <Leader>B :Unite buffer<CR>

" FZF
noremap <C-p> :Files<CR>
noremap <C-b> :Buffers<CR>

" ALE
nmap <Leader>al <Plug>(ale_lint)
nmap <Leader>af <Plug>(ale_fix)
nmap <Leader>ap <Plug>(ale_previous)
nmap <Leader>an <Plug>(ale_next)
nmap <Leader>agg :ALEGoToDefinition<CR>
nmap <Leader>agt :ALEGoToDefinitionInTab<CR>
nmap <Leader>ags :sp<CR>:ALEGoToDefinition<CR>
nmap <Leader>agv :vs<CR>:ALEGoToDefinition<CR>
nmap <Leader>ad :ALEDetail<CR>

" COC
nmap <C-g>t <Plug>(coc-type-definition)
nmap <C-g>d <Plug>(coc-definition)
nmap <C-g>D <Plug>(coc-declaration)
nmap <C-g>i <Plug>(coc-implementation)
nmap <C-g>r <Plug>(coc-references)

nmap <C-g>R <Plug>(coc-rename)

map <C-g>f <Plug>(coc-format-selected)
nmap <C-g>f <Plug>(coc-format)

nmap <C-g>a <Plug>(coc-codeaction)
map <C-g>a <Plug>(coc-codeaction-selected)

nmap <C-g>o <Plug>(coc-openlink)
nmap <C-g>l <Plug>(coc-codelens-action)
nmap <C-g>F <Plug>(coc-fix-current)

nmap <C-g>x <Plug>(coc-float-hide)
nmap <C-g>j <Plug>(coc-float-jump)

nmap <C-g>I <Plug>(coc-diagnostic-info)

nmap <silent> <C-g>ld :CocList diagnostics<CR>
nmap <silent> <C-g>ls :CocList sources<CR>
nmap <silent> <C-g>le :CocList extensions<CR>

" VimFiler
noremap <Leader>le :VimFilerExplorer -project -winwidth=50<CR>
noremap <Leader>lE :VimFilerExplorer -find -winwidth=50<CR>
noremap <Leader>ls :VimFilerBuffer<CR>
noremap <Leader>lS :VimFiler<CR>

noremap <Leader>ly :let @+ = expand("%")<CR>
noremap <Leader>lcd :tcd %:p:h<CR>

" Gundo
nnoremap <silent> <Leader>z :GundoToggle<CR>

" GitGutter
nnoremap <Leader>GG :GitGutter<CR>

" Choosewin
map - <Plug>(choosewin)

" Search
noremap <silent> <Leader>/ :noh<CR>

" Maximixer
nnoremap <C-w>z :MaximizerToggle<CR>

" Find/Replace
nnoremap <Leader>rp :%s/"//g<Left><Left>

" Grepper
nnoremap <Leader>gg :Grepper -tool git -noswitch<CR>
nnoremap <Leader>ga :Grepper -tool ag -grepprg ag --vimgrep<CR>
nnoremap <Leader>gr :Grepper -tool rg -grepprg rg<CR>

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
tnoremap <C-e> <C-\><C-n>
tmap <C-w> <C-e><C-w>

" tmap <C-h> <Leader><ESC><C-h>
" tmap <C-j> <Leader><ESC><C-j>
" tmap <C-k> <Leader><ESC><C-k>
" tmap <C-l> <Leader><ESC><C-l>

" Neoterm
nmap <silent> <Leader>nt :Ttoggle<CR><ESC>
nmap <silent> <Leader>nx :Tclose<CR>
nmap <silent> <Leader>no :Topen<CR><ESC>
nmap <silent> <Leader>nc :Tclear<CR>
nmap <silent> <Leader>nk :Tkill<CR>

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" EasyMotion
map <Leader> <Plug>(easymotion-prefix)

" Location list
nnoremap <Leader>lo :lopen<CR>
nnoremap <Leader>lc :lclose<CR>
nnoremap <Leader>l, :ll<CR>
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>

" JSDoc
nmap <Leader>js <Plug>(jsdoc)

" Tags
noremap <F8> :TagbarToggle<CR>

" vim-test
nnoremap <silent> <Leader>st :TestNearest<CR>
nnoremap <silent> <Leader>sT :TestFile<CR>
nnoremap <silent> <Leader>sa :TestSuite<CR>
nnoremap <silent> <Leader>sl :TestLast<CR>
nnoremap <silent> <Leader>sg :TestVisit<CR>

" Neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

