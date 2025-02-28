scriptencoding utf-8

runtime settings/globals.vim

let g:init = 'init-kitty.vim'


""
" @section Plugins, plugins

call plug#begin(stdpath('data') . '/plugged-kitty')


Plug 'gruvbox-material/vim', { 'as': 'gruvbox-material' }

Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'qpkorr/vim-bufkill'
Plug 'sjl/gundo.vim'
Plug 'szw/vim-maximizer'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

""
" @section Plugins, lsp + completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'

""
" @section Plugins, motion
Plug 'AndrewRadev/splitjoin.vim'
Plug 'easymotion/vim-easymotion'
Plug 'chamindra/marvim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

""
" @section Plugins, search
Plug 'tpope/vim-abolish'

""
" @section Plugins, syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()


runtime settings/common.vim
runtime settings/interface.vim
runtime mappings/common.vim

colorscheme gruvbox-material

lua require('init-kitty')
