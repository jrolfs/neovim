scriptencoding utf-8

let s:xdg_data = $XDG_DATA_HOME
let s:data = s:xdg_data . '/nvim/'


""
" @section Plugins, plugins

call plug#begin('$XDG_DATA_HOME/nvim/plugged')

""
" @section Plugins, interface
Plug 'editorconfig/editorconfig-vim'

Plug 'gruvbox-material/vim', { 'as': 'gruvbox-material' }
Plug 'edkolev/tmuxline.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'gcmt/taboo.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'sjl/gundo.vim'
Plug 'szw/vim-maximizer'
Plug 'vim-airline/vim-airline'
Plug 'qpkorr/vim-bufkill'
Plug 'chrisbra/Recover.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

""
" @section Plugins, search
Plug 'lotabout/skim', { 'dir': '$XDG_DATA_HOME/nvim/skim' }
Plug 'lotabout/skim.vim'
Plug 'mhinz/vim-grepper'
Plug 'brooth/far.vim'

""
" @section Plugins, completion / formatting / linting
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }
Plug 'w0rp/ale'


""
" @section Plugins, terminal / repl
Plug 'metakirby5/codi.vim'
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

""
" @section Plugins, tools
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'moll/vim-node'


""
" @section Plugins, files
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'
Plug 'Shougo/tabpagebuffer.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'danro/rename.vim'
Plug 't9md/vim-choosewin'
Plug 'lambdalisue/suda.vim'

""
" @section Plugins, motion
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-unimpaired'

""
" @section Plugins, syntax
Plug 'sheerun/vim-polyglot'
Plug 'jrolfs/vim-github-hub', { 'branch': 'support-commit' }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'chrisbra/Colorizer'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'heavenshell/vim-jsdoc'

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
filetype plugin indent on

set signcolumn=auto:3

syntax enable
filetype plugin on

let g:gruvbox_material_background = 'soft'

colorscheme gruvbox-material

" Interface
set noshowmode
set fillchars+=vert:⎸
set winminwidth=0
set winminheight=0
set updatetime=100

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
set autoread

" Ruler
set colorcolumn=0
set nowrap

" Session
set sessionoptions+=tabpages,globals

" Polyglot
let g:polyglot_disabled = []

" Sleuth
let g:sleuth_automatic = 1

" Taboo
let g:taboo_tab_format = ' %m %I%P  '
let g:taboo_renamed_tab_format = '  %m%I%l  '
let g:taboo_modified_tab_flag = '✎'

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

" Far
let g:far#source = 'rgnvim'

" Python
let g:python_host_prog = '/run/current-system/sw/bin/nvim-python'
let g:python3_host_prog = '/run/current-system/sw/bin/nvim-python3'

let g:JavaComplete_UsePython3 = 1
let g:JavaComplete_BaseDir = '~/.cache'

" Tags
let g:tagbar_autofocus = 1

" Airline
let g:airline_theme = 'gruvbox_material'

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
let g:ale_sign_error = ""
let g:ale_sign_warning = ""
let g:ale_completion_enabled = 0

let g:ale_javascript_eslint_options = '--ext .js,.jsx,.ts,.tsx'

let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'typescript': ['eslint', 'tslint']
  \ }

let g:ale_fixers = {
  \   'css': ['prettier'],
  \   'graphql': ['prettier'],
  \   'html': ['prettier', 'html-tidy'],
  \   'javascript': ['eslint', 'prettier'],
  \   'json': ['prettier'],
  \   'json5': ['prettier'],
  \   'markdown': ['prettier'],
  \   'mdx': ['prettier'],
  \   'scss': ['prettier'],
  \   'typescript': ['eslint', 'prettier'],
  \   'yaml': ['prettier']
  \ }

" COC
let g:coc_status_error_sign = "\uf057"
let g:coc_status_warning_sign = "\uf071"

let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-solargraph',
  \ 'coc-json',
  \ 'coc-emoji',
  \ 'coc-css',
  \ 'coc-yaml',
  \ 'coc-svg',
  \ 'coc-git',
  \ ]

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
noremap <silent> <leader>C :source $XDG_CONFIG_HOME/nvim/init.vim<CR>

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
nnoremap <silent> <C-s>h <plug>(airline-toggle-highlight)

" Denite
nnoremap <leader>dp :<C-u>Denite file_rec<CR>
nnoremap <leader>df :<C-u>Denite grep:. -mode=normal<CR>
nnoremap <leader>ds :<C-u>DeniteCursorWord grep:. -mode=normal<CR>
nnoremap <leader>dr :<C-u>Denite -resume<CR>

" Unite
nnoremap <leader>b :Unite buffer<CR>
nnoremap <leader>B :Unite buffer<CR>

" FZF
noremap <C-p> :Files<CR>
noremap <C-b> :Buffers<CR>

