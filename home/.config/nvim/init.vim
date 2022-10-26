scriptencoding utf-8

runtime settings/globals.vim

let g:init = 'init.vim'

""
" @section Plugins, plugins

call plug#begin(stdpath('data') . '/plugged')

""
" @section Plugins, interface
Plug 'editorconfig/editorconfig-vim'

" Themes
Plug 'gruvbox-material/vim', { 'as': 'gruvbox-material' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

Plug 'chrisbra/Recover.vim'
Plug 'gcmt/taboo.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'qpkorr/vim-bufkill'
Plug 'sjl/gundo.vim'
Plug 'szw/vim-maximizer'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

""
" @section Plugins, search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-abolish'

""
" @section Plugins, completion / formatting / linting
Plug 'dundalek/lazy-lsp.nvim'
Plug 'folke/trouble.nvim'
Plug 'neovim/nvim-lspconfig'
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
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'sjl/splice.vim'
Plug 'moll/vim-node'

""
" @section Plugins, files
Plug 'danro/rename.vim'
Plug 'lambdalisue/suda.vim'
Plug 't9md/vim-choosewin'
Plug 'tpope/vim-vinegar'

""
" @section Plugins, motion
Plug 'AndrewRadev/splitjoin.vim'
Plug 'chamindra/marvim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

""
" @section Plugins, syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'LnL7/vim-nix'
Plug 'direnv/direnv.vim'
Plug 'fladson/vim-kitty', { 'branch': 'main' }
Plug 'heavenshell/vim-jsdoc'
Plug 'jparise/vim-graphql'
Plug 'jrolfs/vim-github-hub', { 'branch': 'support-commit' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'sheerun/vim-polyglot'
Plug 'tridactyl/vim-tridactyl'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

""
" @section Plugins, icons
Plug 'ryanoasis/vim-devicons'

call plug#end()

runtime settings/interface.vim
runtime settings/common.vim

""
" @section Settings, settings

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
let g:session_directory = stdpath('data') . 'sessions'

" Grepper
let g:grepper = {
  \   'tools': ['rg', 'ag', 'git'],
  \   'ag': { 'grepprg': '/run/current-system/sw/bin/ag' },
  \   'rg': { 'grepprg': '/run/current-system/sw/bin/rg' }
  \ }

" Gundo
let g:gundo_prefer_python3 = 1

" Python
let g:python_host_prog = '/run/current-system/sw/bin/nvim-python'
let g:python3_host_prog = '/run/current-system/sw/bin/nvim-python3'

let g:JavaComplete_UsePython3 = 1
let g:JavaComplete_BaseDir = '~/.cache'

" Tags
let g:tagbar_autofocus = 1

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

" Neosnippet
let g:neosnippet#enable_completed_snippet = 1

" JSX
let g:jsx_ext_required = 0

" Multiple Cursors
let g:multi_cursor_exit_from_insert_mode = 0

" JSDoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1

" ALE
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
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
  \   'typescriptreact': ['eslint', 'prettier'],
  \   'yaml': ['prettier']
  \ }

" vim-test
let g:test#ruby#rspec#executable = '$(rbenv which zeus) rspec'
let g:test#strategy = 'neoterm'


"
" @section Mappings, mappings

" Omnifunc
inoremap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" Telescope
noremap <C-p> :Telescope git_files<CR>
noremap <C-b> :Telescope buffers<CR>

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

" netrw
noremap <leader>ls :Explore<CR>

noremap <leader>ly :let @+ = expand("%")<CR>
noremap <leader>lcd :tcd %:p:h<CR>

" Gundo
nnoremap <silent> <leader>z :GundoToggle<CR>

" GitGutter
nnoremap <leader>GG :GitGutter<CR>

" Choosewin
map - <plug>(choosewin)

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

" Terminal
tnoremap <C-e> <C-\><C-n>
tmap <C-w> <C-e><C-w>

" Neoterm
nmap <silent> <leader>nt :Ttoggle<CR><ESC>
nmap <silent> <leader>nx :Tclose<CR>
nmap <silent> <leader>no :Topen<CR><ESC>
nmap <silent> <leader>nc :Tclear<CR>
nmap <silent> <leader>nk :Tkill<CR>

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

runtime mappings/common.vim

lua require('init')
