scriptencoding utf-8

runtime settings/globals.vim

let g:init = 'init-kitty.vim'


""
" @section Plugins, plugins

call plug#begin(stdpath('data') . '/plugged-kitty')


Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'gruvbox-material/vim', { 'as': 'gruvbox-material' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

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

call plug#end()


runtime settings/common.vim
runtime settings/interface.vim
runtime mappings/common.vim