" ALE
nmap <leader>al <plug>(ale_lint)
nmap <leader>af <plug>(ale_fix)
nmap <leader>ap <plug>(ale_previous)
nmap <leader>an <plug>(ale_next)
nmap <leader>agg :ALEGoToDefinition<CR>
nmap <leader>agt :ALEGoToDefinitionInTab<CR>
nmap <leader>ags :sp<CR>:ALEGoToDefinition<CR>
nmap <leader>agv :vs<CR>:ALEGoToDefinition<CR>
nmap <leader>ad :ALEDetail<CR>

" COC
nmap <C-g>t <plug>(coc-type-definition)
nmap <C-g>d <plug>(coc-definition)
nmap <C-g>D <plug>(coc-declaration)
nmap <C-g>i <plug>(coc-implementation)
nmap <C-g>r <plug>(coc-references)

nmap <C-g>R <plug>(coc-rename)
nmap <C-g>F <plug>(coc-refactor)

map <C-g>f <plug>(coc-format-selected)
nmap <C-g>f <plug>(coc-format)

nmap <C-g>a <plug>(coc-codeaction)
map <C-g>a <plug>(coc-codeaction-selected)

nmap <C-g>o <plug>(coc-openlink)
nmap <C-g>l <plug>(coc-codelens-action)
nmap <C-g>F <plug>(coc-fix-current)

nmap <C-g>x <plug>(coc-float-hide)
nmap <C-g>j <plug>(coc-float-jump)

nmap <C-g>I <plug>(coc-diagnostic-info)

nmap <silent> <C-g>ld :CocList diagnostics<CR>
nmap <silent> <C-g>ls :CocList sources<CR>
nmap <silent> <C-g>le :CocList extensions<CR>

nmap <silent> <C-g>Tr :CocCommand tsserver.restart<CR>

" coc-git
nmap ]c <plug>(coc-git-nextchunk)
nmap [c <plug>(coc-git-prevchunk)

" VimFiler
noremap <leader>le :VimFilerExplorer -project -winwidth=50<CR>
noremap <leader>lE :VimFilerExplorer -find -winwidth=50<CR>
noremap <leader>ls :VimFilerBuffer<CR>
noremap <leader>lS :VimFiler<CR>

noremap <leader>ly :let @+ = expand("%")<CR>
noremap <leader>lcd :tcd %:p:h<CR>

" Gundo
nnoremap <silent> <leader>z :GundoToggle<CR>

" GitGutter
nnoremap <leader>GG :GitGutter<CR>

" Choosewin
map - <plug>(choosewin)

" Search
noremap <silent> <leader>/ :noh<CR>

" Maximixer
nnoremap <C-w>z :MaximizerToggle<CR>

" Find/Replace
nnoremap <leader>rp :%s/"//g<Left><Left>

" Grepper
nnoremap <leader>gg :Grepper -tool git -noswitch<CR>
nnoremap <leader>ga :Grepper -tool ag -grepprg ag --vimgrep<CR>
nnoremap <leader>gr :Grepper -tool rg -grepprg rg<CR>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Pane navigation
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>

" Quickfix
nnoremap <leader>qq :ccl<CR>

" Terminal
tnoremap <C-e> <C-\><C-n>
tmap <C-w> <C-e><C-w>

" tmap <C-h> <leader><ESC><C-h>
" tmap <C-j> <leader><ESC><C-j>
" tmap <C-k> <leader><ESC><C-k>
" tmap <C-l> <leader><ESC><C-l>

" Neoterm
nmap <silent> <leader>nt :Ttoggle<CR><ESC>
nmap <silent> <leader>nx :Tclose<CR>
nmap <silent> <leader>no :Topen<CR><ESC>
nmap <silent> <leader>nc :Tclear<CR>
nmap <silent> <leader>nk :Tkill<CR>

" EasyAlign
xmap ga <plug>(EasyAlign)
nmap ga <plug>(EasyAlign)

" EasyMotion
map <leader> <plug>(easymotion-prefix)

" Location list
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <leader>l, :ll<CR>
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprev<CR>

" JSDoc
nmap <leader>js <plug>(jsdoc)

" Tags
noremap <F8> :TagbarToggle<CR>

" vim-test
nnoremap <silent> <C-t>t :TestNearest<CR>
nnoremap <silent> <C-t>T :TestFile<CR>
nnoremap <silent> <C-t>a :TestSuite<CR>
nnoremap <silent> <C-t>l :TestLast<CR>
nnoremap <silent> <C-t>g :TestVisit<CR>

" Neosnippet
imap <C-k> <plug>(neosnippet_expand_or_jump)
smap <C-k> <plug>(neosnippet_expand_or_jump)
xmap <C-k> <plug>(neosnippet_expand_target)

