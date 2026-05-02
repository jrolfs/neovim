scriptencoding utf-8

runtime settings/globals.vim

let g:init = 'init-kitty.vim'


""
" @section Plugins, plugins

lua require('packages.kitty')


runtime settings/common.vim
runtime settings/interface.vim
runtime mappings/common.vim

colorscheme gruvbox-material

lua require('init-kitty')
