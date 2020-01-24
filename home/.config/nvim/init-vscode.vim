scriptencoding utf-8

let g:init = 'init-vscode.vim'


""
" @section Plugins, plugins

call plug#begin(stdpath('data') . '/plugged-vscode')

""
" @section Plugins, interface
Plug 'editorconfig/editorconfig-vim'
Plug 'sjl/gundo.vim'

""
" @section Plugins, motion
Plug 'AndrewRadev/splitjoin.vim'
Plug 'asvetliakov/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

""
" @section Plugins, syntax
Plug 'heavenshell/vim-jsdoc'

call plug#end()


runtime settings/common.vim
runtime mappings/common.vim

"
" @section Mappings, mappings

xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine
