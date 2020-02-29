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

xmap gc  <plug>VSCodeCommentary
nmap gc  <plug>VSCodeCommentary
omap gc  <plug>VSCodeCommentary
nmap gcc <plug>VSCodeCommentaryLine

noremap [w :<C-u>call VSCodeCall('workbench.action.previousEditor')<cr>
noremap ]w :<C-u>call VSCodeCall('workbench.action.nextEditor')<cr>

noremap [c :<C-u>call VSCodeCall('workbench.action.editor.previousChange')<cr>
noremap ]c :<C-u>call VSCodeCall('workbench.action.editor.nextChange')<cr>

noremap <c-w>H :<C-u>call VSCodeCall('workbench.action.moveActiveEditorGroupLeft')<cr>
noremap <c-w>J :<C-u>call VSCodeCall('workbench.action.moveActiveEditorGroupDown')<cr>
noremap <c-w>K :<C-u>call VSCodeCall('workbench.action.moveActiveEditorGroupUp')<cr>
noremap <c-w>L :<C-u>call VSCodeCall('workbench.action.moveActiveEditorGroupRight')<cr>

noremap <leader>af :<C-u>call VSCodeCall('editor.action.formatDocument')<cr>
